unit Form.NewAbonent;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseForm, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar,
  FGX.PageControl, FGX.Button.Types, FGX.Button, FGX.Memo,
  FGX.Image, FGX.Edit, FGX.CardPanel, FGX.CollectionView,
  ServiceUnit.mwClasses;

type
  TApplyParametersCallback = reference to procedure(const AResult: boolean);

type
  TmwFormNewAbonent = class(TmwBaseForm)
    pcAbonent: TfgPageControl;
    pgAbonent: TfgPage;
    pgService: TfgPage;
    pgEquipment: TfgPage;
    pgDiscount: TfgPage;
    pgNotice: TfgPage;
    pnNavigation: TfgLayout;
    mmNotice: TfgMemo;
    bnSend: TfgButton;
    lbPageTitle: TfgLabel;
    imNext: TfgImage;
    imPrev: TfgImage;
    bnServiceAdd: TfgButton;
    bnEquipmentAdd: TfgButton;
    bnDiscountAdd: TfgButton;
    lbFlat: TfgLabel;
    edFlat: TfgEdit;
    lbPassportReg: TfgLabel;
    edPassportReg: TfgEdit;
    lbLastName: TfgLabel;
    edLastName: TfgEdit;
    lbFirstName: TfgLabel;
    edFirstName: TfgEdit;
    lbMiddleName: TfgLabel;
    edMiddleName: TfgEdit;
    lbPassportSerie: TfgLabel;
    edPassportSerie: TfgEdit;
    lbNotice: TfgLabel;
    lvServices: TfgCollectionView;
    lvServices_Styles: TfgCollectionViewStyles;
    lvServices_Style1: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    lvEquipment: TfgCollectionView;
    lvEquipment_Styles: TfgCollectionViewStyles;
    lvEquipment_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    fgLayout1: TfgLayout;
    fgLabel1: TfgLabel;
    fgLabel2: TfgLabel;
    lvDiscount: TfgCollectionView;
    lvDiscount_Styles: TfgCollectionViewStyles;
    lvDiscount_Style1: TfgCollectionViewStyle;
    fgCardPanel3: TfgCardPanel;
    fgLayout2: TfgLayout;
    fgLabel3: TfgLabel;
    fgLabel4: TfgLabel;
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure bnSendTap(Sender: TObject);
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: boolean);
    procedure pcAbonentChanged(Sender: TObject);
    procedure fgFormShow(Sender: TObject);
    procedure imNextTap(Sender: TObject);
    procedure imPrevTap(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    function lvServicesGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvServicesBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure lvEquipmentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvEquipmentGetItemCount(Sender: TObject): Integer;
    function lvEquipmentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvDiscountBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvDiscountGetItemCount(Sender: TObject): Integer;
    function lvDiscountGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure bnServiceAddTap(Sender: TObject);
    procedure bnDiscountAddTap(Sender: TObject);
    procedure lvServicesTapItem(Sender: TObject; const AIndex: Integer);
    procedure lvDiscountTapItem(Sender: TObject; const AIndex: Integer);
    procedure bnEquipmentAddTap(Sender: TObject);
    function lvServicesGetItemCount(Sender: TObject): Integer;
    procedure lvEquipmentTapItem(Sender: TObject; const AIndex: Integer);
    procedure nbFormTap(Sender: TObject);
  private
    FHouseId: Integer;
    FCustomerId: Integer;
    FCustomerInfo: TmwCustomerItem;
    FServiceList: TObjectList<TmwCustomServices>;
    FEquipmentList: TObjectList<TmwEquipmentItemEx>;
    FDiscountList: TObjectList<TmwCustomerDiscountItem>;
    FOnApplyParameters: TApplyParametersCallback;
    procedure CloseForm(AResult: boolean);
    procedure DoPing(const Id, eType: Integer);
    procedure ChangePage(const NextId: Integer);
  public
    property OnApplyParameters: TApplyParametersCallback read FOnApplyParameters write FOnApplyParameters;
    procedure SetParams(Values: array of Variant); overload; override;
    procedure SetParams(ACustomerInfo: TmwCustomerItem); overload;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.UITypes, System.Math, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  ServiceUnit.API, ServiceUnit.Settings, Assets.Consts,
  Form.ServiceAdd, Form.DiscountAdd, Form.EquipmentAdd,
  Form.Main;

{ TmwFormNewAbonent }

procedure TmwFormNewAbonent.SetParams(Values: array of Variant);
begin
  if Length(Values) = 2 then
  begin
    FHouseId := Values[0];
    FCustomerId := Values[1];
  end;
end;

procedure TmwFormNewAbonent.bnDiscountAddTap(Sender: TObject);
var
  fDiscountAdd: TmwDiscountAdd;
  discountItem: TmwCustomerDiscountItem;
begin
  inherited;
  fDiscountAdd := TmwDiscountAdd.Create(Application);
  fDiscountAdd.SetParams([FCustomerId]);
  fDiscountAdd.OnApplyParameters :=
      procedure(const ADiscountId: Integer; const ADiscountName: string; const ADiscountDateFrom: TDate;
      const ADiscountDateTo: TDate; const ADiscountSum: single; const ADiscountNotice: string)
    begin
      discountItem := TmwCustomerDiscountItem.Create;
      discountItem.srv_id := ADiscountId.ToString;
      discountItem.Id := 0;
      discountItem.name := ADiscountName;
      discountItem.date_from := DateToStr(ADiscountDateFrom);
      discountItem.date_to := DateToStr(ADiscountDateTo);
      discountItem.value := RoundTo(ADiscountSum, -6).ToString;
      discountItem.notice := ADiscountNotice;
      FDiscountList.Add(discountItem);
      lvDiscount.ReloadItems;
    end;
  fDiscountAdd.ShowForm('Добавить коэффициент', '');
end;

procedure TmwFormNewAbonent.bnEquipmentAddTap(Sender: TObject);
var
  fEquipmentAdd: TmwEquipmentAdd;
  equipmentItem: TmwEquipmentItemEx;
begin
  inherited;
  fEquipmentAdd := TmwEquipmentAdd.Create(Application);
  fEquipmentAdd.SetParams([FCustomerId, FHouseId]);
  fEquipmentAdd.OnApplyParameters :=
      procedure(const AEquipmentId: Integer; const AEquipmentName: string; const AIp: String; const AMac: string;
      const APort: Integer; const ANotice: string)
    begin
      equipmentItem := TmwEquipmentItemEx.Create;
      equipmentItem.Id := 1;
      equipmentItem.e_type := '';
      equipmentItem.name := AEquipmentName;
      equipmentItem.mac := AMac;
      equipmentItem.parent_id := AEquipmentId;
      equipmentItem.parent_name := AEquipmentName;
      equipmentItem.port := APort.ToString;
      equipmentItem.ip := AIp;
      equipmentItem.notice := ANotice;
      FEquipmentList.Add(equipmentItem);
      lvEquipment.ReloadItems;
    end;
  fEquipmentAdd.ShowForm('Добавить оборудование', '');
end;

procedure TmwFormNewAbonent.bnSendTap(Sender: TObject);
var
  newCustomer: TmwNewCustomer;
  I: Integer;
  ss: TmwStoreService;
  es: TmwStoreEquipment;
  ds: TmwStoreDiscount;
  API: TmwApi;
begin
  newCustomer := TmwNewCustomer.Create;
  newCustomer.customer_id := FCustomerId;
  newCustomer.flat := edFlat.Text;
  newCustomer.secondname := edLastName.Text;
  newCustomer.name := edFirstName.Text;
  newCustomer.thirdname := edMiddleName.Text;
  newCustomer.passport_num := edPassportSerie.Text;
  newCustomer.passport_reg := edPassportReg.Text;
  newCustomer.desc := mmNotice.Text;
  newCustomer.house_id := FHouseId;

  for I := 0 to FServiceList.Count - 1 do
  begin
    if FServiceList[I].service_id >= 0 then
    begin
      ss := TmwStoreService.Create;
      ss.service_id := FServiceList[I].service_id;
      ss.name := FServiceList[I].name;
      if FServiceList[I].onlist.Count > 0 then
      begin
        ss.onList_id := FServiceList[I].onlist[0].on_id;
        ss.onList_name := FServiceList[I].onlist[0].name;
      end;
      ss.date := FServiceList[I].date;
      newCustomer.new_services.Add(ss);
    end;
  end;
  for I := 0 to FEquipmentList.Count - 1 do
  begin
    if FEquipmentList[I].Id >= 0 then
    begin
      es := TmwStoreEquipment.Create;
      es.equipment_id := FEquipmentList[I].parent_id;
      es.name := FEquipmentList[I].parent_name;
      es.mac := FEquipmentList[I].mac;
      es.port := FEquipmentList[I].port.ToInteger;
      es.ip := FEquipmentList[I].ip;
      es.notice := FEquipmentList[I].notice;
      newCustomer.new_equipments.Add(es);
    end;
  end;
  for I := 0 to FDiscountList.Count - 1 do
  begin
    if FDiscountList[I].Id >= 0 then
    begin
      ds := TmwStoreDiscount.Create;
      ds.discount_id := FDiscountList[I].srv_id.ToInteger;
      ds.name := FDiscountList[I].name;
      ds.from_date := StrToDate(FDiscountList[I].date_from);
      ds.to_date := StrToDate(FDiscountList[I].date_to);
      ds.sum := RoundTo(FDiscountList[I].value.ToExtended, -6);
      ds.notice := FDiscountList[I].notice;
      newCustomer.new_discounts.Add(ds);
    end;
  end;
  // fn := TPath.Combine(TPath.GetDocumentsPath, 'cs' + IntToStr(FCustomerId) + '.json');
  // NewCustomer.SaveToFile(fn);
  AnimationStart();
  TTask.Run(
    procedure
    begin
      API := TmwApi.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        API.newCustomer(newCustomer);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if API.Err.Code <> 0 then
            begin
              AnimationStop();
              TfgToastFactory.Show(API.Err.Msg)
            end
            else
              CloseForm(true);
          end)
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormNewAbonent.lvDiscountBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
const AItem: TfgItemWrapper);
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FDiscountList[AIndex].name;
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FDiscountList[AIndex].value;
  if FDiscountList[AIndex].Id >= 0 then
    AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_BIDSIGNALIEN;
