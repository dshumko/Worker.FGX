unit FGX.OpenDialog.Android;

interface

uses System.SysUtils, System.Classes, System.Messaging,
  FGX.Canvas, FGX.Controls, FGX.Controls.Android,
  Android.Api.ActivityAndView, Android.Api.Providers.MediaStore, Android.Api.Widgets,
  Android.Api.Dialogs, Java.Bridge;

const
  CAMERA_REQUEST_CODE = 42;
  FILE_REQUEST_CODE = 43;

type
  IFGXShareSheetActionsService = interface
    ['{79FCC7B1-C5BF-4533-B31E-084F1A6E2264}']
    procedure Share(const AText: string; const AImage: TfgBitmap);
  end;

  IFGCameraDialog = interface
    ['{C4A5DB09-922B-4079-9878-5791991300FE}']
    procedure Execute(Proc: TProc<boolean>);
    function GetFileName: String;
    procedure SetFileName(const AValue: String);
    property FileName: String read GetFileName write SetFileName;
  end;

  IFGOpenDialog = interface
    ['{B57C21C2-2301-459A-B017-E7254C1720F3}']
    procedure Execute(Proc: TProc<boolean>);
    function GetFiles: TStrings;
    function GetMultiSelect: boolean;
    function GetMimeType: String;
    procedure SetMultiSelect(const Value: boolean);
    procedure SetMimeType(const Value: String);
    property Files: TStrings read GetFiles;
    property MultiSelect: boolean read GetMultiSelect write SetMultiSelect;
    property MimeType: String read GetMimeType write SetMimeType;

  end;

  TSharingManagerAndroid = class(TInterfacedObject,
    IFGXShareSheetActionsService)
  private type
    TSharingDataType = (None, Image, Text, Any);
  private
    FDataType: TSharingDataType;
    function GetSharingMIMETypes(const DataTypes: TSharingDataType): string;
    function GetChooserCaption(const DataTypes: TSharingDataType): string;
    { Working with sharing Intent }
    function CreateSharingIntent(const DataType: TSharingDataType): JIntent;
    procedure AddText(AIntent: JIntent; const AText: string);
    procedure AddImage(AIntent: JIntent; const AImage: TfgBitmap);
  public
    { IFGXShareSheetActionsService }
    procedure Share(const AText: string; const AImage: TfgBitmap);
  end;

  TfgOpenDialog = class(TInterfacedObject, IFGOpenDialog)
  private
    FProc: TProc<boolean>;
    FMultiSelect: boolean;
    FFiles: TStrings;
    FMimeType: String;
    procedure ResultCallback(const Sender: TObject; const M: TMessage);
    procedure SetMultiSelect(const Value: boolean);
    procedure SetMimeType(const Value: String);
    function GetFiles: TStrings;
    function GetMultiSelect: boolean;
    function GetMimeType: String;
  public
    property Files: TStrings read GetFiles;
    property MultiSelect: boolean read GetMultiSelect write SetMultiSelect;
    property MimeType: String read GetMimeType write SetMimeType;
    constructor Create;
    destructor Destroy; override;
    procedure Execute(Proc: TProc<boolean>);
  end;

  TfgCameraDialog = class(TInterfacedObject, IFGCameraDialog)
  private
    FProc: TProc<boolean>;
    FFileName: String;
    procedure ResultCallback(const Sender: TObject; const M: TMessage);
    procedure SetFileName(const Value: String);
    function GetFileName: String;
  public
    property FileName: String read GetFileName write SetFileName;
    constructor Create;
    destructor Destroy; override;
    procedure Execute(Proc: TProc<boolean>);
  end;

implementation

uses System.IOUtils, FGX.Platform.Android, Android.Api.JavaTypes, AndroidApi.Jni,
  FGX.Helpers.Android, FGX.Any.Utils;

constructor TfgOpenDialog.Create;
begin
  FFiles := TStringList.Create;
  TMessageManager.DefaultManager.SubscribeToMessage(TfgActivityResultMessage,
    ResultCallback);
end;

destructor TfgOpenDialog.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TfgActivityResultMessage,
    ResultCallback);
  FFiles := nil;
  inherited;

end;

