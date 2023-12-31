{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2021 Embarcadero Technologies, Inc. }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FGX.iOS.Sensors;

interface

uses
  FGX.Sensors,FGX.Helpers.iOS;

type
  TPlatformSensorManager = class(TSensorManager)
  protected
    class function GetSensorManager: TSensorManager; override;
  end;

  TPlatformGeocoder = class(TGeocoder)
  protected
    class function GetGeocoderImplementer: TGeocoderClass; override;
  end;

  TPlatformGpsStatus = class(TGpsStatus)
  protected
    class function GetGpsStatusImplementer: TGpsStatusClass; override;
  end;

implementation

uses
  System.SysUtils, System.Math, System.Generics.Collections, System.RTLConsts, System.Classes, System.TypInfo, iOS.api.Foundation,iOS.api.CoreLocation,iOS.api.CoreMotion, iOS.api.UIKit, iOS.api.Helpers,MacApi.ObjectiveC;

function ConvCLLocationCoord(const Value: CLLocationCoordinate2D): TLocationCoord2D;
begin
  Result := TLocationCoord2D.Create(Value.latitude, Value.longitude);
end;

function ConvCLLocation(const Value: CLLocation): TLocationCoord2D;
begin
  if Value <> nil then
    Result := ConvCLLocationCoord(Value.coordinate)
  else
    Result := TLocationCoord2D.Create(0, 0);
end;

// Note:
//   Because method definition of CLRegion.initCircularRegionWithCenter is incorrect.
// identifier parameter have to use Pointer, not NSString.
// For Tokyo update, we can't chagne the inteface, then we add the following code.


const
  libobjc = '/usr/lib/libobjc.dylib';

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}

function objc_msgSend(theReceiver: Pointer; theSelector: Pointer): Pointer; cdecl; overload;
  external libobjc name _PU + 'objc_msgSend';
function objc_msgSendPD3(theReceiver: Pointer; theSelector: Pointer; center: CLLocationCoordinate2D; radius: CLLocationDistance; identifier: Pointer): Pointer; cdecl;
  external libobjc name _PU + 'objc_msgSend';
function objc_getClass(const name: MarshaledAString): Pointer; cdecl;
  external libobjc name _PU + 'objc_getClass';
function sel_getUid(const str: MarshaledAString): Pointer; cdecl; external libobjc name _PU + 'sel_getUid';

function ConvLocationRegion(const Region: TLocationRegion): CLRegion;
var
  Center: CLLocationCoordinate2D;
  UniqueID: NSString;
  CLRegionPtr: Pointer;
begin
  Center := CLLocationCoordinate2DMake(Region.Center.Latitude, Region.Center.Longitude);
  UniqueID := TNSString.Wrap(TNSString.OCClass.stringWithUTF8String(MarshaledAString(UTF8Encode(Region.ID))));

  // create the region object and add it for monitorization
  CLRegionPtr := objc_msgSend(objc_getClass('CLRegion'), sel_getUid('alloc'));
  Result := TCLRegion.Wrap(
    objc_msgSendPD3(CLRegionPtr, sel_getUid('initCircularRegionWithCenter:radius:identifier:'),
      Center, Region.Radius,NSObjectToID(UniqueID)) );
end;

function ConvCLRegion(const Region: CLRegion): TLocationRegion;
begin
  Result := TLocationRegion.Create(ConvCLLocationCoord(Region.center), Region.radius, NSStrToStr(Region.identifier));
end;

type
{$M+}

