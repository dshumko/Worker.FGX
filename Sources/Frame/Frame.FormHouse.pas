unit Frame.FormHouse;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.Image,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.API, ServiceUnit.mwClasses,
  Base.BaseListViewForm, FGX.CardPanel, FGX.AutocompleteEdit.Types, FGX.Edit,
  FGX.AutocompleteEdit, FGX.SearchEdit, FGX.Button.Types, FGX.Button;

type
  THouseInfoItemType = (ltChair, ltHeader, ltBids, ltCustomers, ltEquipment, ltCircuit);

type
  THouseInfoItem = class
  public
    isHeader: Boolean;
    TextPrimary: string;
    TextSecondary: string;
    Icon: string;
    Id: integer;
    itemType: integer;
    Kind: THouseInfoItemType;
    constructor Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
      AItemType: integer; AKind: THouseInfoItemType);
  end;

type
  TmwFormHouse = class(TmwBaseListViewForm)
    lvContent_StyleHeader: TfgCollectionViewStyle;
    lbHeaderPrimary: TfgLabel;
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    lvContent_StyleSingle: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbSinglePrimary: TfgLabel;
    imSingle: TfgImage;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure bnBookmarkTap(Sender: TObject);
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    function lvContentGetItemCount(Sender: TObject): integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure bnMapTap(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FHouseInfo: TmwHouseInfoItem;
    FObjectId: integer;
    FChairCount: integer;
    FCurrentList: TObjectList<THouseInfoItem>;
    procedure BookmarkUpdate;
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
  System.SysUtils, System.Math, System.StrUtils,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.PhoneDialer, FGX.Toasts,
  XSuperObject, ServiceUnit.BookMarks, Form.Main, Frame.FormBids, Frame.FormMap,
  Frame.FormCustomers, Frame.FormEquipment, Assets.Consts, ServiceUnit.Utils;

{ TmwFormHouse }

procedure TmwFormHouse.AfterLoad;
var
  item: THouseInfoItem;
  i: integer;
  IcoRight : string;
begin
  BookmarkUpdate;

  IcoRight := Self.ThemeName+'\Icons\chevron right';

  nbForm.Subtitle := FHouseInfo.name;
  FCurrentList.Clear;
  nbForm.ActionButtons.ByName['bnMap'].Visible := (FHouseInfo.lat > 0) and (FHouseInfo.lon > 0);
  if not FHouseInfo.chair.IsEmpty then
    FChairCount := 1
  else
    FChairCount := 0;
  if not FHouseInfo.chair.IsEmpty then
  begin
    item := THouseInfoItem.Create(false, FHouseInfo.chair, FHouseInfo.chair_phone,
      IfThen(FHouseInfo.chair_phone.IsEmpty, '', R.Bitmap.ICONS_PHONE), -1, -1, THouseInfoItemType.ltChair);
    FCurrentList.Add(item);
  end;

  item := THouseInfoItem.Create(false, 'Абоненты', '', IcoRight, FObjectId, -1,
    THouseInfoItemType.ltCustomers);
  FCurrentList.Add(item);
  item := THouseInfoItem.Create(false, 'Заявки', '', IfThen(FHouseInfo.bid_count = 0, '', IcoRight),
    FObjectId, -1, THouseInfoItemType.ltBids);
  FCurrentList.Add(item);
  if FHouseInfo.equipment.Count > 0 then
  begin
    item := THouseInfoItem.Create(true, 'Оборудование', '', '', -1, -1, THouseInfoItemType.ltHeader);
    FCurrentList.Add(item);
    for i := 0 to FHouseInfo.equipment.Count - 1 do
    begin
      item := THouseInfoItem.Create(false, FHouseInfo.equipment[i].name, FHouseInfo.equipment[i].notice,
        IcoRight, FHouseInfo.equipment[i].Id, FHouseInfo.equipment[i].e_type,
        THouseInfoItemType.ltEquipment);
      FCurrentList.Add(item);
    end;
  end;
  if FHouseInfo.circuit.Count > 0 then
  begin
    item := THouseInfoItem.Create(true, 'Схемы', '', '', -1, -1, THouseInfoItemType.ltHeader);
    FCurrentList.Add(item);
    for i := 0 to FHouseInfo.circuit.Count - 1 do
    begin
      item := THouseInfoItem.Create(false, FHouseInfo.circuit[i].name, FHouseInfo.circuit[i].notice, '',
        FHouseInfo.circuit[i].Id, -1, THouseInfoItemType.ltCircuit);
      FCurrentList.Add(item);
    end;
  end;
  inherited;
end;

procedure TmwFormHouse.BookmarkUpdate;
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

procedure TmwFormHouse.fgFormCreate(Sender: TObject);
begin
  inherited;
  FHouseInfo := TmwHouseInfoItem.Create();
  FObjectId := 0;
  FCurrentList := TObjectList<THouseInfoItem>.Create(true);
end;

procedure TmwFormHouse.fgFormDestroy(Sender: TObject);
begin
  FHouseInfo.Free;
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormHouse.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  if AStyle = 'Style-Secondary' then
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
  if AStyle <> 'Style-Header' then
    AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FCurrentList[AIndex].Icon;
end;

function TmwFormHouse.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormHouse.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  inherited;
  case FCurrentList[AIndex].Kind of
    THouseInfoItemType.ltChair, THouseInfoItemType.ltEquipment, THouseInfoItemType.ltCircuit:
      Result := 'Style-Secondary';
    THouseInfoItemType.ltHeader:
      Result := 'Style-Header';
  else
    Result := 'Style-Single';
  end;
end;

procedure TmwFormHouse.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormHouse.lvContentTapItem(Sender: TObject; const AIndex: integer);
var
  name, title, Subtitle: string;
begin
  inherited;
  name := Self.name;
  title := nbForm.title;
  Subtitle := nbForm.Subtitle;
  if FCurrentList[AIndex].Kind = THouseInfoItemType.ltBids then
  begin
    if FHouseInfo.bid_count > 0 then
    begin
      CloseMe(Self, true);
      FormMain.RunFrame(TmwBidList, [0, FCurrentList[AIndex].Id], 'Заявки', FCurrentList[AIndex].TextPrimary);
      FormMain.AddToStack(TmwFormHouse, name, [FObjectId, AIndex], title, Subtitle);
    end;
  end
  else if FCurrentList[AIndex].Kind = THouseInfoItemType.ltCustomers then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormCustomers, [FCurrentList[AIndex].Id], 'Абоненты', FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormHouse, Name, [FObjectId, AIndex], title, Subtitle);
  end
  else if FCurrentList[AIndex].Kind = THouseInfoItemType.ltEquipment then
  begin
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormEquipment, [FCurrentList[AIndex].Id, FCurrentList[AIndex].itemType], 'Оборудование',
      FCurrentList[AIndex].TextPrimary);
    FormMain.AddToStack(TmwFormHouse, Name, [FObjectId, AIndex], title, Subtitle);
  end
  else if FCurrentList[AIndex].Kind = THouseInfoItemType.ltChair then
  begin
    if not FCurrentList[AIndex].TextSecondary.IsEmpty then
{$IFDEF ANDROID}
      DoExternalCall(FCurrentList[AIndex].TextSecondary);
{$ELSE}
      TfgPhoneDialer.Call(FCurrentList[AIndex].TextSecondary);
{$ENDIF}
  end;
