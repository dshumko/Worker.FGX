unit Frame.FormCustomer;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, ServiceUnit.BookMarks, FGX.Image,
  FGX.CardPanel, FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit,
  FGX.SearchEdit, FGX.Button.Types, FGX.Button;

type
  TCustomerItemType = (ltCustomerData, ltHeader, ltBalance, ltHouseInfo, ltEquipment, ltService, ltPhone, ltNotice,
    ltParentEquipment);

type
  TCustomerItem = class
  public
    isHeader: Boolean;
    TextPrimary: string;
    TextSecondary: string;
    Icon: string;
    Id: integer;
    ItemType: integer;
    Kind: TCustomerItemType;
    constructor Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
      AItemType: integer; AKind: TCustomerItemType);
  end;

type
  TmwFormCustomer = class(TmwBaseListViewForm)
    lvContent_StyleHeader: TfgCollectionViewStyle;
    lbHeaderPrimary: TfgLabel;
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    lvContent_StyleSingle: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbSinglePrimary: TfgLabel;
    imSingle: TfgImage;
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    fgCardPanel3: TfgCardPanel;
    fgLabel2: TfgLabel;
    bnEdit: TfgButton;
    procedure nbFormActionButtons0Tap(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure bnEditTap(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FCustomer: TmwCustomerItem;
    FObjectId: integer;
    FCurrentList: TObjectList<TCustomerItem>;
    procedure BookmarkUpdate;
    procedure DoPing(const Id, eType: integer);
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant); override;
  end;

implementation

{$R *.xfm}
// TODo оборудование, редактирование

uses
  System.SysUtils, System.StrUtils, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.PhoneDialer,
  FGX.Toasts, FGX.Animation,
  XSuperObject, ServiceUnit.Utils, ServiceUnit.Settings,
  Form.Main, Frame.FormCustomers, Form.NewAbonent, Frame.FormEquipment,
  Assets.Consts;

{ TmwFormCustomer }

procedure TmwFormCustomer.AfterLoad;
var
  item: TCustomerItem;
  i: integer;
  aPhones: TArray<string>;
  curParentId: integer;
begin
  BookmarkUpdate;
  nbForm.Subtitle := Format('Лицевой: %s', [FCustomer.account]);
  FCurrentList.Clear;
  item := TCustomerItem.Create(false, String.Join(' ', [FCustomer.firstname, FCustomer.midlename, FCustomer.surname]),
    '', '', -1, -1, TCustomerItemType.ltCustomerData);
  FCurrentList.Add(item);
  item := TCustomerItem.Create(true, 'Баланс', '', '', -1, -1, TCustomerItemType.ltHeader);
  FCurrentList.Add(item);
  item := TCustomerItem.Create(false, FCustomer.balance, '', '', -1, -1, TCustomerItemType.ltBalance);
  FCurrentList.Add(item);
  if not FCustomer.phones.IsEmpty then
  begin
    item := TCustomerItem.Create(true, 'Позвонить', '', '', -1, -1, TCustomerItemType.ltHeader);
    FCurrentList.Add(item);
    aPhones := PhonesSplit(FCustomer.phones);
    for i := Low(aPhones) to High(aPhones) do
    begin
      item := TCustomerItem.Create(false, aPhones[i], '', R.Bitmap.ICONS_PHONE, -1, -1, TCustomerItemType.ltPhone);
      FCurrentList.Add(item)
    end
  end;
  if not FCustomer.notice.IsEmpty then
  begin
    item := TCustomerItem.Create(true, 'Примечание', '', '', -1, -1, TCustomerItemType.ltHeader);
    FCurrentList.Add(item);
    item := TCustomerItem.Create(false, FCustomer.notice, '', '', -1, -1, TCustomerItemType.ltNotice);
    FCurrentList.Add(item);
  end;
  item := TCustomerItem.Create(true, 'Адрес', '', '', -1, -1, TCustomerItemType.ltHeader);
  FCurrentList.Add(item);
  item := TCustomerItem.Create(false, String.Join(', ', [FCustomer.street, FCustomer.house, FCustomer.flat]), '',
    R.Bitmap.ICONS_CHEVRON_RIGHT, FCustomer.house_id, -1, TCustomerItemType.ltHouseInfo);
  FCurrentList.Add(item);
  if FCustomer.services.Count > 0 then
  begin
    item := TCustomerItem.Create(true, 'Подключенные услуги', '', '', -1, -1, TCustomerItemType.ltHeader);
    FCurrentList.Add(item);
    for i := 0 to FCustomer.services.Count - 1 do
    begin
      item := TCustomerItem.Create(false, FCustomer.services[i].name, FCustomer.services[i].tarif, // ???
        '', -1, -1, TCustomerItemType.ltService);
      FCurrentList.Add(item);
    end;
  end;
  if FCustomer.equipment.Count > 0 then
  begin
    item := TCustomerItem.Create(true, 'Оборудование', '', '', -1, -1, TCustomerItemType.ltHeader);
    FCurrentList.Add(item);
    curParentId := -1;
    FCustomer.equipment.Sort;
    for i := 0 to FCustomer.equipment.Count - 1 do
    begin
      if FCustomer.equipment[i].parent_id <> curParentId then
      begin
        item := TCustomerItem.Create(false, 'Подключен к:', FCustomer.equipment[i].parent_name,
          R.Bitmap.ICONS_CHEVRON_RIGHT, FCustomer.equipment[i].parent_id, -1, TCustomerItemType.ltParentEquipment);
        FCurrentList.Add(item);
        curParentId := FCustomer.equipment[i].parent_id;
      end;
      item := TCustomerItem.Create(false, IfThen(FCustomer.equipment[i].port.IsEmpty, FCustomer.equipment[i].name,
        Format('[ %s ] %s', [FCustomer.equipment[i].port, FCustomer.equipment[i].name])), FCustomer.equipment[i].mac,
        R.Bitmap.ICONS_CHEVRON_RIGHT, FCustomer.equipment[i].Id, FCustomer.equipment[i].e_type.ToInteger,
        TCustomerItemType.ltEquipment);
      FCurrentList.Add(item);
    end;
  end;
  inherited;

end;

procedure TmwFormCustomer.bnEditTap(Sender: TObject);
var
  fNewAbonent: TmwFormNewAbonent;
begin
  inherited;
  fNewAbonent := TmwFormNewAbonent.Create(Application);
  fNewAbonent.SetParams(FCustomer);
  fNewAbonent.OnApplyParameters := procedure(const AResult: Boolean)
    begin
      if AResult then
        Load;
    end;
  fNewAbonent.ShowForm('Абонент', '');
end;

procedure TmwFormCustomer.BookmarkUpdate;
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

procedure TmwFormCustomer.DoPing(const Id, eType: integer);
var
  API: TmwAPI;
  aJson: string;
begin
  TfgToastFactory.Show('Ping');
  TTask.Run(
    procedure
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        aJson := API.ActionEquipment(Id, eType);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            TfgDialogs.ShowMessage(API.ResultJson['result'].AsString);
          end);
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormCustomer.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCustomer := TmwCustomerItem.Create();
  FObjectId := 0;
  FCurrentList := TObjectList<TCustomerItem>.Create(true);
  bnEdit.Visible := Formmain.Rights.AbEdit;
end;

procedure TmwFormCustomer.fgFormDestroy(Sender: TObject);
begin
  FCustomer.Free;
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormCustomer.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
const AItem: TfgItemWrapper);
var
  NewHeight: Single;
