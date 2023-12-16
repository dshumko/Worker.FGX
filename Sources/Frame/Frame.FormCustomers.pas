unit Frame.FormCustomers;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections, Generics.Defaults,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.Image, FGX.CardPanel,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  ServiceUnit.mwClasses, ServiceUnit.API, XSuperObject, FGX.Button.Types,
  FGX.Button;

type
  TCustomerItemType = (ltCustomerItemData, ltHeader);

type
  THouseCustomersItem = class
  public
    isHeader: Boolean;
    TextPrimary: string;
    TextSecondary: string;
    Icon: string;
    Index: integer;
    Id: integer;
    BackGroundColor: string;
    Kind: TCustomerItemType;
    constructor Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon, ABackgroundColor: string;
      AIndex: integer; AId: integer; AKind: TCustomerItemType);
  end;

type
  TmwFormCustomers = class(TmwBaseListViewForm)
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    lvAvailable_Style2: TfgCollectionViewStyle;
    bnAdd: TfgButton;
    lvContent_StyleHeader: TfgCollectionViewStyle;
    lbHeaderPrimary: TfgLabel;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure seSearchChanging(Sender: TObject); override;
    procedure fgFormShow(Sender: TObject);
    procedure bnAddTap(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormLongTap(Sender: TObject; const ATouchDown: TfgTouch);
    procedure nbFormTap(Sender: TObject);
  private
    FObjectId: integer;
    FCurrentList: TObjectList<THouseCustomersItem>;
    FCustomersList: TObjectList<TmwHouseCustomersItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); override;
  end;

implementation

{$R *.xfm}
// TODO сделать группировку подъезд/этаж, добавление

uses
  System.SysUtils, System.UITypes, System.StrUtils, System.UIConsts,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Assets, FGX.Assets.Helpers,
  FGX.Assets.Color,
  ServiceUnit.Utils, Form.Main, Frame.FormCustomer, Form.NewAbonent,
  Assets.Consts;

{ TmwFormCustomers }

procedure TmwFormCustomers.bnAddTap(Sender: TObject);
var
  fNewAbonent: TmwFormNewAbonent;
begin
  inherited;
  fNewAbonent := TmwFormNewAbonent.Create(Application);
  fNewAbonent.SetParams([FObjectId, -1]);
  fNewAbonent.OnApplyParameters := procedure(const AResult: Boolean)
    begin
      if AResult then
        Load;
    end;
  fNewAbonent.ShowForm('Абонент', '');
end;

procedure TmwFormCustomers.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := 0;
  FCustomersList := TObjectList<TmwHouseCustomersItem>.Create(TComparer<TmwHouseCustomersItem>.Construct(
    function(const L, R: TmwHouseCustomersItem): integer
    begin
      Result := StrToIntDef(L.porch, 0) - StrToIntDef(R.porch, 0);
      if Result = 0 then
      begin
        if L.porch <> R.porch then
          Result := TComparer<string>.Default.Compare(L.porch, R.porch)
        else
          Result := StrToIntDef(L.floor, 0) - StrToIntDef(R.floor, 0);
      end;
      if Result = 0 then
      begin
        if L.floor <> R.floor then
          Result := TComparer<string>.Default.Compare(L.floor, R.floor)
        else
          Result := StrToIntDef(L.flat, 0) - StrToIntDef(R.flat, 0);
      end;
    end), true);
  FCurrentList := TObjectList<THouseCustomersItem>.Create(true);
  bnAdd.Visible := FormMain.Rights.AbAdd;
end;

procedure TmwFormCustomers.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  FCustomersList.Free;
  inherited;
end;

procedure TmwFormCustomers.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwFormCustomers.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
const AItem: TfgItemWrapper);
begin
  if AStyle = 'Style-Empty' then
    Exit;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  if AStyle = 'Style-Header' then
    Exit;
  AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := FCurrentList[AIndex].BackGroundColor;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].TextPrimary;
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].TextSecondary;
  AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FCurrentList[AIndex].Icon;
end;

function TmwFormCustomers.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormCustomers.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  if FCurrentList[AIndex].isHeader then
  begin
    if edSearch.Text.IsEmpty then
      Result := 'Style-Header'
    else
      Result := 'Style-Empty'
  end
  else if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCustomersList[FCurrentList[AIndex].Index].fio.ToLower) >
    0) or (Pos(edSearch.Text.ToLower, FCustomersList[FCurrentList[AIndex].Index].flat.ToLower) > 0) or
    (Pos(edSearch.Text.ToLower, FCustomersList[FCurrentList[AIndex].Index].info.ToLower) > 0) or
    (Pos(edSearch.Text.ToLower, FCustomersList[FCurrentList[AIndex].Index].balance.ToLower) > 0) then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Empty'
end;

procedure TmwFormCustomers.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormCustomers.lvContentTapItem(Sender: TObject; const AIndex: integer);
var
  Id: integer;
  Txt: String;
  name, title, subtitle: string;
