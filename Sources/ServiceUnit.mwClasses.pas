unit ServiceUnit.mwClasses;

interface

uses XSuperObject, JsonableObject, Generics.Collections, Generics.Defaults;

type
  TmwUserRights = class(TJsonableObject)
    AbAdd: Boolean;
    AbEdit: Boolean;
    AbAddSrv: Boolean;
  end;

  TmwStreetHouseItem = class(TJsonableObject)
  public
    id: integer;
    name: string;
  end;

  TmwEquipmentItem = class(TJsonableObject)
    id: integer;
    e_type: integer;
    name: string;
    notice: string;
  end;

  TmwEquipmentItemEx = class(TJsonableObject)
    id: integer;
    e_type: string;
    name: string;
    mac: string;
    parent_id: integer;
    parent_name: string;
    port: string;
    //
    ip: string;
    notice: string;
  end;

  TmwCircuitItem = class(TJsonableObject)
    id: integer;
    name: string;
    notice: string;
  end;

  TmwHouseInfoItem = class(TJsonableObject)
  public
    id: integer;
    name: string;
    chair: string;
    chair_phone: string;
    bid_count: integer;
    lat: single;
    lon: single;
    equipment: TObjectList<TmwEquipmentItem>;
    circuit: TObjectList<TmwCircuitItem>;
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromJSON(X: ISuperObject); override;
  end;

  TmwPromoItem = class(TJsonableObject)
    title: string;
    body: string;
    url: string;
  end;

  TmwContactItem = class(TJsonableObject)
    name: string;
    phone: string;
  end;

  TmwBookMarkItem = class(TJsonableObject)
    id: integer;
    name: string;
    form: string;
  end;

  TmwBidListItem = class(TJsonableObject)
    id: integer;
    plan_str: string;
    plan_date: integer;
    color: string;
    type_name: string;
    adress: string;
    content: string;
    whose: integer;
    lat: double;
    lon: double;
  end;

  TmwCustomerServiceItem = class(TJsonableObject)
    service_id: integer;
    name: string;
    tarif: string;
  end;

  TmwCustomerDiscountItem = class(TJsonableObject)
    id: integer;
    srv_id: string;
    /// !!!
    name: string;
    date_from: string;
    date_to: string;
    value: string;
    //
    notice: string;
    procedure LoadFromJSON(X: ISuperObject); override;
  end;

  TmwBidInfoItem = class(TJsonableObject)
    id: integer;
    plan_str: string;
    plan_date: integer;
    color: string;
    type_name: string;
    adress: string;
    content: string;
    whose: integer;
    house_id: integer;
    phones: string;
    customer_id: integer;
    balance: string;
    account: string;
    fio: string;
    services: TObjectList<TmwCustomerServiceItem>;
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromJSON(X: ISuperObject); override;
  end;

  TmwHouseCustomersItem = class(TJsonableObject)
  public
    id: integer;
    fio: string;
    balance: string;
    flat: string;
    porch: string;
    floor: string;
    info: string;
    color: String;
    connected: integer;
  end;

  TmwCustomerItem = class(TJsonableObject)
  public
    id: integer;
    balance: string;
    account: string;
    surname: string;
    firstname: string;
    midlename: string;
    street: string;
    house: string;
    house_id: integer;
    flat: string;
    phones: string;
    passport_num: string;
    passport_reg: string;
    color: string;
    notice: string;
    services: TObjectList<TmwCustomerServiceItem>;
    equipment: TObjectList<TmwEquipmentItemEx>;
    discount: TObjectList<TmwCustomerDiscountItem>;
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromJSON(X: ISuperObject); override;
  end;

  TmwStoreService = class(TJsonableObject)
    service_id: integer;
    name: string;
    price: string;
    onList_id: integer;
    onList_name: string;
    date: TDateTime;
    notice: string;
  end;

  TmwStoreEquipment = class(TJsonableObject)
    equipment_id: integer;
    name: string;
    ip: string;
    mac: string;
    port: integer;
    notice: string;
  end;

  TmwStoreDiscount = class(TJsonableObject)
    name: string;
    from_date: TDateTime;
    to_date: TDateTime;
    discount_id: integer;
    sum: single;
    notice: string;
  end;

  TmwNewCustomer = class(TJsonableObject)
    customer_id: integer;
    house_id: integer;
    flat: string;
    secondname: string;
    name: string;
    thirdname: string;
    passport_num: string;
    passport_reg: string;
    desc: string;
    new_services: TObjectList<TmwStoreService>;
    new_equipments: TObjectList<TmwStoreEquipment>;
    new_discounts: TObjectList<TmwStoreDiscount>;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TmwEquipmentAttr = class(TJsonableObject)
    name: string;
  end;

  TmwEquipmentPorts = class(TJsonableObject)
    id: integer;
    name: string;
    port: string;
    ip: string;
    e_type: integer;
    on_srv: integer;
  end;

  TmwEquipmentInfoItem = class(TJsonableObject)
    id: integer;
    name: string;
    place: string;
    house_id: integer;
    ip: string;
    mac: string;
    // [alias('type')]
    e_type: integer;
    notice: string;
    parent_id: integer;
    parent_aderss: string;
    parent_name: string;
    parent_ip: string;
    parent_port: string;
    parent_type: integer;
    attributes: TObjectList<TmwEquipmentAttr>;
    ports: TObjectList<TmwEquipmentPorts>;
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromJSON(X: ISuperObject); override;
  end;

  TmwLocalBidPhotoItem = class(TJsonableObject)
    data: string;
    constructor Create; overload;
    constructor Create(aData: string); overload;
  end;

  TmwLocalBidMaterials = class(TJsonableObject)
    ids: string;
    counts: string;
    whids: string;
  end;

  TmwLocalBidWorks = class(TJsonableObject)
    ids: string;
    counts: string;
  end;

  TmwLocalBid = class(TJsonableObject)
    status: string;
    id: integer;
    result: integer;
    resultText: string;
    unix_dt: integer;
    photos: TObjectList<TmwLocalBidPhotoItem>;
    materials: TmwLocalBidMaterials;
    works: TmwLocalBidWorks;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TmwMaterialItem = class(TJsonableObject)
    id: integer;
    name: string;
    rest: string;
    int: integer;
    wh_id: integer;
  end;

  TmwWorkItem = class(TJsonableObject)
    id: integer;
    name: string;
    rest: string;
    int: integer;
  end;

  TmwCustomServicesOnlist = class(TJsonableObject)
    on_id: integer;
    name: string;
  end;

  TmwCustomServices = class(TJsonableObject)
    service_id: integer;
    name: string;
    tarif: string;
    date: TDateTime;
    onlist: TObjectList<TmwCustomServicesOnlist>;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TmwDiscountItem = class(TJsonableObject)
    id: integer;
    name: string;
  end;

  TmwLinkTo = class(TJsonableObject)
    id: integer;
    name: string;
  end;

  TmwMapMarker = class(TJsonableObject)
    lat: double;
    lon: double;
    title: string;
    hint: string;
    icon: string;
  end;

