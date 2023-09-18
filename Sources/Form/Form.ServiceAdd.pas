unit Form.ServiceAdd;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.AutocompleteEdit.Types, FGX.CollectionView, FGX.Edit,
  FGX.AutocompleteEdit, FGX.SearchEdit, FGX.StaticLabel, FGX.ActivityIndicator,
  FGX.NavigationBar,
  ServiceUnit.API, ServiceUnit.mwClasses, FGX.Image, FGX.CardPanel,
  FGX.Calendar.Types, FGX.DateTimeControl, FGX.Calendar, FGX.Button.Types,
  FGX.Button;

type
  TApplyParametersCallback = reference to procedure(const AServiceId: integer; const AServiceName: string;
    const AServicePrice: string; const AOnListId: integer; const AOnListName: string; const AServiceDate: TDate);

type
  TmwServiceAdd = class(TmwBaseListViewForm)
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    lvContent_StyleSingle: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    lbSinglePrimary: TfgLabel;
    imSingle: TfgImage;
    pnCalendar: TfgLayout;
    bnSend: TfgButton;
    cdService: TfgCalendar;
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemCount(Sender: TObject): integer;
    function lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
    procedure lvContentTapItem(Sender: TObject; const AIndex: integer);
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure fgFormShow(Sender: TObject);
    procedure bnSendTap(Sender: TObject);
    procedure cdServiceDateSelected(Sender: TObject; const ANewDate: TDate);
  private
    FObjectId: integer;
    FStage: integer;
    FServiceId: integer;
    FServiceIndex: integer;
    FServiceName, FServicePrice: String;
    FOnListId: integer;
    FOnListName: String;
    FCurrentList: TObjectList<TmwCustomServices>;
    FSubList: TObjectList<TmwCustomServicesOnlist>;
    FServiceDate: TDate;
    FOnApplyParameters: TApplyParametersCallback;
    procedure CloseForm(AResult: Boolean);
    procedure SetStage(Value: integer);
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    property OnApplyParameters: TApplyParametersCallback read FOnApplyParameters write FOnApplyParameters;
    procedure SetParams(Values: array of Variant); override;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.UITypes,
  FGX.Application, FGX.Dialogs, FGX.Log,
{$IFDEF ANDROID}
  Android.API.ActivityAndView,
{$ENDIF}
  XSuperObject;

{ TTmwServiceAdd }

procedure TmwServiceAdd.bnSendTap(Sender: TObject);
begin
  inherited;
  CloseForm(true);
end;

procedure TmwServiceAdd.cdServiceDateSelected(Sender: TObject; const ANewDate: TDate);
begin
  inherited;
  FServiceDate := cdService.Date;
end;

procedure TmwServiceAdd.CloseForm(AResult: Boolean);
begin
  if AResult and Assigned(FOnApplyParameters) then
    FOnApplyParameters(FServiceId, FServiceName, FServicePrice, FOnListId, FOnListName, FServiceDate);
  Close;
end;

procedure TmwServiceAdd.fgFormCreate(Sender: TObject);
begin
  inherited;
  FObjectId := -1;
  FStage := 0;
  FServiceId := -1;
  FServiceName := '';
  FServicePrice := '';
  FOnListId := -1;
  FOnListName := '';
  // FServiceDate := Now();
  // cdService.Date := FServiceDate;
  FServiceIndex := -1;
  FCurrentList := TObjectList<TmwCustomServices>.Create(true);
  FSubList := TObjectList<TmwCustomServicesOnlist>.Create(true);
end;

procedure TmwServiceAdd.fgFormDestroy(Sender: TObject);
begin
  FCurrentList.Free;
  FSubList.Free;
  inherited;
end;

procedure TmwServiceAdd.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
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

