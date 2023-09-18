{********************************************************************* 
 *                                                                     
 * This Source Code Form is subject to the terms of the Mozilla Public 
 * License, v. 2.0. If a copy of the MPL was not distributed with this 
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.            
 *                                                                     
 * Autor: Brovin Y.D.                                                  
 * E-mail: y.brovin@gmail.com                                          
 *                                                                     
 *********************************************************************}


unit Android.Api.Location;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, Androidapi.Jni, Java.Bridge,Android.Api.JavaTypes, Android.Api.ActivityAndView;

type
  JGpsStatus_Listener = interface;
  TJGpsStatus_Listener = class;
  JCriteria = interface;
  TJCriteria = class;
  JLocation = interface;
  TJLocation = class;
  JGnssNavigationMessage = interface;
  TJGnssNavigationMessage = class;
  JGpsSatellite = interface;
  TJGpsSatellite = class;
  JLocationProvider = interface;
  TJLocationProvider = class;
  JLocationListener = interface;
  TJLocationListener = class;
  JGnssClock = interface;
  TJGnssClock = class;
  JGnssMeasurementsEvent_Callback = interface;
  TJGnssMeasurementsEvent_Callback = class;
  JGnssMeasurementsEvent = interface;
  TJGnssMeasurementsEvent = class;
  JGeocoder = interface;
  TJGeocoder = class;
  JSettingInjectorService = interface;
  TJSettingInjectorService = class;
  JGpsStatus_NmeaListener = interface;
  TJGpsStatus_NmeaListener = class;
  JGnssStatus = interface;
  TJGnssStatus = class;
  JGpsStatus = interface;
  TJGpsStatus = class;
  JGnssMeasurement = interface;
  TJGnssMeasurement = class;
  JOnNmeaMessageListener = interface;
  TJOnNmeaMessageListener = class;
  JLocationManager = interface;
  TJLocationManager = class;
  JGnssNavigationMessage_Callback = interface;
  TJGnssNavigationMessage_Callback = class;
  JAddress = interface;
  TJAddress = class;
  JGnssStatus_Callback = interface;
  TJGnssStatus_Callback = class;

{ android.location.GpsStatus_Listener - interface }

  [JavaClassSignature('android/location/GpsStatus$Listener')]
  JGpsStatus_Listener = interface(IJavaObject)
    ['{E0402B4E-E6D7-40B4-B024-A95A8DF599C4}']
    procedure onGpsStatusChanged(const AArg0: Integer);
  end;

  [JavaClassSignature('android/location/GpsStatus$Listener')]
  TJGpsStatus_Listener = class(TJObject, JGpsStatus_Listener)
  private
    { methods }
    procedure onGpsStatusChanged(const AArg0: Integer);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsStatus_Listener; overload;
    class function Wrap(const AObject: IJNIObject): JGpsStatus_Listener; overload;
  end;

{ android.location.Criteria }

  [JavaClassSignature('android/location/Criteria')]
  JCriteria = interface(JObject)
    ['{04AEDE90-A338-404C-84BF-6C5B8E255BEC}']
    function describeContents: Integer;
    function getAccuracy: Integer;
    function getBearingAccuracy: Integer;
    function getHorizontalAccuracy: Integer;
    function getPowerRequirement: Integer;
    function getSpeedAccuracy: Integer;
    function getVerticalAccuracy: Integer;
    function isAltitudeRequired: Boolean;
    function isBearingRequired: Boolean;
    function isCostAllowed: Boolean;
    function isSpeedRequired: Boolean;
    procedure setAccuracy(const AArg0: Integer);
    procedure setAltitudeRequired(const AArg0: Boolean);
    procedure setBearingAccuracy(const AArg0: Integer);
    procedure setBearingRequired(const AArg0: Boolean);
    procedure setCostAllowed(const AArg0: Boolean);
    procedure setHorizontalAccuracy(const AArg0: Integer);
    procedure setPowerRequirement(const AArg0: Integer);
    procedure setSpeedAccuracy(const AArg0: Integer);
    procedure setSpeedRequired(const AArg0: Boolean);
    procedure setVerticalAccuracy(const AArg0: Integer);
    function toString: JString;
  end;

  [JavaClassSignature('android/location/Criteria')]
  TJCriteria = class(TJObject, JCriteria)
  private
    { methods }
    function describeContents: Integer;
    function getAccuracy: Integer;
    function getBearingAccuracy: Integer;
    function getHorizontalAccuracy: Integer;
    function getPowerRequirement: Integer;
    function getSpeedAccuracy: Integer;
    function getVerticalAccuracy: Integer;
    function isAltitudeRequired: Boolean;
    function isBearingRequired: Boolean;
    function isCostAllowed: Boolean;
    function isSpeedRequired: Boolean;
    procedure setAccuracy(const AArg0: Integer);
    procedure setAltitudeRequired(const AArg0: Boolean);
    procedure setBearingAccuracy(const AArg0: Integer);
    procedure setBearingRequired(const AArg0: Boolean);
    procedure setCostAllowed(const AArg0: Boolean);
    procedure setHorizontalAccuracy(const AArg0: Integer);
    procedure setPowerRequirement(const AArg0: Integer);
    procedure setSpeedAccuracy(const AArg0: Integer);
    procedure setSpeedRequired(const AArg0: Boolean);
    procedure setVerticalAccuracy(const AArg0: Integer);
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JCriteria; overload;
    class function Wrap(const AObject: IJNIObject): JCriteria; overload;
    { constructors }
    class function Create: JCriteria; overload;
    class function Create(const AArg0: JCriteria): JCriteria; overload;
    { constants }
    class function ACCURACY_COARSE: Integer;
    class function ACCURACY_FINE: Integer;
    class function ACCURACY_HIGH: Integer;
    class function ACCURACY_LOW: Integer;
    class function ACCURACY_MEDIUM: Integer;
    class function NO_REQUIREMENT: Integer;
    class function POWER_HIGH: Integer;
    class function POWER_LOW: Integer;
    class function POWER_MEDIUM: Integer;
  end;

{ android.location.Location }

  [JavaClassSignature('android/location/Location')]
  JLocation = interface(JObject)
    ['{8429F765-7E66-443E-9681-C1428A559025}']
    function bearingTo(const AArg0: JLocation): Single;
    function describeContents: Integer;
    function distanceTo(const AArg0: JLocation): Single;
    function getAccuracy: Single;
    function getAltitude: Double;
    function getBearing: Single;
    function getBearingAccuracyDegrees: Single;
    function getElapsedRealtimeNanos: Int64;
    function getExtras: JBundle;
    function getLatitude: Double;
    function getLongitude: Double;
    function getProvider: JString;
    function getSpeed: Single;
    function getSpeedAccuracyMetersPerSecond: Single;
    function getTime: Int64;
    function getVerticalAccuracyMeters: Single;
    function hasAccuracy: Boolean;
    function hasAltitude: Boolean;
    function hasBearing: Boolean;
    function hasBearingAccuracy: Boolean;
    function hasSpeed: Boolean;
    function hasSpeedAccuracy: Boolean;
    function hasVerticalAccuracy: Boolean;
    function isFromMockProvider: Boolean;
    procedure removeAccuracy;
    procedure removeAltitude;
    procedure removeBearing;
    procedure removeSpeed;
    procedure reset;
    procedure &set(const AArg0: JLocation);
    procedure setAccuracy(const AArg0: Single);
    procedure setAltitude(const AArg0: Double);
    procedure setBearing(const AArg0: Single);
    procedure setBearingAccuracyDegrees(const AArg0: Single);
    procedure setElapsedRealtimeNanos(const AArg0: Int64);
    procedure setExtras(const AArg0: JBundle);
    procedure setLatitude(const AArg0: Double);
    procedure setLongitude(const AArg0: Double);
    procedure setProvider(const AArg0: JString);
    procedure setSpeed(const AArg0: Single);
    procedure setSpeedAccuracyMetersPerSecond(const AArg0: Single);
    procedure setTime(const AArg0: Int64);
    procedure setVerticalAccuracyMeters(const AArg0: Single);
    function toString: JString;
  end;

  [JavaClassSignature('android/location/Location')]
  TJLocation = class(TJObject, JLocation)
  private
    { methods }
    function bearingTo(const AArg0: JLocation): Single;
    function describeContents: Integer;
    function distanceTo(const AArg0: JLocation): Single;
    function getAccuracy: Single;
    function getAltitude: Double;
    function getBearing: Single;
    function getBearingAccuracyDegrees: Single;
    function getElapsedRealtimeNanos: Int64;
    function getExtras: JBundle;
    function getLatitude: Double;
    function getLongitude: Double;
    function getProvider: JString;
    function getSpeed: Single;
    function getSpeedAccuracyMetersPerSecond: Single;
    function getTime: Int64;
    function getVerticalAccuracyMeters: Single;
    function hasAccuracy: Boolean;
    function hasAltitude: Boolean;
    function hasBearing: Boolean;
    function hasBearingAccuracy: Boolean;
    function hasSpeed: Boolean;
    function hasSpeedAccuracy: Boolean;
    function hasVerticalAccuracy: Boolean;
    function isFromMockProvider: Boolean;
    procedure removeAccuracy;
    procedure removeAltitude;
    procedure removeBearing;
    procedure removeSpeed;
    procedure reset;
    procedure &set(const AArg0: JLocation);
    procedure setAccuracy(const AArg0: Single);
    procedure setAltitude(const AArg0: Double);
    procedure setBearing(const AArg0: Single);
    procedure setBearingAccuracyDegrees(const AArg0: Single);
    procedure setElapsedRealtimeNanos(const AArg0: Int64);
    procedure setExtras(const AArg0: JBundle);
    procedure setLatitude(const AArg0: Double);
    procedure setLongitude(const AArg0: Double);
    procedure setProvider(const AArg0: JString);
    procedure setSpeed(const AArg0: Single);
    procedure setSpeedAccuracyMetersPerSecond(const AArg0: Single);
    procedure setTime(const AArg0: Int64);
    procedure setVerticalAccuracyMeters(const AArg0: Single);
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocation; overload;
    class function Wrap(const AObject: IJNIObject): JLocation; overload;
    { constructors }
    class function Create(const AArg0: JString): JLocation; overload;
    class function Create(const AArg0: JLocation): JLocation; overload;
    { constants }
    class function FORMAT_DEGREES: Integer;
    class function FORMAT_MINUTES: Integer;
    class function FORMAT_SECONDS: Integer;
    { methods }
    class function convert(const AArg0: Double; const AArg1: Integer): JString; overload;
    class function convert(const AArg0: JString): Double; overload;
    class procedure distanceBetween(const AArg0: Double; const AArg1: Double; const AArg2: Double; const AArg3: Double; const AArg4: IJavaArray<Single>);
  end;

{ android.location.GnssNavigationMessage }

  [JavaClassSignature('android/location/GnssNavigationMessage')]
  JGnssNavigationMessage = interface(JObject)
    ['{BAFE739F-684E-492E-A6E4-179A5C966D8C}']
    function describeContents: Integer;
    function getData: IJavaArray<Byte>;
    function getMessageId: Integer;
    function getStatus: Integer;
    function getSubmessageId: Integer;
    function getSvid: Integer;
    function getType: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssNavigationMessage')]
  TJGnssNavigationMessage = class(TJObject, JGnssNavigationMessage)
  private
    { methods }
    function describeContents: Integer;
    function getData: IJavaArray<Byte>;
    function getMessageId: Integer;
    function getStatus: Integer;
    function getSubmessageId: Integer;
    function getSvid: Integer;
    function getType: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssNavigationMessage; overload;
    class function Wrap(const AObject: IJNIObject): JGnssNavigationMessage; overload;
    { constants }
    class function STATUS_PARITY_PASSED: Integer;
    class function STATUS_PARITY_REBUILT: Integer;
    class function STATUS_UNKNOWN: Integer;
    class function TYPE_BDS_D1: Integer;
    class function TYPE_BDS_D2: Integer;
    class function TYPE_GAL_F: Integer;
    class function TYPE_GAL_I: Integer;
    class function TYPE_GLO_L1CA: Integer;
    class function TYPE_GPS_CNAV2: Integer;
    class function TYPE_GPS_L1CA: Integer;
    class function TYPE_GPS_L2CNAV: Integer;
    class function TYPE_GPS_L5CNAV: Integer;
    class function TYPE_UNKNOWN: Integer;
  end;

{ android.location.GpsSatellite }

  [JavaClassSignature('android/location/GpsSatellite')]
  JGpsSatellite = interface(JObject)
    ['{4C1D8E15-EE67-4978-9B76-7418A8A89AC4}']
    function getAzimuth: Single;
    function getElevation: Single;
    function getPrn: Integer;
    function getSnr: Single;
    function hasAlmanac: Boolean;
    function hasEphemeris: Boolean;
    function usedInFix: Boolean;
  end;

  [JavaClassSignature('android/location/GpsSatellite')]
  TJGpsSatellite = class(TJObject, JGpsSatellite)
  private
    { methods }
    function getAzimuth: Single;
    function getElevation: Single;
    function getPrn: Integer;
    function getSnr: Single;
    function hasAlmanac: Boolean;
    function hasEphemeris: Boolean;
    function usedInFix: Boolean;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsSatellite; overload;
    class function Wrap(const AObject: IJNIObject): JGpsSatellite; overload;
  end;

{ android.location.LocationProvider }

  [JavaClassSignature('android/location/LocationProvider')]
  JLocationProvider = interface(JObject)
    ['{C5B53315-421D-43FD-8127-A2FADD2B78B6}']
    function getAccuracy: Integer;
    function getName: JString;
    function getPowerRequirement: Integer;
    function hasMonetaryCost: Boolean;
    function meetsCriteria(const AArg0: JCriteria): Boolean;
    function requiresCell: Boolean;
    function requiresNetwork: Boolean;
    function requiresSatellite: Boolean;
    function supportsAltitude: Boolean;
    function supportsBearing: Boolean;
    function supportsSpeed: Boolean;
  end;

  [JavaClassSignature('android/location/LocationProvider')]
  TJLocationProvider = class(TJObject, JLocationProvider)
  private
    { methods }
    function getAccuracy: Integer;
    function getName: JString;
    function getPowerRequirement: Integer;
    function hasMonetaryCost: Boolean;
    function meetsCriteria(const AArg0: JCriteria): Boolean;
    function requiresCell: Boolean;
    function requiresNetwork: Boolean;
    function requiresSatellite: Boolean;
    function supportsAltitude: Boolean;
    function supportsBearing: Boolean;
    function supportsSpeed: Boolean;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationProvider; overload;
    class function Wrap(const AObject: IJNIObject): JLocationProvider; overload;
    { constants }
    class function AVAILABLE: Integer;
    class function OUT_OF_SERVICE: Integer;
    class function TEMPORARILY_UNAVAILABLE: Integer;
  end;