{ Location Sensor }

  // Notification about changed sensor's data
  TOnStateChanged = procedure (const ANewState: TSensorState) of object;
  TOnLocationChanged = procedure (const AOldLocation, ANewLocation: TLocationCoord2D) of object;
  TOnDidEnterRegion = procedure (const ADidEnterRegion: TLocationRegion) of object;
  TOnDidExitRegion = procedure (const didExitRegion: TLocationRegion) of object;
  TOnHeadingChanged = procedure (const ANewHeading: CLHeading) of object;
  TOnCLLocationChanged = procedure (const ACLLocation: CLLocation ) of object;
  TOnLocationUpdatesPausedChanged = procedure (const Paused: Boolean) of object;

  /// <summary>
  ///   Implementation of iOS Delegate for receive data from location sensor
  /// </summary>
  CLLocationManagerDelegate = interface(IObjectiveC)
    ['{A1481CE0-8EE2-497A-9132-5309F0DCCA90}']
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); overload; cdecl;
    [MethodName('locationManager:didUpdateLocations:')]
    procedure locationManagerDidUpdateLocations(manager: CLLocationManager; locations: NSArray); cdecl;
    function locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean; cdecl;
    [MethodName('locationManager:didDetermineState:forRegion:')]
    procedure locationManagerDidDetermineStateForRegion(manager: CLLocationManager; state: CLRegionState; region: CLRegion); cdecl;
    [MethodName('locationManager:didRangeBeacons:inRegion:')]
    procedure locationManagerDidRangeBeaconsInRegion(manager: CLLocationManager; beacons: NSArray; region: CLBeaconRegion); cdecl;
    [MethodName('locationManager:rangingBeaconsDidFailForRegion:withError:')]
    procedure locationManagerRangingBeaconsDidFailForRegionWithError(manager: CLLocationManager; region: CLBeaconRegion; error: NSError); cdecl;
    [MethodName('locationManager:didEnterRegion:')]
    procedure locationManagerDidEnterRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didExitRegion:')]
    procedure locationManagerDidExitRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didStartMonitoringForRegion:')]
    procedure locationManagerDidStartMonitoringForRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    procedure locationManagerDidPauseLocationUpdates(manager: CLLocationManager); cdecl;
    procedure locationManagerDidResumeLocationUpdates(manager: CLLocationManager); cdecl;
    [MethodName('locationManager:didFinishDeferredUpdatesWithError:')]
    procedure locationManagerDidFinishDeferredUpdatesWithError(manager: CLLocationManager; error: NSError); cdecl;
  end;

  TiOSLocationDelegate = class(TOCLocal, CLLocationManagerDelegate)
  strict private
    FPreviousLocation: TLocationCoord2D;
    FOnStateChanged: TOnStateChanged;
    FOnLocationChanged: TOnLocationChanged;
    FOnDidEnterRegion: TOnDidEnterRegion;
    FOnDidExitRegion: TOnDidExitRegion;
    FOnHeadingChanged: TOnHeadingChanged;
    FOnCLLocationChanged : TOnCLLocationChanged;
    FOnLocationUpdatesPausedChanged: TOnLocationUpdatesPausedChanged;
    procedure DoStateChanged(const ANewState: TSensorState);
    procedure DoLocationChanged(const AOldLocation, ANewLocation: TLocationCoord2D);
    procedure DoDidEnterRegion(const ADidEnterRegion: TLocationRegion);
    procedure DoDidExitRegion(const ADidExitRegion: TLocationRegion);
    procedure DoHeadingChanged(const ANewHeading: CLHeading);
    procedure DoCLLocationChanged(const ACLLocation:CLLocation);
    procedure DoLocationUpdatesPausedChanged(const APaused: Boolean);
  public
    constructor Create;
    { CLLocationManagerDelegate }
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); overload; cdecl;
    [MethodName('locationManager:didEnterRegion:')]
    procedure locationManagerDidEnterRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didExitRegion:')]
    procedure locationManagerDidExitRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); overload; cdecl;
    function locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean; cdecl;
    [MethodName('locationManager:didUpdateLocations:')]
    procedure locationManagerDidUpdateLocations(manager: CLLocationManager; locations: NSArray); cdecl;
    [MethodName('locationManager:didDetermineState:forRegion:')]
    procedure locationManagerDidDetermineStateForRegion(manager: CLLocationManager; state: CLRegionState; region: CLRegion); cdecl;
    [MethodName('locationManager:didRangeBeacons:inRegion:')]
    procedure locationManagerDidRangeBeaconsInRegion(manager: CLLocationManager; beacons: NSArray; region: CLBeaconRegion); cdecl;
    [MethodName('locationManager:rangingBeaconsDidFailForRegion:withError:')]
    procedure locationManagerRangingBeaconsDidFailForRegionWithError(manager: CLLocationManager; region: CLBeaconRegion; error: NSError); cdecl;
    [MethodName('locationManager:didStartMonitoringForRegion:')]
    procedure locationManagerDidStartMonitoringForRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    procedure locationManagerDidPauseLocationUpdates(manager: CLLocationManager); cdecl;
    procedure locationManagerDidResumeLocationUpdates(manager: CLLocationManager); cdecl;
    [MethodName('locationManager:didFinishDeferredUpdatesWithError:')]
    procedure locationManagerDidFinishDeferredUpdatesWithError(manager: CLLocationManager; error: NSError); cdecl;
    property OnStateChanged: TOnStateChanged read FOnStateChanged write FOnStateChanged;
    property OnLocationChanged: TOnLocationChanged read FOnLocationChanged write FOnLocationChanged;
    property OnDidEnterRegion: TOnDidEnterRegion read FOnDidEnterRegion write FOnDidEnterRegion;
    property OnDidExitRegion: TOnDidExitRegion read FOnDidExitRegion write FOnDidExitRegion;
    property OniOSHeadingChanged: TOnHeadingChanged read FOnHeadingChanged write FOnHeadingChanged;
    property OnCLLocationChanged : TOnCLLocationChanged read FOnCLLocationChanged write FOnCLLocationChanged;
    property OnLocationUpdatesPausedChanged: TOnLocationUpdatesPausedChanged read FOnLocationUpdatesPausedChanged write FOnLocationUpdatesPausedChanged;
  end;

  IApplicationActiveNotifications = interface(NSObject)
    ['{BCEDAA3F-B9AB-4A77-B7BC-9457C3A304BD}']
    procedure willEnterForeground(notification: Pointer); cdecl;
    procedure didEnterBackground(notification: Pointer); cdecl;
  end;

  TApplicationActiveNotifier = class(TOCLocal)
  private
    FIsActive: Boolean;
    FOnChange: TNotifyEvent;
    procedure DoChange;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    { IApplicationActiveNotifications }
    procedure willEnterForeground(notification: Pointer); cdecl;
    procedure didEnterBackground(notification: Pointer); cdecl;
  public
    constructor Create;
    destructor Destroy; override;
    property IsActive: Boolean read FIsActive;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TiOSLocationSensor = class(TCustomLocationSensor)
  private const
                                                         
    CRegionAccuracy = 2; // 2 meters
    CActivityValues: array[TLocationActivityType] of CLActivityType = (
      CLActivityTypeOther, CLActivityTypeAutomotiveNavigation, CLActivityTypeFitness, CLActivityTypeOtherNavigation
    );
  private var
    FApplicationActiveNotifier: TApplicationActiveNotifier;
    FLocater: CLLocationManager;
    FLocationDelegate: TiOSLocationDelegate;
    FLocation: CLLocation;
    FHeading: CLHeading;
    FSensorState: TSensorState;
    FUsageAuthorization: TLocationUsageAuthorization;
    procedure DoApplicationActiveChanged(Sender: TObject);
    // when the app is relaunched, it puts the existing monitored regions into the
    // current regions list
    procedure GrabExistingRegions;
    procedure StartLocationUpdates;
    procedure UpdateUsageAuthorization;
  protected
    // determines if the device can monitor regions
    function CanMonitorRegions: Boolean;
    // determines if the device has heading support
    function CanUseHeading: Boolean;
    // determines if significant change notifications are supported
    function CanUseSignifChangeNotifs: Boolean;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    function GetLocationSensorType: TLocationSensorType; override;
    // the sensor doesn't support properties such as address, city, street name etc
    // because they can be easily obtain using the Geocoder class
    function GetAvailableProperties: TCustomLocationSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double; override;

    function GetAuthorized: TAuthorizationType; override;
    function GetAccuracy: TLocationAccuracy; override;
    function GetActivityType: TLocationActivityType; override;
    function GetDistance: TLocationDistance; override;
    function GetPowerConsumption: TPowerConsumption; override;
    function GetUsageAuthorization: TLocationUsageAuthorization; override;
    procedure SetAccuracy(const Value: TLocationAccuracy); override;
    procedure SetActivityType(const Value: TLocationActivityType); override;
    procedure SetDistance(const Value: TLocationDistance); override;
    procedure SetUsageAuthorization(const Value: TLocationUsageAuthorization); override;

    procedure DoLocationChangeType; override;
    procedure DoOptimize; override;
    procedure DoStateChanged(const ANewState: TSensorState);
    procedure DoiOSHeadingChanged(const ANewHeading: CLHeading);
    procedure DoCLLocationChanged(const ACLLocation : CLLocation);

    function DoStart: Boolean; override;
    procedure DoStop; override;

    procedure RegionAdded(const Item: TLocationRegion); override;
    procedure RegionRemoved(const Item: TLocationRegion); override;

    constructor Create(AManager: TSensorManager); override;
    function DoGetInterface(const IID: TGUID; out Obj): HResult; override;
  public
    destructor Destroy; override;
  end;

{ Motion Sensor }

  IMotionSensorDelegate = interface
    ['{D9DFC491-3BDA-4F45-864F-66D9358600A1}']
    function GetSensorCategory: TSensorCategory;
    function GetSensorType: TMotionSensorType;
    function GetAvailableProperties: TCustomMotionSensor.TProperties;
    function GetDoubleProperty(AProp: TCustomMotionSensor.TProperty): Double;
    procedure Start;
    procedure Stop;
  end;

  TAccelerometerDelegate = class(TInterfacedObject, IMotionSensorDelegate)
  private
    [weak] FNativeManager: CMMotionManager;
  public
    constructor Create(ANativeManager: CMMotionManager);
    function GetSensorCategory: TSensorCategory;
    function GetSensorType: TMotionSensorType;
    function GetAvailableProperties: TCustomMotionSensor.TProperties;
    function GetDoubleProperty(AProp: TCustomMotionSensor.TProperty): Double;
    procedure Start;
    procedure Stop;
  end;

  TDeviceMotionDelegate = class(TInterfacedObject, IMotionSensorDelegate)
  private
    [weak] FNativeManager: CMMotionManager;
  public
    constructor Create(ANativeManager: CMMotionManager);
    function GetSensorCategory: TSensorCategory;
    function GetSensorType: TMotionSensorType;
    function GetAvailableProperties: TCustomMotionSensor.TProperties;
    function GetDoubleProperty(AProp: TCustomMotionSensor.TProperty): Double;
    procedure Start;
    procedure Stop;
  end;

  // Represents any iOS motion sensor: accelerometer, device motion, magnetometer,
  // etc. Because the callbacks and data types for each sensor are different,
  // this class delegates retrieving those properties to an instance of IMotionSensorDelegate.
  // A specific delegate must be created for each sensor.
  TiOSMotionSensor = class(TCustomMotionSensor)
  private
    FIsDeviceMotionAvailable : Boolean;
    FSensorState: TSensorState;
    FSensorDelegate: IMotionSensorDelegate;
    FQueue: NSOperationQueue;
    FUpdateInterval : Double;
  protected
    function GetMotionSensorType: TMotionSensorType; override;
    function GetAvailableProperties: TCustomMotionSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomMotionSensor.TProperty): Double; override;
    function GetSensorCategory: TSensorCategory; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;

    function GetUpdateInterval: Double; override;
    procedure SetUpdateInterval(AInterval: Double); override;
    function DoStart: Boolean; override;
    procedure DoStop; override;

    // determines if the device supports providing motion events
    function Supported: Boolean; inline;

    constructor Create(AManager: TSensorManager; ADelegate: IMotionSensorDelegate); reintroduce;
    function DoGetInterface(const IID: TGUID; out Obj): HResult; override;
  public
    destructor Destroy; override;
    property IsDeviceMotionAvailable: Boolean read FIsDeviceMotionAvailable write FIsDeviceMotionAvailable;
  end;