procedure TfgOpenDialog.ResultCallback(const Sender: TObject;
  const M: TMessage);
  function GetFileName(Uri: JUri): String;
  var
    c: JCursor;
  begin
    result := '';
    if (Uri.getScheme().equalsIgnoreCase(S2Js('content'))) then
    begin
      c := TfgAndroidHelper.Context.getContentResolver.query(Uri, nil, nil,
        nil, nil);
      try
        if (c <> nil) and c.moveToFirst then
          result := Js2S(c.getString(c.getColumnIndex(S2Js('_display_name'))))
      finally
        if (c <> nil) then
          c.close;
      end;
    end;
    if (result = '') then
      result := Js2S(Uri.getPath());
  end;
  procedure UriToFile(Uri: JUri);
  var
    b: IJavaArray<Byte>;
    jis: JInputStream;
    FilePath: string;
    ms: TMemoryStream;
  begin
    ms := TMemoryStream.Create;
    try

      jis := TfgAndroidHelper.Context.getContentResolver.openInputStream(Uri);
      b := TJavaArray<Byte>.Create(jis.available);
      jis.read(b);
      jis.close;
      ms.Write(b.Elements^, b.Length);
      FilePath := System.IOUtils.TPath.GetTempFileName + '.jpg';
      ms.SaveToFile(FilePath);
      FFiles.Add(GetFileName(Uri) + '=' + FilePath);
    finally
      ms.Free;
    end;
  end;

var
  i: integer;
begin
  if TfgActivityResultMessage(M).RequestCode = FILE_REQUEST_CODE then
  begin
    if TfgActivityResultMessage(M).ResultCode = TJActivity.RESULT_OK then
    begin
      if FMultiSelect and Assigned(TfgActivityResultMessage(M)
        .Data.getClipData()) then
        for i := 0 to TfgActivityResultMessage(M).Data.getClipData()
          .getItemCount - 1 do
          UriToFile(TfgActivityResultMessage(M).Data.getClipData()
            .getItemAt(i).getUri)
      else
        UriToFile(TfgActivityResultMessage(M).Data.getData());
      FProc(True);
    end
    else
      FProc(False);

  end;
end;

procedure TfgOpenDialog.SetMimeType(const Value: String);
begin
  FMimeType := Value;
end;

procedure TfgOpenDialog.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
end;

procedure TfgOpenDialog.Execute(Proc: TProc<boolean>);
var
  Intent: JIntent;
  S: JCharSequence;
begin
  FProc := Proc;
  Intent := TJIntent.Create(TJIntent.ACTION_GET_CONTENT);
  if FMultiSelect then
    Intent.putExtra(TJIntent.EXTRA_ALLOW_MULTIPLE, True)
  else
    Intent.putExtra(TJIntent.EXTRA_ALLOW_MULTIPLE, False);
  // Intent.setAction(TJIntent.ACTION_GET_CONTENT);
  S := StringToJCharSequence('Choose Photo');
  Intent.setType(S2Js(MimeType));
  TfgAndroidHelper.Activity.startActivityForResult
    (TJIntent.createChooser(Intent, S), FILE_REQUEST_CODE);

end;

function TfgOpenDialog.GetFiles: TStrings;
begin
  result := FFiles;
end;

function TfgOpenDialog.GetMimeType: String;
begin
  result := FMimeType;
end;

function TfgOpenDialog.GetMultiSelect: boolean;
begin
  result := FMultiSelect;
end;

procedure TSharingManagerAndroid.AddImage(AIntent: JIntent;
  const AImage: TfgBitmap);
var
  ImageFile: JFile;
  ImageUri: JUri;
  ArrayList: JArrayList;
  OutputDir: JFile;
  S: TMemoryStream;
begin
  Assert(AIntent <> nil);
  Assert(AImage <> nil);
  OutputDir := TfgAndroidHelper.Context.getExternalCacheDir();
  ImageFile := TJFile.createTempFile(S2Js('attachment'), S2Js('.png'),
    OutputDir);
  ImageUri := TJFileProvider.getUriForFile(TfgAndroidHelper.Context,
    S2Js(Js2S(TfgAndroidHelper.Context.getPackageName) + '.fileprovider'),
    ImageFile);
  { else
    ImageUri :=TJUri.fromFile(ImageFile);
  }
  S := TMemoryStream.Create;
  try
    AImage.SaveToStream(S);
    S.Position := 0;
    S.SaveToFile(Js2S(ImageFile.getAbsolutePath));
  finally
    S.Free;
  end;

  if FDataType = TSharingDataType.Image then
    AIntent.putExtra(TJIntent.EXTRA_STREAM,
      TJParcelable.Wrap(ImageUri.ObjectId))
  else
  begin
    ArrayList := TJArrayList.Create;
    ArrayList.Add(ImageUri);
    AIntent.putParcelableArrayListExtra(TJIntent.EXTRA_STREAM, ArrayList);
  end;
end;

procedure TSharingManagerAndroid.AddText(AIntent: JIntent; const AText: string);
begin
  Assert(AIntent <> nil);
  AIntent.putExtra(TJIntent.EXTRA_TEXT, S2Js(AText));