{ android.location.LocationListener - interface }

  [JavaClassSignature('android/location/LocationListener')]
  JLocationListener = interface(IJavaObject)
    ['{181CB316-BFD6-4EF9-AF1D-FD6C0EAA1BD4}']
    procedure onLocationChanged(const AArg0: JLocation);
    procedure onProviderDisabled(const AArg0: JString);
    procedure onProviderEnabled(const AArg0: JString);
    procedure onStatusChanged(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle);
  end;

  [JavaClassSignature('android/location/LocationListener')]
  TJLocationListener = class(TJObject, JLocationListener)
  private
    { methods }
    procedure onLocationChanged(const AArg0: JLocation);
    procedure onProviderDisabled(const AArg0: JString);
    procedure onProviderEnabled(const AArg0: JString);
    procedure onStatusChanged(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationListener; overload;
    class function Wrap(const AObject: IJNIObject): JLocationListener; overload;
  end;

{ android.location.GnssClock }

  [JavaClassSignature('android/location/GnssClock')]
  JGnssClock = interface(JObject)
    ['{5D23C904-AA1E-44BC-86F0-115B6DA1756B}']
    function describeContents: Integer;
    function getBiasNanos: Double;
    function getBiasUncertaintyNanos: Double;
    function getDriftNanosPerSecond: Double;
    function getDriftUncertaintyNanosPerSecond: Double;
    function getFullBiasNanos: Int64;
    function getHardwareClockDiscontinuityCount: Integer;
    function getLeapSecond: Integer;
    function getTimeNanos: Int64;
    function getTimeUncertaintyNanos: Double;
    function hasBiasNanos: Boolean;
    function hasBiasUncertaintyNanos: Boolean;
    function hasDriftNanosPerSecond: Boolean;
    function hasDriftUncertaintyNanosPerSecond: Boolean;
    function hasFullBiasNanos: Boolean;
    function hasLeapSecond: Boolean;
    function hasTimeUncertaintyNanos: Boolean;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssClock')]
  TJGnssClock = class(TJObject, JGnssClock)
  private
    { methods }
    function describeContents: Integer;
    function getBiasNanos: Double;
    function getBiasUncertaintyNanos: Double;
    function getDriftNanosPerSecond: Double;
    function getDriftUncertaintyNanosPerSecond: Double;
    function getFullBiasNanos: Int64;
    function getHardwareClockDiscontinuityCount: Integer;
    function getLeapSecond: Integer;
    function getTimeNanos: Int64;
    function getTimeUncertaintyNanos: Double;
    function hasBiasNanos: Boolean;
    function hasBiasUncertaintyNanos: Boolean;
    function hasDriftNanosPerSecond: Boolean;
    function hasDriftUncertaintyNanosPerSecond: Boolean;
    function hasFullBiasNanos: Boolean;
    function hasLeapSecond: Boolean;
    function hasTimeUncertaintyNanos: Boolean;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssClock; overload;
    class function Wrap(const AObject: IJNIObject): JGnssClock; overload;
  end;

{ android.location.GnssMeasurementsEvent_Callback }

  [JavaClassSignature('android/location/GnssMeasurementsEvent$Callback')]
  JGnssMeasurementsEvent_Callback = interface(JObject)
    ['{8AFC745E-4483-4895-B640-BBC19697E4B3}']
    procedure onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
    procedure onStatusChanged(const AArg0: Integer);
  end;

  [JavaClassSignature('android/location/GnssMeasurementsEvent$Callback')]
  TJGnssMeasurementsEvent_Callback = class(TJObject, JGnssMeasurementsEvent_Callback)
  private
    { methods }
    procedure onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
    procedure onStatusChanged(const AArg0: Integer);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssMeasurementsEvent_Callback; overload;
    class function Wrap(const AObject: IJNIObject): JGnssMeasurementsEvent_Callback; overload;
    { constructors }
    class function Create: JGnssMeasurementsEvent_Callback; overload;
    { constants }
    class function STATUS_LOCATION_DISABLED: Integer;
    class function STATUS_NOT_SUPPORTED: Integer;
    class function STATUS_READY: Integer;
  end;

{ android.location.GnssMeasurementsEvent }

  [JavaClassSignature('android/location/GnssMeasurementsEvent')]
  JGnssMeasurementsEvent = interface(JObject)
    ['{90D367BE-82DA-4F4B-813A-14D1CD138A64}']
    function describeContents: Integer;
    function getClock: JGnssClock;
    function getMeasurements: JCollection;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssMeasurementsEvent')]
  TJGnssMeasurementsEvent = class(TJObject, JGnssMeasurementsEvent)
  private
    { methods }
    function describeContents: Integer;
    function getClock: JGnssClock;
    function getMeasurements: JCollection;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssMeasurementsEvent; overload;
    class function Wrap(const AObject: IJNIObject): JGnssMeasurementsEvent; overload;
  end;

{ android.location.Geocoder }

  [JavaClassSignature('android/location/Geocoder')]
  JGeocoder = interface(JObject)
    ['{52C48EC1-BF24-482A-AF53-5A6F1E0E1A73}']
    function getFromLocation(const AArg0: Double; const AArg1: Double; const AArg2: Integer): JList;
    function getFromLocationName(const AArg0: JString; const AArg1: Integer; const AArg2: Double; const AArg3: Double; const AArg4: Double; const AArg5: Double): JList; overload;
    function getFromLocationName(const AArg0: JString; const AArg1: Integer): JList; overload;
  end;

  [JavaClassSignature('android/location/Geocoder')]
  TJGeocoder = class(TJObject, JGeocoder)
  private
    { methods }
    function getFromLocation(const AArg0: Double; const AArg1: Double; const AArg2: Integer): JList;
    function getFromLocationName(const AArg0: JString; const AArg1: Integer; const AArg2: Double; const AArg3: Double; const AArg4: Double; const AArg5: Double): JList; overload;
    function getFromLocationName(const AArg0: JString; const AArg1: Integer): JList; overload;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGeocoder; overload;
    class function Wrap(const AObject: IJNIObject): JGeocoder; overload;
    { constructors }
    class function Create(const AArg0: JContext; const AArg1: JLocale): JGeocoder; overload;
    class function Create(const AArg0: JContext): JGeocoder; overload;
    { methods }
    class function isPresent: Boolean;
  end;

{ android.location.SettingInjectorService }

  [JavaClassSignature('android/location/SettingInjectorService')]
  JSettingInjectorService = interface(JService)
    ['{62AC2062-721A-4F4B-9136-220E6E2154C3}']
    function onBind(const AArg0: JIntent): JIBinder;
    procedure onStart(const AArg0: JIntent; const AArg1: Integer);
    function onStartCommand(const AArg0: JIntent; const AArg1: Integer; const AArg2: Integer): Integer;
  end;

  [JavaClassSignature('android/location/SettingInjectorService')]
  TJSettingInjectorService = class(TJService, JSettingInjectorService)
  private
    { methods }
    function onBind(const AArg0: JIntent): JIBinder;
    procedure onStart(const AArg0: JIntent; const AArg1: Integer);
    function onStartCommand(const AArg0: JIntent; const AArg1: Integer; const AArg2: Integer): Integer;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JSettingInjectorService; overload;
    class function Wrap(const AObject: IJNIObject): JSettingInjectorService; overload;
    { constructors }
    class function Create(const AArg0: JString): JSettingInjectorService; overload;
    { constants }
    class function ACTION_INJECTED_SETTING_CHANGED: JString;
    class function ACTION_SERVICE_INTENT: JString;
    class function ATTRIBUTES_NAME: JString;
    class function META_DATA_NAME: JString;
  end;

{ android.location.GpsStatus_NmeaListener - interface }

  [JavaClassSignature('android/location/GpsStatus$NmeaListener')]
  JGpsStatus_NmeaListener = interface(IJavaObject)
    ['{7986E9B2-6827-4794-B990-E94EC4A29076}']
    procedure onNmeaReceived(const AArg0: Int64; const AArg1: JString);
  end;

  [JavaClassSignature('android/location/GpsStatus$NmeaListener')]
  TJGpsStatus_NmeaListener = class(TJObject, JGpsStatus_NmeaListener)
  private
    { methods }
    procedure onNmeaReceived(const AArg0: Int64; const AArg1: JString);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsStatus_NmeaListener; overload;
    class function Wrap(const AObject: IJNIObject): JGpsStatus_NmeaListener; overload;
  end;

{ android.location.GnssStatus }

  [JavaClassSignature('android/location/GnssStatus')]
  JGnssStatus = interface(JObject)
    ['{CE21C7E5-0605-4156-A022-62E19A09096A}']
    function getAzimuthDegrees(const AArg0: Integer): Single;
    function getCarrierFrequencyHz(const AArg0: Integer): Single;
    function getCn0DbHz(const AArg0: Integer): Single;
    function getConstellationType(const AArg0: Integer): Integer;
    function getElevationDegrees(const AArg0: Integer): Single;
    function getSatelliteCount: Integer;
    function getSvid(const AArg0: Integer): Integer;
    function hasAlmanacData(const AArg0: Integer): Boolean;
    function hasCarrierFrequencyHz(const AArg0: Integer): Boolean;
    function hasEphemerisData(const AArg0: Integer): Boolean;
    function usedInFix(const AArg0: Integer): Boolean;
  end;

  [JavaClassSignature('android/location/GnssStatus')]
  TJGnssStatus = class(TJObject, JGnssStatus)
  private
    { methods }
    function getAzimuthDegrees(const AArg0: Integer): Single;
    function getCarrierFrequencyHz(const AArg0: Integer): Single;
    function getCn0DbHz(const AArg0: Integer): Single;
    function getConstellationType(const AArg0: Integer): Integer;
    function getElevationDegrees(const AArg0: Integer): Single;
    function getSatelliteCount: Integer;
    function getSvid(const AArg0: Integer): Integer;
    function hasAlmanacData(const AArg0: Integer): Boolean;
    function hasCarrierFrequencyHz(const AArg0: Integer): Boolean;
    function hasEphemerisData(const AArg0: Integer): Boolean;
    function usedInFix(const AArg0: Integer): Boolean;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssStatus; overload;
    class function Wrap(const AObject: IJNIObject): JGnssStatus; overload;
    { constants }
    class function CONSTELLATION_BEIDOU: Integer;
    class function CONSTELLATION_GALILEO: Integer;
    class function CONSTELLATION_GLONASS: Integer;
    class function CONSTELLATION_GPS: Integer;
    class function CONSTELLATION_QZSS: Integer;
    class function CONSTELLATION_SBAS: Integer;
    class function CONSTELLATION_UNKNOWN: Integer;
  end;

{ android.location.GpsStatus }

  [JavaClassSignature('android/location/GpsStatus')]
  JGpsStatus = interface(JObject)
    ['{34D80F8F-2836-4ABD-BA9F-AF09F4295BA4}']
    function getMaxSatellites: Integer;
    function getSatellites: JIterable;
    function getTimeToFirstFix: Integer;
  end;

  [JavaClassSignature('android/location/GpsStatus')]
  TJGpsStatus = class(TJObject, JGpsStatus)
  private
    { methods }
    function getMaxSatellites: Integer;
    function getSatellites: JIterable;
    function getTimeToFirstFix: Integer;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsStatus; overload;
    class function Wrap(const AObject: IJNIObject): JGpsStatus; overload;
    { constants }
    class function GPS_EVENT_FIRST_FIX: Integer;
    class function GPS_EVENT_SATELLITE_STATUS: Integer;
    class function GPS_EVENT_STARTED: Integer;
    class function GPS_EVENT_STOPPED: Integer;
  end;

{ android.location.GnssMeasurement }

  [JavaClassSignature('android/location/GnssMeasurement')]
  JGnssMeasurement = interface(JObject)
    ['{F0AEC040-C011-4044-9537-0468D2E742D3}']
    function describeContents: Integer;
    function getAccumulatedDeltaRangeMeters: Double;
    function getAccumulatedDeltaRangeState: Integer;
    function getAccumulatedDeltaRangeUncertaintyMeters: Double;
    function getAutomaticGainControlLevelDb: Double;
    function getCarrierCycles: Int64;
    function getCarrierFrequencyHz: Single;
    function getCarrierPhase: Double;
    function getCarrierPhaseUncertainty: Double;
    function getCn0DbHz: Double;
    function getConstellationType: Integer;
    function getMultipathIndicator: Integer;
    function getPseudorangeRateMetersPerSecond: Double;
    function getPseudorangeRateUncertaintyMetersPerSecond: Double;
    function getReceivedSvTimeNanos: Int64;
    function getReceivedSvTimeUncertaintyNanos: Int64;
    function getSnrInDb: Double;
    function getState: Integer;
    function getSvid: Integer;
    function getTimeOffsetNanos: Double;
    function hasAutomaticGainControlLevelDb: Boolean;
    function hasCarrierCycles: Boolean;
    function hasCarrierFrequencyHz: Boolean;
    function hasCarrierPhase: Boolean;
    function hasCarrierPhaseUncertainty: Boolean;
    function hasSnrInDb: Boolean;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssMeasurement')]
  TJGnssMeasurement = class(TJObject, JGnssMeasurement)
  private
    { methods }
    function describeContents: Integer;
    function getAccumulatedDeltaRangeMeters: Double;
    function getAccumulatedDeltaRangeState: Integer;
    function getAccumulatedDeltaRangeUncertaintyMeters: Double;
    function getAutomaticGainControlLevelDb: Double;
    function getCarrierCycles: Int64;
    function getCarrierFrequencyHz: Single;
    function getCarrierPhase: Double;
    function getCarrierPhaseUncertainty: Double;
    function getCn0DbHz: Double;
    function getConstellationType: Integer;
    function getMultipathIndicator: Integer;
    function getPseudorangeRateMetersPerSecond: Double;
    function getPseudorangeRateUncertaintyMetersPerSecond: Double;
    function getReceivedSvTimeNanos: Int64;
    function getReceivedSvTimeUncertaintyNanos: Int64;
    function getSnrInDb: Double;
    function getState: Integer;
    function getSvid: Integer;
    function getTimeOffsetNanos: Double;
    function hasAutomaticGainControlLevelDb: Boolean;
    function hasCarrierCycles: Boolean;
    function hasCarrierFrequencyHz: Boolean;
    function hasCarrierPhase: Boolean;
    function hasCarrierPhaseUncertainty: Boolean;
    function hasSnrInDb: Boolean;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssMeasurement; overload;
    class function Wrap(const AObject: IJNIObject): JGnssMeasurement; overload;
    { constants }
    class function ADR_STATE_CYCLE_SLIP: Integer;
    class function ADR_STATE_RESET: Integer;
    class function ADR_STATE_UNKNOWN: Integer;
    class function ADR_STATE_VALID: Integer;
    class function MULTIPATH_INDICATOR_DETECTED: Integer;
    class function MULTIPATH_INDICATOR_NOT_DETECTED: Integer;
    class function MULTIPATH_INDICATOR_UNKNOWN: Integer;
    class function STATE_BDS_D2_BIT_SYNC: Integer;
    class function STATE_BDS_D2_SUBFRAME_SYNC: Integer;
    class function STATE_BIT_SYNC: Integer;
    class function STATE_CODE_LOCK: Integer;
    class function STATE_GAL_E1BC_CODE_LOCK: Integer;
    class function STATE_GAL_E1B_PAGE_SYNC: Integer;
    class function STATE_GAL_E1C_2ND_CODE_LOCK: Integer;
    class function STATE_GLO_STRING_SYNC: Integer;
    class function STATE_GLO_TOD_DECODED: Integer;
    class function STATE_GLO_TOD_KNOWN: Integer;
    class function STATE_MSEC_AMBIGUOUS: Integer;
    class function STATE_SBAS_SYNC: Integer;
    class function STATE_SUBFRAME_SYNC: Integer;
    class function STATE_SYMBOL_SYNC: Integer;
    class function STATE_TOW_DECODED: Integer;
    class function STATE_TOW_KNOWN: Integer;
    class function STATE_UNKNOWN: Integer;
  end;

{ android.location.OnNmeaMessageListener - interface }

  [JavaClassSignature('android/location/OnNmeaMessageListener')]
  JOnNmeaMessageListener = interface(IJavaObject)
    ['{499D225D-5388-4B23-B10C-104947CC9234}']
    procedure onNmeaMessage(const AArg0: JString; const AArg1: Int64);
  end;

  [JavaClassSignature('android/location/OnNmeaMessageListener')]
  TJOnNmeaMessageListener = class(TJObject, JOnNmeaMessageListener)
  private
    { methods }
    procedure onNmeaMessage(const AArg0: JString; const AArg1: Int64);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JOnNmeaMessageListener; overload;
    class function Wrap(const AObject: IJNIObject): JOnNmeaMessageListener; overload;
  end;

{ android.location.LocationManager }

  [JavaClassSignature('android/location/LocationManager')]
  JLocationManager = interface(JObject)
    ['{20C40154-08F4-411E-A3D5-6AEC56CE3433}']
    function addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean;
    function addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean; overload;
    function addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean; overload;
    function addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean; overload;
    procedure addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
    procedure addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer);
    procedure clearTestProviderEnabled(const AArg0: JString);
    procedure clearTestProviderLocation(const AArg0: JString);
    procedure clearTestProviderStatus(const AArg0: JString);
    function getAllProviders: JList;
    function getBestProvider(const AArg0: JCriteria; const AArg1: Boolean): JString;
    function getGpsStatus(const AArg0: JGpsStatus): JGpsStatus;
    function getLastKnownLocation(const AArg0: JString): JLocation;
    function getProvider(const AArg0: JString): JLocationProvider;
    function getProviders(const AArg0: Boolean): JList; overload;
    function getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList; overload;
    function isProviderEnabled(const AArg0: JString): Boolean;
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean; overload;
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean; overload;
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean; overload;
    procedure removeGpsStatusListener(const AArg0: JGpsStatus_Listener);
    procedure removeNmeaListener(const AArg0: JOnNmeaMessageListener); overload;
    procedure removeNmeaListener(const AArg0: JGpsStatus_NmeaListener); overload;
    procedure removeProximityAlert(const AArg0: JPendingIntent);
    procedure removeTestProvider(const AArg0: JString);
    procedure removeUpdates(const AArg0: JPendingIntent); overload;
    procedure removeUpdates(const AArg0: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent); overload;
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent); overload;
    function sendExtraCommand(const AArg0: JString; const AArg1: JString; const AArg2: JBundle): Boolean;
    procedure setTestProviderEnabled(const AArg0: JString; const AArg1: Boolean);
    procedure setTestProviderLocation(const AArg0: JString; const AArg1: JLocation);
    procedure setTestProviderStatus(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle; const AArg3: Int64);
    procedure unregisterGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback);
    procedure unregisterGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback);
    procedure unregisterGnssStatusCallback(const AArg0: JGnssStatus_Callback);
  end;

  [JavaClassSignature('android/location/LocationManager')]
  TJLocationManager = class(TJObject, JLocationManager)
  private
    { methods }
    function addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean;
    function addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean; overload;
    function addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean; overload;
    function addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean; overload;
    procedure addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
    procedure addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer);
    procedure clearTestProviderEnabled(const AArg0: JString);
    procedure clearTestProviderLocation(const AArg0: JString);
    procedure clearTestProviderStatus(const AArg0: JString);
    function getAllProviders: JList;
    function getBestProvider(const AArg0: JCriteria; const AArg1: Boolean): JString;
    function getGpsStatus(const AArg0: JGpsStatus): JGpsStatus;
    function getLastKnownLocation(const AArg0: JString): JLocation;
    function getProvider(const AArg0: JString): JLocationProvider;
    function getProviders(const AArg0: Boolean): JList; overload;
    function getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList; overload;
    function isProviderEnabled(const AArg0: JString): Boolean;
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean; overload;
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean; overload;
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean; overload;
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean; overload;
    procedure removeGpsStatusListener(const AArg0: JGpsStatus_Listener);
    procedure removeNmeaListener(const AArg0: JOnNmeaMessageListener); overload;
    procedure removeNmeaListener(const AArg0: JGpsStatus_NmeaListener); overload;
    procedure removeProximityAlert(const AArg0: JPendingIntent);
    procedure removeTestProvider(const AArg0: JString);
    procedure removeUpdates(const AArg0: JPendingIntent); overload;
    procedure removeUpdates(const AArg0: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper); overload;
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent); overload;
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent); overload;
    function sendExtraCommand(const AArg0: JString; const AArg1: JString; const AArg2: JBundle): Boolean;
    procedure setTestProviderEnabled(const AArg0: JString; const AArg1: Boolean);
    procedure setTestProviderLocation(const AArg0: JString; const AArg1: JLocation);
    procedure setTestProviderStatus(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle; const AArg3: Int64);
    procedure unregisterGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback);
    procedure unregisterGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback);
    procedure unregisterGnssStatusCallback(const AArg0: JGnssStatus_Callback);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationManager; overload;
    class function Wrap(const AObject: IJNIObject): JLocationManager; overload;
    { constants }
    class function GPS_PROVIDER: JString;
    class function KEY_LOCATION_CHANGED: JString;
    class function KEY_PROVIDER_ENABLED: JString;
    class function KEY_PROXIMITY_ENTERING: JString;
    class function KEY_STATUS_CHANGED: JString;
    class function MODE_CHANGED_ACTION: JString;
    class function NETWORK_PROVIDER: JString;
    class function PASSIVE_PROVIDER: JString;
    class function PROVIDERS_CHANGED_ACTION: JString;
  end;