end;

function TmwFormNewAbonent.lvDiscountGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FDiscountList <> nil then
    Result := FDiscountList.Count
  else
    Result := 0;
end;

function TmwFormNewAbonent.lvDiscountGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  Result := 'Style-Secondary';
end;

procedure TmwFormNewAbonent.lvDiscountTapItem(Sender: TObject; const AIndex: Integer);
begin
  inherited;
  if FDiscountList[AIndex].Id < 0 then
    Exit;
  TfgDialogs.MessageDialog('Удалить коэффициент?', [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        FDiscountList.Delete(AIndex);
        lvDiscount.ReloadItems;
      end;
    end);
end;

procedure TmwFormNewAbonent.lvEquipmentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
const AItem: TfgItemWrapper);
begin
  inherited;
  if FEquipmentList[AIndex].Id <= 0 then
  begin
    if FEquipmentList[AIndex].parent_id = -1 then
    begin
      AItem.GetControlByLookupName<TfgLabel>('primary').Text := 'Подключен к';
      AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FEquipmentList[AIndex].name;
    end
    else
    begin
      AItem.GetControlByLookupName<TfgLabel>('primary').Text := FEquipmentList[AIndex].name;
      AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FEquipmentList[AIndex].mac;
    end;
  end
  else
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FEquipmentList[AIndex].parent_name;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FEquipmentList[AIndex].ip;
    AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_BIDSIGNALIEN;
  end;
