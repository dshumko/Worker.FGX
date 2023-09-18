unit Frame.FormBookMarks;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.Image, FGX.CardPanel,
  ServiceUnit.mwClasses, ServiceUnit.API, ServiceUnit.BookMarks,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  FGX.Button.Types, FGX.Button;

type
  TmwFormBookMarks = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    function lvContentGetItemCount(Sender: TObject): Integer;
  private
    FCurrentList: TObjectList<TmwBookMarkItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    { Public declarations }
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log,
  XSuperObject, Form.Main, Frame.FormHouse, Frame.FormHouses, Frame.FormBidInfo,
  Frame.FormCustomer;

procedure TmwFormBookMarks.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwBookMarkItem>.Create(true);
end;

procedure TmwFormBookMarks.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormBookMarks.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  formType: String;
begin
  formType := '';
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
  if FCurrentList[AIndex].Form = 'TmwFormHouses' then
    formType := 'Дома'
  else if FCurrentList[AIndex].Form = 'TmwFormHouse' then
    formType := 'Дом'
  else if FCurrentList[AIndex].Form = 'TmwFormBidInfo' then
    formType := 'Заявка'
  else if FCurrentList[AIndex].Form = 'TmwFormCustomer' then
    formType := 'Абонент';
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text := formType;
end;

function TmwFormBookMarks.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormBookMarks.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  Result := 'Style-Secondary';
end;

procedure TmwFormBookMarks.lvContentTapItem(Sender: TObject; const AIndex: Integer);
var
  name, title, subtitle: string;
begin
  name := Self.name;
  title := nbForm.title;
  subtitle := nbForm.subtitle;
  CloseMe(Self, true);
  if FCurrentList[AIndex].Form = 'TmwFormHouses' then
    FormMain.RunFrame(TmwFormHouses, [FCurrentList[AIndex].id], 'Дома', FCurrentList[AIndex].name)
  else if FCurrentList[AIndex].Form = 'TmwFormHouse' then
    FormMain.RunFrame(TmwFormHouse, [FCurrentList[AIndex].id], 'Дом', FCurrentList[AIndex].name)
  else if FCurrentList[AIndex].Form = 'TmwFormBidInfo' then
    FormMain.RunFrame(TmwFormBidInfo, [FCurrentList[AIndex].id], 'Заявка', FCurrentList[AIndex].name)
  else if FCurrentList[AIndex].Form = 'TmwFormCustomer' then
    FormMain.RunFrame(TmwFormCustomer, [FCurrentList[AIndex].id], 'Абонент', FCurrentList[AIndex].name);
  FormMain.AddToStack(TmwFormBookMarks, Name, [], title, subtitle);
end;

procedure TmwFormBookMarks.ThreadApiCall(API: TmwAPI);
begin
  inherited;
end;

procedure TmwFormBookMarks.ThreadFillData(API: TmwAPI);
var
  item: TmwBookMarkItem;
  i: Integer;
begin
  inherited;
  for i := 0 to BookMarks.struct.Count - 1 do
  begin
    item := TmwBookMarkItem.CreateFromJSON(BookMarks.struct[i].AsJsonObj);
    FCurrentList.Add(item)
  end;
end;

end.
