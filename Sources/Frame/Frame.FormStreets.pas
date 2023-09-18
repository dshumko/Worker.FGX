unit Frame.FormStreets;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.Image,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.Edit, FGX.AutoCompleteEdit, FGX.SearchEdit,
  XSuperObject, ServiceUnit.mwClasses, ServiceUnit.API,
  Base.BaseListViewForm, FGX.CardPanel, FGX.AutoCompleteEdit.Types,
  FGX.Button.Types, FGX.Button;

type
  TmwFormStreets = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbPrimary: TfgLabel;
    imIcon: TfgImage;
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
    procedure nbFormTap(Sender: TObject);
  private
    FCurrentList: TObjectList<TmwStreetHouseItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); override;
  end;

  TmwFormStreetsClass = class of TmwFormStreets;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log,
  Form.Main, Frame.FormHouses;

procedure TmwFormStreets.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwStreetHouseItem>.Create(true);
end;

procedure TmwFormStreets.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormStreets.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwFormStreets.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  if AStyle <> 'Style-Empty' then
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
end;

function TmwFormStreets.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormStreets.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Streets'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormStreets.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormStreets.lvContentTapItem(Sender: TObject; const AIndex: Integer);
var
  Id: Integer;
  Txt: string;
  name, title, subtitle: string;
begin
  Id := FCurrentList[AIndex].Id;
  Txt := FCurrentList[AIndex].name;
  name := Self.name;
  title := nbForm.title;
  subtitle := nbForm.subtitle;
  CloseMe(Self);
  FormMain.RunFrame(TmwFormHouses, [Id], 'Дома', Txt);
  FormMain.AddToStack(TmwFormStreets, name, [AIndex], title, subtitle);
end;

procedure TmwFormStreets.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormStreets.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvContent.ReloadItems;
end;

procedure TmwFormStreets.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 0 then
    FLVStartIndex := Values[0];
end;

procedure TmwFormStreets.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.StreetList;
end;

procedure TmwFormStreets.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: Integer;
  item: TmwStreetHouseItem;
  ol: ISuperArray;
begin
  inherited;
  FCurrentList.Clear;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      item := TmwStreetHouseItem.Create;
      item.LoadFromJSON(x);
      FCurrentList.Add(item)
    end;
  end;
end;

end.