end;

function TmwFormNewAbonent.lvEquipmentGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FEquipmentList <> nil then
    Result := FEquipmentList.Count
  else
    Result := 0;
end;

function TmwFormNewAbonent.lvEquipmentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  Result := 'Style-Secondary';
end;

procedure TmwFormNewAbonent.lvEquipmentTapItem(Sender: TObject; const AIndex: Integer);
begin
  inherited;
  if FEquipmentList[AIndex].Id < 0 then
  begin
    if (FEquipmentList[AIndex].parent_id <> -1) then
      DoPing(-FEquipmentList[AIndex].Id, FEquipmentList[AIndex].e_type.ToInteger);
    Exit;
  end;
  TfgDialogs.MessageDialog('Удалить оборудование?', [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        FEquipmentList.Delete(AIndex);
        lvEquipment.ReloadItems;
      end;
    end);
end;

procedure TmwFormNewAbonent.bnServiceAddTap(Sender: TObject);
var
  fServiceAdd: TmwServiceAdd;
  item: TmwCustomServices;
  onListItem: TmwCustomServicesOnlist;
begin
  inherited;
  fServiceAdd := TmwServiceAdd.Create(Application);
  fServiceAdd.SetParams([FCustomerId]);
  fServiceAdd.OnApplyParameters :=
      procedure(const AServiceId: Integer; const AServiceName: string; const AServicePrice: string;
    const AOnListId: Integer; const AOnListName: string; const AServiceDate: TDate)
    begin
      item := TmwCustomServices.Create;
      item.service_id := AServiceId;
      item.name := AServiceName;
      item.tarif := AServicePrice;
      item.date := AServiceDate;
      if AOnListId > 0 then
      begin
        onListItem := TmwCustomServicesOnlist.Create;
        onListItem.on_id := AOnListId;
        onListItem.name := AOnListName;
        item.onlist := TObjectList<TmwCustomServicesOnlist>.Create(true);
        item.onlist.Add(onListItem);
      end;
      FServiceList.Add(item);
      lvServices.ReloadItems;
    end;
  fServiceAdd.ShowForm('Добавить услугу', '');
end;

procedure TmwFormNewAbonent.CloseForm(AResult: boolean);
begin
  if Assigned(FOnApplyParameters) then
    FOnApplyParameters(AResult);
  Close;
end;

procedure TmwFormNewAbonent.DoPing(const Id, eType: Integer);
var
  API: TmwApi;
  aJson: string;
begin
  TfgToastFactory.Show('Ping');
  TTask.Run(
    procedure
    begin
      API := TmwApi.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        aJson := API.ActionEquipment(Id, eType);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            TfgDialogs.ShowMessage(API.ResultJson['result'].AsString);
          end);
      finally
        API.Free;
      end
    end);