{ Orientation Sensor: Gyroscope and Compass }

  TiOSCustomOrientationSensor = class (TCustomOrientationSensor)
  private
    FUpdateInterval: Double;
  protected
    function GetSensorCategory: TSensorCategory; override;
    function GetUpdateInterval: Double; override;
    procedure SetUpdateInterval(AInterval: Double); override;
  public
    constructor Create(AManager: TSensormanager); override;
  end;

  { Gyroscope Sensor }

  TiOSGyroscopeSensor = class (TiOSCustomOrientationSensor)
  strict private
    FNativeManager: CMMotionManager;
  protected
    function GetOrientationSensorType: TOrientationSensorType; override;
    function GetAvailableProperties: TCustomOrientationSensor.TProperties; override;
    function GetDoubleProperty(AProp: TCustomOrientationSensor.TProperty): Double; override;
    function GetTimeStamp: TDateTime; override;
    function GetState: TSensorState; override;
    function DoStart: Boolean; override;
    procedure DoStop; override;
    function DoGetInterface(const IID: TGUID; out Obj): HResult; override;
  public
    constructor Create(AManager: TSensorManager); override;
    destructor Destroy; override;
  end;

  { Compass Sensor }

  TiOSCompassSensor = class (TiOSCustomOrientationSensor)
  strict private
    FNativeManager: CLLocationManager;
    FDelegate: TiOSLocationDelegate;
    FHeading: CLHeading;
    FSensorState: TSensorState;
  private
    procedure DoStateChanged(const ANewState: TSensorState);
    procedure DoHeadingChanged(const ANewHeading: CLHeading);
  protected
    function GetOrientationSensorType: TOrientationSensorType; override;
    function GetAvailableProperties: TCustomOrientationSensor.TProperties; override;
    function GetDoubleProperty(AProp: TCustomOrientationSensor.TProperty): Double; override;
    function GetTimeStamp: TDateTime; override;
    function GetState: TSensorState; override;
    function DoStart: Boolean; override;
    procedure DoStop; override;
    function DoGetInterface(const IID: TGUID; out Obj): HResult; override;
  public
    constructor Create(AManager: TSensorManager); override;
    destructor Destroy; override;
  end;

{ Sensor Manager }

  TiOSSensorManager = class(TPlatformSensorManager)
  private
    FActive: Boolean;
    FMotionManager: CMMotionManager;
    FLocationManager: CLLocationManager;
    FCoreMotionHandle: HMODULE;
  protected
    function GetCanActivate: Boolean; override;
    function GetActive: Boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Activate; override;
    procedure Deactivate; override;
  end;

  TiOSGeocoder = class(TGeocoder)
  private class var
    FGeocoder: CLGeocoder;
  private
    // these handlers receive the forward and reverse geocoding results
    // and trigger the events
    class procedure GeocodeForwardHandler(placemark: NSArray;error: NSError);
    class procedure GeocodeReverseHandler(placemark: NSArray;error: NSError);
    class constructor Create;
    class destructor Destroy;
  protected
    class function GetGeocoderImplementer: TGeocoderClass; override;

    class procedure GeocodeRequest(const Address: TCivicAddress); override;
    class procedure GeocodeReverseRequest(const Coords: TLocationCoord2D); override;
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class procedure Cancel; override;
  end;

  TiOSGpsStatus = class(TGpsStatus)
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class function Satellites(Index: Integer): TGpsSatellite; override;
    class function SatelliteCount: Integer; override;
    class function SatelliteFirstFixTime: Integer; override;
  end;

{ TPlatformSensorManager }

class function TPlatformSensorManager.GetSensorManager: TSensorManager;
begin
  Result := TiOSSensorManager.Create;
end;

{ TiOSSensorManager }

procedure TiOSSensorManager.Activate;
var
  LMotionSensor : TiOSMotionSensor;
begin
  if not Active then
  begin
    FActive := True;
    { Acelerometer }
    if FMotionManager.isAccelerometerAvailable then
    begin
      LMotionSensor := TiOSMotionSensor.Create(Self, TAccelerometerDelegate.Create(FMotionManager));
      LMotionSensor.IsDeviceMotionAvailable := True;
      AddSensor(LMotionSensor);
    end;
    { Motion }
    if FMotionManager.isDeviceMotionAvailable then
    begin
      LMotionSensor := TiOSMotionSensor.Create(Self, TDeviceMotionDelegate.Create(FMotionManager));
      LMotionSensor.IsDeviceMotionAvailable := FMotionManager.isDeviceMotionAvailable;
      AddSensor(LMotionSensor);
    end;
    { Gyroscope }
    if FMotionManager.isGyroAvailable then
      AddSensor(TiOSGyroscopeSensor.Create(Self));
    { Location }
    if FLocationManager.locationServicesEnabled then
      AddSensor(TiOSLocationSensor.Create(Self));
    { Compass (Heading) }
    if FLocationManager.headingAvailable then
      AddSensor(TiOSCompassSensor.Create(Self));
  end;
end;

constructor TiOSSensorManager.Create;
begin
  inherited;
  FCoreMotionHandle := LoadLibrary('/System/Library/Frameworks/CoreMotion.framework/CoreMotion');
  FMotionManager := TCMMotionManager.Create;
  FLocationManager := TCLLocationManager.Create;
end;

procedure TiOSSensorManager.Deactivate;
var
  I: Integer;
begin
  FActive := False;

  for I := Count - 1 downto 0 do
    RemoveSensor(Sensors[I]);
end;

destructor TiOSSensorManager.Destroy;
begin
  if FCoreMotionHandle <> 0 then
    FreeLibrary(FCoreMotionHandle);
  inherited;
end;

function TiOSSensorManager.GetActive: Boolean;
begin
  Result := FActive;
end;

function TiOSSensorManager.GetCanActivate: Boolean;
begin
                                                                       
  Result := True;
end;

{ TiOSLocationSensor }

function TiOSLocationSensor.CanMonitorRegions: Boolean;
begin
  Result := TCLLocationManager.OCClass.regionMonitoringAvailable and
            TCLLocationManager.OCClass.regionMonitoringEnabled;
end;

function TiOSLocationSensor.CanUseHeading: Boolean;
begin
  Result := [TProperty.TrueHeading, TProperty.MagneticHeading] * AvailableProperties <> [];
