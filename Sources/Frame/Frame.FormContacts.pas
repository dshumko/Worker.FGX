unit Frame.FormContacts;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.CollectionView, FGX.StaticLabel, FGX.ActivityIndicator, FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, FGX.Image, FGX.CardPanel,
  FGX.AutocompleteEdit.Types, FGX.Edit, FGX.AutocompleteEdit, FGX.SearchEdit,
  FGX.Button.Types, FGX.Button;

type
  TmwFormContacts = class(TmwBaseListViewForm)
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    fgLabel1: TfgLabel;
    fgImage1: TfgImage;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    function lvContentGetItemCount(Sender: TObject): Integer;
    procedure lvContentPullToRefresh(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    FCurrentList: TObjectList<TmwContactItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    { Public declarations }
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.PhoneDialer, FGX.Toasts,
  XSuperObject, ServiceUnit.Utils, Form.Main;

{ TmwFormContacts }

procedure TmwFormContacts.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwContactItem>.Create(true);
end;

procedure TmwFormContacts.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwFormContacts.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
  AItem.GetControlByLookupName<TfgImage>('icon').Visible := not FCurrentList[AIndex].phone.IsEmpty;
end;

function TmwFormContacts.lvContentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormContacts.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  Result := 'Style-Contacts';
end;

procedure TmwFormContacts.lvContentPullToRefresh(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TmwFormContacts.lvContentTapItem(Sender: TObject; const AIndex: Integer);
begin
  inherited;
  if not FCurrentList[AIndex].phone.IsEmpty then
  begin
{$IFDEF ANDROID}
    DoExternalCall(FCurrentList[AIndex].phone);
{$ELSE}
    TfgPhoneDialer.Call(FCurrentList[AIndex].phone);
{$ENDIF}
  end;
end;

procedure TmwFormContacts.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormContacts.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.ContactList;
end;

procedure TmwFormContacts.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: Integer;
  item: TmwContactItem;
begin
  inherited;
  FCurrentList.Clear;
  if API.ResultJson['struct'].AsArray.Length > 0 then
  begin
    for i := 0 to API.ResultJson['struct'].AsArray.Length - 1 do
    begin
      x := API.ResultJson['struct'].AsArray.O[i];
      item := TmwContactItem.Create;
      item.LoadFromJSON(x);
      FCurrentList.Add(item)
    end;
  end;
end;

end.