end;

procedure TmwFormNewAbonent.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCustomerInfo := TmwCustomerItem.Create;
  FServiceList := TObjectList<TmwCustomServices>.Create(true);
  FEquipmentList := TObjectList<TmwEquipmentItemEx>.Create(true);
  FDiscountList := TObjectList<TmwCustomerDiscountItem>.Create(true);
  bnServiceAdd.Visible := FormMain.Rights.AbAddSrv;
end;

procedure TmwFormNewAbonent.fgFormDestroy(Sender: TObject);
begin
  inherited;
  FServiceList.Free;
  FEquipmentList.Free;
  FDiscountList.Free;
  FCustomerInfo.Free;
end;

procedure TmwFormNewAbonent.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: boolean);
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := true;
    if pcAbonent.PageIndex = 0 then
      CloseForm(false)
    else
      pcAbonent.PageIndex := pcAbonent.PageIndex - 1;
  end;
end;

procedure TmwFormNewAbonent.fgFormShow(Sender: TObject);
begin
  pcAbonent.PageIndex := 0;
  lbPageTitle.Text := pcAbonent.ActivePage.Title;
end;

procedure TmwFormNewAbonent.imNextTap(Sender: TObject);
begin
  if pcAbonent.PageIndex < pcAbonent.PagesCount - 1 then
    ChangePage(pcAbonent.PageIndex + 1);
end;

procedure TmwFormNewAbonent.imPrevTap(Sender: TObject);
begin
  if pcAbonent.PageIndex > 0 then
    ChangePage(pcAbonent.PageIndex - 1);
end;

procedure TmwFormNewAbonent.lvServicesBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
const AItem: TfgItemWrapper);
begin
  inherited;
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FServiceList[AIndex].name;
  AItem.GetControlByLookupName<TfgLabel>('secondary').Text := FServiceList[AIndex].tarif;
  if FServiceList[AIndex].service_id >= 0 then
    AItem.GetControlByLookupName<TfgCardPanel>('card').BackgroundColorName := R.Color.COLORS_BIDSIGNALIEN;
end;

function TmwFormNewAbonent.lvServicesGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  if FServiceList <> nil then
    Result := FServiceList.Count
  else
    Result := 0;
end;

function TmwFormNewAbonent.lvServicesGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  Result := 'Style-Secondary';
end;