begin
  inherited;
  if FCurrentList[AIndex].Kind = TCustomerItemType.ltCustomerData then
  begin
    if (FCustomer.Id <> -1) and (FCustomer.services.Count = 0) then
    begin
      if FCustomer.balance.ToSingle < 0 then
        AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_CUSTOMERPAYMENTSOUT
      else
        AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_CUSTOMEROFF
    end;
  end;

  if AStyle = 'Style-Notice' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  end
  else
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  if AStyle = 'Style-Secondary' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
    NewHeight := AItem.GetControlByLookupName<TfgLabel>('primary').MeasureSize(TfgMeasuringSpecification.Fixed,
      Width - 16, TfgMeasuringSpecification.Unspecified, 0).Height + AItem.GetControlByLookupName<TfgLabel>('secondary')
      .Size.Height + 8;
    AItem.item.Height := NewHeight;
    AItem.item.Realign;
  end;
  if (AStyle <> 'Style-Header') and (AStyle <> 'Style-Notice') then
    AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FCurrentList[AIndex].Icon;
  if AStyle = 'Style-Notice' then
  begin
    NewHeight := AItem.GetControlByLookupName<TfgLabel>('primary').MeasureSize(TfgMeasuringSpecification.Fixed,
      Width - 16, TfgMeasuringSpecification.Unspecified, 0).Height + 16;
    AItem.item.Height := NewHeight;
    AItem.item.Realign;
  end;
