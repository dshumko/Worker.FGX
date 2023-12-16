unit Base.BaseListViewForm;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections, Base.BaseApiForm,
  FGX.NavigationBar.Types, FGX.Layout.Types, FGX.AutocompleteEdit.Types,
  FGX.CollectionView, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  FGX.StaticLabel, FGX.ActivityIndicator, FGX.Layout, FGX.Controls,
  FGX.NavigationBar, JsonableObject, FGX.Image, FGX.Button.Types, FGX.Button;

type
  TObjectListOfJsonable = class(TObjectList<TJsonableObject>)
  public
    constructor Create;
  end;

type
  TmwBaseListViewForm = class(TmwBaseApiForm)
    lvContent: TfgCollectionView;
    lvContent_Styles: TfgCollectionViewStyles;
    pnSearch: TfgLayout;
    imSearch: TfgImage;
    edSearch: TfgEdit;
    imClear: TfgImage;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): Integer;
    procedure imClearTap(Sender: TObject);
    procedure seSearchChanging(Sender: TObject); virtual;
  private
    procedure processCardPanel(fg: TfgControl);
    procedure pnCardPanelTap(Sender: TObject);
  protected
    FLVStartIndex: Integer;
  public
    procedure AfterLoad; override;
  end;

var
  mwBaseListViewForm: TmwBaseListViewForm;

implementation

{$R *.xfm}

uses
  System.SysUtils, ServiceUnit.Settings,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.CardPanel;

{ TmwBaseListViewForm }

procedure TmwBaseListViewForm.AfterLoad;
begin
  lvContent.ReloadItems;
  if (FLVStartIndex > 0) and (lvContent.Count > FLVStartIndex) then
  begin
    lvContent.ScrollToItem(FLVStartIndex, TfgItemLocation.Auto, false);
    FLVStartIndex := 0;
  end;
  inherited;
end;

{ TObjectListOfJsonable }

constructor TObjectListOfJsonable.Create;
begin
  inherited Create(True);
end;

procedure TmwBaseListViewForm.seSearchChanging(Sender: TObject);
begin
  inherited;
  imClear.Visible := not edSearch.Text.IsEmpty;
end;

procedure TmwBaseListViewForm.fgFormCreate(Sender: TObject);
begin
  inherited;
  FLVStartIndex := 0;
  if TOSVersion.Platform = TOSVersion.TPlatform.pfiOS then
    processCardPanel(lvContent_Styles);
end;

procedure TmwBaseListViewForm.fgFormDestroy(Sender: TObject);
begin
  inherited;
//  FCurrentList.Free;
end;

procedure TmwBaseListViewForm.imClearTap(Sender: TObject);
begin
  inherited;
  edSearch.Text := '';
  seSearchChanging(edSearch);
end;

function TmwBaseListViewForm.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  Result := 0;
{
  if FCurrentList <> nil then
    Result := FCurrentList.Count
}
end;

procedure TmwBaseListViewForm.processCardPanel(fg: TfgControl);
var
  i: Integer;
begin
  if fg is TfgCardPanel then
  begin
    fg.HitTest := True;
    fg.OnTap := pnCardPanelTap
  end;
  for i := 0 to fg.ControlsCount - 1 do
    processCardPanel(fg.Controls[i]);
end;

procedure TmwBaseListViewForm.pnCardPanelTap(Sender: TObject);
var
  AIndex: Integer;
begin
  inherited;
  if Assigned(lvContent.OnTapItem) and lvContent.FindItemIndexByObject(Sender, AIndex) then
    lvContent.OnTapItem(lvContent, AIndex);
end;

end.