procedure TmwFormNewAbonent.lvServicesTapItem(Sender: TObject; const AIndex: Integer);
begin
  inherited;
  if FServiceList[AIndex].service_id < 0 then
    Exit;
  TfgDialogs.MessageDialog('Удалить услугу?', [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        FServiceList.Delete(AIndex);
        lvServices.ReloadItems;
      end;
    end);
end;

procedure TmwFormNewAbonent.nbFormNavigationIconTap(Sender: TObject);
begin
  if pcAbonent.PageIndex = 0 then
    CloseForm(false)
  else
    pcAbonent.PageIndex := pcAbonent.PageIndex - 1
end;

procedure TmwFormNewAbonent.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormNewAbonent.pcAbonentChanged(Sender: TObject);
begin
  lbPageTitle.Text := pcAbonent.ActivePage.Title;
  imNext.Visible := pcAbonent.PageIndex < pcAbonent.PagesCount - 1;
  imPrev.Visible := pcAbonent.PageIndex > 0;
end;

procedure TmwFormNewAbonent.SetParams(ACustomerInfo: TmwCustomerItem);
var
  I: Integer;
  serviceItem: TmwCustomServices;
  equipmentItem: TmwEquipmentItemEx;
  discountItem: TmwCustomerDiscountItem;
  curParentId: Integer;
begin
  if Assigned(ACustomerInfo) then
  begin
    FCustomerInfo.LoadFromJSON(ACustomerInfo.AsJsonObj);
    FHouseId := ACustomerInfo.house_id;
    edFlat.Text := ACustomerInfo.firstname;
    edLastName.Text := ACustomerInfo.surname;
    edMiddleName.Text := ACustomerInfo.midlename;
    edFlat.Text := ACustomerInfo.flat;
    FCustomerId := ACustomerInfo.Id;
    edPassportSerie.Text := ACustomerInfo.passport_num;
    edPassportReg.Text := ACustomerInfo.passport_reg;
    for I := 0 to ACustomerInfo.services.Count - 1 do
    begin
      serviceItem := TmwCustomServices.Create;
      serviceItem.service_id := -ACustomerInfo.services[I].service_id;
      serviceItem.name := ACustomerInfo.services[I].name;
      serviceItem.tarif := ACustomerInfo.services[I].tarif;
      FServiceList.Add(serviceItem);
    end;
    curParentId := -1;
    ACustomerInfo.equipment.Sort;
    for I := 0 to ACustomerInfo.equipment.Count - 1 do
    begin
      if ACustomerInfo.equipment[I].parent_id <> curParentId then
      begin
        equipmentItem := TmwEquipmentItemEx.Create;
        equipmentItem.Id := -ACustomerInfo.equipment[I].parent_id;
        equipmentItem.name := ACustomerInfo.equipment[I].parent_name;
        equipmentItem.parent_id := -1;
        curParentId := ACustomerInfo.equipment[I].parent_id;
        FEquipmentList.Add(equipmentItem);
      end;
      equipmentItem := TmwEquipmentItemEx.Create;
      equipmentItem.Id := -ACustomerInfo.equipment[I].Id;
      equipmentItem.e_type := ACustomerInfo.equipment[I].e_type;
      equipmentItem.name := ACustomerInfo.equipment[I].name;
      equipmentItem.mac := ACustomerInfo.equipment[I].mac;
      equipmentItem.parent_id := ACustomerInfo.equipment[I].parent_id;
      equipmentItem.parent_name := ACustomerInfo.equipment[I].parent_name;
      equipmentItem.port := ACustomerInfo.equipment[I].port;
      equipmentItem.ip := ACustomerInfo.equipment[I].ip;
      FEquipmentList.Add(equipmentItem);
    end;
    // FEquipmentList.Sort;
    for I := 0 to ACustomerInfo.discount.Count - 1 do
    begin
      discountItem := TmwCustomerDiscountItem.Create;
      discountItem.Id := -1;
      discountItem.srv_id := ACustomerInfo.discount[I].Id.ToString;
      discountItem.name := ACustomerInfo.discount[I].name;
      discountItem.date_from := ACustomerInfo.discount[I].date_from;
      discountItem.date_to := ACustomerInfo.discount[I].date_to;
      FDiscountList.Add(discountItem);
    end;
  end;
end;

procedure TmwFormNewAbonent.ChangePage(const NextId: Integer);
begin
  pcAbonent.PageIndex := NextId;
  lbPageTitle.Text := pcAbonent.ActivePage.Title;
end;

end.
