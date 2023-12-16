unit Frame.FormEquipment;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections, Generics.Defaults,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, FGX.Image, FGX.CardPanel,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  FGX.Button.Types, FGX.Button, FGX.Popup;

type
  TEquipmentInfoItemType = (ltHeader, ltInfo, ltHouseInfo, ltIp, ltAttribute, ltPort, ltParent);

type
  TEquipmentInfoItem = class
  public
    isHeader: Boolean;
    TextPrimary: string;
    TextSecondary: string;
    TextNotice: string;
    Icon: string;
    Id: integer;
    itemType: integer;
    Kind: TEquipmentInfoItemType;
    constructor Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, ATextNotice, AIcon: string; AId: integer;
      AItemType: integer; AKind: TEquipmentInfoItemType);
  end;

type
  TmwFormEquipment = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    lvContent_StyleHeader: TfgCollectionViewStyle;
    lbHeaderPrimary: TfgLabel;
    lvContent_StyleSingle: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbSinglePrimary: TfgLabel;
    imSingle: TfgImage;
    fgCollectionViewStyle2: TfgCollectionViewStyle;
    fgCardPanel3: TfgCardPanel;
    fgLayout1: TfgLayout;
    fgLabel5: TfgLabel;
    fgImage1: TfgImage;
    fgLayout2: TfgLayout;
    fgLabel4: TfgLabel;
    fgLabel6: TfgLabel;
    fgCardPanel4: TfgCardPanel;
    fgLabel2: TfgLabel;
    fgLabel1: TfgLabel;
    fgLabel3: TfgLabel;
    fgCollectionViewStyle3: TfgCollectionViewStyle;
    fgCardPanel5: TfgCardPanel;
    fgLayout3: TfgLayout;
    fgLabel7: TfgLabel;
    fgLabel8: TfgLabel;
    fgImage2: TfgImage;
    fgLabel9: TfgLabel;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    function lvContentGetItemCount(Sender: TObject): integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FObjectId, FObjectType: integer;
    FEquipmentInfo: TmwEquipmentInfoItem;
    FCurrentList: TObjectList<TEquipmentInfoItem>;
    FLanPopup: TfgPopup;
    FLanPopupContent: TfgControl;
    procedure DoAction(const ACard: TfgCardPanel; const Id, eType: integer);
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
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  XSuperObject, Form.Main, Frame.FormHouse, Frame.FormCustomer, Frame.LanPopup,
  ServiceUnit.Settings, Assets.Consts;

{ TmwFormEquipment }

procedure TmwFormEquipment.AfterLoad;
var
  item: TEquipmentInfoItem;
  i: integer;