{ android.location.GnssNavigationMessage_Callback }

  [JavaClassSignature('android/location/GnssNavigationMessage$Callback')]
  JGnssNavigationMessage_Callback = interface(JObject)
    ['{2EE0DB7D-FE11-4D01-9BB0-18F99D81B6D2}']
    procedure onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
    procedure onStatusChanged(const AArg0: Integer);
  end;

  [JavaClassSignature('android/location/GnssNavigationMessage$Callback')]
  TJGnssNavigationMessage_Callback = class(TJObject, JGnssNavigationMessage_Callback)
  private
    { methods }
    procedure onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
    procedure onStatusChanged(const AArg0: Integer);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssNavigationMessage_Callback; overload;
    class function Wrap(const AObject: IJNIObject): JGnssNavigationMessage_Callback; overload;
    { constructors }
    class function Create: JGnssNavigationMessage_Callback; overload;
    { constants }
    class function STATUS_LOCATION_DISABLED: Integer;
    class function STATUS_NOT_SUPPORTED: Integer;
    class function STATUS_READY: Integer;
  end;

{ android.location.Address }

  [JavaClassSignature('android/location/Address')]
  JAddress = interface(JObject)
    ['{23E76888-C1F4-4121-B163-C47B49AC5109}']
    procedure clearLatitude;
    procedure clearLongitude;
    function describeContents: Integer;
    function getAddressLine(const AArg0: Integer): JString;
    function getAdminArea: JString;
    function getCountryCode: JString;
    function getCountryName: JString;
    function getExtras: JBundle;
    function getFeatureName: JString;
    function getLatitude: Double;
    function getLocale: JLocale;
    function getLocality: JString;
    function getLongitude: Double;
    function getMaxAddressLineIndex: Integer;
    function getPhone: JString;
    function getPostalCode: JString;
    function getPremises: JString;
    function getSubAdminArea: JString;
    function getSubLocality: JString;
    function getSubThoroughfare: JString;
    function getThoroughfare: JString;
    function getUrl: JString;
    function hasLatitude: Boolean;
    function hasLongitude: Boolean;
    procedure setAddressLine(const AArg0: Integer; const AArg1: JString);
    procedure setAdminArea(const AArg0: JString);
    procedure setCountryCode(const AArg0: JString);
    procedure setCountryName(const AArg0: JString);
    procedure setExtras(const AArg0: JBundle);
    procedure setFeatureName(const AArg0: JString);
    procedure setLatitude(const AArg0: Double);
    procedure setLocality(const AArg0: JString);
    procedure setLongitude(const AArg0: Double);
    procedure setPhone(const AArg0: JString);
    procedure setPostalCode(const AArg0: JString);
    procedure setPremises(const AArg0: JString);
    procedure setSubAdminArea(const AArg0: JString);
    procedure setSubLocality(const AArg0: JString);
    procedure setSubThoroughfare(const AArg0: JString);
    procedure setThoroughfare(const AArg0: JString);
    procedure setUrl(const AArg0: JString);
    function toString: JString;
  end;

  [JavaClassSignature('android/location/Address')]
  TJAddress = class(TJObject, JAddress)
  private
    { methods }
    procedure clearLatitude;
    procedure clearLongitude;
    function describeContents: Integer;
    function getAddressLine(const AArg0: Integer): JString;
    function getAdminArea: JString;
    function getCountryCode: JString;
    function getCountryName: JString;
    function getExtras: JBundle;
    function getFeatureName: JString;
    function getLatitude: Double;
    function getLocale: JLocale;
    function getLocality: JString;
    function getLongitude: Double;
    function getMaxAddressLineIndex: Integer;
    function getPhone: JString;
    function getPostalCode: JString;
    function getPremises: JString;
    function getSubAdminArea: JString;
    function getSubLocality: JString;
    function getSubThoroughfare: JString;
    function getThoroughfare: JString;
    function getUrl: JString;
    function hasLatitude: Boolean;
    function hasLongitude: Boolean;
    procedure setAddressLine(const AArg0: Integer; const AArg1: JString);
    procedure setAdminArea(const AArg0: JString);
    procedure setCountryCode(const AArg0: JString);
    procedure setCountryName(const AArg0: JString);
    procedure setExtras(const AArg0: JBundle);
    procedure setFeatureName(const AArg0: JString);
    procedure setLatitude(const AArg0: Double);
    procedure setLocality(const AArg0: JString);
    procedure setLongitude(const AArg0: Double);
    procedure setPhone(const AArg0: JString);
    procedure setPostalCode(const AArg0: JString);
    procedure setPremises(const AArg0: JString);
    procedure setSubAdminArea(const AArg0: JString);
    procedure setSubLocality(const AArg0: JString);
    procedure setSubThoroughfare(const AArg0: JString);
    procedure setThoroughfare(const AArg0: JString);
    procedure setUrl(const AArg0: JString);
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAddress; overload;
    class function Wrap(const AObject: IJNIObject): JAddress; overload;
    { constructors }
    class function Create(const AArg0: JLocale): JAddress; overload;
  end;

{ android.location.GnssStatus_Callback }

  [JavaClassSignature('android/location/GnssStatus$Callback')]
  JGnssStatus_Callback = interface(JObject)
    ['{9F3077F4-6E64-49B7-85C9-8608D25609EE}']
    procedure onFirstFix(const AArg0: Integer);
    procedure onSatelliteStatusChanged(const AArg0: JGnssStatus);
    procedure onStarted;
    procedure onStopped;
  end;

  [JavaClassSignature('android/location/GnssStatus$Callback')]
  TJGnssStatus_Callback = class(TJObject, JGnssStatus_Callback)
  private
    { methods }
    procedure onFirstFix(const AArg0: Integer);
    procedure onSatelliteStatusChanged(const AArg0: JGnssStatus);
    procedure onStarted;
    procedure onStopped;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssStatus_Callback; overload;
    class function Wrap(const AObject: IJNIObject): JGnssStatus_Callback; overload;
    { constructors }
    class function Create: JGnssStatus_Callback; overload;
  end;

implementation

{ TJGpsStatus_Listener }

class procedure TJGpsStatus_Listener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onGpsStatusChanged', '(I)V');
end;

class function TJGpsStatus_Listener.Wrap(const AObjectID: JNIObject): JGpsStatus_Listener;
begin
  Result := Wrap<TJGpsStatus_Listener, JGpsStatus_Listener>(AObjectId);
end;

class function TJGpsStatus_Listener.Wrap(const AObject: IJNIObject): JGpsStatus_Listener;
begin
  Result := Wrap<TJGpsStatus_Listener, JGpsStatus_Listener>(AObject);
end;

procedure TJGpsStatus_Listener.onGpsStatusChanged(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGpsStatusChanged', '(I)V', [AArg0]);
end;

{ TJCriteria }

class procedure TJCriteria.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
  AddMethod('<init>', '(Landroid/location/Criteria;)V');
end;

class procedure TJCriteria.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('getAccuracy', '()I');
  AddMethod('getBearingAccuracy', '()I');
  AddMethod('getHorizontalAccuracy', '()I');
  AddMethod('getPowerRequirement', '()I');
  AddMethod('getSpeedAccuracy', '()I');
  AddMethod('getVerticalAccuracy', '()I');
  AddMethod('isAltitudeRequired', '()Z');
  AddMethod('isBearingRequired', '()Z');
  AddMethod('isCostAllowed', '()Z');
  AddMethod('isSpeedRequired', '()Z');
  AddMethod('setAccuracy', '(I)V');
  AddMethod('setAltitudeRequired', '(Z)V');
  AddMethod('setBearingAccuracy', '(I)V');
  AddMethod('setBearingRequired', '(Z)V');
  AddMethod('setCostAllowed', '(Z)V');
  AddMethod('setHorizontalAccuracy', '(I)V');
  AddMethod('setPowerRequirement', '(I)V');
  AddMethod('setSpeedAccuracy', '(I)V');
  AddMethod('setSpeedRequired', '(Z)V');
  AddMethod('setVerticalAccuracy', '(I)V');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJCriteria.LoadFields;
begin
  inherited;
  AddStaticField('ACCURACY_COARSE', 'I');
  AddStaticField('ACCURACY_FINE', 'I');
  AddStaticField('ACCURACY_HIGH', 'I');
  AddStaticField('ACCURACY_LOW', 'I');
  AddStaticField('ACCURACY_MEDIUM', 'I');
  AddStaticField('NO_REQUIREMENT', 'I');
  AddStaticField('POWER_HIGH', 'I');
  AddStaticField('POWER_LOW', 'I');
  AddStaticField('POWER_MEDIUM', 'I');
end;

class function TJCriteria.Wrap(const AObjectID: JNIObject): JCriteria;
begin
  Result := Wrap<TJCriteria, JCriteria>(AObjectId);
end;

class function TJCriteria.Wrap(const AObject: IJNIObject): JCriteria;
begin
  Result := Wrap<TJCriteria, JCriteria>(AObject);
end;

class function TJCriteria.Create: JCriteria;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJCriteria.Create(const AArg0: JCriteria): JCriteria;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/Criteria;)V', [AArg0]);
  Result := O;