end;

function TSharingManagerAndroid.CreateSharingIntent(const DataType
  : TSharingDataType): JIntent;
var
  MIMETypes: string;
  Intent: JIntent;
begin
  Intent := TJIntent.Create;
  MIMETypes := GetSharingMIMETypes(DataType);
  if TSharingDataType.Any = DataType then
    Intent.setAction(TJIntent.ACTION_SEND_MULTIPLE)
  else
    Intent.setAction(TJIntent.ACTION_SEND);
  Intent.setType(S2Js(MIMETypes));
  Intent.setFlags(TJIntent.FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET);
  Intent.addFlags(TJIntent.FLAG_GRANT_READ_URI_PERMISSION);
  result := Intent;
end;

function TSharingManagerAndroid.GetChooserCaption(const DataTypes
  : TSharingDataType): string;
begin
  result := 'Send to...';
end;

function TSharingManagerAndroid.GetSharingMIMETypes(const DataTypes
  : TSharingDataType): string;
begin
  // See details http://developer.android.com/training/sharing/send.html#send-multiple-content
  // For TSharingDataType.Any we don't set / because in this case SMS/MMS application opens with empty field
  // without text and image (SMS/MMS don't work with either types of data)

  case DataTypes of
    TSharingDataType.Image:
      result := 'image/png';
    TSharingDataType.Text:
      result := 'text/plain';
    TSharingDataType.Any:
      result := 'image/png;text/plain'
  else
    result := '*/*';
  end;
end;

procedure TSharingManagerAndroid.Share(const AText: string;
  const AImage: TfgBitmap);

  function DefineDataTypes: TSharingDataType;
  var
    DataType: TSharingDataType;
  begin
    DataType := TSharingDataType.None;
    if not AText.IsEmpty and (AImage <> nil) and not AImage.IsEmpty then
      DataType := TSharingDataType.Any
    else if not AText.IsEmpty then
      DataType := TSharingDataType.Text
    else if (AImage <> nil) and not AImage.IsEmpty then
      DataType := TSharingDataType.Image;

    result := DataType;
  end;

var
  Intent: JIntent;
  IntentChooser: JIntent;
  ChooserCaption: string;
begin
  FDataType := DefineDataTypes;
  if FDataType <> TSharingDataType.None then
    try
      Intent := CreateSharingIntent(FDataType);
      case FDataType of
        TSharingDataType.Image:
          AddImage(Intent, AImage);
        TSharingDataType.Text:
          AddText(Intent, AText);
        TSharingDataType.Any:
          begin
            AddText(Intent, AText);
            AddImage(Intent, AImage);
          end;
      end;

      { Create chooser of activity }

      ChooserCaption := GetChooserCaption(FDataType);

      IntentChooser := TJIntent.createChooser(Intent,
        StringToJCharSequence(ChooserCaption));
      TfgAndroidHelper.Activity.startActivity(IntentChooser);
    finally
      FDataType := TSharingDataType.None;
    end;
end;
{ TfgCameraDialog }

constructor TfgCameraDialog.Create;

begin
  TMessageManager.DefaultManager.SubscribeToMessage(TfgActivityResultMessage,
    ResultCallback);
  FFileName := TPath.GetTempFileName + '.jpg';
end;

destructor TfgCameraDialog.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TfgActivityResultMessage,
    ResultCallback);
  inherited;
end;

procedure TfgCameraDialog.Execute(Proc: TProc<boolean>);
var
  Intent: JIntent;
  U: JUri;
begin
  FProc := Proc;
  U := TfgAndroidHelper.GetUriForFileName(FFileName);
  Intent := TJIntent.Create(TJMediaStore.ACTION_IMAGE_CAPTURE);
  Intent.putExtra(TJMediaStore.EXTRA_OUTPUT, TJParcelable.Wrap(U));
  TfgAndroidHelper.Activity.startActivityForResult(Intent, CAMERA_REQUEST_CODE);
end;

function TfgCameraDialog.GetFileName: String;
begin
  result := FFileName;
end;

procedure TfgCameraDialog.ResultCallback(const Sender: TObject;
  const M: TMessage);
begin
  if TfgActivityResultMessage(M).RequestCode = CAMERA_REQUEST_CODE then
  begin
    if TfgActivityResultMessage(M).ResultCode = TJActivity.RESULT_OK then
    begin
      FProc(True);
    end
    else
      FProc(False);
  end;

end;

procedure TfgCameraDialog.SetFileName(const Value: String);
begin
  FFileName := Value;
end;

end.