implementation

uses System.SysUtils, System.StrUtils;

{ TmwHouseInfoItem }

constructor TmwHouseInfoItem.Create;
begin
  inherited;
  equipment := TObjectList<TmwEquipmentItem>.Create(true);
  circuit := TObjectList<TmwCircuitItem>.Create(true);
end;

destructor TmwHouseInfoItem.Destroy;
begin
  FreeAndNil(equipment);
  FreeAndNil(circuit);
  inherited;
end;

procedure TmwHouseInfoItem.LoadFromJSON(X: ISuperObject);
var
  i: integer;
  ei: TmwEquipmentItem;
  ci: TmwCircuitItem;
begin
  id := X['id'].AsInteger;
  name := X['name'].AsString;
  chair := X['chair'].AsString;
  chair_phone := X['chair_phone'].AsString;
  bid_count := X['bid_count'].AsInteger;
  lat := X['lat'].AsFloat;
  lon := X['lon'].AsFloat;
  equipment.Clear;
  for i := 0 to X['equipment'].AsArray.Length - 1 do
  begin
    ei := TmwEquipmentItem.Create();
    ei.LoadFromJSON(X['equipment'].AsArray.O[i]);
    equipment.add(ei);
  end;
  circuit.Clear;
  for i := 0 to X['circuit'].AsArray.Length - 1 do
  begin
    ci := TmwCircuitItem.Create();
    ci.LoadFromJSON(X['circuit'].AsArray.O[i]);
    circuit.add(ci);
  end;