end;

function TiOSLocationSensor.CanUseSignifChangeNotifs: Boolean;
begin
  Result := TCLLocationManager.OCClass.significantLocationChangeMonitoringAvailable;
end;

constructor TiOSLocationSensor.Create(AManager: TSensorManager);
begin
  inherited Create(AManager);
  FLocationDelegate := TiOSLocationDelegate.Create;
  FLocationDelegate.OnStateChanged := DoStateChanged;
  FLocationDelegate.OnLocationChanged := DoLocationChanged;
  FLocationDelegate.OnDidEnterRegion := DoEnterRegion;
  FLocationDelegate.OnDidExitRegion := DoExitRegion;
  FLocationDelegate.OniOSHeadingChanged := DoiOSHeadingChanged;
  FLocationDelegate.OnCLLocationChanged := DoCLLocationChanged;
  FLocationDelegate.OnLocationUpdatesPausedChanged := DoLocationUpdatesPausedChanged;
  FLocater := TCLLocationManager.Create;
  FLocater.retain;
  FLocater.setDelegate(FLocationDelegate.GetObjectID);
  FApplicationActiveNotifier := TApplicationActiveNotifier.Create;
  FApplicationActiveNotifier.OnChange := DoApplicationActiveChanged;
  GrabExistingRegions;
end;

destructor TiOSLocationSensor.Destroy;
begin
  FApplicationActiveNotifier.Free;
  FLocater.setDelegate(nil);
  if FLocation <> nil then
    FLocation.release;
  FLocater.release;
  FLocationDelegate.Free;
  inherited;
end;

procedure TiOSLocationSensor.DoCLLocationChanged(const ACLLocation: CLLocation);
begin
  if FLocation <> nil then
    FLocation.release;
  FLocation := ACLLocation;
  FLocation.retain;
end;

function TiOSLocationSensor.DoGetInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOTIMPL;
  if FLocater <> nil then
    Result := FLocater.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FLocationDelegate <> nil) then
    Result := FLocationDelegate.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FLocation <> nil) then
    Result := FLocation.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FHeading <> nil) then
    Result := FHeading.QueryInterface(IID, Obj);
end;

procedure TiOSLocationSensor.DoiOSHeadingChanged(const ANewHeading: CLHeading);
var
  LHeading: THeading;
begin
  if ANewHeading <> nil then
  begin
    LHeading.Azimuth := ANewHeading.trueHeading;
    inherited DoHeadingChanged(LHeading);
  end;
  if FHeading <> nil then
    FHeading.release;
  FHeading := ANewHeading;
  FHeading.retain;
end;

procedure TiOSLocationSensor.DoLocationChangeType;
begin
  // do nothing; location change type values influence the way notifications
  // will be done the next time the sensor is started
end;

procedure TiOSLocationSensor.DoOptimize;
begin
  // do nothing; the location services on iOS are already optimized
  // by selecting the appropriate sensor (GPS, Wifi, cell towers) to determine
  // the best location
end;

function TiOSLocationSensor.DoStart: Boolean;
var
  I: Integer;
begin
  if TOSVersion.Check(9) and
  true //todo TiOSHelper.HasBackgroundMode('location')
  then
    FLocater.setAllowsBackgroundLocationUpdates(True);
  UpdateUsageAuthorization;
  // check authorization
  if Authorized = TAuthorizationType.atUnauthorized then
    SensorError(SLocationServiceUnauthorized);
  // check if location sensor is enabled
  if not FLocater.locationServicesEnabled then
    SensorError(SLocationServiceDisabled);

  // start location updates
  StartLocationUpdates;

  // start heading updates
  if CanUseHeading then
  begin
    FLocater.startUpdatingHeading;
  end;

  // start monitoring regions
  if CanMonitorRegions then
    for I := 0 to Regions.Count - 1 do
      FLocater.startMonitoringForRegion(ConvLocationRegion(Regions[I]));
  Result := FLocater.locationServicesEnabled;
  if Result then
    Result := Authorized = TAuthorizationType.atAuthorized;
end;

procedure TiOSLocationSensor.DoStateChanged(const ANewState: TSensorState);
begin
  FSensorState := ANewState;
  if (FUsageAuthorization = TLocationUsageAuthorization.Always) and
    (TCLLocationManager.OCClass.authorizationStatus = kCLAuthorizationStatusAuthorizedWhenInUse) then
    FUsageAuthorization := TLocationUsageAuthorization.WhenInUse;
  if FSensorState = TSensorState.AccessDenied then
    Stop;
  // If the sensor was already started and we just received a state change to Ready,
  // it means that we just received authorization, so restart the sensor.
  if (FSensorState = TSensorState.Ready) and Started then
    Start;
  StateChanged;
end;

procedure TiOSLocationSensor.DoStop;
var
  I: Integer;
begin
  // stop the location update
  if (LocationChange = TLocationChangeType.lctLarge) and CanUseSignifChangeNotifs then
    FLocater.stopMonitoringSignificantLocationChanges
  else
    FLocater.stopUpdatingLocation;

  // stop receiving heading updates
  FLocater.stopUpdatingHeading;

  // stop receiving region proximity updates
  if CanMonitorRegions then
    for I := 0 to Regions.Count - 1 do
      FLocater.stopMonitoringForRegion(ConvLocationRegion(Regions[I]));
end;

function TiOSLocationSensor.GetAccuracy: TLocationAccuracy;
begin
  Result := FLocater.desiredAccuracy
end;

function TiOSLocationSensor.GetAuthorized: TAuthorizationType;
begin
  case TCLLocationManager.OCClass.authorizationStatus of
    kCLAuthorizationStatusNotDetermined:
      Result := TAuthorizationType.atNotSpecified;
    kCLAuthorizationStatusDenied,
    kCLAuthorizationStatusRestricted:
      Result := TAuthorizationType.atUnauthorized;
    kCLAuthorizationStatusAuthorizedWhenInUse,
    kCLAuthorizationStatusAuthorized:
      Result := TAuthorizationType.atAuthorized;
  else // avoids compiler warnings
    Result := TAuthorizationType.atNotSpecified;
  end;  
end;

function TiOSLocationSensor.GetAvailableProperties: TCustomLocationSensor.TProperties;
begin
  Result := [];
  if (Authorized <> TAuthorizationType.atUnauthorized) and
      FLocater.locationServicesEnabled then
    Result := [TProperty.Latitude, TProperty.Longitude, TProperty.Altitude, TProperty.Speed];

  if FLocater.headingAvailable then
    Result := Result + [TProperty.TrueHeading, TProperty.MagneticHeading];
end;

function TiOSLocationSensor.GetDistance: TLocationDistance;
begin
  Result := FLocater.distanceFilter;
end;

function TiOSLocationSensor.GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double;
begin
  Result := NaN;
  case Prop of
    TProperty.Latitude:
      if FLocation <> nil then
        Result := FLocation.coordinate.latitude;
    TProperty.Longitude:
      if FLocation <> nil then
        Result := FLocation.coordinate.longitude;
    TProperty.Speed:
      if FLocation <> nil then
        Result := FLocation.speed;
    TProperty.Altitude:
      if FLocation <> nil then
        Result := FLocation.altitude;
                                                                                          
    TProperty.ErrorRadius:
      Result := 0;
    TProperty.TrueHeading:
      if FHeading <> nil then
        Result := FHeading.trueHeading;
    TProperty.MagneticHeading:
      if FHeading <> nil then
        Result := FHeading.magneticHeading;
  end;
