unit Frame.FormBids;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.Image, FGX.CardPanel, FGX.Line, FGX.Rectangle, FGX.GraphicControl,
  FGX.Shape,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  XSuperObject, ServiceUnit.mwClasses, ServiceUnit.API, FGX.Button.Types,
  FGX.Button;

type
  TmwBidList = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel: TfgCardPanel;
    fgltBid: TfgLayout;
    fgLayout1: TfgLayout;
    fgLabel2: TfgLabel;
    fgLabel1: TfgLabel;
    fgLabel5: TfgLabel;
    fgltAddress: TfgLayout;
    fgLabel4: TfgLabel;
    fgltContent: TfgLayout;
    fgLabel3: TfgLabel;
    imIcon: TfgImage;
    fgRectangle1: TfgRectangle;
    lvAvailable_Style2: TfgCollectionViewStyle;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    procedure seSearchChanging(Sender: TObject); override;
    procedure fgFormShow(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): Integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure bnMapTap(Sender: TObject);
  private
    FStreetID: Integer;
    FHouseID: Integer;
    // FClrTextLight :
    FCurrentList: TObjectList<TmwBidListItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); override;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.UIConsts, System.UITypes, System.StrUtils,
  System.DateUtils,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Assets, FGX.Assets.Helpers,
  FGX.Assets.Color, FGX.SystemInfo, FGX.Platform,
  Form.Main, Frame.FormBidInfo, Frame.FormMap, ServiceUnit.Utils, Assets.Consts;

{ TmwBidList }

procedure TmwBidList.bnMapTap(Sender: TObject);
var
  markerList: TSuperArray;
  I: Integer;
  m: TmwMapMarker;
  c1, c2: double;
  mc: Integer;
begin
  inherited;
  mc := 0;
  c1 := 0;
  c2 := 0;
  markerList := TSuperArray.Create();
  try
    for I := 0 to FCurrentList.Count - 1 do
    begin
      if (FCurrentList[I].lat > 0) and (FCurrentList[I].lon > 0) then
      begin
        m := TmwMapMarker.Create;
        try
          m.lat := FCurrentList[I].lat;
          m.lon := FCurrentList[I].lon;
          m.title := FCurrentList[I].id.ToString;
          m.hint := FCurrentList[I].content;
          m.icon := R.Bitmap.ICONS_ENGINEERING;
          markerList.Add(m.AsJsonObj);
          inc(mc);
          c1 := c1 + m.lat;
          c2 := c2 + m.lon;
        finally
          m.Free;
        end;
      end;
    end;
  finally
    CloseMe(Self, true);
    FormMain.RunFrame(TmwFormMap, [c1 / mc, c2 / mc, 12, markerList.AsJSON], 'Карта', nbForm.title);
    FormMain.AddToStack(TmwBidList, Self.Name, [FStreetID, FHouseID, 0], nbForm.title, nbForm.SubTitle);

    markerList.Free;
  end;
end;

procedure TmwBidList.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwBidListItem>.Create(true);
end;

procedure TmwBidList.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwBidList.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwBidList.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  iColor: TColor;
  aColor: TAlphaColor;
  cName: string;
  A: TfgAssetColor;
  LabelSize: TSizeF;
  lblContent: TfgLabel;
  TH: Single;
  ColorPath: string;
