unit Form.EquipmentAdd;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.AutocompleteEdit.Types, FGX.CollectionView, FGX.Edit,
  FGX.AutocompleteEdit, FGX.SearchEdit, FGX.StaticLabel, FGX.ActivityIndicator,
  FGX.NavigationBar,
  ServiceUnit.mwClasses, ServiceUnit.API, FGX.Image, FGX.CardPanel,
  FGX.Button.Types, FGX.Memo, FGX.Button;

type
  TApplyParametersCallback = reference to procedure(const AEquipmentId: integer; const AEquipmentName: string;
    const AIp: String; const AMac: string; const APort: integer; const ANotice: string);

type
  TmwEquipmentAdd = class(TmwBaseListViewForm)
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    pnEquipment: TfgLayout;
    lbIpAddress: TfgLabel;
    lbPort: TfgLabel;
    edPort: TfgEdit;
    bnSelect: TfgButton;
    lbNotice: TfgLabel;
    mmNotice: TfgMemo;
    bnSend: TfgButton;
    edIpAddress: TfgEdit;
    edMacAddress: TfgEdit;
    lbMacAddress: TfgLabel;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure bnSelectTap(Sender: TObject);
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure bnSendTap(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): integer;
  private
    FObjectId: integer;
    FHouseId: integer;
    FStage: integer;
    FEquipmentId: integer;
    FEquipmentIndex: integer;
    FCurrentList: TObjectList<TmwLinkTo>;
    FIP, FMAC: string;
    FPort: integer;
    FOnApplyParameters: TApplyParametersCallback;
    procedure CloseForm(AResult: Boolean);
    procedure SetStage(Value: integer);
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); overload;
    property OnApplyParameters: TApplyParametersCallback read FOnApplyParameters write FOnApplyParameters;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.UITypes,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  XSuperObject;

{ TmwEquipmentAdd }

procedure TmwEquipmentAdd.bnSelectTap(Sender: TObject);
begin
  SetStage(1);
end;

function FormatMAC(const MAC: string): string;
var
  S: string;
  c: Char;
begin
  S := UpperCase(MAC);
  for c in S do
  begin
    if '0123456789ABCDEF'.Contains(c) then
      Result := Result + c;
  end;
  if Length(Result) <> 12 then
  begin
    Result := '';
    Exit;
  end
  else
  begin
    Result := Result.Insert(10, ':');
    Result := Result.Insert(8, ':');
    Result := Result.Insert(6, ':');
    Result := Result.Insert(4, ':');
    Result := Result.Insert(2, ':');
  end
end;

function FormatIP(const IP: string): string;
var
  c: Char;
begin
  for c in IP do
  begin
    if '0123456789.'.Contains(c) then
      Result := Result + c;
  end;
end;

procedure TmwEquipmentAdd.bnSendTap(Sender: TObject);
begin
  FIP := FormatIP(edIpAddress.Text);
  FMAC := FormatMAC(edMacAddress.Text);
  if FIP = '' then
  begin
    TfgToastFactory.Show('IP адрес введен не верно!');
    Exit;
  end;
  if FMAC = '' then
  begin
    TfgToastFactory.Show('MAC адрес введен не верно!');
    Exit;
  end;
  if FEquipmentIndex = -1 then
  begin
    TfgToastFactory.Show('ќборудование не выбрано');
    Exit;
  end;
  if not TryStrToInt(edPort.Text, FPort) then
  begin
    TfgToastFactory.Show('”кажите порт');
    Exit;
  end;
  CloseForm(true);
end;

procedure TmwEquipmentAdd.CloseForm(AResult: Boolean);
begin
  if AResult and Assigned(FOnApplyParameters) then
    FOnApplyParameters(FEquipmentId, bnSelect.Text, FMAC, FIP, edPort.Text.ToInteger, mmNotice.Text);
  Close;
end;

procedure TmwEquipmentAdd.fgFormCreate(Sender: TObject);
begin
  inherited;
  FHouseId := -1;
  FObjectId := -1;
  FEquipmentId := -1;
  FEquipmentIndex := -1;
  FStage := 0;
  FCurrentList := TObjectList<TmwLinkTo>.Create(true);
end;

procedure TmwEquipmentAdd.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwEquipmentAdd.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := true;
    if FStage = 0 then
      CloseForm(false)
    else
      SetStage(FStage - 1);
  end;
end;

procedure TmwEquipmentAdd.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text :=
    trim(FCurrentList[AIndex].name.Substring(0, FCurrentList[AIndex].name.LastIndexOf(' ')));
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text :=
    trim(FCurrentList[AIndex].name.Substring(FCurrentList[AIndex].name.LastIndexOf(' ') + 1));
end;

function TmwEquipmentAdd.lvContentGetItemCount(Sender: TObject): integer;
begin
  inherited;
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwEquipmentAdd.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  inherited;
  Result := 'Style-Secondary';
end;

procedure TmwEquipmentAdd.lvContentTapItem(Sender: TObject; const AIndex: integer);
begin
  FEquipmentId := FCurrentList[AIndex].id;
  FEquipmentIndex := AIndex;
  bnSelect.Text := FCurrentList[AIndex].name;
  SetStage(0);
end;

procedure TmwEquipmentAdd.nbFormNavigationIconTap(Sender: TObject);
begin
  if FStage = 0 then
    CloseForm(false)
  else
    SetStage(FStage - 1);
end;

procedure TmwEquipmentAdd.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
  begin
    FObjectId := Values[0];
    FHouseId := Values[1];
  end;
end;

procedure TmwEquipmentAdd.SetStage(Value: integer);
begin
  FStage := Value;
  case FStage of
    0:
      begin
        lvContent.Visible := false;
        pnEquipment.Visible := true;
      end;
    1:
      begin
        lvContent.Visible := true;
        lvContent.ReloadItems;
        pnEquipment.Visible := false;
      end;
  end;
end;

procedure TmwEquipmentAdd.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetLinkTo(FHouseId);
end;

procedure TmwEquipmentAdd.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: integer;
  item: TmwLinkTo;
  ol: ISuperArray;
begin
  inherited;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      item := TmwLinkTo.Create;
      item.LoadFromJSON(x);
      FCurrentList.Add(item)
    end;
  end;
end;

end.