end;

function TiOSLocationSensor.GetLocationSensorType: TLocationSensorType;
begin
  Result := TLocationSensorType.GPS;
end;

function TiOSLocationSensor.GetPowerConsumption: TPowerConsumption;
begin
  if LocationChange = TLocationChangeType.lctSmall then
    Result := TPowerConsumption.pcHigh
  else
    Result := TPowerConsumption.pcLow;
end;

function TiOSLocationSensor.GetState: TSensorState;
begin
  Result := FSensorState;
end;

function TiOSLocationSensor.GetTimeStamp: TDateTime;
begin
                                                      
  Result := 0;
end;

procedure TiOSLocationSensor.GrabExistingRegions;
var
  RegionArray: NSArray;
  Current: CLRegion;
  I: Integer;
begin
  if CanMonitorRegions and (FLocater.monitoredRegions.count > 0) then
  begin
    RegionArray := FLocater.monitoredRegions.allObjects;

    for I := 0 to RegionArray.count - 1 do
    begin
      Current := TCLRegion.Wrap(RegionArray.objectAtIndex(I));
      Regions.Add(ConvCLRegion(Current));
    end;
  end;
end;

procedure TiOSLocationSensor.RegionAdded(const Item: TLocationRegion);
begin
  if CanMonitorRegions and Started then
    FLocater.startMonitoringForRegion(ConvLocationRegion(Item), CRegionAccuracy)
end;

procedure TiOSLocationSensor.RegionRemoved(const Item: TLocationRegion);
begin
  if CanMonitorRegions and Started then
    FLocater.stopMonitoringForRegion(ConvLocationRegion(Item));
end;

procedure TiOSLocationSensor.SetAccuracy(const Value: TLocationAccuracy);
begin
  FLocater.setDesiredAccuracy(Value);
end;

procedure TiOSLocationSensor.SetDistance(const Value: TLocationDistance);
begin
  FLocater.setDistanceFilter(Value);
end;

procedure TiOSLocationSensor.DoApplicationActiveChanged(Sender: TObject);
begin
  if Started then
    StartLocationUpdates;
end;

function TiOSLocationSensor.GetActivityType: TLocationActivityType;
var
  LType: TLocationActivityType;
begin
  for LType := Low(TLocationActivityType) to High(TLocationActivityType) do
  begin
    if CActivityValues[LType] = FLocater.activityType then
      Exit(LType);
  end;
  Result := TLocationActivityType.Other;
end;

procedure TiOSLocationSensor.SetActivityType(const Value: TLocationActivityType);
begin
  FLocater.setActivityType(CActivityValues[Value]);
end;

function TiOSLocationSensor.GetUsageAuthorization: TLocationUsageAuthorization;
begin
  Result := FUsageAuthorization;
end;

procedure TiOSLocationSensor.SetUsageAuthorization(const Value: TLocationUsageAuthorization);
begin
  FUsageAuthorization := Value;
  if Started then
    UpdateUsageAuthorization;
end;

procedure TiOSLocationSensor.StartLocationUpdates;
begin
  FLocater.setPausesLocationUpdatesAutomatically(FApplicationActiveNotifier.IsActive);
  if CanUseSignifChangeNotifs and (not FApplicationActiveNotifier.IsActive or (LocationChange = TLocationChangeType.lctLarge)) then
    FLocater.startMonitoringSignificantLocationChanges
  else
    FLocater.startUpdatingLocation;
end;

procedure TiOSLocationSensor.UpdateUsageAuthorization;
begin
  if TOSVersion.Check(8) then
  begin
    case FUsageAuthorization of
      TLocationUsageAuthorization.WhenInUse:
        FLocater.requestWhenInUseAuthorization;
      TLocationUsageAuthorization.Always:
        FLocater.requestAlwaysAuthorization;
    end;
  end;
end;

{ TiOSGpsStatus }

class function TiOSGpsStatus.Authorized: TAuthorizationType;
begin
  Result := TAuthorizationType.atNotSpecified;
end;

class function TiOSGpsStatus.Supported: Boolean;
begin
  Result := False;
end;

class function TiOSGpsStatus.SatelliteCount: Integer;
begin
  Result := 0;
end;

class function TiOSGpsStatus.SatelliteFirstFixTime: Integer;
begin
  Result := 0;
end;

class function TiOSGpsStatus.Satellites(Index: Integer): TGpsSatellite;
begin
  Result := TGpsSatellite.Create(0, 0, 0, 0, False, False, False);
end;

{ TiOSGeocoder }

class function TiOSGeocoder.Authorized: TAuthorizationType;
begin
  Result := TAuthorizationType.atNotSpecified;
end;

class procedure TiOSGeocoder.Cancel;
begin
  inherited;
  FGeocoder.cancelGeocode;
end;

class function TiOSGeocoder.Supported: Boolean;
begin
                                                                                           
// geocoding is supported for the device
  Result := True;
end;

class constructor TiOSGeocoder.Create;
begin
  FGeocoder := TCLGeocoder.Create;
  FGeocoder.retain;
end;

class destructor TiOSGeocoder.Destroy;
begin
  TiOSGeocoder.FGeocoder.release;
  TiOSGeocoder.FGeocoder := nil;
end;

class procedure TiOSGeocoder.GeocodeRequest(const Address: TCivicAddress);
begin
  if Address = nil then
    GeocodeForwardHandler(nil, nil);
  if not FGeocoder.isGeocoding then
    FGeocoder.geocodeAddressString(StrToNSStr(Address.ToString), GeocodeForwardHandler);
end;

class procedure TiOSGeocoder.GeocodeReverseRequest(const Coords: TLocationCoord2D);
var
  Location: CLLocation;
begin
  Location := TCLLocation.Create;
  Location.initWithLatitude(Coords.Latitude, Coords.Longitude);
  if Location = nil then
    GeocodeReverseHandler(nil, nil);
  if not FGeocoder.isGeocoding then
    FGeocoder.reverseGeocodeLocation(Location, GeocodeReverseHandler );
end;

class function TiOSGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := Self;
end;

class procedure TiOSGeocoder.GeocodeForwardHandler(placemark: NSArray;error: NSError);
var
  Current: CLPlacemark;
  I: Integer;
  Addr: TCivicAddress;
begin
  if placemark = nil then
    // If the request was canceled or there was an error in obtaining the placemark information, this parameter is nil.
    SetLength(FGeoFwdCoords, 0)
  else
  begin
    // adapt the coordinates storage
    SetLength(FGeoFwdCoords, placemark.count);
    for I := 0 to placemark.count - 1 do
    begin
      Current := TCLPlacemark.Wrap(placemark.objectAtIndex(I));
      FGeoFwdCoords[I] := ConvCLLocation(Current.location);
    Addr := FGeoRevAddress;

    Addr.AdminArea := NSStrToStr(Current.administrativeArea);
    Addr.CountryName := NSStrToStr(Current.country);
    Addr.CountryCode := NSStrToStr(Current.ISOCountryCode);
    Addr.Locality := NSStrToStr(Current.locality);
    Addr.Coord := ConvCLLocation(Current.location);
    Addr.FeatureName := NSStrToStr(Current.name);
    Addr.PostalCode := NSStrToStr(Current.postalCode);
    Addr.SubAdminArea := NSStrToStr(Current.subAdministrativeArea);
    Addr.SubLocality := NSStrToStr(Current.subLocality);
    Addr.SubThoroughfare := NSStrToStr(Current.subThoroughfare);
    Addr.Thoroughfare := NSStrToStr(Current.thoroughfare);
    Addr.Coord:=FGeoFwdCoords[i];
    DoGeocodeReverse(Addr);
    end;
  end;

  // call the event-handler
  DoGeocode(FGeoFwdCoords);