end;

class function TJCriteria.ACCURACY_COARSE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_COARSE');
end;

class function TJCriteria.ACCURACY_FINE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_FINE');
end;

class function TJCriteria.ACCURACY_HIGH: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_HIGH');
end;

class function TJCriteria.ACCURACY_LOW: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_LOW');
end;

class function TJCriteria.ACCURACY_MEDIUM: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_MEDIUM');
end;

class function TJCriteria.NO_REQUIREMENT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('NO_REQUIREMENT');
end;

class function TJCriteria.POWER_HIGH: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_HIGH');
end;

class function TJCriteria.POWER_LOW: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_LOW');
end;

class function TJCriteria.POWER_MEDIUM: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_MEDIUM');
end;

function TJCriteria.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJCriteria.getAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getAccuracy', '()I', []);
end;

function TJCriteria.getBearingAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getBearingAccuracy', '()I', []);
end;

function TJCriteria.getHorizontalAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getHorizontalAccuracy', '()I', []);
end;

function TJCriteria.getPowerRequirement: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getPowerRequirement', '()I', []);
end;

function TJCriteria.getSpeedAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSpeedAccuracy', '()I', []);
end;

function TJCriteria.getVerticalAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getVerticalAccuracy', '()I', []);
end;

function TJCriteria.isAltitudeRequired: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isAltitudeRequired', '()Z', []);
end;

function TJCriteria.isBearingRequired: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isBearingRequired', '()Z', []);
end;

function TJCriteria.isCostAllowed: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isCostAllowed', '()Z', []);
end;

function TJCriteria.isSpeedRequired: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isSpeedRequired', '()Z', []);
end;

procedure TJCriteria.setAccuracy(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAccuracy', '(I)V', [AArg0]);
end;

procedure TJCriteria.setAltitudeRequired(const AArg0: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAltitudeRequired', '(Z)V', [AArg0]);
end;

procedure TJCriteria.setBearingAccuracy(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setBearingAccuracy', '(I)V', [AArg0]);
end;

procedure TJCriteria.setBearingRequired(const AArg0: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setBearingRequired', '(Z)V', [AArg0]);
end;

procedure TJCriteria.setCostAllowed(const AArg0: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setCostAllowed', '(Z)V', [AArg0]);
end;

procedure TJCriteria.setHorizontalAccuracy(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setHorizontalAccuracy', '(I)V', [AArg0]);
end;

procedure TJCriteria.setPowerRequirement(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setPowerRequirement', '(I)V', [AArg0]);
end;

procedure TJCriteria.setSpeedAccuracy(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSpeedAccuracy', '(I)V', [AArg0]);
end;

procedure TJCriteria.setSpeedRequired(const AArg0: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSpeedRequired', '(Z)V', [AArg0]);
end;

procedure TJCriteria.setVerticalAccuracy(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'setVerticalAccuracy', '(I)V', [AArg0]);
end;

function TJCriteria.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJLocation }

class procedure TJLocation.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(Ljava/lang/String;)V');
  AddMethod('<init>', '(Landroid/location/Location;)V');
end;

class procedure TJLocation.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('bearingTo', '(Landroid/location/Location;)F');
  AddStaticMethod('convert', '(DI)Ljava/lang/String;');
  AddStaticMethod('convert', '(Ljava/lang/String;)D');
  AddMethod('describeContents', '()I');
  AddStaticMethod('distanceBetween', '(DDDD[F)V');
  AddMethod('distanceTo', '(Landroid/location/Location;)F');
  AddMethod('getAccuracy', '()F');
  AddMethod('getAltitude', '()D');
  AddMethod('getBearing', '()F');
  AddMethod('getBearingAccuracyDegrees', '()F');
  AddMethod('getElapsedRealtimeNanos', '()J');
  AddMethod('getExtras', '()Landroid/os/Bundle;');
  AddMethod('getLatitude', '()D');
  AddMethod('getLongitude', '()D');
  AddMethod('getProvider', '()Ljava/lang/String;');
  AddMethod('getSpeed', '()F');
  AddMethod('getSpeedAccuracyMetersPerSecond', '()F');
  AddMethod('getTime', '()J');
  AddMethod('getVerticalAccuracyMeters', '()F');
  AddMethod('hasAccuracy', '()Z');
  AddMethod('hasAltitude', '()Z');
  AddMethod('hasBearing', '()Z');
  AddMethod('hasBearingAccuracy', '()Z');
  AddMethod('hasSpeed', '()Z');
  AddMethod('hasSpeedAccuracy', '()Z');
  AddMethod('hasVerticalAccuracy', '()Z');
  AddMethod('isFromMockProvider', '()Z');
  AddMethod('removeAccuracy', '()V');
  AddMethod('removeAltitude', '()V');
  AddMethod('removeBearing', '()V');
  AddMethod('removeSpeed', '()V');
  AddMethod('reset', '()V');
  AddMethod('set', '(Landroid/location/Location;)V');
  AddMethod('setAccuracy', '(F)V');
  AddMethod('setAltitude', '(D)V');
  AddMethod('setBearing', '(F)V');
  AddMethod('setBearingAccuracyDegrees', '(F)V');
  AddMethod('setElapsedRealtimeNanos', '(J)V');
  AddMethod('setExtras', '(Landroid/os/Bundle;)V');
  AddMethod('setLatitude', '(D)V');
  AddMethod('setLongitude', '(D)V');
  AddMethod('setProvider', '(Ljava/lang/String;)V');
  AddMethod('setSpeed', '(F)V');
  AddMethod('setSpeedAccuracyMetersPerSecond', '(F)V');
  AddMethod('setTime', '(J)V');
  AddMethod('setVerticalAccuracyMeters', '(F)V');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJLocation.LoadFields;
begin
  inherited;
  AddStaticField('FORMAT_DEGREES', 'I');
  AddStaticField('FORMAT_MINUTES', 'I');
  AddStaticField('FORMAT_SECONDS', 'I');
end;

class function TJLocation.Wrap(const AObjectID: JNIObject): JLocation;
begin
  Result := Wrap<TJLocation, JLocation>(AObjectId);
end;

class function TJLocation.Wrap(const AObject: IJNIObject): JLocation;
begin
  Result := Wrap<TJLocation, JLocation>(AObject);
end;

class function TJLocation.Create(const AArg0: JString): JLocation;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/lang/String;)V', [AArg0]);
  Result := O;
end;

class function TJLocation.Create(const AArg0: JLocation): JLocation;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/Location;)V', [AArg0]);
  Result := O;
end;

class function TJLocation.FORMAT_DEGREES: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_DEGREES');
end;

class function TJLocation.FORMAT_MINUTES: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_MINUTES');
end;

class function TJLocation.FORMAT_SECONDS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_SECONDS');
end;

function TJLocation.bearingTo(const AArg0: JLocation): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'bearingTo', '(Landroid/location/Location;)F', [AArg0]);
end;

class function TJLocation.convert(const AArg0: Double; const AArg1: Integer): JString;
begin
  Result := CallStaticObjectMethod<TJString, JString>('convert', '(DI)Ljava/lang/String;', [WrapDouble(AArg0), AArg1]);
end;

class function TJLocation.convert(const AArg0: JString): Double;
begin
  Result := StaticJavaType[Self].CallStaticDoubleMethod('convert', '(Ljava/lang/String;)D', [AArg0]);
end;

function TJLocation.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

class procedure TJLocation.distanceBetween(const AArg0: Double; const AArg1: Double; const AArg2: Double; const AArg3: Double; const AArg4: IJavaArray<Single>);
begin
  StaticJavaType[Self].CallStaticVoidMethod('distanceBetween', '(DDDD[F)V', [WrapDouble(AArg0), WrapDouble(AArg1), WrapDouble(AArg2), WrapDouble(AArg3), AArg4]);
end;

function TJLocation.distanceTo(const AArg0: JLocation): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'distanceTo', '(Landroid/location/Location;)F', [AArg0]);
end;

function TJLocation.getAccuracy: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getAccuracy', '()F', []);
end;

function TJLocation.getAltitude: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAltitude', '()D', []);
end;

function TJLocation.getBearing: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getBearing', '()F', []);
end;

function TJLocation.getBearingAccuracyDegrees: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getBearingAccuracyDegrees', '()F', []);
end;

function TJLocation.getElapsedRealtimeNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getElapsedRealtimeNanos', '()J', []);
end;

function TJLocation.getExtras: JBundle;
begin
  Result := CallObjectMethod<TJBundle, JBundle>('getExtras', '()Landroid/os/Bundle;', []);
end;

function TJLocation.getLatitude: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getLatitude', '()D', []);
end;

function TJLocation.getLongitude: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getLongitude', '()D', []);
end;

function TJLocation.getProvider: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getProvider', '()Ljava/lang/String;', []);
end;

function TJLocation.getSpeed: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getSpeed', '()F', []);
end;

function TJLocation.getSpeedAccuracyMetersPerSecond: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getSpeedAccuracyMetersPerSecond', '()F', []);
end;

function TJLocation.getTime: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getTime', '()J', []);
end;

function TJLocation.getVerticalAccuracyMeters: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getVerticalAccuracyMeters', '()F', []);
end;

function TJLocation.hasAccuracy: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAccuracy', '()Z', []);
end;

function TJLocation.hasAltitude: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAltitude', '()Z', []);
end;

function TJLocation.hasBearing: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBearing', '()Z', []);
end;

function TJLocation.hasBearingAccuracy: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBearingAccuracy', '()Z', []);
end;

function TJLocation.hasSpeed: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSpeed', '()Z', []);
end;

function TJLocation.hasSpeedAccuracy: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSpeedAccuracy', '()Z', []);
end;

function TJLocation.hasVerticalAccuracy: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasVerticalAccuracy', '()Z', []);
end;

function TJLocation.isFromMockProvider: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isFromMockProvider', '()Z', []);
end;

procedure TJLocation.removeAccuracy;
begin
  JavaType.CallVoidMethod(ObjectID, 'removeAccuracy', '()V', []);
end;

procedure TJLocation.removeAltitude;
begin
  JavaType.CallVoidMethod(ObjectID, 'removeAltitude', '()V', []);
end;

procedure TJLocation.removeBearing;
begin
  JavaType.CallVoidMethod(ObjectID, 'removeBearing', '()V', []);
end;

procedure TJLocation.removeSpeed;
begin
  JavaType.CallVoidMethod(ObjectID, 'removeSpeed', '()V', []);
end;

procedure TJLocation.reset;
begin
  JavaType.CallVoidMethod(ObjectID, 'reset', '()V', []);
end;

procedure TJLocation.&set(const AArg0: JLocation);
begin
  JavaType.CallVoidMethod(ObjectID, 'set', '(Landroid/location/Location;)V', [AArg0]);
end;

procedure TJLocation.setAccuracy(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAccuracy', '(F)V', [AArg0]);
end;

procedure TJLocation.setAltitude(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAltitude', '(D)V', [WrapDouble(AArg0)]);
end;

procedure TJLocation.setBearing(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setBearing', '(F)V', [AArg0]);
end;

procedure TJLocation.setBearingAccuracyDegrees(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setBearingAccuracyDegrees', '(F)V', [AArg0]);
end;

procedure TJLocation.setElapsedRealtimeNanos(const AArg0: Int64);
begin
  JavaType.CallVoidMethod(ObjectID, 'setElapsedRealtimeNanos', '(J)V', [AArg0]);
end;

procedure TJLocation.setExtras(const AArg0: JBundle);
begin
  JavaType.CallVoidMethod(ObjectID, 'setExtras', '(Landroid/os/Bundle;)V', [AArg0]);
end;

procedure TJLocation.setLatitude(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setLatitude', '(D)V', [WrapDouble(AArg0)]);
end;

procedure TJLocation.setLongitude(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setLongitude', '(D)V', [WrapDouble(AArg0)]);
end;

procedure TJLocation.setProvider(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setProvider', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocation.setSpeed(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSpeed', '(F)V', [AArg0]);
end;

procedure TJLocation.setSpeedAccuracyMetersPerSecond(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSpeedAccuracyMetersPerSecond', '(F)V', [AArg0]);
end;

procedure TJLocation.setTime(const AArg0: Int64);
begin
  JavaType.CallVoidMethod(ObjectID, 'setTime', '(J)V', [AArg0]);
end;

procedure TJLocation.setVerticalAccuracyMeters(const AArg0: Single);
begin
  JavaType.CallVoidMethod(ObjectID, 'setVerticalAccuracyMeters', '(F)V', [AArg0]);
end;

function TJLocation.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssNavigationMessage }

class procedure TJGnssNavigationMessage.LoadConstructors;
begin
end;

class procedure TJGnssNavigationMessage.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('getData', '()[B');
  AddMethod('getMessageId', '()I');
  AddMethod('getStatus', '()I');
  AddMethod('getSubmessageId', '()I');
  AddMethod('getSvid', '()I');
  AddMethod('getType', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJGnssNavigationMessage.LoadFields;
begin
  inherited;
  AddStaticField('STATUS_PARITY_PASSED', 'I');
  AddStaticField('STATUS_PARITY_REBUILT', 'I');
  AddStaticField('STATUS_UNKNOWN', 'I');
  AddStaticField('TYPE_BDS_D1', 'I');
  AddStaticField('TYPE_BDS_D2', 'I');
  AddStaticField('TYPE_GAL_F', 'I');
  AddStaticField('TYPE_GAL_I', 'I');
  AddStaticField('TYPE_GLO_L1CA', 'I');
  AddStaticField('TYPE_GPS_CNAV2', 'I');
  AddStaticField('TYPE_GPS_L1CA', 'I');
  AddStaticField('TYPE_GPS_L2CNAV', 'I');
  AddStaticField('TYPE_GPS_L5CNAV', 'I');
  AddStaticField('TYPE_UNKNOWN', 'I');
end;

class function TJGnssNavigationMessage.Wrap(const AObjectID: JNIObject): JGnssNavigationMessage;
begin
  Result := Wrap<TJGnssNavigationMessage, JGnssNavigationMessage>(AObjectId);
end;

class function TJGnssNavigationMessage.Wrap(const AObject: IJNIObject): JGnssNavigationMessage;
begin
  Result := Wrap<TJGnssNavigationMessage, JGnssNavigationMessage>(AObject);
end;

class function TJGnssNavigationMessage.STATUS_PARITY_PASSED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_PARITY_PASSED');
end;

class function TJGnssNavigationMessage.STATUS_PARITY_REBUILT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_PARITY_REBUILT');
end;

class function TJGnssNavigationMessage.STATUS_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_UNKNOWN');
end;

class function TJGnssNavigationMessage.TYPE_BDS_D1: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_D1');
end;

class function TJGnssNavigationMessage.TYPE_BDS_D2: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_D2');
end;

class function TJGnssNavigationMessage.TYPE_GAL_F: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GAL_F');
end;

class function TJGnssNavigationMessage.TYPE_GAL_I: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GAL_I');
end;

class function TJGnssNavigationMessage.TYPE_GLO_L1CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GLO_L1CA');
end;

class function TJGnssNavigationMessage.TYPE_GPS_CNAV2: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_CNAV2');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L1CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L1CA');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L2CNAV: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L2CNAV');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L5CNAV: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L5CNAV');
end;

class function TJGnssNavigationMessage.TYPE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_UNKNOWN');
end;

function TJGnssNavigationMessage.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssNavigationMessage.getData: IJavaArray<Byte>;
begin
  Result := CallArrayMethod<Byte>('getData', '()[B', []);
end;

function TJGnssNavigationMessage.getMessageId: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getMessageId', '()I', []);
end;

function TJGnssNavigationMessage.getStatus: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getStatus', '()I', []);
end;

function TJGnssNavigationMessage.getSubmessageId: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSubmessageId', '()I', []);
end;

function TJGnssNavigationMessage.getSvid: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSvid', '()I', []);
end;

function TJGnssNavigationMessage.getType: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getType', '()I', []);
end;

function TJGnssNavigationMessage.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGpsSatellite }

class procedure TJGpsSatellite.LoadConstructors;
begin
end;

class procedure TJGpsSatellite.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getAzimuth', '()F');
  AddMethod('getElevation', '()F');
  AddMethod('getPrn', '()I');
  AddMethod('getSnr', '()F');
  AddMethod('hasAlmanac', '()Z');
  AddMethod('hasEphemeris', '()Z');
  AddMethod('usedInFix', '()Z');
end;

class function TJGpsSatellite.Wrap(const AObjectID: JNIObject): JGpsSatellite;
begin
  Result := Wrap<TJGpsSatellite, JGpsSatellite>(AObjectId);
end;

class function TJGpsSatellite.Wrap(const AObject: IJNIObject): JGpsSatellite;
begin
  Result := Wrap<TJGpsSatellite, JGpsSatellite>(AObject);
end;

function TJGpsSatellite.getAzimuth: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getAzimuth', '()F', []);
end;

function TJGpsSatellite.getElevation: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getElevation', '()F', []);
end;

function TJGpsSatellite.getPrn: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getPrn', '()I', []);
end;

function TJGpsSatellite.getSnr: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getSnr', '()F', []);
end;

function TJGpsSatellite.hasAlmanac: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAlmanac', '()Z', []);
end;

function TJGpsSatellite.hasEphemeris: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasEphemeris', '()Z', []);
end;

function TJGpsSatellite.usedInFix: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'usedInFix', '()Z', []);
end;

{ TJLocationProvider }

class procedure TJLocationProvider.LoadConstructors;
begin
end;

class procedure TJLocationProvider.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getAccuracy', '()I');
  AddMethod('getName', '()Ljava/lang/String;');
  AddMethod('getPowerRequirement', '()I');
  AddMethod('hasMonetaryCost', '()Z');
  AddMethod('meetsCriteria', '(Landroid/location/Criteria;)Z');
  AddMethod('requiresCell', '()Z');
  AddMethod('requiresNetwork', '()Z');
  AddMethod('requiresSatellite', '()Z');
  AddMethod('supportsAltitude', '()Z');
  AddMethod('supportsBearing', '()Z');
  AddMethod('supportsSpeed', '()Z');
end;

class procedure TJLocationProvider.LoadFields;
begin
  inherited;
  AddStaticField('AVAILABLE', 'I');
  AddStaticField('OUT_OF_SERVICE', 'I');
  AddStaticField('TEMPORARILY_UNAVAILABLE', 'I');
end;

class function TJLocationProvider.Wrap(const AObjectID: JNIObject): JLocationProvider;
begin
  Result := Wrap<TJLocationProvider, JLocationProvider>(AObjectId);
end;

class function TJLocationProvider.Wrap(const AObject: IJNIObject): JLocationProvider;
begin
  Result := Wrap<TJLocationProvider, JLocationProvider>(AObject);
end;

class function TJLocationProvider.AVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('AVAILABLE');
end;

class function TJLocationProvider.OUT_OF_SERVICE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('OUT_OF_SERVICE');
end;

class function TJLocationProvider.TEMPORARILY_UNAVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TEMPORARILY_UNAVAILABLE');
end;

function TJLocationProvider.getAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getAccuracy', '()I', []);
end;

function TJLocationProvider.getName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getName', '()Ljava/lang/String;', []);
end;

function TJLocationProvider.getPowerRequirement: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getPowerRequirement', '()I', []);
end;

function TJLocationProvider.hasMonetaryCost: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasMonetaryCost', '()Z', []);
end;

function TJLocationProvider.meetsCriteria(const AArg0: JCriteria): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'meetsCriteria', '(Landroid/location/Criteria;)Z', [AArg0]);
end;

function TJLocationProvider.requiresCell: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'requiresCell', '()Z', []);
end;

function TJLocationProvider.requiresNetwork: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'requiresNetwork', '()Z', []);
end;

function TJLocationProvider.requiresSatellite: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'requiresSatellite', '()Z', []);
end;

function TJLocationProvider.supportsAltitude: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'supportsAltitude', '()Z', []);
end;

function TJLocationProvider.supportsBearing: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'supportsBearing', '()Z', []);
end;

function TJLocationProvider.supportsSpeed: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'supportsSpeed', '()Z', []);
end;

