unit Form.MaterialAddRemove;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.CardPanel, FGX.Button.Types, FGX.Button, FGX.Edit,
  FGX.StaticLabel;

type
  TApplyParametersCallback = reference to procedure(const AId: Integer; const ADirection: Boolean; const ACount: Single;
    const AInt: Boolean);

type
  TmwMaterialAddRemove = class(TfgForm)
    fgLayout2: TfgLayout;
    fgLayout1: TfgLayout;
    fgCardPanel1: TfgCardPanel;
    fgLayout3: TfgLayout;
    lbAvailable: TfgLabel;
    fgLayout4: TfgLayout;
    edMaterialAdd: TfgEdit;
    lbCaption: TfgLabel;
    bnPlus: TfgButton;
    bnMinus: TfgButton;
    fgLayout5: TfgLayout;
    fglyt1: TfgLayout;
    bnMaterialAdd: TfgButton;
    fglyt2: TfgLayout;
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure bnMaterialAddTap(Sender: TObject);
    procedure edMaterialAddChanged(Sender: TObject);
    procedure bnMinusTap(Sender: TObject);
    procedure bnPlusTap(Sender: TObject);
  private
    FId: Integer;
    FDirection: Boolean;
    FMax, FMin: Single;
    FOnApplyParameters: TApplyParametersCallback;
    FCurValue: Single;
    FInt: Boolean;
    procedure CloseForm;
    procedure SetCurValue(const Value: Single);
  public
    procedure SetParams(const AId: Integer; const ACaption, AAvailable: string; const AMax, AMin: Single;
      const ADirection: Boolean; const AInt: Boolean; const useMax: Boolean = true);
    property OnApplyParameters: TApplyParametersCallback read FOnApplyParameters write FOnApplyParameters;
    property CurValue: Single read FCurValue write SetCurValue;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.UITypes, System.Math,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Text,
  ServiceUnit.Utils, Assets.Consts;

procedure TmwMaterialAddRemove.bnMaterialAddTap(Sender: TObject);
begin
  CloseForm;
end;

procedure TmwMaterialAddRemove.bnMinusTap(Sender: TObject);
begin
  if FCurValue > 1 then
    CurValue := CurValue - 1
  else
    CurValue := 0;
end;

procedure TmwMaterialAddRemove.bnPlusTap(Sender: TObject);
begin
  if (FMax - CurValue) > 1 then
    CurValue := CurValue + 1
  else
    CurValue := FMax;
end;

procedure TmwMaterialAddRemove.CloseForm;
begin
  if FCurValue > FMax then
    FCurValue := FMax;
  if FCurValue < FMin then
    FCurValue := FMin;
  if Assigned(FOnApplyParameters) then
    FOnApplyParameters(FId, FDirection, CurValue, FInt);
  Close;
end;

procedure TmwMaterialAddRemove.edMaterialAddChanged(Sender: TObject);
var
  floatValue: Single;
begin
  try
    floatValue := edMaterialAdd.Text.toSingle;
    if FInt then
    begin
      FCurValue := Round(floatValue);
    end
    else
    begin
      FCurValue := RoundTo(floatValue, -2);
    end;
  except
    FCurValue := FCurValue;
  end;
end;

procedure TmwMaterialAddRemove.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := true;
    CurValue := 0;
    CloseForm;
  end;
end;

procedure TmwMaterialAddRemove.SetParams(const AId: Integer; const ACaption, AAvailable: string;
  const AMax, AMin: Single; const ADirection: Boolean; const AInt: Boolean; const useMax: Boolean = true);
begin
  FId := AId;
  FDirection := ADirection;
  FMax := AMax;
  FMin := AMin;
  FInt := AInt;
  if FInt then
    edMaterialAdd.KeyboardType := TfgKeyboardType.NumberPad
  else
    edMaterialAdd.KeyboardType := TfgKeyboardType.NumbersAndPunctuation;
  lbCaption.Text := ACaption;
  if ADirection then
  begin
    lbAvailable.Text := Format('Доступно: %s', [AAvailable]);
    bnMaterialAdd.Text := 'Добавить';
    bnMaterialAdd.BackgroundName := R.Color.COLORS_BTNGREEN;
    CurValue := 1;
  end
  else
  begin
    lbAvailable.Text := Format('В заявке: %s', [AAvailable]);
    bnMaterialAdd.Text := 'Удалить';
    bnMaterialAdd.BackgroundName := R.Color.COLORS_BTNRED;
    CurValue := AMax;
  end;
  if not useMax then
    lbAvailable.Text := '';
end;

procedure TmwMaterialAddRemove.SetCurValue(const Value: Single);
begin
  if FInt then
  begin
    FCurValue := Round(Value);
    edMaterialAdd.Text := FCurValue.ToString;
  end
  else
  begin
    FCurValue := Value;
    edMaterialAdd.Text := RoundTo(FCurValue, -2).ToString;
  end;
end;

end.
