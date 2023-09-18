unit Frame.FormHouses;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.Image,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.Edit, FGX.AutoCompleteEdit, FGX.SearchEdit, FGX.CardPanel, FGX.AutoCompleteEdit.Types,
  XSuperObject, ServiceUnit.mwClasses, ServiceUnit.API,
  Base.BaseListViewForm, FGX.Button.Types, FGX.Button;

type
  TmwFormHouses = class(TmwBaseListViewForm)
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbPrimary: TfgLabel;
    imIcon: TfgImage;
    lvAvailable_Style2: TfgCollectionViewStyle;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    procedure nbFormActionButtons0Tap(Sender: TObject);
    procedure fgFormShow(Sender: TObject);
    procedure seSearchChanging(Sender: TObject); override;
    function lvContentGetItemCount(Sender: TObject): Integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FObjectId: Integer;
    FCurrentList: TObjectList<TmwStreetHouseItem>;
    procedure BookmarkUpdate;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant); override;
  end;

  TmwFormHousesClass = class of TmwFormHouses;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log,
  Form.Main, Frame.FormHouse, ServiceUnit.BookMarks, Assets.Consts;

{ TmwFormHouses }

procedure TmwFormHouses.AfterLoad;
begin
  inherited;
  BookmarkUpdate;
end;

procedure TmwFormHouses.BookmarkUpdate;
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

procedure TmwFormHouses.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := 0;
  FCurrentList := TObjectList<TmwStreetHouseItem>.Create(true);
end;

procedure TmwFormHouses.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormHouses.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwFormHouses.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  if AStyle <> 'Style-Empty' then
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
end;

function TmwFormHouses.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormHouses.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Streets'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormHouses.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormHouses.lvContentTapItem(Sender: TObject; const AIndex: Integer);
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
  CloseMe(Self, true);
  FormMain.RunFrame(TmwFormHouse, [Id], 'Дом', Txt);
  FormMain.AddToStack(TmwFormHouses, Name, [FObjectId, AIndex], title, subtitle);
end;

procedure TmwFormHouses.nbFormActionButtons0Tap(Sender: TObject);
var
  s: String;
begin
  inherited;
  s := Self.ClassName;
  if nbForm.ActionButtons.ByName['bnBookmark'].Tag = -1 then
    BookMarks.AddBookMark(s, FObjectId, nbForm.subtitle)
  else
    BookMarks.DeleteBookMark(s, FObjectId);
  BookmarkUpdate;
end;

procedure TmwFormHouses.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormHouses.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvContent.ReloadItems;
end;

procedure TmwFormHouses.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 0 then
    FObjectId := Values[0];
  if Length(Values) > 1 then
    FLVStartIndex := Values[1];
end;

procedure TmwFormHouses.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.HousesList(FObjectId);
end;

procedure TmwFormHouses.ThreadFillData(API: TmwAPI);
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