{ TJLocationListener }

class procedure TJLocationListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onLocationChanged', '(Landroid/location/Location;)V');
  AddMethod('onProviderDisabled', '(Ljava/lang/String;)V');
  AddMethod('onProviderEnabled', '(Ljava/lang/String;)V');
  AddMethod('onStatusChanged', '(Ljava/lang/String;ILandroid/os/Bundle;)V');
end;

class function TJLocationListener.Wrap(const AObjectID: JNIObject): JLocationListener;
begin
  Result := Wrap<TJLocationListener, JLocationListener>(AObjectId);
end;

class function TJLocationListener.Wrap(const AObject: IJNIObject): JLocationListener;
begin
  Result := Wrap<TJLocationListener, JLocationListener>(AObject);
end;

procedure TJLocationListener.onLocationChanged(const AArg0: JLocation);
begin
  JavaType.CallVoidMethod(ObjectID, 'onLocationChanged', '(Landroid/location/Location;)V', [AArg0]);
end;

procedure TJLocationListener.onProviderDisabled(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'onProviderDisabled', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocationListener.onProviderEnabled(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'onProviderEnabled', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocationListener.onStatusChanged(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStatusChanged', '(Ljava/lang/String;ILandroid/os/Bundle;)V', [AArg0, AArg1, AArg2]);
end;

{ TJGnssClock }

class procedure TJGnssClock.LoadConstructors;
begin
end;

class procedure TJGnssClock.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('getBiasNanos', '()D');
  AddMethod('getBiasUncertaintyNanos', '()D');
  AddMethod('getDriftNanosPerSecond', '()D');
  AddMethod('getDriftUncertaintyNanosPerSecond', '()D');
  AddMethod('getFullBiasNanos', '()J');
  AddMethod('getHardwareClockDiscontinuityCount', '()I');
  AddMethod('getLeapSecond', '()I');
  AddMethod('getTimeNanos', '()J');
  AddMethod('getTimeUncertaintyNanos', '()D');
  AddMethod('hasBiasNanos', '()Z');
  AddMethod('hasBiasUncertaintyNanos', '()Z');
  AddMethod('hasDriftNanosPerSecond', '()Z');
  AddMethod('hasDriftUncertaintyNanosPerSecond', '()Z');
  AddMethod('hasFullBiasNanos', '()Z');
  AddMethod('hasLeapSecond', '()Z');
  AddMethod('hasTimeUncertaintyNanos', '()Z');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssClock.Wrap(const AObjectID: JNIObject): JGnssClock;
begin
  Result := Wrap<TJGnssClock, JGnssClock>(AObjectId);
end;

class function TJGnssClock.Wrap(const AObject: IJNIObject): JGnssClock;
begin
  Result := Wrap<TJGnssClock, JGnssClock>(AObject);
end;

function TJGnssClock.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssClock.getBiasNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getBiasNanos', '()D', []);
end;

function TJGnssClock.getBiasUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getBiasUncertaintyNanos', '()D', []);
end;

function TJGnssClock.getDriftNanosPerSecond: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getDriftNanosPerSecond', '()D', []);
end;

function TJGnssClock.getDriftUncertaintyNanosPerSecond: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getDriftUncertaintyNanosPerSecond', '()D', []);
end;

function TJGnssClock.getFullBiasNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getFullBiasNanos', '()J', []);
end;

function TJGnssClock.getHardwareClockDiscontinuityCount: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getHardwareClockDiscontinuityCount', '()I', []);
end;

function TJGnssClock.getLeapSecond: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getLeapSecond', '()I', []);
end;

function TJGnssClock.getTimeNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getTimeNanos', '()J', []);
end;

function TJGnssClock.getTimeUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getTimeUncertaintyNanos', '()D', []);
end;

function TJGnssClock.hasBiasNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBiasNanos', '()Z', []);
end;

function TJGnssClock.hasBiasUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBiasUncertaintyNanos', '()Z', []);
end;

function TJGnssClock.hasDriftNanosPerSecond: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasDriftNanosPerSecond', '()Z', []);
end;

function TJGnssClock.hasDriftUncertaintyNanosPerSecond: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasDriftUncertaintyNanosPerSecond', '()Z', []);
end;

function TJGnssClock.hasFullBiasNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasFullBiasNanos', '()Z', []);
end;

function TJGnssClock.hasLeapSecond: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasLeapSecond', '()Z', []);
end;

function TJGnssClock.hasTimeUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasTimeUncertaintyNanos', '()Z', []);
end;

function TJGnssClock.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssMeasurementsEvent_Callback }

class procedure TJGnssMeasurementsEvent_Callback.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJGnssMeasurementsEvent_Callback.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onGnssMeasurementsReceived', '(Landroid/location/GnssMeasurementsEvent;)V');
  AddMethod('onStatusChanged', '(I)V');
end;

class procedure TJGnssMeasurementsEvent_Callback.LoadFields;
begin
  inherited;
  AddStaticField('STATUS_LOCATION_DISABLED', 'I');
  AddStaticField('STATUS_NOT_SUPPORTED', 'I');
  AddStaticField('STATUS_READY', 'I');
end;

class function TJGnssMeasurementsEvent_Callback.Wrap(const AObjectID: JNIObject): JGnssMeasurementsEvent_Callback;
begin
  Result := Wrap<TJGnssMeasurementsEvent_Callback, JGnssMeasurementsEvent_Callback>(AObjectId);
end;

class function TJGnssMeasurementsEvent_Callback.Wrap(const AObject: IJNIObject): JGnssMeasurementsEvent_Callback;
begin
  Result := Wrap<TJGnssMeasurementsEvent_Callback, JGnssMeasurementsEvent_Callback>(AObject);
end;

class function TJGnssMeasurementsEvent_Callback.Create: JGnssMeasurementsEvent_Callback;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_LOCATION_DISABLED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_LOCATION_DISABLED');
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_NOT_SUPPORTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_NOT_SUPPORTED');
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_READY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_READY');
end;

procedure TJGnssMeasurementsEvent_Callback.onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGnssMeasurementsReceived', '(Landroid/location/GnssMeasurementsEvent;)V', [AArg0]);
end;

procedure TJGnssMeasurementsEvent_Callback.onStatusChanged(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStatusChanged', '(I)V', [AArg0]);
end;

{ TJGnssMeasurementsEvent }

class procedure TJGnssMeasurementsEvent.LoadConstructors;
begin
end;

class procedure TJGnssMeasurementsEvent.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('getClock', '()Landroid/location/GnssClock;');
  AddMethod('getMeasurements', '()Ljava/util/Collection;');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssMeasurementsEvent.Wrap(const AObjectID: JNIObject): JGnssMeasurementsEvent;
begin
  Result := Wrap<TJGnssMeasurementsEvent, JGnssMeasurementsEvent>(AObjectId);
end;

class function TJGnssMeasurementsEvent.Wrap(const AObject: IJNIObject): JGnssMeasurementsEvent;
begin
  Result := Wrap<TJGnssMeasurementsEvent, JGnssMeasurementsEvent>(AObject);
end;

function TJGnssMeasurementsEvent.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssMeasurementsEvent.getClock: JGnssClock;
begin
  Result := CallObjectMethod<TJGnssClock, JGnssClock>('getClock', '()Landroid/location/GnssClock;', []);
end;

function TJGnssMeasurementsEvent.getMeasurements: JCollection;
begin
  Result := CallObjectMethod<TJCollection, JCollection>('getMeasurements', '()Ljava/util/Collection;', []);
end;

function TJGnssMeasurementsEvent.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGeocoder }

class procedure TJGeocoder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(Landroid/content/Context;Ljava/util/Locale;)V');
  AddMethod('<init>', '(Landroid/content/Context;)V');
end;

class procedure TJGeocoder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getFromLocation', '(DDI)Ljava/util/List;');
  AddMethod('getFromLocationName', '(Ljava/lang/String;IDDDD)Ljava/util/List;');
  AddMethod('getFromLocationName', '(Ljava/lang/String;I)Ljava/util/List;');
  AddStaticMethod('isPresent', '()Z');
end;

class function TJGeocoder.Wrap(const AObjectID: JNIObject): JGeocoder;
begin
  Result := Wrap<TJGeocoder, JGeocoder>(AObjectId);
end;

class function TJGeocoder.Wrap(const AObject: IJNIObject): JGeocoder;
begin
  Result := Wrap<TJGeocoder, JGeocoder>(AObject);
end;

class function TJGeocoder.Create(const AArg0: JContext; const AArg1: JLocale): JGeocoder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/content/Context;Ljava/util/Locale;)V', [AArg0, AArg1]);
  Result := O;
end;

class function TJGeocoder.Create(const AArg0: JContext): JGeocoder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/content/Context;)V', [AArg0]);
  Result := O;
