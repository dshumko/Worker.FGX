unit ServiceUnit.API;

interface

uses
  System.Classes,
  UVKCommonApi,
  ServiceUnit.mwClasses;

type
  TmwAPI = class(TVKCommonApi)
  private
    FCompany: string;
    FPassword: string;
    FLogin: string;
    FValidURLDate: TDate;
    procedure SetCompany(const Value: string);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetValidURLDate(const Value: TDate);
  public
    class function isOK(const aData: string): boolean; static;
    function MakeUri(): string; override;
    procedure GetErrFromJson; override;
    procedure Method(AMethod: string);
    function UserAuth(ALogin, APass: string): string;
    procedure SaveToken(const aDeviceID, aDeviceToken: string);
    procedure StreetList;
    procedure HousesList(const Id: Integer);
    procedure HouseInfo(const Id: Integer);
    procedure PromoList;
    procedure ContactList;
    procedure BidList(const aStreetID, aHouseID: Integer);
    procedure GetBidInfo(const Id: Integer);
    procedure HouseCustomers(const Id: Integer);
    procedure CustomerInfo(const Id: Integer);
    procedure GetEquipmentInfo(const Id, aType: Integer);
    function ActionEquipment(const Id, aType: Integer; const act:string = 'ping'; const format:string = ''): string;
    procedure RefuseBid(const Id: Integer);
    procedure TakeBid(const Id: Integer);
    procedure JoinBid(const Id: Integer);
    procedure GetMaterials;
    procedure GetWorks;
    procedure GetCustomerServices(const Id: Integer);
    procedure GetDiscountList(const Id: Integer);
    procedure GetLinkTo(const aHouseID: Integer);
    procedure SetLocation(const aLat, aLon: Double);
    procedure newCustomer(const aNewCustomer: TmwNewCustomer);
    procedure closeBid(const aID: Integer);
    function RequestEx(const ARequestType: string; AResStream: TStream = nil; newUrl: string = ''): string;
    procedure RecheckBaseUrl;
    constructor Create; override;
    property Company: string read FCompany write SetCompany;
    property Login: string read FLogin write SetLogin;
    property Password: string read FPassword write SetPassword;
    property ValidURLDate: TDate read FValidURLDate write SetValidURLDate;
    // !!!!!!!!!!!!!!!!!!!
    function Request(const ARequestType: string; AResStream: TStream = nil): string;
  end;

var
  _API: TmwAPI;

implementation

uses
  System.Net.UrlClient, Fgx.Log,
  System.Net.HttpClient, System.NetEncoding,
  System.Hash, System.Sysutils, System.StrUtils,
  ServiceUnit.Utils;

const
  A4onApiKey: string = 'QTRPTi5UVi1CaWxsaW5nIEVQRw';
  A4onApiURL: string = '';
  GetCompanyUrl: string = 'https://api.a4on.net/worker/';

function TmwAPI.ActionEquipment(const Id, aType: Integer; const act:string = 'ping'; const format:string = ''): string;
begin
  Method('actionEqipment');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  URIparams.AddPair('type', IntToStr(aType));
  URIparams.AddPair('act', act);
  if not format.IsEmpty then
    URIparams.AddPair('format', format);
  Result := Request(sHTTPMethodGet);
end;

procedure TmwAPI.BidList(const aStreetID, aHouseID: Integer);
begin
  Method('getBidList');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('street', IntToStr(aStreetID));
  URIparams.AddPair('house', IntToStr(aHouseID));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.closeBid(const aID: Integer);
var
  LSource: TStringList;
begin
  Method('closeBid');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(aID));
  // remove BOM
  LSource := TStringList.Create;
  try
    LSource.LoadFromFile(generateBid(aID), TEncoding.UTF8);
    PostData.WriteString(LSource.Text);
    Request(sHTTPMethodPost);
  finally
    LSource.Free;
  end;
end;

procedure TmwAPI.ContactList;
begin
  Method('contactsList');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  Request(sHTTPMethodGet);
end;

constructor TmwAPI.Create;
begin
  inherited;
  BaseURL := A4onApiURL;
  SetLength(FHeaders, 1);
  FHeaders[0].Name := 'Connection';
  FHeaders[0].Value := 'close';
end;

procedure TmwAPI.CustomerInfo(const Id: Integer);
begin
  Method('getCustomerInfo');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetBidInfo(const Id: Integer);
begin
  Method('getBid');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetCustomerServices(const Id: Integer);
begin
  Method('getCustomerServices');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetDiscountList(const Id: Integer);
begin
  Method('getDiscountList');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetEquipmentInfo(const Id, aType: Integer);
begin
  Method('getEqipmentInfo');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  URIparams.AddPair('type', IntToStr(aType));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetErrFromJson;