begin
  inherited;
  if FCurrentList[AIndex].Kind <> TCustomerItemType.ltCustomerItemData then
    Exit;
  if FCustomersList[FCurrentList[AIndex].Index].Id <> -1 then
  begin
    Id := FCurrentList[AIndex].Id;
    Txt := FCustomersList[FCurrentList[AIndex].Index].fio;
    name := Self.name;
    title := nbForm.title;
    subtitle := nbForm.subtitle;
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormCustomer, [Id], 'Абонент', Txt);
    FormMain.AddToStack(TmwFormCustomers, Name, [FObjectId, AIndex], title, subtitle);
  end;
end;

procedure TmwFormCustomers.nbFormLongTap(Sender: TObject; const ATouchDown: TfgTouch);
begin
  inherited;
  FormMain.SetNavigation(true);
end;

procedure TmwFormCustomers.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormCustomers.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvContent.ReloadItems;
end;

procedure TmwFormCustomers.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 0 then
    FObjectId := Values[0];
  if Length(Values) > 1 then
    FLVStartIndex := Values[1];
end;

procedure TmwFormCustomers.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.HouseCustomers(FObjectId);
end;

procedure TmwFormCustomers.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: integer;
  item: TmwHouseCustomersItem;
  ol: ISuperArray;
  lastHeader, curHeader: string;
  lItem: THouseCustomersItem;
  sText, bColor: string;
  iColor: TColor;
  aColor: TAlphaColor;
  cName: string;
  A: TfgAssetColor;
  IcoRight : string;
begin
  inherited;

  IcoRight := Self.ThemeName+'\Icons\chevron right';

  FCurrentList.Clear;
  FCustomersList.Clear;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      item := TmwHouseCustomersItem.Create;
      item.LoadFromJSON(x);
      FCustomersList.Add(item)
    end;
    FCustomersList.Sort;
    lastHeader := IfThen(FCustomersList[0].porch.IsEmpty, '', 'подъезд ' + FCustomersList[0].porch) +
      IfThen(FCustomersList[0].floor.IsEmpty, '', ' этаж ' + FCustomersList[0].floor);
    lItem := THouseCustomersItem.Create(true, lastHeader, '', '', '', -1, -1, TCustomerItemType.ltHeader);
    FCurrentList.Add(lItem);
    for i := 0 to FCustomersList.Count - 1 do
    begin
      curHeader := IfThen(FCustomersList[i].porch.IsEmpty, '', 'подъезд ' + FCustomersList[i].porch) +
        IfThen(FCustomersList[i].floor.IsEmpty, '', ' этаж ' + FCustomersList[i].floor);
      if curHeader <> lastHeader then
      begin
        lastHeader := curHeader;
        lItem := THouseCustomersItem.Create(true, lastHeader, '', '', '', -1, -1, TCustomerItemType.ltHeader);
        FCurrentList.Add(lItem);
      end;
      if FCustomersList[i].info.IsEmpty then
        sText := Format('Бал. %s', [FCustomersList[i].balance])
      else
        sText := FCustomersList[i].info + ' ' + Format('Бал. %s', [FCustomersList[i].balance]);
      if (FCustomersList[i].Id <> -1) and (FCustomersList[i].connected = 0) then
      begin
        if FCustomersList[i].balance.ToSingle < 0 then
          bColor := R.Color.COLORS_CUSTOMERPAYMENTSOUT
        else
          bColor := R.Color.COLORS_CUSTOMEROFF
      end
      else if not FCustomersList[i].Color.IsEmpty then
      begin
        cName := ReplaceStr(FCustomersList[i].Color, '$', 'clr');
        iColor := StringToColor(FCustomersList[i].Color);
        if not TfgAssetsManager.Current.Find<TfgAssetColor>(cName, A) then
        begin
          aColor := ColorToAlphaColor(iColor);
          A := TfgAssetsManager.Current.AddColor(cName, aColor);
        end;
        bColor := A.name;
      end
      else
        bColor := '';
      lItem := THouseCustomersItem.Create(false, Format('%s. %s', [FCustomersList[i].flat, FCustomersList[i].fio]),
        sText, IfThen(FCustomersList[i].Id <> -1, IcoRight, ''), bColor, i, FCustomersList[i].Id,
        TCustomerItemType.ltCustomerItemData);
      FCurrentList.Add(lItem);
    end
  end;
  bnAdd.OnTap := bnAddTap;
end;

{ THouseCustomersItem }

constructor THouseCustomersItem.Create(AIsHeader: Boolean; ATextPrimary, ATextSecondary, AIcon,
  ABackgroundColor: string; AIndex, AId: integer; AKind: TCustomerItemType);
begin
  isHeader := AIsHeader;
  TextPrimary := ATextPrimary;
  TextSecondary := ATextSecondary;
  Icon := AIcon;
  BackGroundColor := ABackgroundColor;
  Index := AIndex;
  Id := AId;
  Kind := AKind;
end;

end.