end;

function TJGeocoder.getFromLocation(const AArg0: Double; const AArg1: Double; const AArg2: Integer): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getFromLocation', '(DDI)Ljava/util/List;', [WrapDouble(AArg0), WrapDouble(AArg1), AArg2]);
end;

function TJGeocoder.getFromLocationName(const AArg0: JString; const AArg1: Integer; const AArg2: Double; const AArg3: Double; const AArg4: Double; const AArg5: Double): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getFromLocationName', '(Ljava/lang/String;IDDDD)Ljava/util/List;', [AArg0, AArg1, WrapDouble(AArg2), WrapDouble(AArg3), WrapDouble(AArg4), WrapDouble(AArg5)]);
end;

function TJGeocoder.getFromLocationName(const AArg0: JString; const AArg1: Integer): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getFromLocationName', '(Ljava/lang/String;I)Ljava/util/List;', [AArg0, AArg1]);
end;

class function TJGeocoder.isPresent: Boolean;
begin
  Result := StaticJavaType[Self].CallStaticBooleanMethod('isPresent', '()Z', []);
end;

{ TJSettingInjectorService }

class procedure TJSettingInjectorService.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(Ljava/lang/String;)V');
end;

class procedure TJSettingInjectorService.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onBind', '(Landroid/content/Intent;)Landroid/os/IBinder;');
  AddMethod('onStart', '(Landroid/content/Intent;I)V');
  AddMethod('onStartCommand', '(Landroid/content/Intent;II)I');
end;

class procedure TJSettingInjectorService.LoadFields;
begin
  inherited;
  AddStaticField('ACTION_INJECTED_SETTING_CHANGED', 'Ljava/lang/String;');
  AddStaticField('ACTION_SERVICE_INTENT', 'Ljava/lang/String;');
  AddStaticField('ATTRIBUTES_NAME', 'Ljava/lang/String;');
  AddStaticField('META_DATA_NAME', 'Ljava/lang/String;');
end;

class function TJSettingInjectorService.Wrap(const AObjectID: JNIObject): JSettingInjectorService;
begin
  Result := Wrap<TJSettingInjectorService, JSettingInjectorService>(AObjectId);
end;

class function TJSettingInjectorService.Wrap(const AObject: IJNIObject): JSettingInjectorService;
begin
  Result := Wrap<TJSettingInjectorService, JSettingInjectorService>(AObject);
end;

class function TJSettingInjectorService.Create(const AArg0: JString): JSettingInjectorService;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/lang/String;)V', [AArg0]);
  Result := O;
end;

class function TJSettingInjectorService.ACTION_INJECTED_SETTING_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_INJECTED_SETTING_CHANGED');
end;

class function TJSettingInjectorService.ACTION_SERVICE_INTENT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_SERVICE_INTENT');
end;

class function TJSettingInjectorService.ATTRIBUTES_NAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ATTRIBUTES_NAME');
end;

class function TJSettingInjectorService.META_DATA_NAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('META_DATA_NAME');
end;

function TJSettingInjectorService.onBind(const AArg0: JIntent): JIBinder;
begin
  Result := CallObjectMethod<TJIBinder, JIBinder>('onBind', '(Landroid/content/Intent;)Landroid/os/IBinder;', [AArg0]);
end;

procedure TJSettingInjectorService.onStart(const AArg0: JIntent; const AArg1: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStart', '(Landroid/content/Intent;I)V', [AArg0, AArg1]);
end;

function TJSettingInjectorService.onStartCommand(const AArg0: JIntent; const AArg1: Integer; const AArg2: Integer): Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'onStartCommand', '(Landroid/content/Intent;II)I', [AArg0, AArg1, AArg2]);
end;

{ TJGpsStatus_NmeaListener }

class procedure TJGpsStatus_NmeaListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onNmeaReceived', '(JLjava/lang/String;)V');
end;

class function TJGpsStatus_NmeaListener.Wrap(const AObjectID: JNIObject): JGpsStatus_NmeaListener;
begin
  Result := Wrap<TJGpsStatus_NmeaListener, JGpsStatus_NmeaListener>(AObjectId);
end;

class function TJGpsStatus_NmeaListener.Wrap(const AObject: IJNIObject): JGpsStatus_NmeaListener;
begin
  Result := Wrap<TJGpsStatus_NmeaListener, JGpsStatus_NmeaListener>(AObject);
end;

procedure TJGpsStatus_NmeaListener.onNmeaReceived(const AArg0: Int64; const AArg1: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'onNmeaReceived', '(JLjava/lang/String;)V', [AArg0, AArg1]);
end;

{ TJGnssStatus }

class procedure TJGnssStatus.LoadConstructors;
begin
end;

class procedure TJGnssStatus.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getAzimuthDegrees', '(I)F');
  AddMethod('getCarrierFrequencyHz', '(I)F');
  AddMethod('getCn0DbHz', '(I)F');
  AddMethod('getConstellationType', '(I)I');
  AddMethod('getElevationDegrees', '(I)F');
  AddMethod('getSatelliteCount', '()I');
  AddMethod('getSvid', '(I)I');
  AddMethod('hasAlmanacData', '(I)Z');
  AddMethod('hasCarrierFrequencyHz', '(I)Z');
  AddMethod('hasEphemerisData', '(I)Z');
  AddMethod('usedInFix', '(I)Z');
end;

class procedure TJGnssStatus.LoadFields;
begin
  inherited;
  AddStaticField('CONSTELLATION_BEIDOU', 'I');
  AddStaticField('CONSTELLATION_GALILEO', 'I');
  AddStaticField('CONSTELLATION_GLONASS', 'I');
  AddStaticField('CONSTELLATION_GPS', 'I');
  AddStaticField('CONSTELLATION_QZSS', 'I');
  AddStaticField('CONSTELLATION_SBAS', 'I');
  AddStaticField('CONSTELLATION_UNKNOWN', 'I');
end;

class function TJGnssStatus.Wrap(const AObjectID: JNIObject): JGnssStatus;
begin
  Result := Wrap<TJGnssStatus, JGnssStatus>(AObjectId);
end;

class function TJGnssStatus.Wrap(const AObject: IJNIObject): JGnssStatus;
begin
  Result := Wrap<TJGnssStatus, JGnssStatus>(AObject);
end;

class function TJGnssStatus.CONSTELLATION_BEIDOU: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_BEIDOU');
end;

class function TJGnssStatus.CONSTELLATION_GALILEO: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GALILEO');
end;

class function TJGnssStatus.CONSTELLATION_GLONASS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GLONASS');
end;

class function TJGnssStatus.CONSTELLATION_GPS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GPS');
end;

class function TJGnssStatus.CONSTELLATION_QZSS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_QZSS');
end;

class function TJGnssStatus.CONSTELLATION_SBAS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_SBAS');
end;

class function TJGnssStatus.CONSTELLATION_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_UNKNOWN');
end;