end;

class procedure TiOSGeocoder.GeocodeReverseHandler(placemark: NSArray;error: NSError);
var
  Current: CLPlacemark;
  Addr: TCivicAddress;
begin
  if (placemark <> nil) and (placemark.count > 0) then
  begin
    // grab the actual placemark object
    Current := TCLPlacemark.Wrap(placemark.objectAtIndex(0));
    Addr := FGeoRevAddress;

    Addr.AdminArea := NSStrToStr(Current.administrativeArea);
    Addr.CountryName := NSStrToStr(Current.country);
    Addr.CountryCode := NSStrToStr(Current.ISOCountryCode);
    Addr.Locality := NSStrToStr(Current.locality);
    Addr.Coord := ConvCLLocation(Current.location);
    Addr.FeatureName := NSStrToStr(Current.name);
    Addr.PostalCode := NSStrToStr(Current.postalCode);
    Addr.SubAdminArea := NSStrToStr(Current.subAdministrativeArea);
    Addr.SubLocality := NSStrToStr(Current.subLocality);
    Addr.SubThoroughfare := NSStrToStr(Current.subThoroughfare);
    Addr.Thoroughfare := NSStrToStr(Current.thoroughfare);
  end
  else
    Addr := nil;

  // call the event handler
  DoGeocodeReverse(Addr);
end;

{ TiOSLocationDelegate }

procedure TiOSLocationDelegate.locationManagerDidDetermineStateForRegion(manager: CLLocationManager;
  state: CLRegionState; region: CLRegion);
begin
  { For debugging purporses }
end;

procedure TiOSLocationDelegate.locationManagerDidEnterRegion(manager: CLLocationManager; region: CLRegion);
var
  LRegion: TLocationRegion;
begin
  DoStateChanged(TSensorState.Ready);
  try
    LRegion := ConvCLRegion(region);
    DoDidEnterRegion(LRegion);
  finally
    DoStateChanged(TSensorState.NoData);
  end;
end;

procedure TiOSLocationDelegate.locationManagerDidExitRegion(manager: CLLocationManager; region: CLRegion);
var
  LRegion: TLocationRegion;
begin
  DoStateChanged(TSensorState.Ready);
  try
    LRegion := ConvCLRegion(region);
    DoDidExitRegion(LRegion);
  finally
    DoStateChanged(TSensorState.NoData);
  end;
end;

procedure TiOSLocationDelegate.locationManagerDidFinishDeferredUpdatesWithError(manager: CLLocationManager;
  error: NSError);
begin
  { For debugging purporses }
end;

procedure TiOSLocationDelegate.locationManagerDidPauseLocationUpdates(manager: CLLocationManager);
begin
  DoLocationUpdatesPausedChanged(True);
end;

procedure TiOSLocationDelegate.locationManagerDidRangeBeaconsInRegion(manager: CLLocationManager; beacons: NSArray;
  region: CLBeaconRegion);
begin
  { For debugging purporses }
end;

procedure TiOSLocationDelegate.locationManagerDidResumeLocationUpdates(manager: CLLocationManager);
begin
  DoLocationUpdatesPausedChanged(False);
end;

procedure TiOSLocationDelegate.locationManagerDidStartMonitoringForRegion(manager: CLLocationManager; region: CLRegion);
begin
  { For debugging purporses }
end;

procedure TiOSLocationDelegate.locationManagerDidUpdateLocations(manager: CLLocationManager; locations: NSArray);
var
  Location: CLLocation;
  NewLocation: TLocationCoord2D;
begin
  DoStateChanged(TSensorState.Ready);
  try
    Location := TCLLocation.Wrap(locations.lastObject);
    NewLocation := ConvCLLocation(Location);

    DoCLLocationChanged(manager.location);
    DoLocationChanged(FPreviousLocation, NewLocation);

    FPreviousLocation := NewLocation;
  finally
    DoStateChanged(TSensorState.NoData);
  end;
end;

procedure TiOSLocationDelegate.locationManagerRangingBeaconsDidFailForRegionWithError(manager: CLLocationManager;
  region: CLBeaconRegion; error: NSError);
begin
  { For debugging purporses }
end;

procedure TiOSLocationDelegate.locationManager(
  manager: CLLocationManager;
  didChangeAuthorizationStatus: CLAuthorizationStatus);
var
  State: TSensorState;
begin
  case didChangeAuthorizationStatus of
    // The user has not yet made a choice regarding whether this application
    // can use location services.
    kCLAuthorizationStatusNotDetermined:
      State := TSensorState.AccessDenied;
    // This application is not authorized to use location services.
    // The user cannot change this application�s status, possibly due to active
    // restrictions such as parental controls being in place.
    kCLAuthorizationStatusRestricted:
      State := TSensorState.AccessDenied;
    // The user explicitly denied the use of location services for this
    // application or location services are currently disabled in Settings.
    kCLAuthorizationStatusDenied:
      State := TSensorState.AccessDenied;
    // This application is authorized to use location services.
    kCLAuthorizationStatusAuthorized, kCLAuthorizationStatusAuthorizedWhenInUse:
      State := TSensorState.Ready;
    else
      State := TSensorState.Error;
  end;
  DoStateChanged(State);
end;

procedure TiOSLocationDelegate.locationManager(manager: CLLocationManager; didFailWithError: NSError);
var
  State: TSensorState;
begin
  case didFailWithError.code of
    // can't get a location right now; wait for a new event
    kCLErrorLocationUnknown:
      State := TSensorState.Error;
    // user denied usage of location services
    kCLErrorDenied:
      State := TSensorState.AccessDenied;
    // strong interference from nearby magnetic fields
    kCLErrorHeadingFailure:
      State := TSensorState.Error;
   else
      State := TSensorState.Error;
  end;
  DoStateChanged(State);
end;

procedure TiOSLocationDelegate.DoDidEnterRegion(const ADidEnterRegion: TLocationRegion);
begin
  if Assigned(FOnDidEnterRegion) then
    FOnDidEnterRegion(ADidEnterRegion);
end;

procedure TiOSLocationDelegate.DoDidExitRegion(const ADidExitRegion: TLocationRegion);
begin
  if Assigned(FOnDidExitRegion) then
    FOnDidExitRegion(ADidExitRegion);
end;

procedure TiOSLocationDelegate.DoHeadingChanged(const ANewHeading: CLHeading);
begin
  if Assigned(FOnHeadingChanged) then
    FOnHeadingChanged(ANewHeading);
end;

procedure TiOSLocationDelegate.DoLocationChanged(const AOldLocation, ANewLocation: TLocationCoord2D);
begin
  if Assigned(FOnLocationChanged) then
    FOnLocationChanged(AOldLocation, ANewLocation);
end;

procedure TiOSLocationDelegate.DoLocationUpdatesPausedChanged(const APaused: Boolean);
begin
  if Assigned(FOnLocationUpdatesPausedChanged) then
    FOnLocationUpdatesPausedChanged(APaused);
end;

constructor TiOSLocationDelegate.Create;
begin
  inherited;
  FPreviousLocation := TLocationCoord2D.Create(0, 0);
end;

