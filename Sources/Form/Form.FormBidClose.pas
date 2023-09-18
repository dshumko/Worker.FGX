unit Form.FormBidClose;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseForm, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar, FGX.DateTimeControl, FGX.TimeEdit,
  FGX.DateEdit, FGX.ComboBox, FGX.Button.Types, FGX.Button, FGX.Memo,
  Base.BaseApiForm, Frame.FormBidInfo, FGX.ScrollBox;

type
  TmwFormBidClose = class(TmwBaseForm)
    lbTextDateTime: TfgLabel;
    lbTextTroubleDescr: TfgLabel;
    cbResult: TfgComboBox;
    fgLayout1: TfgLayout;
    deBidComplete: TfgDateEdit;
    teBidComplete: TfgTimeEdit;
    mmTextResult: TfgMemo;
    fgLayout2: TfgLayout;
    bnMaterials: TfgButton;
    pnResultTextTitle: TfgLayout;
    fgLabel2: TfgLabel;
    tiSelect: TfgComboBoxTextItem;
    tiDone: TfgComboBoxTextItem;
    tiCanceled: TfgComboBoxTextItem;
    tiUnable: TfgComboBoxTextItem;
    fpnResultTitle: TfgLayout;
    fgLabel1: TfgLabel;
    pnEditor: TfgScrollBox;
    keyboardSpacer: TfgLayout;
    fgLayout3: TfgLayout;
    bnBidClose: TfgButton;
    bnWorks: TfgButton;
    procedure bnBidCloseTap(Sender: TObject);
    procedure nbFormActionButtons0Tap(Sender: TObject);
    procedure bnMaterialsTap(Sender: TObject);
    procedure fgFormVirtualKeyboardFrameChanged(Sender: TObject; const AVKFrame: TRectF);
    procedure bnWorksTap(Sender: TObject);
  private
    FObjectId: Integer;
    FParentForm: TmwFormBidInfo;
    function SaveBidToFile: boolean;
    procedure SetParentForm(const Value: TmwFormBidInfo);
  public
    property ParentForm: TmwFormBidInfo read FParentForm write SetParentForm;
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant);
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.DateUtils, System.Threading, Posix.Unistd,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  ServiceUnit.Utils, ServiceUnit.API, ServiceUnit.Settings,
  Form.BidPhoto, Form.Materials, Form.Works;

{ TmwFormBidClose }

procedure TmwFormBidClose.AfterLoad;
var
  aResult, aUnixDateTime: Integer;
  aResultText: string;
  aDT: TDateTime;
begin
  inherited;
  LoadLocalBidText(FObjectId, aResult, aResultText, aUnixDateTime);
  mmTextResult.Text := aResultText;
  if aResult > 0 then
    cbResult.itemIndex := aResult - 1
  else
    cbResult.itemIndex := 0;
  aDT := UnixToDateTime(aUnixDateTime, false);
  deBidComplete.Date := DateOf(aDT);
  teBidComplete.Time := TimeOf(aDT);

end;

procedure TmwFormBidClose.bnBidCloseTap(Sender: TObject);
var
  aJSON: string;
  API: TmwAPI;
begin
  inherited;
  if not SaveBidToFile then
    Exit;
  AnimationStart();
  TTask.Run(
    procedure
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        API.closeBid(FObjectId);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if API.Err.Code <> 0 then
            begin
              AnimationStop();
              TfgToastFactory.Show(API.Err.Msg)
            end
            else
            begin
              TfgToastFactory.Show('Заявка закрыта');
              aJSON := generateBid(FObjectId);
              if FileExists(aJSON) then
                DeleteFile(aJSON);
              ParentForm.CloseForm;
              Close;
            end;
          end)
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormBidClose.bnMaterialsTap(Sender: TObject);
var
  fmMaterials: TmwFormMaterials;
begin
  inherited;
  fmMaterials := TmwFormMaterials.Create(Application);
  fmMaterials.SetParams([FObjectId]);
  fmMaterials.ShowForm(Format('Закрыть заявку: %d', [FObjectId]));
end;

procedure TmwFormBidClose.bnWorksTap(Sender: TObject);
var
  fmWorks: TmwFormWorks;
begin
  inherited;
  fmWorks := TmwFormWorks.Create(Application);
  fmWorks.SetParams([FObjectId]);
  fmWorks.ShowForm(Format('Закрыть заявку: %d', [FObjectId]));
end;

procedure TmwFormBidClose.fgFormVirtualKeyboardFrameChanged(Sender: TObject; const AVKFrame: TRectF);
begin
  inherited;
  keyboardSpacer.Height := AVKFrame.Height;
end;

procedure TmwFormBidClose.nbFormActionButtons0Tap(Sender: TObject);
var
  fmBidPhoto: TmwFormBidPhoto;
begin
  inherited;
  fmBidPhoto := TmwFormBidPhoto.Create(Application);
  fmBidPhoto.SetParams([FObjectId]);
  fmBidPhoto.ShowForm(Format('Фото заявки: %d', [FObjectId]));
end;

function TmwFormBidClose.SaveBidToFile: boolean;
begin
  Result := false;
  if cbResult.itemIndex = 0 then
  begin
    TfgToastFactory.Show('Укажите результат');
    Exit;
  end;
  if mmTextResult.Text.IsEmpty then
  begin
    TfgToastFactory.Show('Описание не указано');
    Exit;
  end;
  SaveLocalBidText(FObjectId, cbResult.itemIndex + 1, mmTextResult.Text,
    DateTimeToUnix(DateOf(deBidComplete.Date) + TimeOf(teBidComplete.Time), false));
  if FileExists(generateBid(FObjectId)) then
    Result := true
  else
    TfgToastFactory.Show('Ошибка сохранения файла заявки');

end;

procedure TmwFormBidClose.SetParams(Values: array of Variant);
begin
  if Length(Values) > 2 then
  begin
    FObjectId := Values[0];
    lbTextDateTime.Text := Values[1];
    lbTextTroubleDescr.Text := Format('%d, %s', [FObjectId, Values[2]]);
  end;
end;

procedure TmwFormBidClose.SetParentForm(const Value: TmwFormBidInfo);
begin
  FParentForm := Value;
end;

end.
