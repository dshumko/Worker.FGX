unit Form.BidPhoto;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseForm, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar, FGX.Button.Types, FGX.Image,
  FGX.Button, FGX.Pickers.Photo;

type
  TmwFormBidPhoto = class(TmwBaseForm)
    fgLayout2: TfgLayout;
    bnSave: TfgButton;
    pnPhoto1: TfgLayout;
    pnPhoto2: TfgLayout;
    imPhoto1: TfgImage;
    imPhoto2: TfgImage;
    bnTakePhoto1: TfgButton;
    bnTakePhoto2: TfgButton;
    bnDelPhoto1: TfgButton;
    bnDelPhoto2: TfgButton;
    btnxFile1: TfgButton;
    btnxFile2: TfgButton;
    procedure bnTakePhotoTap(Sender: TObject);
    procedure bnSaveTap(Sender: TObject);
    procedure bnDelPhotoTap(Sender: TObject);
    procedure fgFormClose(Sender: TObject; var AAction: TfgFormCloseAction);
    procedure btnxFile1Tap(Sender: TObject);
  private
    FObjectId: Integer;
    procedure ProcessFile(AFileName: String; Tag: Integer);
    procedure ShowPhotos;
    function ShowPhoto(Tag: Integer): string;
  public
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant); virtual;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.StrUtils,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Canvas, FGX.Permissions,
  FGX.Assets, FGX.Assets.Helpers, FGX.Assets.BitMapSet, FGX.Toasts,
  FGX.Any.Utils, FGX.Pickers.Media,
  Posix.Unistd, ServiceUnit.Utils;

procedure TmwFormBidPhoto.btnxFile1Tap(Sender: TObject);
begin
  inherited;
  // TfgPermissionService.RequestPermissionsAsync(['android.permission.READ_EXTERNAL_STORAGE'],
  // procedure(const APermissionInfo: TArray<TfgPermissionInfo>)
  // begin
  // case APermissionInfo[0].CheckResult of
  // TPermissionCheckResult.Granted:
  TfgPickerPhotoFactory.PickPhotoFromLibrary(Sender,
    procedure(const AFileNames: TfgMediaFiles)
    begin
      ProcessFile(AFileNames[0], (Sender as TfgButton).Tag);
    end)
  // else
  // TfgToastFactory.Show('Read storage permission is not granted. Cannot wotk with gallery.',
  // TfgToastDuration.Long);
  // end;
  // end);
end;

procedure TmwFormBidPhoto.bnTakePhotoTap(Sender: TObject);
begin
  // TfgPermissionService.RequestPermissionsAsync(['android.permission.CAMERA', 'android.permission.WRITE_EXTERNAL_STORAGE'],
  // procedure(const APermissionInfo: TArray<TfgPermissionInfo>)
  // begin
  // case APermissionInfo[0].CheckResult of
  // TPermissionCheckResult.Granted:
  TfgPickerPhotoFactory.PickPhotoFromCamera(Sender,
    procedure(const AFileNames: TfgMediaFiles)
    begin
      ProcessFile(AFileNames[0], (Sender as TfgButton).Tag);
    end)
  // else
  // TfgToastFactory.Show('Camera permission is not granted. Cannot wotk with camera.', TfgToastDuration.Long);
  // end;
  // end);
end;

procedure TmwFormBidPhoto.ProcessFile(AFileName: String; Tag: Integer);
var
  Bmp: TfgBitmap;
  Photo: string;
  Lat, Lon: Double;
begin
  Bmp := PrepareBitmapFromFile(AFileName, 800, Lat, Lon, True);
  Photo := 'photo' + IntToStr(FObjectId) + '_' + IntToStr(Tag) + '.jpg';
  TfgAssetsManager.Current.AddBitmap(Photo, Bmp);
  if Tag = 0 then
    imPhoto1.ImageName := ShowPhoto(Tag)
  else
    imPhoto2.ImageName := ShowPhoto(Tag);
  DeleteFile(AFileName);
end;

procedure TmwFormBidPhoto.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
  begin
    FObjectId := Values[0];
  end;
end;

function TmwFormBidPhoto.ShowPhoto(Tag: Integer): string;
var
  Photo: string;
  F: TfgAssetBitmapSet;
  oId: string;
  aImage: TfgBitmap;
begin
  aImage := nil;
  oId := IntToStr(FObjectId);
  Photo := 'photo' + oId + '_' + IntToStr(Tag) + '.jpg';
  if TfgAssetsManager.Current.Find(Photo, F) then
  begin
    Result := Photo;
  end
  else
  begin
    RemoveAssetDirectory(Photo);
    Result := '';
    LoadLocalBidPhoto(FObjectId, Tag, aImage);
    if Assigned(aImage) then
    begin
      TfgAssetsManager.Current.AddBitmap(Photo, aImage);
      Result := Photo;
    end;
  end;
end;

procedure TmwFormBidPhoto.ShowPhotos;
begin
  imPhoto1.ImageName := '';
  if FObjectId > 0 then
  begin
    imPhoto1.ImageName := ShowPhoto(0);
    imPhoto2.ImageName := ShowPhoto(1);
  end
  else
  begin
    imPhoto1.ImageName := '';
    imPhoto2.ImageName := '';
  end;
end;

procedure TmwFormBidPhoto.AfterLoad;
begin
  inherited;
  ShowPhotos;
end;

procedure TmwFormBidPhoto.bnDelPhotoTap(Sender: TObject);
begin
  inherited;
  if TfgControl(Sender).Tag = 0 then
  begin
    TfgAssetsManager.Current.Remove(imPhoto1.ImageName);
    imPhoto1.ImageName := '';
  end
  else
  begin
    TfgAssetsManager.Current.Remove(imPhoto2.ImageName);
    imPhoto2.ImageName := '';
  end;
end;

procedure TmwFormBidPhoto.bnSaveTap(Sender: TObject);
var
  F: TfgAssetBitmapSet;
  B: TfgBitmap;
begin
  inherited;
  RemoveBidPhotos(FObjectId);
  if TfgAssetsManager.Current.Find(imPhoto1.ImageName, F) then
  begin
    B := F.GetBitmap;
    if Assigned(B) then
      SaveLocalBidPhoto(FObjectId, 0, B);
  end;
  if TfgAssetsManager.Current.Find(imPhoto2.ImageName, F) then
  begin
    B := F.GetBitmap;
    if Assigned(B) then
      SaveLocalBidPhoto(FObjectId, 1, B);
  end;
  Close;
end;

procedure TmwFormBidPhoto.fgFormClose(Sender: TObject; var AAction: TfgFormCloseAction);
begin
  inherited;
  TfgAssetsManager.Current.Remove(imPhoto1.ImageName);
  TfgAssetsManager.Current.Remove(imPhoto2.ImageName);
end;

end.