function TJGnssStatus.getAzimuthDegrees(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getAzimuthDegrees', '(I)F', [AArg0]);
end;

function TJGnssStatus.getCarrierFrequencyHz(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getCarrierFrequencyHz', '(I)F', [AArg0]);
end;

function TJGnssStatus.getCn0DbHz(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getCn0DbHz', '(I)F', [AArg0]);
end;

function TJGnssStatus.getConstellationType(const AArg0: Integer): Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getConstellationType', '(I)I', [AArg0]);
end;

function TJGnssStatus.getElevationDegrees(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getElevationDegrees', '(I)F', [AArg0]);
end;

function TJGnssStatus.getSatelliteCount: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSatelliteCount', '()I', []);
end;

function TJGnssStatus.getSvid(const AArg0: Integer): Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSvid', '(I)I', [AArg0]);
end;

function TJGnssStatus.hasAlmanacData(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAlmanacData', '(I)Z', [AArg0]);
end;

function TJGnssStatus.hasCarrierFrequencyHz(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierFrequencyHz', '(I)Z', [AArg0]);
end;

function TJGnssStatus.hasEphemerisData(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasEphemerisData', '(I)Z', [AArg0]);
end;

function TJGnssStatus.usedInFix(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'usedInFix', '(I)Z', [AArg0]);
end;

{ TJGpsStatus }

class procedure TJGpsStatus.LoadConstructors;
begin
end;

class procedure TJGpsStatus.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getMaxSatellites', '()I');
  AddMethod('getSatellites', '()Ljava/lang/Iterable;');
  AddMethod('getTimeToFirstFix', '()I');
end;

class procedure TJGpsStatus.LoadFields;
begin
  inherited;
  AddStaticField('GPS_EVENT_FIRST_FIX', 'I');
  AddStaticField('GPS_EVENT_SATELLITE_STATUS', 'I');
  AddStaticField('GPS_EVENT_STARTED', 'I');
  AddStaticField('GPS_EVENT_STOPPED', 'I');
end;

class function TJGpsStatus.Wrap(const AObjectID: JNIObject): JGpsStatus;
begin
  Result := Wrap<TJGpsStatus, JGpsStatus>(AObjectId);
end;

class function TJGpsStatus.Wrap(const AObject: IJNIObject): JGpsStatus;
begin
  Result := Wrap<TJGpsStatus, JGpsStatus>(AObject);
end;

class function TJGpsStatus.GPS_EVENT_FIRST_FIX: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_FIRST_FIX');
end;

class function TJGpsStatus.GPS_EVENT_SATELLITE_STATUS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_SATELLITE_STATUS');
end;

class function TJGpsStatus.GPS_EVENT_STARTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_STARTED');
end;

class function TJGpsStatus.GPS_EVENT_STOPPED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_STOPPED');
end;

function TJGpsStatus.getMaxSatellites: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getMaxSatellites', '()I', []);
end;

function TJGpsStatus.getSatellites: JIterable;
begin
  Result := CallObjectMethod<TJIterable, JIterable>('getSatellites', '()Ljava/lang/Iterable;', []);
end;

function TJGpsStatus.getTimeToFirstFix: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getTimeToFirstFix', '()I', []);
end;

{ TJGnssMeasurement }

class procedure TJGnssMeasurement.LoadConstructors;
begin
end;

class procedure TJGnssMeasurement.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('getAccumulatedDeltaRangeMeters', '()D');
  AddMethod('getAccumulatedDeltaRangeState', '()I');
  AddMethod('getAccumulatedDeltaRangeUncertaintyMeters', '()D');
  AddMethod('getAutomaticGainControlLevelDb', '()D');
  AddMethod('getCarrierCycles', '()J');
  AddMethod('getCarrierFrequencyHz', '()F');
  AddMethod('getCarrierPhase', '()D');
  AddMethod('getCarrierPhaseUncertainty', '()D');
  AddMethod('getCn0DbHz', '()D');
  AddMethod('getConstellationType', '()I');
  AddMethod('getMultipathIndicator', '()I');
  AddMethod('getPseudorangeRateMetersPerSecond', '()D');
  AddMethod('getPseudorangeRateUncertaintyMetersPerSecond', '()D');
  AddMethod('getReceivedSvTimeNanos', '()J');
  AddMethod('getReceivedSvTimeUncertaintyNanos', '()J');
  AddMethod('getSnrInDb', '()D');
  AddMethod('getState', '()I');
  AddMethod('getSvid', '()I');
  AddMethod('getTimeOffsetNanos', '()D');
  AddMethod('hasAutomaticGainControlLevelDb', '()Z');
  AddMethod('hasCarrierCycles', '()Z');
  AddMethod('hasCarrierFrequencyHz', '()Z');
  AddMethod('hasCarrierPhase', '()Z');
  AddMethod('hasCarrierPhaseUncertainty', '()Z');
  AddMethod('hasSnrInDb', '()Z');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJGnssMeasurement.LoadFields;
begin
  inherited;
  AddStaticField('ADR_STATE_CYCLE_SLIP', 'I');
  AddStaticField('ADR_STATE_RESET', 'I');
  AddStaticField('ADR_STATE_UNKNOWN', 'I');
  AddStaticField('ADR_STATE_VALID', 'I');
  AddStaticField('MULTIPATH_INDICATOR_DETECTED', 'I');
  AddStaticField('MULTIPATH_INDICATOR_NOT_DETECTED', 'I');
  AddStaticField('MULTIPATH_INDICATOR_UNKNOWN', 'I');
  AddStaticField('STATE_BDS_D2_BIT_SYNC', 'I');
  AddStaticField('STATE_BDS_D2_SUBFRAME_SYNC', 'I');
  AddStaticField('STATE_BIT_SYNC', 'I');
  AddStaticField('STATE_CODE_LOCK', 'I');
  AddStaticField('STATE_GAL_E1BC_CODE_LOCK', 'I');
  AddStaticField('STATE_GAL_E1B_PAGE_SYNC', 'I');
  AddStaticField('STATE_GAL_E1C_2ND_CODE_LOCK', 'I');
  AddStaticField('STATE_GLO_STRING_SYNC', 'I');
  AddStaticField('STATE_GLO_TOD_DECODED', 'I');
  AddStaticField('STATE_GLO_TOD_KNOWN', 'I');
  AddStaticField('STATE_MSEC_AMBIGUOUS', 'I');
  AddStaticField('STATE_SBAS_SYNC', 'I');
  AddStaticField('STATE_SUBFRAME_SYNC', 'I');
  AddStaticField('STATE_SYMBOL_SYNC', 'I');
  AddStaticField('STATE_TOW_DECODED', 'I');
  AddStaticField('STATE_TOW_KNOWN', 'I');
  AddStaticField('STATE_UNKNOWN', 'I');
end;

class function TJGnssMeasurement.Wrap(const AObjectID: JNIObject): JGnssMeasurement;
begin
  Result := Wrap<TJGnssMeasurement, JGnssMeasurement>(AObjectId);
end;

class function TJGnssMeasurement.Wrap(const AObject: IJNIObject): JGnssMeasurement;
begin
  Result := Wrap<TJGnssMeasurement, JGnssMeasurement>(AObject);
end;

class function TJGnssMeasurement.ADR_STATE_CYCLE_SLIP: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_CYCLE_SLIP');
end;

class function TJGnssMeasurement.ADR_STATE_RESET: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_RESET');
end;

class function TJGnssMeasurement.ADR_STATE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_UNKNOWN');
end;

class function TJGnssMeasurement.ADR_STATE_VALID: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_VALID');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_DETECTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_DETECTED');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_NOT_DETECTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_NOT_DETECTED');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_UNKNOWN');
end;

class function TJGnssMeasurement.STATE_BDS_D2_BIT_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BDS_D2_BIT_SYNC');
end;

class function TJGnssMeasurement.STATE_BDS_D2_SUBFRAME_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BDS_D2_SUBFRAME_SYNC');
end;

class function TJGnssMeasurement.STATE_BIT_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BIT_SYNC');
end;

class function TJGnssMeasurement.STATE_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_CODE_LOCK');
end;

class function TJGnssMeasurement.STATE_GAL_E1BC_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1BC_CODE_LOCK');
end;

class function TJGnssMeasurement.STATE_GAL_E1B_PAGE_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1B_PAGE_SYNC');
end;

class function TJGnssMeasurement.STATE_GAL_E1C_2ND_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1C_2ND_CODE_LOCK');
end;

class function TJGnssMeasurement.STATE_GLO_STRING_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_STRING_SYNC');
end;

class function TJGnssMeasurement.STATE_GLO_TOD_DECODED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_TOD_DECODED');
end;

class function TJGnssMeasurement.STATE_GLO_TOD_KNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_TOD_KNOWN');
end;

class function TJGnssMeasurement.STATE_MSEC_AMBIGUOUS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_MSEC_AMBIGUOUS');
end;

class function TJGnssMeasurement.STATE_SBAS_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SBAS_SYNC');
end;

class function TJGnssMeasurement.STATE_SUBFRAME_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SUBFRAME_SYNC');
end;

class function TJGnssMeasurement.STATE_SYMBOL_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SYMBOL_SYNC');
end;

class function TJGnssMeasurement.STATE_TOW_DECODED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_TOW_DECODED');
end;

class function TJGnssMeasurement.STATE_TOW_KNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_TOW_KNOWN');
end;

class function TJGnssMeasurement.STATE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_UNKNOWN');
end;

function TJGnssMeasurement.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssMeasurement.getAccumulatedDeltaRangeMeters: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAccumulatedDeltaRangeMeters', '()D', []);
end;

function TJGnssMeasurement.getAccumulatedDeltaRangeState: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getAccumulatedDeltaRangeState', '()I', []);
end;

function TJGnssMeasurement.getAccumulatedDeltaRangeUncertaintyMeters: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAccumulatedDeltaRangeUncertaintyMeters', '()D', []);
end;

function TJGnssMeasurement.getAutomaticGainControlLevelDb: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAutomaticGainControlLevelDb', '()D', []);
end;

function TJGnssMeasurement.getCarrierCycles: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getCarrierCycles', '()J', []);
end;

function TJGnssMeasurement.getCarrierFrequencyHz: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getCarrierFrequencyHz', '()F', []);
end;

function TJGnssMeasurement.getCarrierPhase: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getCarrierPhase', '()D', []);
end;

function TJGnssMeasurement.getCarrierPhaseUncertainty: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getCarrierPhaseUncertainty', '()D', []);
end;

function TJGnssMeasurement.getCn0DbHz: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getCn0DbHz', '()D', []);
end;

function TJGnssMeasurement.getConstellationType: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getConstellationType', '()I', []);
end;

function TJGnssMeasurement.getMultipathIndicator: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getMultipathIndicator', '()I', []);
end;

function TJGnssMeasurement.getPseudorangeRateMetersPerSecond: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getPseudorangeRateMetersPerSecond', '()D', []);
end;

function TJGnssMeasurement.getPseudorangeRateUncertaintyMetersPerSecond: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getPseudorangeRateUncertaintyMetersPerSecond', '()D', []);
end;

function TJGnssMeasurement.getReceivedSvTimeNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getReceivedSvTimeNanos', '()J', []);
end;

function TJGnssMeasurement.getReceivedSvTimeUncertaintyNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getReceivedSvTimeUncertaintyNanos', '()J', []);
end;

function TJGnssMeasurement.getSnrInDb: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getSnrInDb', '()D', []);
end;

function TJGnssMeasurement.getState: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getState', '()I', []);
end;

function TJGnssMeasurement.getSvid: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getSvid', '()I', []);
end;

function TJGnssMeasurement.getTimeOffsetNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getTimeOffsetNanos', '()D', []);
end;

function TJGnssMeasurement.hasAutomaticGainControlLevelDb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAutomaticGainControlLevelDb', '()Z', []);
end;

function TJGnssMeasurement.hasCarrierCycles: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierCycles', '()Z', []);
end;

function TJGnssMeasurement.hasCarrierFrequencyHz: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierFrequencyHz', '()Z', []);
end;

function TJGnssMeasurement.hasCarrierPhase: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierPhase', '()Z', []);
end;

function TJGnssMeasurement.hasCarrierPhaseUncertainty: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierPhaseUncertainty', '()Z', []);
end;

function TJGnssMeasurement.hasSnrInDb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSnrInDb', '()Z', []);
end;

function TJGnssMeasurement.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJOnNmeaMessageListener }

class procedure TJOnNmeaMessageListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onNmeaMessage', '(Ljava/lang/String;J)V');
end;

class function TJOnNmeaMessageListener.Wrap(const AObjectID: JNIObject): JOnNmeaMessageListener;
begin
  Result := Wrap<TJOnNmeaMessageListener, JOnNmeaMessageListener>(AObjectId);
end;

class function TJOnNmeaMessageListener.Wrap(const AObject: IJNIObject): JOnNmeaMessageListener;
begin
  Result := Wrap<TJOnNmeaMessageListener, JOnNmeaMessageListener>(AObject);
end;

procedure TJOnNmeaMessageListener.onNmeaMessage(const AArg0: JString; const AArg1: Int64);
begin
  JavaType.CallVoidMethod(ObjectID, 'onNmeaMessage', '(Ljava/lang/String;J)V', [AArg0, AArg1]);
end;

{ TJLocationManager }

class procedure TJLocationManager.LoadConstructors;
begin
end;

class procedure TJLocationManager.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('addGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/OnNmeaMessageListener;Landroid/os/Handler;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/OnNmeaMessageListener;)Z');
  AddMethod('addProximityAlert', '(DDFJLandroid/app/PendingIntent;)V');
  AddMethod('addTestProvider', '(Ljava/lang/String;ZZZZZZZII)V');
  AddMethod('clearTestProviderEnabled', '(Ljava/lang/String;)V');
  AddMethod('clearTestProviderLocation', '(Ljava/lang/String;)V');
  AddMethod('clearTestProviderStatus', '(Ljava/lang/String;)V');
  AddMethod('getAllProviders', '()Ljava/util/List;');
  AddMethod('getBestProvider', '(Landroid/location/Criteria;Z)Ljava/lang/String;');
  AddMethod('getGpsStatus', '(Landroid/location/GpsStatus;)Landroid/location/GpsStatus;');
  AddMethod('getLastKnownLocation', '(Ljava/lang/String;)Landroid/location/Location;');
  AddMethod('getProvider', '(Ljava/lang/String;)Landroid/location/LocationProvider;');
  AddMethod('getProviders', '(Z)Ljava/util/List;');
  AddMethod('getProviders', '(Landroid/location/Criteria;Z)Ljava/util/List;');
  AddMethod('isProviderEnabled', '(Ljava/lang/String;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)Z');
  AddMethod('registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)Z');
  AddMethod('removeGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)V');
  AddMethod('removeNmeaListener', '(Landroid/location/OnNmeaMessageListener;)V');
  AddMethod('removeNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)V');
  AddMethod('removeProximityAlert', '(Landroid/app/PendingIntent;)V');
  AddMethod('removeTestProvider', '(Ljava/lang/String;)V');
  AddMethod('removeUpdates', '(Landroid/app/PendingIntent;)V');
  AddMethod('removeUpdates', '(Landroid/location/LocationListener;)V');
  AddMethod('requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/app/PendingIntent;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/app/PendingIntent;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestSingleUpdate', '(Ljava/lang/String;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestSingleUpdate', '(Landroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestSingleUpdate', '(Landroid/location/Criteria;Landroid/app/PendingIntent;)V');
  AddMethod('requestSingleUpdate', '(Ljava/lang/String;Landroid/app/PendingIntent;)V');
  AddMethod('sendExtraCommand', '(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Z');
  AddMethod('setTestProviderEnabled', '(Ljava/lang/String;Z)V');
  AddMethod('setTestProviderLocation', '(Ljava/lang/String;Landroid/location/Location;)V');
  AddMethod('setTestProviderStatus', '(Ljava/lang/String;ILandroid/os/Bundle;J)V');
  AddMethod('unregisterGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)V');
  AddMethod('unregisterGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)V');
  AddMethod('unregisterGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)V');
end;

class procedure TJLocationManager.LoadFields;
begin
  inherited;
  AddStaticField('GPS_PROVIDER', 'Ljava/lang/String;');
  AddStaticField('KEY_LOCATION_CHANGED', 'Ljava/lang/String;');
  AddStaticField('KEY_PROVIDER_ENABLED', 'Ljava/lang/String;');
  AddStaticField('KEY_PROXIMITY_ENTERING', 'Ljava/lang/String;');
  AddStaticField('KEY_STATUS_CHANGED', 'Ljava/lang/String;');
  AddStaticField('MODE_CHANGED_ACTION', 'Ljava/lang/String;');
  AddStaticField('NETWORK_PROVIDER', 'Ljava/lang/String;');
  AddStaticField('PASSIVE_PROVIDER', 'Ljava/lang/String;');
  AddStaticField('PROVIDERS_CHANGED_ACTION', 'Ljava/lang/String;');
end;

class function TJLocationManager.Wrap(const AObjectID: JNIObject): JLocationManager;
begin
  Result := Wrap<TJLocationManager, JLocationManager>(AObjectId);
end;

class function TJLocationManager.Wrap(const AObject: IJNIObject): JLocationManager;
begin
  Result := Wrap<TJLocationManager, JLocationManager>(AObject);
end;

class function TJLocationManager.GPS_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('GPS_PROVIDER');
end;

class function TJLocationManager.KEY_LOCATION_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_LOCATION_CHANGED');
end;

class function TJLocationManager.KEY_PROVIDER_ENABLED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_PROVIDER_ENABLED');
end;

class function TJLocationManager.KEY_PROXIMITY_ENTERING: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_PROXIMITY_ENTERING');
end;

class function TJLocationManager.KEY_STATUS_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_STATUS_CHANGED');
end;

class function TJLocationManager.MODE_CHANGED_ACTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('MODE_CHANGED_ACTION');
end;

class function TJLocationManager.NETWORK_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('NETWORK_PROVIDER');
end;

class function TJLocationManager.PASSIVE_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('PASSIVE_PROVIDER');
end;

class function TJLocationManager.PROVIDERS_CHANGED_ACTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('PROVIDERS_CHANGED_ACTION');
end;

function TJLocationManager.addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)Z', [AArg0]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)Z', [AArg0]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/OnNmeaMessageListener;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/OnNmeaMessageListener;)Z', [AArg0]);
end;

procedure TJLocationManager.addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'addProximityAlert', '(DDFJLandroid/app/PendingIntent;)V', [WrapDouble(AArg0), WrapDouble(AArg1), AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'addTestProvider', '(Ljava/lang/String;ZZZZZZZII)V', [AArg0, AArg1, AArg2, AArg3, AArg4, AArg5, AArg6, AArg7, AArg8, AArg9]);
end;

procedure TJLocationManager.clearTestProviderEnabled(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'clearTestProviderEnabled', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocationManager.clearTestProviderLocation(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'clearTestProviderLocation', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocationManager.clearTestProviderStatus(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'clearTestProviderStatus', '(Ljava/lang/String;)V', [AArg0]);
end;

function TJLocationManager.getAllProviders: JList;
begin
  Result := CallObjectMethod<TJList, JList>('getAllProviders', '()Ljava/util/List;', []);
end;

function TJLocationManager.getBestProvider(const AArg0: JCriteria; const AArg1: Boolean): JString;
begin
  Result := CallObjectMethod<TJString, JString>('getBestProvider', '(Landroid/location/Criteria;Z)Ljava/lang/String;', [AArg0, AArg1]);
end;

function TJLocationManager.getGpsStatus(const AArg0: JGpsStatus): JGpsStatus;
begin
  Result := CallObjectMethod<TJGpsStatus, JGpsStatus>('getGpsStatus', '(Landroid/location/GpsStatus;)Landroid/location/GpsStatus;', [AArg0]);
end;

function TJLocationManager.getLastKnownLocation(const AArg0: JString): JLocation;
begin
  Result := CallObjectMethod<TJLocation, JLocation>('getLastKnownLocation', '(Ljava/lang/String;)Landroid/location/Location;', [AArg0]);
end;

function TJLocationManager.getProvider(const AArg0: JString): JLocationProvider;
begin
  Result := CallObjectMethod<TJLocationProvider, JLocationProvider>('getProvider', '(Ljava/lang/String;)Landroid/location/LocationProvider;', [AArg0]);
end;

function TJLocationManager.getProviders(const AArg0: Boolean): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getProviders', '(Z)Ljava/util/List;', [AArg0]);
end;

function TJLocationManager.getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getProviders', '(Landroid/location/Criteria;Z)Ljava/util/List;', [AArg0, AArg1]);
end;

function TJLocationManager.isProviderEnabled(const AArg0: JString): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isProviderEnabled', '(Ljava/lang/String;)Z', [AArg0]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)Z', [AArg0]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)Z', [AArg0]);
end;

function TJLocationManager.registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)Z', [AArg0]);
end;

procedure TJLocationManager.removeGpsStatusListener(const AArg0: JGpsStatus_Listener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)V', [AArg0]);
end;

procedure TJLocationManager.removeNmeaListener(const AArg0: JOnNmeaMessageListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeNmeaListener', '(Landroid/location/OnNmeaMessageListener;)V', [AArg0]);
end;

procedure TJLocationManager.removeNmeaListener(const AArg0: JGpsStatus_NmeaListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)V', [AArg0]);
end;

procedure TJLocationManager.removeProximityAlert(const AArg0: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeProximityAlert', '(Landroid/app/PendingIntent;)V', [AArg0]);
end;

procedure TJLocationManager.removeTestProvider(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeTestProvider', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJLocationManager.removeUpdates(const AArg0: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeUpdates', '(Landroid/app/PendingIntent;)V', [AArg0]);
end;

procedure TJLocationManager.removeUpdates(const AArg0: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeUpdates', '(Landroid/location/LocationListener;)V', [AArg0]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/app/PendingIntent;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/app/PendingIntent;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Ljava/lang/String;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Landroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Landroid/location/Criteria;Landroid/app/PendingIntent;)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Ljava/lang/String;Landroid/app/PendingIntent;)V', [AArg0, AArg1]);
end;

function TJLocationManager.sendExtraCommand(const AArg0: JString; const AArg1: JString; const AArg2: JBundle): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'sendExtraCommand', '(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Z', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.setTestProviderEnabled(const AArg0: JString; const AArg1: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setTestProviderEnabled', '(Ljava/lang/String;Z)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.setTestProviderLocation(const AArg0: JString; const AArg1: JLocation);
begin
  JavaType.CallVoidMethod(ObjectID, 'setTestProviderLocation', '(Ljava/lang/String;Landroid/location/Location;)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.setTestProviderStatus(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle; const AArg3: Int64);
begin
  JavaType.CallVoidMethod(ObjectID, 'setTestProviderStatus', '(Ljava/lang/String;ILandroid/os/Bundle;J)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.unregisterGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback);
begin
  JavaType.CallVoidMethod(ObjectID, 'unregisterGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)V', [AArg0]);
end;

procedure TJLocationManager.unregisterGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback);
begin
  JavaType.CallVoidMethod(ObjectID, 'unregisterGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)V', [AArg0]);
end;

procedure TJLocationManager.unregisterGnssStatusCallback(const AArg0: JGnssStatus_Callback);
begin
  JavaType.CallVoidMethod(ObjectID, 'unregisterGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)V', [AArg0]);
end;

{ TJGnssNavigationMessage_Callback }

class procedure TJGnssNavigationMessage_Callback.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJGnssNavigationMessage_Callback.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onGnssNavigationMessageReceived', '(Landroid/location/GnssNavigationMessage;)V');
  AddMethod('onStatusChanged', '(I)V');
end;

class procedure TJGnssNavigationMessage_Callback.LoadFields;
begin
  inherited;
  AddStaticField('STATUS_LOCATION_DISABLED', 'I');
  AddStaticField('STATUS_NOT_SUPPORTED', 'I');
  AddStaticField('STATUS_READY', 'I');
end;

class function TJGnssNavigationMessage_Callback.Wrap(const AObjectID: JNIObject): JGnssNavigationMessage_Callback;
begin
  Result := Wrap<TJGnssNavigationMessage_Callback, JGnssNavigationMessage_Callback>(AObjectId);
end;

class function TJGnssNavigationMessage_Callback.Wrap(const AObject: IJNIObject): JGnssNavigationMessage_Callback;
begin
  Result := Wrap<TJGnssNavigationMessage_Callback, JGnssNavigationMessage_Callback>(AObject);
end;

class function TJGnssNavigationMessage_Callback.Create: JGnssNavigationMessage_Callback;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJGnssNavigationMessage_Callback.STATUS_LOCATION_DISABLED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_LOCATION_DISABLED');
end;

class function TJGnssNavigationMessage_Callback.STATUS_NOT_SUPPORTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_NOT_SUPPORTED');
end;

class function TJGnssNavigationMessage_Callback.STATUS_READY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_READY');
end;

procedure TJGnssNavigationMessage_Callback.onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGnssNavigationMessageReceived', '(Landroid/location/GnssNavigationMessage;)V', [AArg0]);
end;

procedure TJGnssNavigationMessage_Callback.onStatusChanged(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStatusChanged', '(I)V', [AArg0]);
end;

{ TJAddress }

class procedure TJAddress.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(Ljava/util/Locale;)V');
end;

class procedure TJAddress.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('clearLatitude', '()V');
  AddMethod('clearLongitude', '()V');
  AddMethod('describeContents', '()I');
  AddMethod('getAddressLine', '(I)Ljava/lang/String;');
  AddMethod('getAdminArea', '()Ljava/lang/String;');
  AddMethod('getCountryCode', '()Ljava/lang/String;');
  AddMethod('getCountryName', '()Ljava/lang/String;');
  AddMethod('getExtras', '()Landroid/os/Bundle;');
  AddMethod('getFeatureName', '()Ljava/lang/String;');
  AddMethod('getLatitude', '()D');
  AddMethod('getLocale', '()Ljava/util/Locale;');
  AddMethod('getLocality', '()Ljava/lang/String;');
  AddMethod('getLongitude', '()D');
  AddMethod('getMaxAddressLineIndex', '()I');
  AddMethod('getPhone', '()Ljava/lang/String;');
  AddMethod('getPostalCode', '()Ljava/lang/String;');
  AddMethod('getPremises', '()Ljava/lang/String;');
  AddMethod('getSubAdminArea', '()Ljava/lang/String;');
  AddMethod('getSubLocality', '()Ljava/lang/String;');
  AddMethod('getSubThoroughfare', '()Ljava/lang/String;');
  AddMethod('getThoroughfare', '()Ljava/lang/String;');
  AddMethod('getUrl', '()Ljava/lang/String;');
  AddMethod('hasLatitude', '()Z');
  AddMethod('hasLongitude', '()Z');
  AddMethod('setAddressLine', '(ILjava/lang/String;)V');
  AddMethod('setAdminArea', '(Ljava/lang/String;)V');
  AddMethod('setCountryCode', '(Ljava/lang/String;)V');
  AddMethod('setCountryName', '(Ljava/lang/String;)V');
  AddMethod('setExtras', '(Landroid/os/Bundle;)V');
  AddMethod('setFeatureName', '(Ljava/lang/String;)V');
  AddMethod('setLatitude', '(D)V');
  AddMethod('setLocality', '(Ljava/lang/String;)V');
  AddMethod('setLongitude', '(D)V');
  AddMethod('setPhone', '(Ljava/lang/String;)V');
  AddMethod('setPostalCode', '(Ljava/lang/String;)V');
  AddMethod('setPremises', '(Ljava/lang/String;)V');
  AddMethod('setSubAdminArea', '(Ljava/lang/String;)V');
  AddMethod('setSubLocality', '(Ljava/lang/String;)V');
  AddMethod('setSubThoroughfare', '(Ljava/lang/String;)V');
  AddMethod('setThoroughfare', '(Ljava/lang/String;)V');
  AddMethod('setUrl', '(Ljava/lang/String;)V');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJAddress.Wrap(const AObjectID: JNIObject): JAddress;
begin
  Result := Wrap<TJAddress, JAddress>(AObjectId);
end;

class function TJAddress.Wrap(const AObject: IJNIObject): JAddress;
begin
  Result := Wrap<TJAddress, JAddress>(AObject);
end;

class function TJAddress.Create(const AArg0: JLocale): JAddress;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/util/Locale;)V', [AArg0]);
  Result := O;
end;

procedure TJAddress.clearLatitude;
begin
  JavaType.CallVoidMethod(ObjectID, 'clearLatitude', '()V', []);
end;

procedure TJAddress.clearLongitude;
begin
  JavaType.CallVoidMethod(ObjectID, 'clearLongitude', '()V', []);
end;

function TJAddress.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJAddress.getAddressLine(const AArg0: Integer): JString;
begin
  Result := CallObjectMethod<TJString, JString>('getAddressLine', '(I)Ljava/lang/String;', [AArg0]);
end;

function TJAddress.getAdminArea: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getAdminArea', '()Ljava/lang/String;', []);
end;

function TJAddress.getCountryCode: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getCountryCode', '()Ljava/lang/String;', []);
end;

function TJAddress.getCountryName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getCountryName', '()Ljava/lang/String;', []);
end;

function TJAddress.getExtras: JBundle;
begin
  Result := CallObjectMethod<TJBundle, JBundle>('getExtras', '()Landroid/os/Bundle;', []);
end;

function TJAddress.getFeatureName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getFeatureName', '()Ljava/lang/String;', []);
end;

function TJAddress.getLatitude: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getLatitude', '()D', []);
end;

function TJAddress.getLocale: JLocale;
begin
  Result := CallObjectMethod<TJLocale, JLocale>('getLocale', '()Ljava/util/Locale;', []);
end;

function TJAddress.getLocality: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getLocality', '()Ljava/lang/String;', []);
end;

function TJAddress.getLongitude: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getLongitude', '()D', []);
end;

function TJAddress.getMaxAddressLineIndex: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getMaxAddressLineIndex', '()I', []);
end;

function TJAddress.getPhone: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getPhone', '()Ljava/lang/String;', []);
end;

function TJAddress.getPostalCode: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getPostalCode', '()Ljava/lang/String;', []);
end;

function TJAddress.getPremises: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getPremises', '()Ljava/lang/String;', []);
end;

function TJAddress.getSubAdminArea: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getSubAdminArea', '()Ljava/lang/String;', []);
end;

function TJAddress.getSubLocality: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getSubLocality', '()Ljava/lang/String;', []);
end;

function TJAddress.getSubThoroughfare: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getSubThoroughfare', '()Ljava/lang/String;', []);
end;

function TJAddress.getThoroughfare: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getThoroughfare', '()Ljava/lang/String;', []);
end;

function TJAddress.getUrl: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getUrl', '()Ljava/lang/String;', []);
end;

function TJAddress.hasLatitude: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasLatitude', '()Z', []);
end;

function TJAddress.hasLongitude: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasLongitude', '()Z', []);
end;

procedure TJAddress.setAddressLine(const AArg0: Integer; const AArg1: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAddressLine', '(ILjava/lang/String;)V', [AArg0, AArg1]);
end;

procedure TJAddress.setAdminArea(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAdminArea', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setCountryCode(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setCountryCode', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setCountryName(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setCountryName', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setExtras(const AArg0: JBundle);
begin
  JavaType.CallVoidMethod(ObjectID, 'setExtras', '(Landroid/os/Bundle;)V', [AArg0]);
end;

procedure TJAddress.setFeatureName(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setFeatureName', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setLatitude(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setLatitude', '(D)V', [WrapDouble(AArg0)]);
end;

procedure TJAddress.setLocality(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setLocality', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setLongitude(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setLongitude', '(D)V', [WrapDouble(AArg0)]);
end;

procedure TJAddress.setPhone(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setPhone', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setPostalCode(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setPostalCode', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setPremises(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setPremises', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setSubAdminArea(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSubAdminArea', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setSubLocality(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSubLocality', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setSubThoroughfare(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setSubThoroughfare', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setThoroughfare(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setThoroughfare', '(Ljava/lang/String;)V', [AArg0]);
end;

procedure TJAddress.setUrl(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setUrl', '(Ljava/lang/String;)V', [AArg0]);
end;

function TJAddress.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssStatus_Callback }

class procedure TJGnssStatus_Callback.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJGnssStatus_Callback.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onFirstFix', '(I)V');
  AddMethod('onSatelliteStatusChanged', '(Landroid/location/GnssStatus;)V');
  AddMethod('onStarted', '()V');
  AddMethod('onStopped', '()V');
end;

class function TJGnssStatus_Callback.Wrap(const AObjectID: JNIObject): JGnssStatus_Callback;
begin
  Result := Wrap<TJGnssStatus_Callback, JGnssStatus_Callback>(AObjectId);
end;

class function TJGnssStatus_Callback.Wrap(const AObject: IJNIObject): JGnssStatus_Callback;
begin
  Result := Wrap<TJGnssStatus_Callback, JGnssStatus_Callback>(AObject);
end;

class function TJGnssStatus_Callback.Create: JGnssStatus_Callback;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

procedure TJGnssStatus_Callback.onFirstFix(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onFirstFix', '(I)V', [AArg0]);
end;

procedure TJGnssStatus_Callback.onSatelliteStatusChanged(const AArg0: JGnssStatus);
begin
  JavaType.CallVoidMethod(ObjectID, 'onSatelliteStatusChanged', '(Landroid/location/GnssStatus;)V', [AArg0]);
end;

procedure TJGnssStatus_Callback.onStarted;
begin
  JavaType.CallVoidMethod(ObjectID, 'onStarted', '()V', []);
end;

procedure TJGnssStatus_Callback.onStopped;
begin
  JavaType.CallVoidMethod(ObjectID, 'onStopped', '()V', []);
end;

initialization
  TJavaTypesManager.RegisterJavaType(TJGpsStatus_Listener, TypeInfo(IJavaArray<JGpsStatus_Listener>), TJavaArray<JGpsStatus_Listener>);
  TJavaTypesManager.RegisterJavaType(TJCriteria, TypeInfo(IJavaArray<JCriteria>), TJavaArray<JCriteria>);
  TJavaTypesManager.RegisterJavaType(TJLocation, TypeInfo(IJavaArray<JLocation>), TJavaArray<JLocation>);
  TJavaTypesManager.RegisterJavaType(TJGnssNavigationMessage, TypeInfo(IJavaArray<JGnssNavigationMessage>), TJavaArray<JGnssNavigationMessage>);
  TJavaTypesManager.RegisterJavaType(TJGpsSatellite, TypeInfo(IJavaArray<JGpsSatellite>), TJavaArray<JGpsSatellite>);
  TJavaTypesManager.RegisterJavaType(TJLocationProvider, TypeInfo(IJavaArray<JLocationProvider>), TJavaArray<JLocationProvider>);
  TJavaTypesManager.RegisterJavaType(TJLocationListener, TypeInfo(IJavaArray<JLocationListener>), TJavaArray<JLocationListener>);
  TJavaTypesManager.RegisterJavaType(TJGnssClock, TypeInfo(IJavaArray<JGnssClock>), TJavaArray<JGnssClock>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementsEvent_Callback, TypeInfo(IJavaArray<JGnssMeasurementsEvent_Callback>), TJavaArray<JGnssMeasurementsEvent_Callback>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementsEvent, TypeInfo(IJavaArray<JGnssMeasurementsEvent>), TJavaArray<JGnssMeasurementsEvent>);
  TJavaTypesManager.RegisterJavaType(TJGeocoder, TypeInfo(IJavaArray<JGeocoder>), TJavaArray<JGeocoder>);
  TJavaTypesManager.RegisterJavaType(TJSettingInjectorService, TypeInfo(IJavaArray<JSettingInjectorService>), TJavaArray<JSettingInjectorService>);
  TJavaTypesManager.RegisterJavaType(TJGpsStatus_NmeaListener, TypeInfo(IJavaArray<JGpsStatus_NmeaListener>), TJavaArray<JGpsStatus_NmeaListener>);
  TJavaTypesManager.RegisterJavaType(TJGnssStatus, TypeInfo(IJavaArray<JGnssStatus>), TJavaArray<JGnssStatus>);
  TJavaTypesManager.RegisterJavaType(TJGpsStatus, TypeInfo(IJavaArray<JGpsStatus>), TJavaArray<JGpsStatus>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurement, TypeInfo(IJavaArray<JGnssMeasurement>), TJavaArray<JGnssMeasurement>);
  TJavaTypesManager.RegisterJavaType(TJOnNmeaMessageListener, TypeInfo(IJavaArray<JOnNmeaMessageListener>), TJavaArray<JOnNmeaMessageListener>);
  TJavaTypesManager.RegisterJavaType(TJLocationManager, TypeInfo(IJavaArray<JLocationManager>), TJavaArray<JLocationManager>);
  TJavaTypesManager.RegisterJavaType(TJGnssNavigationMessage_Callback, TypeInfo(IJavaArray<JGnssNavigationMessage_Callback>), TJavaArray<JGnssNavigationMessage_Callback>);
  TJavaTypesManager.RegisterJavaType(TJAddress, TypeInfo(IJavaArray<JAddress>), TJavaArray<JAddress>);
  TJavaTypesManager.RegisterJavaType(TJGnssStatus_Callback, TypeInfo(IJavaArray<JGnssStatus_Callback>), TJavaArray<JGnssStatus_Callback>);
end.
