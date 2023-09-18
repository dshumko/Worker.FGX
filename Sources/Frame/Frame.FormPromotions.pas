unit Frame.FormPromotions;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, FGX.Memo, FGX.Image, FGX.CardPanel,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  FGX.Button.Types, FGX.Button;

type
  TmwFormPromotions = class(TmwBaseListViewForm)
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    function lvContentGetItemCount(Sender: TObject): Integer;
    procedure lvContentPullToRefresh(Sender: TObject);
  private
    FCurrentList: TObjectList<TmwPromoItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    { Public declarations }
  end;

  TmwFormPromotionsClass = class of TmwFormPromotions;

implementation

{$R *.xfm}

uses
  System.SysUtils,
  FGX.Application, FGX.Dialogs, FGX.Log,
  XSuperObject;

procedure TmwFormPromotions.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwPromoItem>.Create(true);
end;

procedure TmwFormPromotions.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
end;

procedure TmwFormPromotions.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].title;
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FCurrentList[AIndex].body;
  AItem.Item.Height := AItem.GetControlByLookupName<TfgLabel>('secondary').MeasureSize(TfgMeasuringSpecification.AtMost,
    Width - 16, TfgMeasuringSpecification.Unspecified, 0).Height + 44;
  AItem.GetControlByLookupName<TfgImage>('icon').Visible := not FCurrentList[AIndex].url.IsEmpty;
  AItem.Item.Realign;
end;

function TmwFormPromotions.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormPromotions.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  Result := 'Style-Promotions';
end;

procedure TmwFormPromotions.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormPromotions.lvContentTapItem(Sender: TObject; const AIndex: Integer);
begin
  inherited;
  if not FCurrentList[AIndex].url.IsEmpty then
    Application.OpenURL(FCurrentList[AIndex].url);
end;

procedure TmwFormPromotions.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.PromoList;
end;

procedure TmwFormPromotions.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: Integer;
  Item: TmwPromoItem;
begin
  inherited;
  FCurrentList.Clear;
  if API.ResultJson['struct'].AsArray.Length > 0 then
  begin
    for i := 0 to API.ResultJson['struct'].AsArray.Length - 1 do
    begin
      x := API.ResultJson['struct'].AsArray.O[i];
      Item := TmwPromoItem.Create;
      Item.LoadFromJSON(x);
      FCurrentList.Add(Item)
    end;
  end;
end;

end.