begin
  inherited;
  // nbForm.Subtitle := FHouseInfo.name;
  FCurrentList.Clear;
  item := TEquipmentInfoItem.Create(false, FEquipmentInfo.name, FEquipmentInfo.mac, FEquipmentInfo.notice, '', -1, -1,
    TEquipmentInfoItemType.ltInfo);
  FCurrentList.Add(item);
  if not FEquipmentInfo.place.IsEmpty then
  begin
    item := TEquipmentInfoItem.Create(true, 'Адрес', '', '', '', -1, -1, TEquipmentInfoItemType.ltHeader);
    FCurrentList.Add(item);
    item := TEquipmentInfoItem.Create(false, FEquipmentInfo.place, '', '', R.Bitmap.ICONS_CHEVRON_RIGHT,
      FEquipmentInfo.house_id, 0, TEquipmentInfoItemType.ltHouseInfo);
    FCurrentList.Add(item);
  end;

  if not FEquipmentInfo.ip.IsEmpty then
  begin
    item := TEquipmentInfoItem.Create(true, 'Ping', '', '', '', -1, -1, TEquipmentInfoItemType.ltHeader);
    FCurrentList.Add(item);
    item := TEquipmentInfoItem.Create(false, FEquipmentInfo.ip, '', '', R.Bitmap.ICONS_CHEVRON_RIGHT, FEquipmentInfo.Id,
      FEquipmentInfo.e_type, TEquipmentInfoItemType.ltIp);
    FCurrentList.Add(item);
  end;

  if not FEquipmentInfo.parent_aderss.IsEmpty then
  begin
    item := TEquipmentInfoItem.Create(true, 'Подключен к', '', '', '', -1, -1, TEquipmentInfoItemType.ltHeader);
    FCurrentList.Add(item);

    item := TEquipmentInfoItem.Create(true, FEquipmentInfo.parent_aderss, FEquipmentInfo.parent_name,

      Format('%s  порт: %s', [FEquipmentInfo.parent_ip, FEquipmentInfo.parent_port]),

      R.Bitmap.ICONS_CHEVRON_RIGHT, FEquipmentInfo.parent_id, FEquipmentInfo.parent_type,
      TEquipmentInfoItemType.ltParent);

    FCurrentList.Add(item);
  end;

  if FEquipmentInfo.attributes.Count > 0 then
  begin
    item := TEquipmentInfoItem.Create(true, 'Атрибуты', '', '', '', -1, -1, TEquipmentInfoItemType.ltHeader);
    FCurrentList.Add(item);

    for i := 0 to FEquipmentInfo.attributes.Count - 1 do
    begin
      item := TEquipmentInfoItem.Create(true, FEquipmentInfo.attributes[i].name, '', '', '', -1, -1,
        TEquipmentInfoItemType.ltAttribute);
      FCurrentList.Add(item);
    end;
  end;

  if FEquipmentInfo.ports.Count > 0 then
  begin
    item := TEquipmentInfoItem.Create(true, 'Порты', '', '', '', -1, -1, TEquipmentInfoItemType.ltHeader);
    FCurrentList.Add(item);
    for i := 0 to FEquipmentInfo.ports.Count - 1 do
    begin

      item := TEquipmentInfoItem.Create(true, FEquipmentInfo.ports[i].name, FEquipmentInfo.ports[i].ip,
        '[ ' + FEquipmentInfo.ports[i].port + ' ]', R.Bitmap.ICONS_CHEVRON_RIGHT, FEquipmentInfo.ports[i].Id,
        FEquipmentInfo.ports[i].e_type, TEquipmentInfoItemType.ltPort);
      FCurrentList.Add(item);

    end;
  end;
end;

procedure TmwFormEquipment.DoAction(const ACard: TfgCardPanel; const Id, eType: integer);
{
  var
  API: TmwAPI;
  aJson: string;
}
begin
  FLanPopup.Size := TSizeF.Create(ACard.Width, 144);
  (FLanPopupContent as TFrameLanPopUp).eqId := Id;
  (FLanPopupContent as TFrameLanPopUp).eqType := eType;
  (FLanPopupContent as TFrameLanPopUp).PopupOwner := FLanPopup;
  FLanPopup.ThemeName := Self.ThemeName;
  FLanPopup.DropDown(ACard);

  {
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
  }
end;

procedure TmwFormEquipment.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := 0;
  FObjectType := 0;
  FEquipmentInfo := TmwEquipmentInfoItem.Create;
  FCurrentList := TObjectList<TEquipmentInfoItem>.Create(true);
  FLanPopupContent := TFrameLanPopUp.Create(nil);
  FLanPopup := TfgPopupFactory.CreatePopup(FLanPopupContent);
end;

procedure TmwFormEquipment.fgFormDestroy(Sender: TObject);
begin
  FreeAndNil(FLanPopup);
  FEquipmentInfo.Free;
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormEquipment.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  NewHeight: Single;
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  if AStyle = 'Style-Port' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('port').Text := FCurrentList[AIndex].TextNotice;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
  end;
  if (AStyle = 'Style-Info') or (AStyle = 'Style-Parent') then
  begin
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
    AItem.GetControlByLookupName<TfgLabel>('notice').Text := FCurrentList[AIndex].TextNotice;
    if AStyle = 'Style-Info' then
    begin
      NewHeight := AItem.GetControlByLookupName<TfgLabel>('notice').MeasureSize(TfgMeasuringSpecification.Fixed,
        Width - 16, TfgMeasuringSpecification.Unspecified, 0).Height + AItem.GetControlByLookupName<TfgLabel>('primary')
        .Size.Height + AItem.GetControlByLookupName<TfgLabel>('secondary').Size.Height + 16;
      AItem.item.Height := NewHeight;
      AItem.item.Realign;
    end;
  end;
  if (AStyle <> 'Style-Header') and (AStyle <> 'Style-Info') then
    AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FCurrentList[AIndex].Icon;