begin
  inherited;
  if AStyle = 'Style-Empty' then
    Exit;
  AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := '';
  ColorPath := ThemeName + '\';

  if not FCurrentList[AIndex].Color.IsEmpty then
  begin
    cName := ReplaceStr(FCurrentList[AIndex].Color, '$', 'clr');
    iColor := StringToColor(FCurrentList[AIndex].Color);
    if not TfgAssetsManager.Current.Find<TfgAssetColor>(cName, A) then
    begin
      aColor := ColorToAlphaColor(iColor);
      A := TfgAssetsManager.Current.AddColor(cName, aColor);
    end;
    AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := A.Name;

    if (FGX.SystemInfo.TfgSystemInfo.Appearance.ThemeKind = TfgSystemThemeKind.Dark) then
    begin
      if IsLightColor(A.Color) then
        ColorPath := '';
    end;
  end;

  AItem.GetControlByLookupName<TfgLabel>('meta').ColorName := ColorPath + 'Text\Secondary Text';
  AItem.GetControlByLookupName<TfgLabel>('number').ColorName := ColorPath + 'Text\Secondary Text';
  AItem.GetControlByLookupName<TfgLabel>('text').ColorName := ColorPath + 'Text\Secondary Text';
  AItem.GetControlByLookupName<TfgLabel>('primary').ColorName := ColorPath + 'Text\Text';
  AItem.GetControlByLookupName<TfgLabel>('address').ColorName := ColorPath + 'Text\Text';

  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].type_name;
  AItem.GetControlByLookupName<TfgLabel>('number').Text := IntToStr(FCurrentList[AIndex].id) + ' ';
  LabelSize := AItem.GetControlByLookupName<TfgLabel>('number').MeasureSize(TfgMeasuringSpecification.AtMost,
    AItem.GetControlByLookupName<TfgLayout>('top').Width, TfgMeasuringSpecification.Unspecified);
  AItem.GetControlByLookupName<TfgLabel>('number').Size.SetSizeF(LabelSize);
  AItem.GetControlByLookupName<TfgLabel>('meta').Text := FCurrentList[AIndex].plan_str;
  LabelSize := AItem.GetControlByLookupName<TfgLabel>('meta').MeasureSize(TfgMeasuringSpecification.AtMost,
    AItem.GetControlByLookupName<TfgLayout>('top').Width, TfgMeasuringSpecification.Unspecified);
  AItem.GetControlByLookupName<TfgLabel>('meta').Size.SetSizeF(LabelSize);
  AItem.GetControlByLookupName<TfgLabel>('address').Text := FCurrentList[AIndex].adress;

  lblContent := AItem.GetControlByLookupName<TfgLabel>('text');
  lblContent.Text := FCurrentList[AIndex].content;

  case FCurrentList[AIndex].whose of
    0:
      begin
        AItem.GetControlByLookupName<TfgRectangle>('line').Fill.ColorName := R.Color.COLORS_BIDSIGNALIEN;
      end;
    1:
      begin
        if UnixToDateTime(FCurrentList[AIndex].plan_date, false) < Now() then
          AItem.GetControlByLookupName<TfgRectangle>('line').Fill.ColorName := R.Color.COLORS_BIDSIGNOWNLATE
        else
          AItem.GetControlByLookupName<TfgRectangle>('line').Fill.ColorName := R.Color.COLORS_BIDSIGNOWN
      end
  else
    AItem.GetControlByLookupName<TfgRectangle>('line').Fill.ColorName := R.Color.COLORS_BIDSIGNNOBODY
  end;

  AItem.GetControlByLookupName<TfgRectangle>('line').Stroke.ColorName :=
    AItem.GetControlByLookupName<TfgRectangle>('line').Fill.ColorName;

  // попытка посчитать высоту в зависимости от текста

  if lblContent.Text.IsEmpty then
  begin
    TH := AItem.GetControlByLookupName<TfgImage>('imIcon').Size.Height;
  end
  else
  begin
    TH := lblContent.MeasureSize(TfgMeasuringSpecification.Fixed, lblContent.Size.Width,
      TfgMeasuringSpecification.Unspecified, 0).Height;
  end;
  AItem.GetControlByLookupName<TfgLayout>('content').Height := TH + 5;

  AItem.GetControlByLookupName<TfgLayout>('bid').Height := AItem.GetControlByLookupName<TfgLayout>('top').Height +
    AItem.GetControlByLookupName<TfgLayout>('adrs').Height + AItem.GetControlByLookupName<TfgLayout>('content').Height;

  AItem.Item.Size.Height := AItem.GetControlByLookupName<TfgLayout>('bid').Height;

  AItem.Item.Realign;
end;

function TmwBidList.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwBidList.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].type_name.ToLower) > 0) or
    (Pos(edSearch.Text.ToLower, IntToStr(FCurrentList[AIndex].id)) > 0) or
    (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].plan_str.ToLower) > 0) or
    (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].adress.ToLower) > 0) or
    (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].content.ToLower) > 0) then
    Result := 'Style-Bid'
  else
    Result := 'Style-Empty';
end;

procedure TmwBidList.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwBidList.lvContentTapItem(Sender: TObject; const AIndex: Integer);
var
  id: Integer;
  Txt: string;
  Name, title, SubTitle: string;
begin
  id := FCurrentList[AIndex].id;
  Txt := IntToStr(FCurrentList[AIndex].id);
  name := Self.Name;
  title := nbForm.title;
  SubTitle := nbForm.SubTitle;
  CloseMe(Self, true);
  FormMain.RunFrame(TmwFormBidInfo, [id], 'Заявка', Txt);
  FormMain.AddToStack(TmwBidList, Name, [FStreetID, FHouseID, AIndex], title, SubTitle);
end;

procedure TmwBidList.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvContent.ReloadItems;
end;

procedure TmwBidList.SetParams(Values: array of Variant);
begin
  inherited;
  inherited;
  if Length(Values) > 1 then
  begin
    FStreetID := Values[0];
    FHouseID := Values[1];
  end;
  if Length(Values) > 2 then
    FLVStartIndex := Values[2];
end;

procedure TmwBidList.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.BidList(FStreetID, FHouseID);
end;

procedure TmwBidList.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  I: Integer;
  Item: TmwBidListItem;
  ol: ISuperArray;
begin
  inherited;
  FCurrentList.Clear;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for I := 0 to ol.Length - 1 do
    begin
      x := ol.O[I];
      Item := TmwBidListItem.Create;
      Item.LoadFromJSON(x);
      FCurrentList.Add(Item)
    end;
  end;
end;

end.