procedure TiOSLocationDelegate.DoCLLocationChanged(const ACLLocation: CLLocation);
begin
  if Assigned(FOnCLLocationChanged) then
    FOnCLLocationChanged(ACLLocation);
end;

procedure TiOSLocationDelegate.DoStateChanged(const ANewState: TSensorState);
begin
  if Assigned(FOnStateChanged) then
    FOnStateChanged(ANewState);
end;

procedure TiOSLocationDelegate.locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion;
  withError: NSError);
begin
                                                      
  DoStateChanged(TSensorState.Error)
end;

function TiOSLocationDelegate.locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean;
begin
  // Orientation Sensor didn't support sensor calibration
  Result := False;
end;

procedure TiOSLocationDelegate.locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading);
begin
  DoStateChanged(TSensorState.Ready);
  try
    DoHeadingChanged(didUpdateHeading);
  finally
    DoStateChanged(TSensorState.NoData);
  end;
end;

procedure TiOSLocationDelegate.locationManager(manager: CLLocationManager; didUpdateToLocation, fromLocation: CLLocation);
begin
end;

{ TPlatformGeocoder }

class function TPlatformGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := TiOSGeocoder;
end;

{ TPlatformGpsStatus }

class function TPlatformGpsStatus.GetGpsStatusImplementer: TGpsStatusClass;
begin
  Result := TiOSGpsStatus;
end;

{ TiOSMotionSensor }

constructor TiOSMotionSensor.Create(AManager: TsensorManager; ADelegate: IMotionSensorDelegate);
begin
  inherited Create(AManager);
  FSensorDelegate := ADelegate;
  FUpdateInterval := 50;
end;

destructor TiOSMotionSensor.Destroy;
begin
  Stop;
  inherited;
end;

function TiOSMotionSensor.DoGetInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOTIMPL;
  if FSensorDelegate <> nil then
    Result := FSensorDelegate.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FQueue <> nil) then
    Result := FQueue.QueryInterface(IID, Obj);
end;

function TiOSMotionSensor.DoStart: Boolean;
begin
  if FQueue = nil then
    FQueue := TNSOperationQueue.Create;
  FQueue.setSuspended(False);
  FSensorDelegate.Start;
  Result := True;
end;

procedure TiOSMotionSensor.DoStop;
begin
  FSensorDelegate.Stop;
  FQueue.cancelAllOperations;
  FQueue.setSuspended(True);
end;

function TiOSMotionSensor.GetAvailableProperties: TCustomMotionSensor.TProperties;
begin
  if Supported then
    Result := FSensorDelegate.GetAvailableProperties
  else
    Result := [];
end;

function TiOSMotionSensor.GetDoubleProperty(Prop: TCustomMotionSensor.TProperty): Double;
begin
  Result := NaN;
  if Prop in AvailableProperties then
    Result := FSensorDelegate.GetDoubleProperty(Prop);
end;

function TiOSMotionSensor.GetMotionSensorType: TMotionSensorType;
begin
  Result := FSensorDelegate.GetSensorType;
end;

function TiOSMotionSensor.GetSensorCategory: TSensorCategory;
begin
  Result := FSensorDelegate.GetSensorCategory;
end;

function TiOSMotionSensor.GetState: TSensorState;
begin
  Result := FSensorState;
end;

function TiOSMotionSensor.GetTimeStamp: TDateTime;
begin
  Result := 0;
end;

function TiOSMotionSensor.GetUpdateInterval: Double;
begin
  Result := FUpdateInterval;
end;

procedure TiOSMotionSensor.SetUpdateInterval(AInterval: Double);
begin
//  inherited;
  if not SameValue(FUpdateInterval, AInterval) then
    FUpdateInterval := AInterval;
end;

function TiOSMotionSensor.Supported: Boolean;
begin
  Result := IsDeviceMotionAvailable;
end;

{ TAccelerometerDelegate }

constructor TAccelerometerDelegate.Create(ANativeManager: CMMotionManager);
begin
  FNativeManager := ANativeManager;
end;

function TAccelerometerDelegate.GetAvailableProperties: TCustomMotionSensor.TProperties;
begin
  Result := [TCustomMotionSensor.TProperty.AccelerationX, TCustomMotionSensor.TProperty.AccelerationY, TCustomMotionSensor.TProperty.AccelerationZ];
end;

function TAccelerometerDelegate.GetDoubleProperty(AProp: TCustomMotionSensor.TProperty): Double;
var
  LAccelData: CMAccelerometerData;
begin
  Result := 0;
  LAccelData := FNativeManager.accelerometerData;
  if LAccelData <> nil then
    case AProp of
      TCustomMotionSensor.TProperty.AccelerationX:
        Result := LAccelData.acceleration.x;
      TCustomMotionSensor.TProperty.AccelerationY:
        Result := LAccelData.acceleration.y;
      TCustomMotionSensor.TProperty.AccelerationZ:
        Result := LAccelData.acceleration.z;
    end;
end;

function TAccelerometerDelegate.GetSensorCategory: TSensorCategory;
begin
  Result := TSensorCategory.Motion;
end;

function TAccelerometerDelegate.GetSensorType: TMotionSensorType;
begin
  Result := TMotionSensorType.Accelerometer3D;
end;

procedure TAccelerometerDelegate.Start;
begin
  if FNativeManager <> nil then
                                                              
    FNativeManager.startAccelerometerUpdates;
end;

procedure TAccelerometerDelegate.Stop;
begin
  if FNativeManager <> nil then
    FNativeManager.stopAccelerometerUpdates;
end;

{ TDeviceMotionDelegate }

constructor TDeviceMotionDelegate.Create(ANativeManager: CMMotionManager);
begin
  FNativeManager := ANativeManager;
end;

function TDeviceMotionDelegate.GetAvailableProperties: TCustomMotionSensor.TProperties;
begin
  Result := [TCustomMotionSensor.TProperty.AccelerationX, TCustomMotionSensor.TProperty.AccelerationY,
    TCustomMotionSensor.TProperty.AccelerationZ, TCustomMotionSensor.TProperty.AngleAccelX,
    TCustomMotionSensor.TProperty.AngleAccelY, TCustomMotionSensor.TProperty.AngleAccelZ]
end;

function TDeviceMotionDelegate.GetDoubleProperty(AProp: TCustomMotionSensor.TProperty): Double;
var
  LMotionData: CMDeviceMotion;
begin
  Result := 0;
  LMotionData := FNativeManager.deviceMotion;
  if LMotionData <> nil then
    case AProp of
      TCustomMotionSensor.TProperty.AccelerationX:
        Result := LMotionData.userAcceleration.x;
      TCustomMotionSensor.TProperty.AccelerationY:
        Result := LMotionData.userAcceleration.y;
      TCustomMotionSensor.TProperty.AccelerationZ:
        Result := LMotionData.userAcceleration.z;
      TCustomMotionSensor.TProperty.AngleAccelX:
        Result := RadToDeg(LMotionData.rotationRate.x);
      TCustomMotionSensor.TProperty.AngleAccelY:
        Result := RadToDeg(LMotionData.rotationRate.y);
      TCustomMotionSensor.TProperty.AngleAccelZ:
        Result := RadToDeg(LMotionData.rotationRate.z);
    end;
end;

function TDeviceMotionDelegate.GetSensorCategory: TSensorCategory;
begin
  Result := TSensorCategory.Motion;
end;

