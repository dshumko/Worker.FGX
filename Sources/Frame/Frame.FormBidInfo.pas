unit Frame.FormBidInfo;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, ServiceUnit.BookMarks, FGX.Image,
  FGX.CardPanel, FGX.Button.Types, FGX.Button, FGX.AutocompleteEdit.Types,
  FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit;

type
  TBidInfoItemType = (ltHeader, ltBidHeader, ltCustomer, ltHouseInfo, ltBidInfo, ltService, ltPhone);

type
  TBidInfoItem = class
  public
    IsHeader: boolean;
    TextPrimary: string;
    TextSecondary: string;
    Icon: string;
    Id: integer;
    Kind: TBidInfoItemType;
    constructor Create(AIsHeader: boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
      AKind: TBidInfoItemType);
  end;

type
  TmwFormBidInfo = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbPrimary: TfgLabel;
    imIcon: TfgImage;
    lvContent_Style2: TfgCollectionViewStyle;
    lbHeaderPrimary: TfgLabel;
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    fgLayout1: TfgLayout;
    fgLabel2: TfgLabel;
    pnButtons: TfgLayout;
    bnBidDo: TfgButton;
    bnBidJoin: TfgButton;
    bnBidRefuse: TfgButton;
    bnBidClose: TfgButton;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure nbFormActionButtons0Tap(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure bnBidCloseTap(Sender: TObject);
    procedure bnBidRefuseTap(Sender: TObject);
    procedure bnBidDoTap(Sender: TObject);
    procedure bnBidJoinTap(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FObjectId: integer;
    FBidInfo: TmwBidInfoItem;
    FCurrentList: TObjectList<TBidInfoItem>;
    procedure BookmarkUpdate;
    procedure RebuildActionsPanel;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant); override;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts, FGX.PhoneDialer,
  Posix.Unistd, Form.Main, Frame.FormHouse, Frame.FormCustomer,
  Form.FormBidClose, ServiceUnit.Utils, ServiceUnit.Settings, Assets.Consts;

const
  WhoseMy = 1;
  WhoseSomeOne = 0;
  WhoseNoOne = -1;

  WhoseUndefined = -2;

  { TmwFormBidInfo }

procedure TmwFormBidInfo.AfterLoad;
var
  item: TBidInfoItem;
  i: integer;
  aPhones: TArray<string>;
begin
  // nbForm.Subtitle := FBidInfo.name;
  BookmarkUpdate;
  RebuildActionsPanel;
  nbForm.Subtitle := IntToStr(FBidInfo.Id);
  FCurrentList.Clear;
  item := TBidInfoItem.Create(false, FBidInfo.plan_str, Format('%d, %s', [FBidInfo.Id, FBidInfo.type_name]), '', -1,
    TBidInfoItemType.ltBidHeader);
  FCurrentList.Add(item);
  item := TBidInfoItem.Create(true, 'Абонент', '', '', -1, TBidInfoItemType.ltHeader);
  FCurrentList.Add(item);
  item := TBidInfoItem.Create(false, FBidInfo.fio, Format('Лицевой %s, Баланс = %s',
    [FBidInfo.account, FBidInfo.balance]), R.Bitmap.ICONS_CHEVRON_RIGHT, FBidInfo.customer_id,
    TBidInfoItemType.ltCustomer);
  FCurrentList.Add(item);
  if not FBidInfo.phones.IsEmpty then
  begin
    item := TBidInfoItem.Create(true, 'Позвонить', '', '', -1, TBidInfoItemType.ltHeader);
    FCurrentList.Add(item);
    aPhones := PhonesSplit(FBidInfo.phones);
    for i := Low(aPhones) to High(aPhones) do
    begin
      item := TBidInfoItem.Create(false, aPhones[i], '', R.Bitmap.ICONS_PHONE, -1, TBidInfoItemType.ltPhone);
      FCurrentList.Add(item)
    end
  end;
  if FBidInfo.services.Count > 0 then
  begin
    item := TBidInfoItem.Create(true, 'Подключенные услуги', '', '', -1, TBidInfoItemType.ltHeader);
    FCurrentList.Add(item);
    for i := 0 to FBidInfo.services.Count - 1 do
    begin
      item := TBidInfoItem.Create(false, FBidInfo.services[i].name, FBidInfo.services[i].tarif, // ???
        '', -1, TBidInfoItemType.ltService);
      FCurrentList.Add(item);
    end;
  end;
  item := TBidInfoItem.Create(true, 'Адрес', '', '', -1, TBidInfoItemType.ltHeader);
  FCurrentList.Add(item);
  item := TBidInfoItem.Create(false, FBidInfo.adress, '', R.Bitmap.ICONS_CHEVRON_RIGHT, FBidInfo.house_id,
    TBidInfoItemType.ltHouseInfo);
  FCurrentList.Add(item);
  item := TBidInfoItem.Create(false, FBidInfo.content, '', R.Bitmap.ICONS_CHEVRON_RIGHT, FBidInfo.house_id,
    TBidInfoItemType.ltBidInfo);
  FCurrentList.Add(item);
  inherited;
end;

procedure TmwFormBidInfo.bnBidCloseTap(Sender: TObject);
var
  fmBidClose: TmwFormBidClose;
begin
  inherited;
  fmBidClose := TmwFormBidClose.Create(Application);
  fmBidClose.SetParams([FObjectId, FBidInfo.plan_str, FBidInfo.type_name]);
  fmBidClose.ParentForm := Self;
  fmBidClose.ShowForm(Format('Закрыть заявку: %d', [FObjectId]));
end;

procedure TmwFormBidInfo.bnBidDoTap(Sender: TObject);
var
  API: TmwAPI;
begin
  AnimationStart();
  TTask.Run(
    procedure
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        API.TakeBid(FObjectId);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if API.Err.Code <> 0 then
              TfgToastFactory.Show(API.Err.Msg);
            Load;
          end)
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormBidInfo.bnBidJoinTap(Sender: TObject);
var
  API: TmwAPI;
begin
  AnimationStart();
  TTask.Run(
    procedure
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        API.JoinBid(FObjectId);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if API.Err.Code <> 0 then
              TfgToastFactory.Show(API.Err.Msg);
            Load;
          end)
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormBidInfo.bnBidRefuseTap(Sender: TObject);
var
  API: TmwAPI;
  aJSON: string;
begin
  aJSON := generateBid(FObjectId);
  AnimationStart();
  if FileExists(aJSON) then
    DeleteFile(aJSON);
  TTask.Run(
    procedure
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        API.RefuseBid(FObjectId);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if API.Err.Code <> 0 then
              TfgToastFactory.Show(API.Err.Msg);
            Load;
          end)
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormBidInfo.BookmarkUpdate;
var
  s: String;
begin
  s := Self.ClassName;
  nbForm.ActionButtons.ByName['bnBookmark'].Tag := BookMarks.ContainsBookMark(s, FObjectId);
  if nbForm.ActionButtons.ByName['bnBookmark'].Tag = -1 then
    nbForm.ActionButtons.ByName['bnBookmark'].IconName := R.Bitmap.ICONS_BOOKMARK_BORDER
  else
    nbForm.ActionButtons.ByName['bnBookmark'].IconName := R.Bitmap.ICONS_BOOKMARK
end;

procedure TmwFormBidInfo.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := -1;
  FBidInfo := TmwBidInfoItem.Create();
  FCurrentList := TObjectList<TBidInfoItem>.Create(true);
end;

procedure TmwFormBidInfo.fgFormDestroy(Sender: TObject);
begin
  FBidInfo.Free;
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormBidInfo.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
const AItem: TfgItemWrapper);
var
  ASize: TSizeF;
  ALabel: TfgLabel;
  s: String;
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  if AStyle = 'Style-Secondary' then
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
  if (AStyle <> 'Style-Header') and (AStyle <> 'Style-Content') then
    AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FCurrentList[AIndex].Icon;

  if AStyle = 'Style-Content' then
  begin
    s := StringReplace(FCurrentList[AIndex].TextPrimary, '\r\n', sLineBreak, [rfReplaceAll, rfIgnoreCase]);
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := s;
    ALabel := AItem.GetControlByLookupName<TfgLabel>('primary');
    if Assigned(ALabel) then
    begin
      if ALabel.Text.IsEmpty then
      begin
        ASize.cy := 0;
        ASize.cx := AItem.GetControlByLookupName<TfgLayout>('Layout1').Size.Width;
      end
      else
        ASize := ALabel.MeasureSize(TfgMeasuringSpecification.Fixed, AItem.GetControlByLookupName<TfgLayout>('Layout1')
          .Size.Width, TfgMeasuringSpecification.Unspecified, 0);

      AItem.GetControlByLookupName<TfgLayout>('Layout1').Size.Height := ASize.cy + 5;
      AItem.item.Height := AItem.GetControlByLookupName<TfgLayout>('Layout1').Size.Height + 5;
      AItem.item.Realign;
    end;
  end;