begin
  Err.Status := ResultJson[sSTATUS].AsString;
  if Err.Status <> sOK then
  begin
    Err.Code := 1;
    Err.Msg := ResultJson[sTEXT].AsString;
  end;
end;

procedure TmwAPI.GetLinkTo(const aHouseID: Integer);
begin
  Method('getLinkTo');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(aHouseID));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetMaterials;
begin
  Method('getMaterials');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.GetWorks;
begin
  Method('getWorks');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.HouseCustomers(const Id: Integer);
begin
  Method('getHouseCustomers');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.HouseInfo(const Id: Integer);
begin
  Method('getHouseInfo');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.HousesList(const Id: Integer);
begin
  Method('getHouses');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

class function TmwAPI.isOK(const aData: string): boolean;
begin
  Result := aData.Contains('"status":"OK"');
end;

procedure TmwAPI.JoinBid(const Id: Integer);
begin
  Method('joinBid');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.RecheckBaseUrl;
var
  Res: string;
  vURL: string;
  aResp: TStringStream;
begin
  vURL := GetCompanyUrl + TNetEncoding.URL.Encode(FCompany); // TURI.URLEncode
  // Self.BaseURL := vURL;
  // Exit;
  // Result := msgErr;
  aResp := TStringStream.Create('', TEncoding.UTF8);
  Res := RequestEx(sHTTPMethodGet, aResp, vURL);
  TFgLog.Debug('Res ' + Res);
  if Res.IsEmpty then
    Self.BaseURL := A4onApiURL
  else
  begin
    Self.BaseURL := Res;
    Self.ValidURLDate := Now();
    _API.ValidURLDate := Now();
  end;
  _API.BaseURL := Self.BaseURL;
  TFgLog.Debug(Self.BaseURL);
end;

procedure TmwAPI.RefuseBid(const Id: Integer);
begin
  Method('refuseBid');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

function TmwAPI.MakeUri: string;
begin
  Result := inherited MakeUri;
end;

procedure TmwAPI.Method(AMethod: string);
begin
  URIparams.AddPair(sMethod, AMethod);
end;

procedure TmwAPI.newCustomer(const aNewCustomer: TmwNewCustomer);
begin
  Method('newCustomer');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  PostData.WriteString(aNewCustomer.AsString);
  Request(sHTTPMethodPost);
end;

procedure TmwAPI.PromoList;
begin
  Method('getPromo');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  Request(sHTTPMethodGet);
end;

function TmwAPI.Request(const ARequestType: string; AResStream: TStream): string;
var
  AUrl: string;
begin
  AUrl := Self.BaseURL;
  try
    Result := inherited Request(ARequestType, AResStream);
  finally
    Self.BaseURL := AUrl;
  end;
end;

function TmwAPI.RequestEx(const ARequestType: string; AResStream: TStream = nil; newUrl: string = ''): string;
var
  cacheUrl: string;
begin
  cacheUrl := Self.BaseURL;
  try
    Self.BaseURL := newUrl;
    Result := Request(ARequestType, AResStream);
  finally
    Self.BaseURL := cacheUrl;
  end;
end;

procedure TmwAPI.SaveToken(const aDeviceID, aDeviceToken: string);
begin
  Method('SaveToken');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('device_id', aDeviceID);
  URIparams.AddPair('device_token', aDeviceToken);
  URIparams.AddPair('platform',
{$IFDEF ANDROID} 'ANDROID'{$ELSEIF defined(IOS)} 'IOS'{$ENDIF}
    );
  Request(sHTTPMethodGet);
end;

function TmwAPI.UserAuth(ALogin, APass: string): string;
begin
  Method('userAuth');
  URIparams.AddPair('login', ALogin);
  URIparams.AddPair('paswd', APass);
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.SetCompany(const Value: string);
begin
  FCompany := Value;
end;

procedure TmwAPI.SetLocation(const aLat, aLon: Double);
begin
  Method('setLocation');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('lat', Format('%15.12f', [aLat]));
  URIparams.AddPair('lon', Format('%15.12f', [aLon]));
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TmwAPI.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TmwAPI.SetValidURLDate(const Value: TDate);
begin
  FValidURLDate := Value;
end;

procedure TmwAPI.StreetList;
begin
  Method('getStreets');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  Request(sHTTPMethodGet);
end;

procedure TmwAPI.TakeBid(const Id: Integer);
begin
  Method('takeBid');
  URIparams.AddPair('login', FLogin);
  URIparams.AddPair('paswd', FPassword);
  URIparams.AddPair('id', IntToStr(Id));
  Request(sHTTPMethodGet);
end;

initialization

_API := TmwAPI.Create;

finalization

FreeAndNil(_API);

end.