end;

function TmwFormEquipment.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormEquipment.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  inherited;
  case FCurrentList[AIndex].Kind of
    TEquipmentInfoItemType.ltInfo:
      Result := 'Style-Info';
    TEquipmentInfoItemType.ltHeader:
      Result := 'Style-Header';
    TEquipmentInfoItemType.ltPort:
      Result := 'Style-Port';
    TEquipmentInfoItemType.ltParent:
      Result := 'Style-Parent';
  else
    Result := 'Style-Single';
  end;
end;

procedure TmwFormEquipment.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormEquipment.lvContentTapItem(Sender: TObject; const AIndex: integer);
var
  name, title, subtitle: string;
  AItem: TfgItemWrapper;
  ACard: TfgCardPanel;
begin
  inherited;
  name := Self.name;
  title := nbForm.title;
  subtitle := nbForm.subtitle;
  if FCurrentList[AIndex].Kind = TEquipmentInfoItemType.ltHouseInfo then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormHouse, [FCurrentList[AIndex].Id], 'Дом', FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormEquipment, Name, [FObjectId, FObjectType, AIndex], title, subtitle);
  end
  else if FCurrentList[AIndex].Kind = TEquipmentInfoItemType.ltPort then
  begin
    CloseMe(Self, true);
    if FCurrentList[AIndex].itemType = 0 then
      FormMain.RunFrame(TmwFormCustomer, [FCurrentList[AIndex].Id], 'Абонент', '')
    else
      FormMain.RunFrame(TmwFormEquipment, [FCurrentList[AIndex].Id, FCurrentList[AIndex].itemType], 'Оборудование',
        FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormEquipment, Name, [FObjectId, FObjectType, AIndex], title, subtitle);
  end
  else if FCurrentList[AIndex].Kind = TEquipmentInfoItemType.ltParent then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormEquipment, [FCurrentList[AIndex].Id, FCurrentList[AIndex].itemType], 'Оборудование',
      FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormEquipment, Name, [FObjectId, FObjectType, AIndex], title, subtitle);
  end
  else if FCurrentList[AIndex].Kind = TEquipmentInfoItemType.ltIp then
  begin
    if lvContent.FindItemWrapperByIndex(AIndex, AItem) then
    begin
      ACard := AItem.GetControlByLookupName<TfgCardPanel>('card');
      DoAction(ACard, FCurrentList[AIndex].Id, FCurrentList[AIndex].itemType);
    end;
  end;
end;

procedure TmwFormEquipment.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormEquipment.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 1 then
  begin
    FObjectId := Values[0];
    FObjectType := Values[1];
  end;
  if Length(Values) > 2 then
    FLVStartIndex := Values[2];
end;

procedure TmwFormEquipment.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetEquipmentInfo(FObjectId, FObjectType);
end;

procedure TmwFormEquipment.ThreadFillData(API: TmwAPI);
begin
  inherited;
  FEquipmentInfo.LoadFromJSON(API.ResultJson['struct'].AsObject);
end;

{ TEquipmentInfoItem }

constructor TEquipmentInfoItem.Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, ATextNotice, AIcon: string;
  AId, AItemType: integer; AKind: TEquipmentInfoItemType);
begin
  isHeader := AIsHeader;
  TextPrimary := ATextPrimary;
  TextSecondary := ATextSecondary;
  TextNotice := ATextNotice;
  Icon := AIcon;
  Id := AId;
  itemType := AItemType;
  Kind := AKind;
end;

end.