end;

function TmwFormBidInfo.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormBidInfo.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  inherited;
  case FCurrentList[AIndex].Kind of
    TBidInfoItemType.ltBidHeader, TBidInfoItemType.ltCustomer:
      Result := 'Style-Secondary';
    TBidInfoItemType.ltHeader:
      Result := 'Style-Header';
    TBidInfoItemType.ltBidInfo:
      Result := 'Style-Content';
  else
    Result := 'Style-Single';
  end;
end;

procedure TmwFormBidInfo.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormBidInfo.lvContentTapItem(Sender: TObject; const AIndex: integer);
var
  name, title, Subtitle: string;
begin
  inherited;
  name := Self.name;
  title := nbForm.title;
  Subtitle := nbForm.Subtitle;
  if FCurrentList[AIndex].Kind = TBidInfoItemType.ltHouseInfo then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormHouse, [FCurrentList[AIndex].Id], 'Дом', FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormBidInfo, Name, [FObjectId, AIndex], title, Subtitle);
  end
  else if FCurrentList[AIndex].Kind = TBidInfoItemType.ltCustomer then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormCustomer, [FCurrentList[AIndex].Id], 'Абонент', FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormBidInfo, Name, [FObjectId, AIndex], title, Subtitle);
  end
  else if FCurrentList[AIndex].Kind = TBidInfoItemType.ltPhone then
  begin
{$IFDEF ANDROID}
    DoExternalCall(FCurrentList[AIndex].TextPrimary);
{$ELSE}
    TfgPhoneDialer.Call(FCurrentList[AIndex].TextPrimary);
{$ENDIF}
  end;