end;

function TmwFormCustomer.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormCustomer.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  inherited;
  case FCurrentList[AIndex].Kind of
    TCustomerItemType.ltEquipment, TCustomerItemType.ltParentEquipment, TCustomerItemType.ltService:
      Result := 'Style-Secondary';
    TCustomerItemType.ltNotice:
      Result := 'Style-Notice';
    TCustomerItemType.ltHeader:
      Result := 'Style-Header';
  else
    Result := 'Style-Single';
  end;
end;

procedure TmwFormCustomer.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormCustomer.lvContentTapItem(Sender: TObject; const AIndex: integer);
var
  name, title, Subtitle: string;
begin
  inherited;
  name := Self.name;
  title := nbForm.title;
  Subtitle := nbForm.Subtitle;
  case FCurrentList[AIndex].Kind of
    TCustomerItemType.ltPhone:
      begin
{$IFDEF ANDROID}
        DoExternalCall(FCurrentList[AIndex].TextPrimary);
{$ELSE}
        TfgPhoneDialer.Call(FCurrentList[AIndex].TextPrimary);
{$ENDIF}
      end;
    TCustomerItemType.ltHouseInfo:
      begin
        CloseMe(Self, true);
        Formmain.RunFrame(TmwFormCustomers, [FCurrentList[AIndex].Id], 'Абоненты', FCurrentList[AIndex].TextPrimary);
        Formmain.AddToStack(TmwFormCustomer, Name, [FObjectId, AIndex], title, Subtitle);
      end;
    TCustomerItemType.ltEquipment:
      begin
        DoPing(FCurrentList[AIndex].Id, FCurrentList[AIndex].ItemType);
      end;
    TCustomerItemType.ltParentEquipment:
      begin
        CloseMe(Self, true);
        Formmain.RunFrame(TmwFormEquipment, [FCurrentList[AIndex].Id, FCurrentList[AIndex].ItemType], 'Оборудование',
          FCurrentList[AIndex].TextSecondary);
        Formmain.AddToStack(TmwFormCustomer, Name, [FObjectId, AIndex], title, Subtitle);
      end;
  end;

end;

procedure TmwFormCustomer.nbFormActionButtons0Tap(Sender: TObject);
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

procedure TmwFormCustomer.nbFormTap(Sender: TObject);
begin
  inherited;
  Formmain.pnDrawer.Open(true);
end;

procedure TmwFormCustomer.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 0 then
    FObjectId := Values[0];
  if Length(Values) > 1 then
    FLVStartIndex := Values[1];
end;

procedure TmwFormCustomer.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.CustomerInfo(FObjectId);
end;

procedure TmwFormCustomer.ThreadFillData(API: TmwAPI);
var
  so: ISuperObject;
  si: ISuperArray;
begin
  inherited;
  si := API.ResultJson['struct'].AsArray;
  if Assigned(si) and (si.Length > 0) then
  begin
    so := si.O[0];
    FCustomer.services.Clear;
    FCustomer.equipment.Clear;
    FCustomer.discount.Clear;
    FCustomer.LoadFromJSON(so)
  end;
  bnEdit.OnTap := bnEditTap;
end;

{ TCustomerItem }

constructor TCustomerItem.Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
AItemType: integer; AKind: TCustomerItemType);
begin
  isHeader := AIsHeader;
  TextPrimary := ATextPrimary;
  TextSecondary := ATextSecondary;
  Icon := AIcon;
  Id := AId;
  ItemType := AItemType;
  Kind := AKind;
end;

end.