procedure TmwServiceAdd.fgFormShow(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  // bug?
  if TJBuild_VERSION.SDK_INT <= 21 then
    cdService.ShowWeekCount := 6;
{$ENDIF}
  SetStage(0);
end;

procedure TmwServiceAdd.lvContentBindItem(Sender: TObject; const AIndex: integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  NewHeight: Single;
  // cnt: integer;
  //item: TmwCustomServicesOnlist;
begin
  if FStage = 0 then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text :=
      trim(FCurrentList[AIndex].name.Substring(0, FCurrentList[AIndex].name.LastIndexOf('/')));
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text :=
      trim(FCurrentList[AIndex].name.Substring(FCurrentList[AIndex].name.LastIndexOf('/') + 1));
    NewHeight := AItem.GetControlByLookupName<TfgLabel>('primary').MeasureSize(TfgMeasuringSpecification.Fixed,
      Width - 64, TfgMeasuringSpecification.Unspecified, 0).Height + AItem.GetControlByLookupName<TfgLabel>('secondary')
      .Size.Height + 24;
  end
  else
  begin
    // cnt := FSubList.Count;
    //item := FSubList[AIndex];
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FSubList[AIndex].name;
    NewHeight := AItem.GetControlByLookupName<TfgLabel>('primary').MeasureSize(TfgMeasuringSpecification.Fixed,
      Width - 64, TfgMeasuringSpecification.Unspecified, 0).Height + 24;

  end;
  AItem.item.Height := NewHeight;
  AItem.item.Realign;
end;

function TmwServiceAdd.lvContentGetItemCount(Sender: TObject): integer;
begin
  if FStage = 0 then
  begin
    if FCurrentList <> nil then
      Result := FCurrentList.Count
    else
      Result := 0;
  end
  else
  begin
    if FSubList <> nil then
      Result := FSubList.Count
    else
      Result := 0;
  end;
end;

function TmwServiceAdd.lvContentGetItemStyle(Sender: TObject; const AIndex: integer): string;
begin
  if FStage = 0 then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Single';
end;

procedure TmwServiceAdd.lvContentTapItem(Sender: TObject; const AIndex: integer);
begin
  if FStage = 0 then
  begin
    FServiceId := FCurrentList[AIndex].service_id;
    FServiceIndex := AIndex;
    FServiceName := trim(FCurrentList[AIndex].name.Substring(0, FCurrentList[AIndex].name.LastIndexOf('/')));
    FServicePrice := trim(FCurrentList[AIndex].name.Substring(FCurrentList[AIndex].name.LastIndexOf('/') + 1));
    SetStage(1);
  end
  else if FStage = 1 then
  begin
    FOnListId := FSubList[AIndex].on_id;
    FOnListName := FSubList[AIndex].name;
    SetStage(2);
  end;
end;

procedure TmwServiceAdd.nbFormNavigationIconTap(Sender: TObject);
begin
  if FStage = 0 then
    CloseForm(false)
  else
    SetStage(FStage - 1);
end;

procedure TmwServiceAdd.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
    FObjectId := Values[0];
end;

procedure TmwServiceAdd.SetStage(Value: integer);
var
  I: integer;
  subItem: TmwCustomServicesOnlist;
  next: Boolean;
begin
  next := Value > FStage;
  FStage := Value;
  case FStage of
    0:
      begin
        lvContent.Visible := true;
        pnCalendar.Visible := false;
        FServiceId := -1;
        FServiceName := '';
        FServicePrice := '';
        FOnListId := -1;
        FOnListName := '';
        FServiceDate := Now();
        lvContent.ReloadItems;
      end;
    1:
      begin
        lvContent.Visible := true;
        pnCalendar.Visible := false;
        if next then
        begin
          while FSubList.Count > 0 do
            FSubList.Delete(0);
          for I := 0 to FCurrentList[FServiceIndex].onlist.Count - 1 do
          begin
            subItem := TmwCustomServicesOnlist.Create;
            subItem.on_id := FCurrentList[FServiceIndex].onlist[I].on_id;
            subItem.name := FCurrentList[FServiceIndex].onlist[I].name;
            FSubList.Add(subItem);
          end;
          if FSubList.Count = 0 then
          begin
            subItem := TmwCustomServicesOnlist.CreateFromJSON('{"on_id": -1, "name":"Дальше..."}');
            FSubList.Add(subItem);
          end;
          FOnListName := '';
          FOnListId := -1;
          FOnListName := '';
          FServiceDate := Now();
        end;
        FServiceDate := Now();
        lvContent.ReloadItems;
      end;
    2:
      begin
        pnCalendar.Visible := true;
        lvContent.Visible := false;
      end;
  end;
end;

procedure TmwServiceAdd.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetCustomerServices(FObjectId);
end;

procedure TmwServiceAdd.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  I: integer;
  item: TmwCustomServices;
  ol: ISuperArray;
begin
  inherited;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for I := 0 to ol.Length - 1 do
    begin
      x := ol.O[I];
      item := TmwCustomServices.Create;
      item.LoadFromJSON(x);
      FCurrentList.Add(item)
    end;
  end;
end;

end.