end;

procedure TmwFormHouse.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormHouse.bnMapTap(Sender: TObject);
begin
  inherited;
  CloseMe(Self, true);
  FormMain.RunFrame(TmwFormMap, [FHouseInfo.lat, FHouseInfo.lon, 18, '[{"lat":' + FHouseInfo.lat.ToString + ',"lon":' +
    FHouseInfo.lon.ToString + ',"icon":"' + ReplaceStr(R.Bitmap.ICONS_HOUSE, '\', '\\') + '"}]'], 'Карта',
    nbForm.Subtitle);
  FormMain.AddToStack(TmwFormHouse, Name, [FObjectId, 0], nbForm.title, nbForm.Subtitle);
end;

procedure TmwFormHouse.bnBookmarkTap(Sender: TObject);
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

procedure TmwFormHouse.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
    FObjectId := Values[0];
  if Length(Values) > 1 then
    FLVStartIndex := Values[1];
end;

procedure TmwFormHouse.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.HouseInfo(FObjectId);
end;

procedure TmwFormHouse.ThreadFillData(API: TmwAPI);
begin
  inherited;
  FHouseInfo.LoadFromJSON(API.ResultJson['struct'].AsObject);
end;

{ THouseInfoItem }

constructor THouseInfoItem.Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon: string; AId: integer;
  AItemType: integer; AKind: THouseInfoItemType);
begin
  isHeader := AIsHeader;
  TextPrimary := ATextPrimary;
  TextSecondary := ATextSecondary;
  Icon := AIcon;
  Id := AId;
  itemType := AItemType;
  Kind := AKind;
end;

end.