end;

procedure TmwFormBidInfo.nbFormActionButtons0Tap(Sender: TObject);
var
  s: String;
begin
  inherited;
  s := Self.ClassName;
  if nbForm.ActionButtons.ByName['bnBookmark'].Tag = -1 then
    BookMarks.AddBookMark(s, FObjectId, nbForm.Subtitle)
  else
    BookMarks.DeleteBookMark(s, FObjectId);
  BookmarkUpdate;
end;

procedure TmwFormBidInfo.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormBidInfo.RebuildActionsPanel;
begin
  if FBidInfo.whose = WhoseNoOne then
  begin
    bnBidDo.Visible := true;
    bnBidClose.Visible := false;
    bnBidRefuse.Visible := false;
    bnBidJoin.Visible := false;
  end
  else if FBidInfo.whose = WhoseMy then
  begin
    bnBidDo.Visible := false;
    bnBidRefuse.Visible := true;
    bnBidClose.Visible := true;
    bnBidJoin.Visible := false;
  end
  else if FBidInfo.whose = WhoseSomeOne then
  begin
    bnBidDo.Visible := false;
    bnBidRefuse.Visible := false;
    bnBidClose.Visible := false;
    bnBidJoin.Visible := true;
  end
  else
  begin
    bnBidDo.Visible := false;
    bnBidRefuse.Visible := false;
    bnBidClose.Visible := false;
    bnBidJoin.Visible := false;
  end;
  pnButtons.Visible := (bnBidJoin.Visible or bnBidClose.Visible or bnBidRefuse.Visible or bnBidDo.Visible);
  pnButtons.Realign;
end;

procedure TmwFormBidInfo.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 0 then
    FObjectId := Values[0];
  if Length(Values) > 1 then
    FLVStartIndex := Values[1];
end;

procedure TmwFormBidInfo.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetBidInfo(FObjectId);
end;

procedure TmwFormBidInfo.ThreadFillData(API: TmwAPI);
begin
  inherited;
  FBidInfo.LoadFromJSON(API.ResultJson['struct'].AsObject);
  bnBidDo.OnTap := bnBidDoTap;
  bnBidJoin.OnTap := bnBidJoinTap;
  bnBidRefuse.OnTap := bnBidRefuseTap;
  bnBidClose.OnTap := bnBidCloseTap;
end;

{ TBidInfoItem }

constructor TBidInfoItem.Create(AIsHeader: boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
AKind: TBidInfoItemType);
begin
  IsHeader := AIsHeader;
  TextPrimary := ATextPrimary;
  TextSecondary := ATextSecondary;
  Icon := AIcon;
  Id := AId;
  Kind := AKind;
end;

end.
