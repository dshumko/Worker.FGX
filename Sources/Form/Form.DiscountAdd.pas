unit Form.DiscountAdd;

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
  FGX.DateTimeControl, FGX.DateEdit, FGX.Button.Types, FGX.Memo, FGX.Button;

type
  TApplyParametersCallback = reference to procedure(const ADiscountId: integer; const ADiscountName: string;
    const ADiscountDateFrom: TDate; const ADiscountDateTo: TDate; const ADiscountSum: single;
    const ADiscountNotice: string);

type
  TmwDiscountAdd = class(TmwBaseListViewForm)
    pnDiscount: TfgLayout;
    lvContent_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbSinglePrimary: TfgLabel;
    imSingle: TfgImage;
    edDiscount: TfgEdit;
    lbDiscount: TfgLabel;
    deDateFrom: TfgDateEdit;
    lbDateFrom: TfgLabel;
    deDateTo: TfgDateEdit;
    lbDateTo: TfgLabel;
    bnSelect: TfgButton;
    mmNotice: TfgMemo;
    lbNotice: TfgLabel;
    bnSend: TfgButton;
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure bnSelectTap(Sender: TObject);
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure bnSendTap(Sender: TObject);
    function lvContentGetItemCount(Sender: TObject): integer;
  private
    FObjectId: integer;
    FDiscountIndex, FDiscountId: integer;
    FStage: integer;
    FCurrentList: TObjectList<TmwDiscountItem>;
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
  System.SysUtils, System.UiTypes, System.DateUtils,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  XSuperObject, Assets.Consts;

procedure TmwDiscountAdd.bnSelectTap(Sender: TObject);
begin
  SetStage(1);
end;

procedure TmwDiscountAdd.bnSendTap(Sender: TObject);
begin
  inherited;
  if edDiscount.Text.Trim.IsEmpty then
  begin
    TfgToastFactory.Show('Коэффициент не указан');
    Exit;
  end;
  if FDiscountIndex = -1 then
  begin
    TfgToastFactory.Show('На что скидка?');
    Exit;
  end;
  CloseForm(True);
end;

procedure TmwDiscountAdd.CloseForm(AResult: Boolean);
begin
  if AResult and Assigned(FOnApplyParameters) then
    FOnApplyParameters(FDiscountId, bnSelect.Text, deDateFrom.Date, deDateTo.Date, edDiscount.Text.ToSingle,
      mmNotice.Text);
  Close;
end;

procedure TmwDiscountAdd.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := -1;
  FDiscountIndex := -1;
  FDiscountId := -1;
  FCurrentList := TObjectList<TmwDiscountItem>.Create(True);
  deDateFrom.Date := StartOfTheMonth(Now);
  deDateTo.Date := EndOfTheMonth(Now);
end;

procedure TmwDiscountAdd.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  inherited;
end;

procedure TmwDiscountAdd.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := True;
    if FStage = 0 then
      CloseForm(false)
    else
      SetStage(FStage - 1);
  end;
end;

procedure TmwDiscountAdd.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  NewHeight: single;
begin
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
  if AIndex = FDiscountIndex then
    AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_BIDSIGNALIEN;
  NewHeight := AItem.GetControlByLookupName<TfgLabel>('primary').MeasureSize(TfgMeasuringSpecification.Fixed,
    Width - 64, TfgMeasuringSpecification.Unspecified, 0).Height + 24;
  AItem.Item.Height := NewHeight;
  AItem.Item.Realign;
end;

function TmwDiscountAdd.lvContentGetItemCount(Sender: TObject): integer;
begin
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwDiscountAdd.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  Result := 'Style-Single';
end;

procedure TmwDiscountAdd.lvContentTapItem(Sender: TObject; const AIndex: integer);
begin
  FDiscountId := FCurrentList[AIndex].id;
  FDiscountIndex := AIndex;
  bnSelect.Text := FCurrentList[AIndex].name;
  SetStage(0);
end;

procedure TmwDiscountAdd.nbFormNavigationIconTap(Sender: TObject);
begin
  if FStage = 0 then
    CloseForm(false)
  else
    SetStage(FStage - 1);
end;

procedure TmwDiscountAdd.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
    FObjectId := Values[0];
end;

procedure TmwDiscountAdd.SetStage(Value: integer);
begin
  FStage := Value;
  case FStage of
    0:
      begin
        lvContent.Visible := false;
        pnDiscount.Visible := True;
      end;
    1:
      begin
        lvContent.Visible := True;
        lvContent.ReloadItems;
        pnDiscount.Visible := false;
      end;
  end;
end;

procedure TmwDiscountAdd.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetDiscountList(FObjectId);
end;

procedure TmwDiscountAdd.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: integer;
  Item: TmwDiscountItem;
  ol: ISuperArray;
begin
  inherited;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      Item := TmwDiscountItem.Create;
      Item.LoadFromJSON(x);
      FCurrentList.Add(Item)
    end;
  end;
end;

end.