function TDeviceMotionDelegate.GetSensorType: TMotionSensorType;
begin
  Result := TMotionSensorType.MotionDetector;
end;

procedure TDeviceMotionDelegate.Start;
begin
                                                           
  if FNativeManager <> nil then
    FNativeManager.startDeviceMotionUpdates;
end;

procedure TDeviceMotionDelegate.Stop;
begin
  if FNativeManager <> nil then
    FNativeManager.stopDeviceMotionUpdates;
end;

{ TiOSCustomOrientationSensor }

constructor TiOSCustomOrientationSensor.Create(AManager: TSensormanager);
begin
  inherited;
  FUpdateInterval := 50;
end;

function TiOSCustomOrientationSensor.GetSensorCategory: TSensorCategory;
begin
  Result := TSensorCategory.Orientation;
end;

function TiOSCustomOrientationSensor.GetUpdateInterval: Double;
begin
  Result := FUpdateInterval;
end;

procedure TiOSCustomOrientationSensor.SetUpdateInterval(AInterval: Double);
begin
  if not SameValue(FUpdateInterval, AInterval) then
    FUpdateInterval := AInterval;
end;

{ TiOSGyroscopeSensor }

constructor TiOSGyroscopeSensor.Create(AManager: TSensorManager);
begin
  inherited Create(AManager);
  FNativeManager := TCMMotionManager.Create;

end;

destructor TiOSGyroscopeSensor.Destroy;
begin
  //CFRelease(FNativeManager.);
  inherited Destroy;
end;

function TiOSGyroscopeSensor.DoGetInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOTIMPL;
  if FNativeManager <> nil then
    Result := FNativeManager.QueryInterface(IID, Obj);
end;

function TiOSGyroscopeSensor.DoStart: Boolean;
begin
  FNativeManager.startDeviceMotionUpdates;
  Result := FNativeManager.isGyroAvailable and FNativeManager.isGyroActive;
end;

procedure TiOSGyroscopeSensor.DoStop;
begin
  FNativeManager.stopDeviceMotionUpdates;
end;

function TiOSGyroscopeSensor.GetAvailableProperties: TCustomOrientationSensor.TProperties;
begin
  Result := [TCustomOrientationSensor.TProperty.TiltX,
             TCustomOrientationSensor.TProperty.TiltY,
             TCustomOrientationSensor.TProperty.TiltZ];
end;

function TiOSGyroscopeSensor.GetDoubleProperty(AProp: TCustomOrientationSensor.TProperty): Double;
var
  LCCMDeviceMotion : CMDeviceMotion;
begin
  Result := NaN;
  LCCMDeviceMotion := FNativeManager.deviceMotion;
  if LCCMDeviceMotion <> nil then
    case AProp of
      TCustomOrientationSensor.TProperty.TiltX:
        Result := RadToDeg(LCCMDeviceMotion.attitude.roll);
      TCustomOrientationSensor.TProperty.TiltY:
        Result := RadToDeg(LCCMDeviceMotion.attitude.pitch);
      TCustomOrientationSensor.TProperty.TiltZ:
        Result := RadToDeg(LCCMDeviceMotion.attitude.yaw);
    else
      Result := 0;
    end;
end;

function TiOSGyroscopeSensor.GetOrientationSensorType: TOrientationSensorType;
begin
  Result := TOrientationSensorType.Inclinometer3D;
end;

function TiOSGyroscopeSensor.GetState: TSensorState;
begin
  Result := TSensorState.Ready;
end;

function TiOSGyroscopeSensor.GetTimeStamp: TDateTime;
begin
  // IOS does not support a property "TimeStamp"
  Result := 0;
end;

{ TiOSCompassSensor }

constructor TiOSCompassSensor.Create(AManager: TSensorManager);
begin
  inherited Create(AManager);
  FDelegate := TiOSLocationDelegate.Create;
  FDelegate.OnStateChanged := DoStateChanged;
  FDelegate.OniOSHeadingChanged := DoHeadingChanged;
  FNativeManager := TCLLocationManager.Create;
//  FNativeManager.setHeadingFilter(0); // kCLHeadingFilterNone
  FNativeManager.retain;
  FNativeManager.setDelegate(FDelegate.GetObjectID);
  FSensorState := TSensorState.NoData;
end;

destructor TiOSCompassSensor.Destroy;
begin
  FNativeManager.setDelegate(nil);
  FNativeManager.release;
  FDelegate.Free;
  if FHeading <> nil then
    FHeading.release;
  inherited Destroy;
end;

function TiOSCompassSensor.DoStart: Boolean;
begin
  FNativeManager.startUpdatingHeading;
  Result := FNativeManager.headingAvailable;
end;

procedure TiOSCompassSensor.DoStateChanged(const ANewState: TSensorState);
begin
  FSensorState := ANewState;
  StateChanged;
end;

procedure TiOSCompassSensor.DoStop;
begin
  FNativeManager.stopUpdatingHeading;
end;

function TiOSCompassSensor.DoGetInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOTIMPL;
  if FNativeManager <> nil then
    Result := FNativeManager.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FDelegate <> nil) then
    Result := FDelegate.QueryInterface(IID, Obj);
  if (Result <> S_OK) and (FHeading <> nil) then
    Result := FHeading.QueryInterface(IID, Obj);
end;

procedure TiOSCompassSensor.DoHeadingChanged(const ANewHeading: CLHeading);
begin
  FHeading := ANewHeading;
  FHeading.retain;
end;

function TiOSCompassSensor.GetAvailableProperties: TCustomOrientationSensor.TProperties;
begin
  Result := [TCustomOrientationSensor.TProperty.HeadingX,
             TCustomOrientationSensor.TProperty.HeadingY,
             TCustomOrientationSensor.TProperty.HeadingZ];
end;

function TiOSCompassSensor.GetDoubleProperty(AProp: TCustomOrientationSensor.TProperty): Double;
begin
  Result := NaN;
  if FHeading <> nil then
    case AProp of
      TCustomOrientationSensor.TProperty.HeadingX:
        Result := FHeading.x; // MicroTeslas
      TCustomOrientationSensor.TProperty.HeadingY:
        Result := FHeading.y; // MicroTeslas
      TCustomOrientationSensor.TProperty.HeadingZ:
        Result := FHeading.z; // MicroTeslas
    end;
end;

function TiOSCompassSensor.GetOrientationSensorType: TOrientationSensorType;
begin
  Result := TOrientationSensorType.Compass3D;
end;

function TiOSCompassSensor.GetState: TSensorState;
begin
  if not FNativeManager.headingAvailable then
    FSensorState := TSensorState.Error;

  Result := FSensorState;
end;

function TiOSCompassSensor.GetTimeStamp: TDateTime;
begin
  Result := NSDateToDateTime(FHeading.timestamp);
end;

{ TApplicationActiveNotifier }

constructor TApplicationActiveNotifier.Create;
begin
  inherited;
  FIsActive := TfgiOSHelper.SharedApplication.applicationState <> UIApplicationStateBackground;
end;

destructor TApplicationActiveNotifier.Destroy;
begin

  inherited;
end;

function TApplicationActiveNotifier.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IApplicationActiveNotifications);
end;

procedure TApplicationActiveNotifier.didEnterBackground(notification: Pointer);
begin
  FIsActive := False;
  DoChange;
end;

procedure TApplicationActiveNotifier.willEnterForeground(notification: Pointer);
begin
  FIsActive := True;
  DoChange;
end;

procedure TApplicationActiveNotifier.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

initialization

end.