end;

{ TmwBidInfoItem }

constructor TmwBidInfoItem.Create;
begin
  inherited;
  whose := -2;
  services := TObjectList<TmwCustomerServiceItem>.Create(true);
end;

destructor TmwBidInfoItem.Destroy;
begin
  FreeAndNil(services);
  inherited;
end;

procedure TmwBidInfoItem.LoadFromJSON(X: ISuperObject);
var
  i: integer;
  srv: TmwCustomerServiceItem;
begin
  id := X['id'].AsInteger;
  plan_str := X['plan_str'].AsString;
  plan_date := X['id'].AsInteger;
  color := X['color'].AsString;
  type_name := X['type_name'].AsString;
  adress := X['adress'].AsString;
  content := X['content'].AsString;
  whose := X['whose'].AsInteger;
  house_id := X['house_id'].AsInteger;
  phones := X['phones'].AsString;
  customer_id := X['customer_id'].AsInteger;
  balance := X['balance'].AsString;
  account := X['account'].AsString;
  fio := X['fio'].AsString;
  services.Clear;
  for i := 0 to X['services'].AsArray.Length - 1 do
  begin
    srv := TmwCustomerServiceItem.Create();
    srv.LoadFromJSON(X['services'].AsArray.O[i]);
    services.add(srv);
  end;
end;

{ TmwCustomerItem }

constructor TmwCustomerItem.Create;
begin
  inherited;
  services := TObjectList<TmwCustomerServiceItem>.Create(true);
  equipment := TObjectList<TmwEquipmentItemEx>.Create(TComparer<TmwEquipmentItemEx>.Construct(
    function(const L, R: TmwEquipmentItemEx): integer
    begin
      result := L.parent_id - R.parent_id;
      if result = 0 then
        result := TComparer<string>.Default.Compare(L.name, R.name);
    end), true);
  discount := TObjectList<TmwCustomerDiscountItem>.Create(true);
end;

destructor TmwCustomerItem.Destroy;
begin
  FreeAndNil(services);
  FreeAndNil(equipment);
  FreeAndNil(discount);
  inherited;
end;

// discount srv_id class typecast
procedure TmwCustomerItem.LoadFromJSON(X: ISuperObject);
var
  i: integer;
  srv: TmwCustomerServiceItem;
  eq: TmwEquipmentItemEx;
  ds: TmwCustomerDiscountItem;
begin
  id := X['id'].AsInteger;
  balance := X['balance'].AsString;
  account := X['account'].AsString;
  surname := X['surname'].AsString;
  firstname := X['firstname'].AsString;
  midlename := X['midlename'].AsString;
  street := X['street'].AsString;
  house := X['house'].AsString;
  house_id := X['house_id'].AsInteger;
  flat := X['flat'].AsString;
  phones := X['phones'].AsString;
  passport_num := X['passport_num'].AsString;
  passport_reg := X['passport_reg'].AsString;
  color := X['color'].AsString;
  notice := X['notice'].AsString;
  for i := 0 to X['services'].AsArray.Length - 1 do
  begin
    srv := TmwCustomerServiceItem.Create();
    srv.LoadFromJSON(X['services'].AsArray.O[i]);
    services.add(srv);
  end;
  for i := 0 to X['equipment'].AsArray.Length - 1 do
  begin
    eq := TmwEquipmentItemEx.Create();
    eq.LoadFromJSON(X['equipment'].AsArray.O[i]);
    equipment.add(eq);
  end;
  for i := 0 to X['discount'].AsArray.Length - 1 do
  begin
    ds := TmwCustomerDiscountItem.Create();
    ds.LoadFromJSON(X['discount'].AsArray.O[i]);
    discount.add(ds);
  end;
end;

{ TmwLocalBidPhotoItem }
constructor TmwLocalBidPhotoItem.Create;
begin
  inherited Create;
end;

constructor TmwLocalBidPhotoItem.Create(aData: string);
begin
  inherited Create;
  data := aData;
end;

{ TmwEquipmentInfoItem }

constructor TmwEquipmentInfoItem.Create;
begin
  inherited;
  attributes := TObjectList<TmwEquipmentAttr>.Create(true);
  ports := TObjectList<TmwEquipmentPorts>.Create(true);
end;

destructor TmwEquipmentInfoItem.Destroy;
begin
  attributes.Free;
  ports.Free;
  inherited;
end;

procedure TmwEquipmentInfoItem.LoadFromJSON(X: ISuperObject);
var
  i: integer;
  ea: TmwEquipmentAttr;
  ep: TmwEquipmentPorts;
begin
  id := X['id'].AsInteger;
  name := X['name'].AsString;
  place := X['place'].AsString;
  house_id := X['house_id'].AsInteger;
  ip := X['ip'].AsString;
  mac := X['mac'].AsString;
  e_type := X['e_type'].AsInteger;
  notice := X['notice'].AsString;
  parent_id := X['parent_id'].AsInteger;
  parent_aderss := X['parent_aderss'].AsString;
  parent_name := X['parent_name'].AsString;
  parent_ip := X['parent_ip'].AsString;
  parent_port := X['parent_port'].AsString;
  parent_type := X['parent_type'].AsInteger;
  attributes.Clear;
  for i := 0 to X['attributes'].AsArray.Length - 1 do
  begin
    ea := TmwEquipmentAttr.Create();
    ea.LoadFromJSON(X['attributes'].AsArray.O[i]);
    attributes.add(ea);
  end;
  ports.Clear;
  for i := 0 to X['ports'].AsArray.Length - 1 do
  begin
    ep := TmwEquipmentPorts.Create();
    ep.LoadFromJSON(X['ports'].AsArray.O[i]);
    ports.add(ep);
  end;
end;

{ TmwLocalBid }

constructor TmwLocalBid.Create;
begin
  inherited;
  photos := TObjectList<TmwLocalBidPhotoItem>.Create(true)
end;

destructor TmwLocalBid.Destroy;
begin
  photos.Free;
  inherited;
end;

{ TmwCustomServices }

constructor TmwCustomServices.Create;
begin
  inherited;
  onlist := TObjectList<TmwCustomServicesOnlist>.Create(true);
end;

destructor TmwCustomServices.Destroy;
begin
  FreeAndNil(onlist);
  inherited;
end;

{ TmwNewCustomer }

constructor TmwNewCustomer.Create;
begin
  inherited;
  new_services := TObjectList<TmwStoreService>.Create(true);
  new_equipments := TObjectList<TmwStoreEquipment>.Create(true);
  new_discounts := TObjectList<TmwStoreDiscount>.Create(true);
end;

destructor TmwNewCustomer.Destroy;
begin
  new_services.Free;
  new_equipments.Free;
  new_discounts.Free;
  inherited;
end;

{ TmwCustomerDiscountItem }
// srv_id class typecast

procedure TmwCustomerDiscountItem.LoadFromJSON(X: ISuperObject);
begin
  id := X['id'].AsInteger;
  srv_id := X['srv_id'].AsString;
  name := X['name'].AsString;
  date_from := X['date_from'].AsString;
  date_to := X['date_to'].AsString;
  value := X['value'].AsString;
end;

end.
