{********************************************************************* 
 *                                                                     
 * Copyright © 2022, Brovin Yaroslav                                   
 * All rights reserved                                                 
 *                                                                     
 * Author: Brovin Y.D.                                                  
 * E-mail: y.brovin@gmail.com                                          
 *                                                                     
 *********************************************************************}

unit Android.Api.Location;

{$SCOPEDENUMS ON}
{$WARN SYMBOL_DEPRECATED OFF}

interface

uses
  System.SysUtils, Androidapi.Jni, Java.Bridge,
  Android.Api.JavaTypes, Android.Api.ActivityAndView;

type
  JAddress = interface;
  TJAddress = class;
  JCriteria = interface;
  TJCriteria = class;
  JGeocoder = interface;
  TJGeocoder = class;
  JGnssAntennaInfo = interface;
  TJGnssAntennaInfo = class;
  JGnssAntennaInfo_Builder = interface;
  TJGnssAntennaInfo_Builder = class;
  JGnssAntennaInfo_Listener = interface;
  TJGnssAntennaInfo_Listener = class;
  JGnssAntennaInfo_PhaseCenterOffset = interface;
  TJGnssAntennaInfo_PhaseCenterOffset = class;
  JGnssAntennaInfo_SphericalCorrections = interface;
  TJGnssAntennaInfo_SphericalCorrections = class;
  JGnssCapabilities = interface;
  TJGnssCapabilities = class;
  JGnssCapabilities_Builder = interface;
  TJGnssCapabilities_Builder = class;
  JGnssClock = interface;
  TJGnssClock = class;
  JGnssMeasurement = interface;
  TJGnssMeasurement = class;
  JGnssMeasurementRequest = interface;
  TJGnssMeasurementRequest = class;
  JGnssMeasurementRequest_Builder = interface;
  TJGnssMeasurementRequest_Builder = class;
  JGnssMeasurementsEvent = interface;
  TJGnssMeasurementsEvent = class;
  JGnssMeasurementsEvent_Callback = interface;
  TJGnssMeasurementsEvent_Callback = class;
  JGnssNavigationMessage = interface;
  TJGnssNavigationMessage = class;
  JGnssNavigationMessage_Callback = interface;
  TJGnssNavigationMessage_Callback = class;
  JGnssStatus = interface;
  TJGnssStatus = class;
  JGnssStatus_Builder = interface;
  TJGnssStatus_Builder = class;
  JGnssStatus_Callback = interface;
  TJGnssStatus_Callback = class;
  JGpsSatellite = interface;
  TJGpsSatellite = class;
  JGpsStatus = interface;
  TJGpsStatus = class;
  JGpsStatus_Listener = interface;
  TJGpsStatus_Listener = class;
  JGpsStatus_NmeaListener = interface;
  TJGpsStatus_NmeaListener = class;
  JLocation = interface;
  TJLocation = class;
  JLocationListener = interface;
  TJLocationListener = class;
  JLocationManager = interface;
  TJLocationManager = class;
  JLocationProvider = interface;
  TJLocationProvider = class;
  JLocationRequest = interface;
  TJLocationRequest = class;
  JLocationRequest_Builder = interface;
  TJLocationRequest_Builder = class;
  JOnNmeaMessageListener = interface;
  TJOnNmeaMessageListener = class;
  JSettingInjectorService = interface;
  TJSettingInjectorService = class;
  JProviderProperties = interface;
  TJProviderProperties = class;
  JProviderProperties_Builder = interface;
  TJProviderProperties_Builder = class;

{ android.location.Address }

  [JavaClassSignature('android/location/Address')]
  JAddress = interface(JObject)
    ['{17D87D2D-614E-46DB-B678-843BAE16EB67}']
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

{ android.location.Criteria }

  [JavaClassSignature('android/location/Criteria')]
  JCriteria = interface(JObject)
    ['{324B497F-A02C-4C96-B828-400865867169}']
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

{ android.location.Geocoder }

  [JavaClassSignature('android/location/Geocoder')]
  JGeocoder = interface(JObject)
    ['{83444128-3180-40E8-B526-B1D139E8F137}']
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

{ android.location.GnssAntennaInfo }

  [JavaClassSignature('android/location/GnssAntennaInfo')]
  JGnssAntennaInfo = interface(JObject)
    ['{1A5F68A1-C80C-408B-BFAB-11764E40A89E}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getCarrierFrequencyMHz: Double;
    function getPhaseCenterOffset: JGnssAntennaInfo_PhaseCenterOffset;
    function getPhaseCenterVariationCorrections: JGnssAntennaInfo_SphericalCorrections;
    function getSignalGainCorrections: JGnssAntennaInfo_SphericalCorrections;
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssAntennaInfo')]
  TJGnssAntennaInfo = class(TJObject, JGnssAntennaInfo)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getCarrierFrequencyMHz: Double;
    function getPhaseCenterOffset: JGnssAntennaInfo_PhaseCenterOffset;
    function getPhaseCenterVariationCorrections: JGnssAntennaInfo_SphericalCorrections;
    function getSignalGainCorrections: JGnssAntennaInfo_SphericalCorrections;
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssAntennaInfo; overload;
    class function Wrap(const AObject: IJNIObject): JGnssAntennaInfo; overload;
  end;

{ android.location.GnssAntennaInfo_Builder }

  [JavaClassSignature('android/location/GnssAntennaInfo$Builder')]
  JGnssAntennaInfo_Builder = interface(JObject)
    ['{072CAE3F-721D-4C19-9895-166EB822DB26}']
    function build: JGnssAntennaInfo;
    function setCarrierFrequencyMHz(const AArg0: Double): JGnssAntennaInfo_Builder;
    function setPhaseCenterOffset(const AArg0: JGnssAntennaInfo_PhaseCenterOffset): JGnssAntennaInfo_Builder;
    function setPhaseCenterVariationCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
    function setSignalGainCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
  end;

  [JavaClassSignature('android/location/GnssAntennaInfo$Builder')]
  TJGnssAntennaInfo_Builder = class(TJObject, JGnssAntennaInfo_Builder)
  private
    { methods }
    function build: JGnssAntennaInfo;
    function setCarrierFrequencyMHz(const AArg0: Double): JGnssAntennaInfo_Builder;
    function setPhaseCenterOffset(const AArg0: JGnssAntennaInfo_PhaseCenterOffset): JGnssAntennaInfo_Builder;
    function setPhaseCenterVariationCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
    function setSignalGainCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JGnssAntennaInfo_Builder; overload;
    { constructors }
    class function Create: JGnssAntennaInfo_Builder; overload;
    class function Create(const AArg0: Double; const AArg1: JGnssAntennaInfo_PhaseCenterOffset): JGnssAntennaInfo_Builder; overload;
    class function Create(const AArg0: JGnssAntennaInfo): JGnssAntennaInfo_Builder; overload;
  end;

{ android.location.GnssAntennaInfo_Listener - interface }

  [JavaClassSignature('android/location/GnssAntennaInfo$Listener')]
  JGnssAntennaInfo_Listener = interface(IJavaObject)
    ['{A7C647E1-AC7E-4C36-8AAB-EED871B488E2}']
    procedure onGnssAntennaInfoReceived(const AArg0: JList);
  end;

  [JavaClassSignature('android/location/GnssAntennaInfo$Listener')]
  TJGnssAntennaInfo_Listener = class(TJObject, JGnssAntennaInfo_Listener)
  private
    { methods }
    procedure onGnssAntennaInfoReceived(const AArg0: JList);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_Listener; overload;
    class function Wrap(const AObject: IJNIObject): JGnssAntennaInfo_Listener; overload;
  end;

{ android.location.GnssAntennaInfo_PhaseCenterOffset }

  [JavaClassSignature('android/location/GnssAntennaInfo$PhaseCenterOffset')]
  JGnssAntennaInfo_PhaseCenterOffset = interface(JObject)
    ['{67AFF088-1A76-4595-8F42-B4AEBA1301B8}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getXOffsetMm: Double;
    function getXOffsetUncertaintyMm: Double;
    function getYOffsetMm: Double;
    function getYOffsetUncertaintyMm: Double;
    function getZOffsetMm: Double;
    function getZOffsetUncertaintyMm: Double;
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssAntennaInfo$PhaseCenterOffset')]
  TJGnssAntennaInfo_PhaseCenterOffset = class(TJObject, JGnssAntennaInfo_PhaseCenterOffset)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getXOffsetMm: Double;
    function getXOffsetUncertaintyMm: Double;
    function getYOffsetMm: Double;
    function getYOffsetUncertaintyMm: Double;
    function getZOffsetMm: Double;
    function getZOffsetUncertaintyMm: Double;
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_PhaseCenterOffset; overload;
    class function Wrap(const AObject: IJNIObject): JGnssAntennaInfo_PhaseCenterOffset; overload;
    { constructors }
    class function Create(const AArg0: Double; const AArg1: Double; const AArg2: Double; const AArg3: Double; const AArg4: Double; const AArg5: Double): JGnssAntennaInfo_PhaseCenterOffset; overload;
  end;

{ android.location.GnssAntennaInfo_SphericalCorrections }

  [JavaClassSignature('android/location/GnssAntennaInfo$SphericalCorrections')]
  JGnssAntennaInfo_SphericalCorrections = interface(JObject)
    ['{EDFAB017-C1C7-4157-93C7-0ADC5E96EBF7}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getCorrectionUncertaintiesArray: IJavaArray<Double>;
    function getCorrectionsArray: IJavaArray<Double>;
    function getDeltaPhi: Double;
    function getDeltaTheta: Double;
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssAntennaInfo$SphericalCorrections')]
  TJGnssAntennaInfo_SphericalCorrections = class(TJObject, JGnssAntennaInfo_SphericalCorrections)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getCorrectionUncertaintiesArray: IJavaArray<Double>;
    function getCorrectionsArray: IJavaArray<Double>;
    function getDeltaPhi: Double;
    function getDeltaTheta: Double;
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_SphericalCorrections; overload;
    class function Wrap(const AObject: IJNIObject): JGnssAntennaInfo_SphericalCorrections; overload;
    { constructors }
    class function Create(const AArg0: IJavaArray<Double>; const AArg1: IJavaArray<Double>): JGnssAntennaInfo_SphericalCorrections; overload;
  end;

{ android.location.GnssCapabilities }

  [JavaClassSignature('android/location/GnssCapabilities')]
  JGnssCapabilities = interface(JObject)
    ['{3C31BE66-C823-48B1-A8DA-EE2C018CDF58}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function hasAntennaInfo: Boolean; // Introduced in 31';
    function hasGnssAntennaInfo: Boolean; deprecated 'Deprecated in 31';
    function hasMeasurements: Boolean; // Introduced in 31';
    function hasNavigationMessages: Boolean; // Introduced in 31';
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssCapabilities')]
  TJGnssCapabilities = class(TJObject, JGnssCapabilities)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function hasAntennaInfo: Boolean; // Introduced in 31';
    function hasGnssAntennaInfo: Boolean; deprecated 'Deprecated in 31';
    function hasMeasurements: Boolean; // Introduced in 31';
    function hasNavigationMessages: Boolean; // Introduced in 31';
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssCapabilities; overload;
    class function Wrap(const AObject: IJNIObject): JGnssCapabilities; overload;
  end;

{ android.location.GnssCapabilities_Builder }

  [JavaClassSignature('android/location/GnssCapabilities$Builder')]
  JGnssCapabilities_Builder = interface(JObject)
    ['{AC2021C2-F4DD-4250-9C52-04F948579917}']
    function build: JGnssCapabilities;
    function setHasAntennaInfo(const AArg0: Boolean): JGnssCapabilities_Builder;
    function setHasMeasurements(const AArg0: Boolean): JGnssCapabilities_Builder;
    function setHasNavigationMessages(const AArg0: Boolean): JGnssCapabilities_Builder;
  end;

  [JavaClassSignature('android/location/GnssCapabilities$Builder')]
  TJGnssCapabilities_Builder = class(TJObject, JGnssCapabilities_Builder)
  private
    { methods }
    function build: JGnssCapabilities;
    function setHasAntennaInfo(const AArg0: Boolean): JGnssCapabilities_Builder;
    function setHasMeasurements(const AArg0: Boolean): JGnssCapabilities_Builder;
    function setHasNavigationMessages(const AArg0: Boolean): JGnssCapabilities_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssCapabilities_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JGnssCapabilities_Builder; overload;
    { constructors }
    class function Create: JGnssCapabilities_Builder; overload;
    class function Create(const AArg0: JGnssCapabilities): JGnssCapabilities_Builder; overload;
  end;

{ android.location.GnssClock }

  [JavaClassSignature('android/location/GnssClock')]
  JGnssClock = interface(JObject)
    ['{58F1477F-B19B-48EE-8C29-B922586425A6}']
    function describeContents: Integer;
    function getBiasNanos: Double;
    function getBiasUncertaintyNanos: Double;
    function getDriftNanosPerSecond: Double;
    function getDriftUncertaintyNanosPerSecond: Double;
    function getElapsedRealtimeNanos: Int64; // Introduced in 29';
    function getElapsedRealtimeUncertaintyNanos: Double; // Introduced in 29';
    function getFullBiasNanos: Int64;
    function getHardwareClockDiscontinuityCount: Integer;
    function getLeapSecond: Integer;
    function getReferenceCarrierFrequencyHzForIsb: Double; // Introduced in 30';
    function getReferenceCodeTypeForIsb: JString; // Introduced in 30';
    function getReferenceConstellationTypeForIsb: Integer; // Introduced in 30';
    function getTimeNanos: Int64;
    function getTimeUncertaintyNanos: Double;
    function hasBiasNanos: Boolean;
    function hasBiasUncertaintyNanos: Boolean;
    function hasDriftNanosPerSecond: Boolean;
    function hasDriftUncertaintyNanosPerSecond: Boolean;
    function hasElapsedRealtimeNanos: Boolean; // Introduced in 29';
    function hasElapsedRealtimeUncertaintyNanos: Boolean; // Introduced in 29';
    function hasFullBiasNanos: Boolean;
    function hasLeapSecond: Boolean;
    function hasReferenceCarrierFrequencyHzForIsb: Boolean; // Introduced in 30';
    function hasReferenceCodeTypeForIsb: Boolean; // Introduced in 30';
    function hasReferenceConstellationTypeForIsb: Boolean; // Introduced in 30';
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
    function getElapsedRealtimeNanos: Int64; // Introduced in 29';
    function getElapsedRealtimeUncertaintyNanos: Double; // Introduced in 29';
    function getFullBiasNanos: Int64;
    function getHardwareClockDiscontinuityCount: Integer;
    function getLeapSecond: Integer;
    function getReferenceCarrierFrequencyHzForIsb: Double; // Introduced in 30';
    function getReferenceCodeTypeForIsb: JString; // Introduced in 30';
    function getReferenceConstellationTypeForIsb: Integer; // Introduced in 30';
    function getTimeNanos: Int64;
    function getTimeUncertaintyNanos: Double;
    function hasBiasNanos: Boolean;
    function hasBiasUncertaintyNanos: Boolean;
    function hasDriftNanosPerSecond: Boolean;
    function hasDriftUncertaintyNanosPerSecond: Boolean;
    function hasElapsedRealtimeNanos: Boolean; // Introduced in 29';
    function hasElapsedRealtimeUncertaintyNanos: Boolean; // Introduced in 29';
    function hasFullBiasNanos: Boolean;
    function hasLeapSecond: Boolean;
    function hasReferenceCarrierFrequencyHzForIsb: Boolean; // Introduced in 30';
    function hasReferenceCodeTypeForIsb: Boolean; // Introduced in 30';
    function hasReferenceConstellationTypeForIsb: Boolean; // Introduced in 30';
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

{ android.location.GnssMeasurement }

  [JavaClassSignature('android/location/GnssMeasurement')]
  JGnssMeasurement = interface(JObject)
    ['{6FC8D62A-112D-4B00-8E46-42ACCEF491BE}']
    function describeContents: Integer;
    function getAccumulatedDeltaRangeMeters: Double;
    function getAccumulatedDeltaRangeState: Integer;
    function getAccumulatedDeltaRangeUncertaintyMeters: Double;
    function getAutomaticGainControlLevelDb: Double; // Introduced in 26';
    function getBasebandCn0DbHz: Double; // Introduced in 30';
    function getCarrierCycles: Int64; deprecated 'Deprecated in 28';
    function getCarrierFrequencyHz: Single;
    function getCarrierPhase: Double; deprecated 'Deprecated in 28';
    function getCarrierPhaseUncertainty: Double; deprecated 'Deprecated in 28';
    function getCn0DbHz: Double;
    function getCodeType: JString; // Introduced in 29';
    function getConstellationType: Integer;
    function getFullInterSignalBiasNanos: Double; // Introduced in 30';
    function getFullInterSignalBiasUncertaintyNanos: Double; // Introduced in 30';
    function getMultipathIndicator: Integer;
    function getPseudorangeRateMetersPerSecond: Double;
    function getPseudorangeRateUncertaintyMetersPerSecond: Double;
    function getReceivedSvTimeNanos: Int64;
    function getReceivedSvTimeUncertaintyNanos: Int64;
    function getSatelliteInterSignalBiasNanos: Double; // Introduced in 30';
    function getSatelliteInterSignalBiasUncertaintyNanos: Double; // Introduced in 30';
    function getSnrInDb: Double;
    function getState: Integer;
    function getSvid: Integer;
    function getTimeOffsetNanos: Double;
    function hasAutomaticGainControlLevelDb: Boolean; // Introduced in 26';
    function hasBasebandCn0DbHz: Boolean; // Introduced in 30';
    function hasCarrierCycles: Boolean; deprecated 'Deprecated in 28';
    function hasCarrierFrequencyHz: Boolean;
    function hasCarrierPhase: Boolean; deprecated 'Deprecated in 28';
    function hasCarrierPhaseUncertainty: Boolean; deprecated 'Deprecated in 28';
    function hasCodeType: Boolean; // Introduced in 29';
    function hasFullInterSignalBiasNanos: Boolean; // Introduced in 30';
    function hasFullInterSignalBiasUncertaintyNanos: Boolean; // Introduced in 30';
    function hasSatelliteInterSignalBiasNanos: Boolean; // Introduced in 30';
    function hasSatelliteInterSignalBiasUncertaintyNanos: Boolean; // Introduced in 30';
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
    function getAutomaticGainControlLevelDb: Double; // Introduced in 26';
    function getBasebandCn0DbHz: Double; // Introduced in 30';
    function getCarrierCycles: Int64; deprecated 'Deprecated in 28';
    function getCarrierFrequencyHz: Single;
    function getCarrierPhase: Double; deprecated 'Deprecated in 28';
    function getCarrierPhaseUncertainty: Double; deprecated 'Deprecated in 28';
    function getCn0DbHz: Double;
    function getCodeType: JString; // Introduced in 29';
    function getConstellationType: Integer;
    function getFullInterSignalBiasNanos: Double; // Introduced in 30';
    function getFullInterSignalBiasUncertaintyNanos: Double; // Introduced in 30';
    function getMultipathIndicator: Integer;
    function getPseudorangeRateMetersPerSecond: Double;
    function getPseudorangeRateUncertaintyMetersPerSecond: Double;
    function getReceivedSvTimeNanos: Int64;
    function getReceivedSvTimeUncertaintyNanos: Int64;
    function getSatelliteInterSignalBiasNanos: Double; // Introduced in 30';
    function getSatelliteInterSignalBiasUncertaintyNanos: Double; // Introduced in 30';
    function getSnrInDb: Double;
    function getState: Integer;
    function getSvid: Integer;
    function getTimeOffsetNanos: Double;
    function hasAutomaticGainControlLevelDb: Boolean; // Introduced in 26';
    function hasBasebandCn0DbHz: Boolean; // Introduced in 30';
    function hasCarrierCycles: Boolean; deprecated 'Deprecated in 28';
    function hasCarrierFrequencyHz: Boolean;
    function hasCarrierPhase: Boolean; deprecated 'Deprecated in 28';
    function hasCarrierPhaseUncertainty: Boolean; deprecated 'Deprecated in 28';
    function hasCodeType: Boolean; // Introduced in 29';
    function hasFullInterSignalBiasNanos: Boolean; // Introduced in 30';
    function hasFullInterSignalBiasUncertaintyNanos: Boolean; // Introduced in 30';
    function hasSatelliteInterSignalBiasNanos: Boolean; // Introduced in 30';
    function hasSatelliteInterSignalBiasUncertaintyNanos: Boolean; // Introduced in 30';
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
    class function ADR_STATE_HALF_CYCLE_REPORTED: Integer;
    class function ADR_STATE_HALF_CYCLE_RESOLVED: Integer;
    class function ADR_STATE_RESET: Integer;
    class function ADR_STATE_UNKNOWN: Integer;
    class function ADR_STATE_VALID: Integer;
    class function MULTIPATH_INDICATOR_DETECTED: Integer;
    class function MULTIPATH_INDICATOR_NOT_DETECTED: Integer;
    class function MULTIPATH_INDICATOR_UNKNOWN: Integer;
    class function STATE_2ND_CODE_LOCK: Integer;
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

{ android.location.GnssMeasurementRequest }

  [JavaClassSignature('android/location/GnssMeasurementRequest')]
  JGnssMeasurementRequest = interface(JObject)
    ['{AE2E8A86-C3B5-4E8D-921B-581D3F2675BA}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function hashCode: Integer;
    function isFullTracking: Boolean;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/GnssMeasurementRequest')]
  TJGnssMeasurementRequest = class(TJObject, JGnssMeasurementRequest)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function hashCode: Integer;
    function isFullTracking: Boolean;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssMeasurementRequest; overload;
    class function Wrap(const AObject: IJNIObject): JGnssMeasurementRequest; overload;
  end;

{ android.location.GnssMeasurementRequest_Builder }

  [JavaClassSignature('android/location/GnssMeasurementRequest$Builder')]
  JGnssMeasurementRequest_Builder = interface(JObject)
    ['{1335E3F2-87C7-4FFA-9DF4-69B611B0CE6A}']
    function build: JGnssMeasurementRequest;
    function setFullTracking(const AArg0: Boolean): JGnssMeasurementRequest_Builder;
  end;

  [JavaClassSignature('android/location/GnssMeasurementRequest$Builder')]
  TJGnssMeasurementRequest_Builder = class(TJObject, JGnssMeasurementRequest_Builder)
  private
    { methods }
    function build: JGnssMeasurementRequest;
    function setFullTracking(const AArg0: Boolean): JGnssMeasurementRequest_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssMeasurementRequest_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JGnssMeasurementRequest_Builder; overload;
    { constructors }
    class function Create: JGnssMeasurementRequest_Builder; overload;
    class function Create(const AArg0: JGnssMeasurementRequest): JGnssMeasurementRequest_Builder; overload;
  end;

{ android.location.GnssMeasurementsEvent }

  [JavaClassSignature('android/location/GnssMeasurementsEvent')]
  JGnssMeasurementsEvent = interface(JObject)
    ['{560E597F-5AAE-4FC4-9116-B423155DD8AA}']
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

{ android.location.GnssMeasurementsEvent_Callback }

  [JavaClassSignature('android/location/GnssMeasurementsEvent$Callback')]
  JGnssMeasurementsEvent_Callback = interface(JObject)
    ['{CF288D11-50B1-45E6-8093-33F8C678C6E6}']
    procedure onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
    procedure onStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 31';
  end;

  [JavaClassSignature('android/location/GnssMeasurementsEvent$Callback')]
  TJGnssMeasurementsEvent_Callback = class(TJObject, JGnssMeasurementsEvent_Callback)
  private
    { methods }
    procedure onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
    procedure onStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 31';
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
    class function STATUS_NOT_ALLOWED: Integer;
    class function STATUS_NOT_SUPPORTED: Integer;
    class function STATUS_READY: Integer;
  end;

{ android.location.GnssNavigationMessage }

  [JavaClassSignature('android/location/GnssNavigationMessage')]
  JGnssNavigationMessage = interface(JObject)
    ['{5EE92D32-3D78-4572-97F4-26D4D6D5B7EC}']
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
    class function TYPE_BDS_CNAV1: Integer;
    class function TYPE_BDS_CNAV2: Integer;
    class function TYPE_BDS_D1: Integer;
    class function TYPE_BDS_D2: Integer;
    class function TYPE_GAL_F: Integer;
    class function TYPE_GAL_I: Integer;
    class function TYPE_GLO_L1CA: Integer;
    class function TYPE_GPS_CNAV2: Integer;
    class function TYPE_GPS_L1CA: Integer;
    class function TYPE_GPS_L2CNAV: Integer;
    class function TYPE_GPS_L5CNAV: Integer;
    class function TYPE_IRN_L5CA: Integer;
    class function TYPE_QZS_L1CA: Integer;
    class function TYPE_SBS: Integer;
    class function TYPE_UNKNOWN: Integer;
  end;

{ android.location.GnssNavigationMessage_Callback }

  [JavaClassSignature('android/location/GnssNavigationMessage$Callback')]
  JGnssNavigationMessage_Callback = interface(JObject)
    ['{40688C06-5FD3-485F-93A1-C71E40418F8F}']
    procedure onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
    procedure onStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 31';
  end;

  [JavaClassSignature('android/location/GnssNavigationMessage$Callback')]
  TJGnssNavigationMessage_Callback = class(TJObject, JGnssNavigationMessage_Callback)
  private
    { methods }
    procedure onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
    procedure onStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 31';
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

{ android.location.GnssStatus }

  [JavaClassSignature('android/location/GnssStatus')]
  JGnssStatus = interface(JObject)
    ['{895D84AE-B96E-4900-BF58-EC47FBD89A62}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getAzimuthDegrees(const AArg0: Integer): Single;
    function getBasebandCn0DbHz(const AArg0: Integer): Single; // Introduced in 30';
    function getCarrierFrequencyHz(const AArg0: Integer): Single; // Introduced in 26';
    function getCn0DbHz(const AArg0: Integer): Single;
    function getConstellationType(const AArg0: Integer): Integer;
    function getElevationDegrees(const AArg0: Integer): Single;
    function getSatelliteCount: Integer;
    function getSvid(const AArg0: Integer): Integer;
    function hasAlmanacData(const AArg0: Integer): Boolean;
    function hasBasebandCn0DbHz(const AArg0: Integer): Boolean; // Introduced in 30';
    function hasCarrierFrequencyHz(const AArg0: Integer): Boolean; // Introduced in 26';
    function hasEphemerisData(const AArg0: Integer): Boolean;
    function hashCode: Integer;
    function usedInFix(const AArg0: Integer): Boolean;
  end;

  [JavaClassSignature('android/location/GnssStatus')]
  TJGnssStatus = class(TJObject, JGnssStatus)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getAzimuthDegrees(const AArg0: Integer): Single;
    function getBasebandCn0DbHz(const AArg0: Integer): Single; // Introduced in 30';
    function getCarrierFrequencyHz(const AArg0: Integer): Single; // Introduced in 26';
    function getCn0DbHz(const AArg0: Integer): Single;
    function getConstellationType(const AArg0: Integer): Integer;
    function getElevationDegrees(const AArg0: Integer): Single;
    function getSatelliteCount: Integer;
    function getSvid(const AArg0: Integer): Integer;
    function hasAlmanacData(const AArg0: Integer): Boolean;
    function hasBasebandCn0DbHz(const AArg0: Integer): Boolean; // Introduced in 30';
    function hasCarrierFrequencyHz(const AArg0: Integer): Boolean; // Introduced in 26';
    function hasEphemerisData(const AArg0: Integer): Boolean;
    function hashCode: Integer;
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
    class function CONSTELLATION_IRNSS: Integer;
    class function CONSTELLATION_QZSS: Integer;
    class function CONSTELLATION_SBAS: Integer;
    class function CONSTELLATION_UNKNOWN: Integer;
  end;

{ android.location.GnssStatus_Builder }

  [JavaClassSignature('android/location/GnssStatus$Builder')]
  JGnssStatus_Builder = interface(JObject)
    ['{17B85D1A-4649-4E52-93CB-518ACD370F10}']
    function addSatellite(const AArg0: Integer; const AArg1: Integer; const AArg2: Single; const AArg3: Single; const AArg4: Single; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Boolean; const AArg9: Single; const AArg10: Boolean; const AArg11: Single): JGnssStatus_Builder;
    function build: JGnssStatus;
    function clearSatellites: JGnssStatus_Builder;
  end;

  [JavaClassSignature('android/location/GnssStatus$Builder')]
  TJGnssStatus_Builder = class(TJObject, JGnssStatus_Builder)
  private
    { methods }
    function addSatellite(const AArg0: Integer; const AArg1: Integer; const AArg2: Single; const AArg3: Single; const AArg4: Single; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Boolean; const AArg9: Single; const AArg10: Boolean; const AArg11: Single): JGnssStatus_Builder;
    function build: JGnssStatus;
    function clearSatellites: JGnssStatus_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGnssStatus_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JGnssStatus_Builder; overload;
    { constructors }
    class function Create: JGnssStatus_Builder; overload;
  end;

{ android.location.GnssStatus_Callback }

  [JavaClassSignature('android/location/GnssStatus$Callback')]
  JGnssStatus_Callback = interface(JObject)
    ['{9F4E35A0-8F0D-48B8-A361-E684459170D2}']
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

{ android.location.GpsSatellite }

  [JavaClassSignature('android/location/GpsSatellite')]
  JGpsSatellite = interface(JObject)
    ['{611E0BAB-6399-43E9-B94C-57F0B9DF936F}']
    function getAzimuth: Single; deprecated 'Deprecated in 29';
    function getElevation: Single; deprecated 'Deprecated in 29';
    function getPrn: Integer; deprecated 'Deprecated in 29';
    function getSnr: Single; deprecated 'Deprecated in 29';
    function hasAlmanac: Boolean; deprecated 'Deprecated in 29';
    function hasEphemeris: Boolean; deprecated 'Deprecated in 29';
    function usedInFix: Boolean; deprecated 'Deprecated in 29';
  end;

  [JavaClassSignature('android/location/GpsSatellite')]
  TJGpsSatellite = class(TJObject, JGpsSatellite)
  private
    { methods }
    function getAzimuth: Single; deprecated 'Deprecated in 29';
    function getElevation: Single; deprecated 'Deprecated in 29';
    function getPrn: Integer; deprecated 'Deprecated in 29';
    function getSnr: Single; deprecated 'Deprecated in 29';
    function hasAlmanac: Boolean; deprecated 'Deprecated in 29';
    function hasEphemeris: Boolean; deprecated 'Deprecated in 29';
    function usedInFix: Boolean; deprecated 'Deprecated in 29';
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsSatellite; overload;
    class function Wrap(const AObject: IJNIObject): JGpsSatellite; overload;
  end;

{ android.location.GpsStatus }

  [JavaClassSignature('android/location/GpsStatus')]
  JGpsStatus = interface(JObject)
    ['{AC8AF541-4B53-4757-AF6F-93FD0FF9E4A1}']
    function getMaxSatellites: Integer; deprecated 'Deprecated in 29';
    function getSatellites: JIterable; deprecated 'Deprecated in 29';
    function getTimeToFirstFix: Integer; deprecated 'Deprecated in 29';
  end;

  [JavaClassSignature('android/location/GpsStatus')]
  TJGpsStatus = class(TJObject, JGpsStatus)
  private
    { methods }
    function getMaxSatellites: Integer; deprecated 'Deprecated in 29';
    function getSatellites: JIterable; deprecated 'Deprecated in 29';
    function getTimeToFirstFix: Integer; deprecated 'Deprecated in 29';
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
    { methods }
    class function create(const AArg0: JGnssStatus; const AArg1: Integer): JGpsStatus; overload; deprecated 'Deprecated in 30';
  end;

{ android.location.GpsStatus_Listener - interface }

  [JavaClassSignature('android/location/GpsStatus$Listener')]
  JGpsStatus_Listener = interface(IJavaObject)
    ['{4C878F46-C014-4464-9667-692542AB5E0E}']
    procedure onGpsStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 29';
  end;

  [JavaClassSignature('android/location/GpsStatus$Listener')]
  TJGpsStatus_Listener = class(TJObject, JGpsStatus_Listener)
  private
    { methods }
    procedure onGpsStatusChanged(const AArg0: Integer); deprecated 'Deprecated in 29';
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsStatus_Listener; overload;
    class function Wrap(const AObject: IJNIObject): JGpsStatus_Listener; overload;
  end;

{ android.location.GpsStatus_NmeaListener - interface }

  [JavaClassSignature('android/location/GpsStatus$NmeaListener')]
  JGpsStatus_NmeaListener = interface(IJavaObject)
    ['{198C8EF9-0CEA-41B8-B401-3A8EBA5791AF}']
    procedure onNmeaReceived(const AArg0: Int64; const AArg1: JString); deprecated 'Deprecated in 29';
  end;

  [JavaClassSignature('android/location/GpsStatus$NmeaListener')]
  TJGpsStatus_NmeaListener = class(TJObject, JGpsStatus_NmeaListener)
  private
    { methods }
    procedure onNmeaReceived(const AArg0: Int64; const AArg1: JString); deprecated 'Deprecated in 29';
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JGpsStatus_NmeaListener; overload;
    class function Wrap(const AObject: IJNIObject): JGpsStatus_NmeaListener; overload;
  end;

{ android.location.Location }

  [JavaClassSignature('android/location/Location')]
  JLocation = interface(JObject)
    ['{A7FE3BA6-B7D0-4459-9E5C-24BF3BA501B3}']
    function bearingTo(const AArg0: JLocation): Single;
    function describeContents: Integer;
    function distanceTo(const AArg0: JLocation): Single;
    function equals(const AArg0: JObject): Boolean;
    function getAccuracy: Single;
    function getAltitude: Double;
    function getBearing: Single;
    function getBearingAccuracyDegrees: Single; // Introduced in 26';
    function getElapsedRealtimeNanos: Int64;
    function getElapsedRealtimeUncertaintyNanos: Double; // Introduced in 29';
    function getExtras: JBundle;
    function getLatitude: Double;
    function getLongitude: Double;
    function getProvider: JString;
    function getSpeed: Single;
    function getSpeedAccuracyMetersPerSecond: Single; // Introduced in 26';
    function getTime: Int64;
    function getVerticalAccuracyMeters: Single; // Introduced in 26';
    function hasAccuracy: Boolean;
    function hasAltitude: Boolean;
    function hasBearing: Boolean;
    function hasBearingAccuracy: Boolean; // Introduced in 26';
    function hasElapsedRealtimeUncertaintyNanos: Boolean; // Introduced in 29';
    function hasSpeed: Boolean;
    function hasSpeedAccuracy: Boolean; // Introduced in 26';
    function hasVerticalAccuracy: Boolean; // Introduced in 26';
    function hashCode: Integer;
    function isFromMockProvider: Boolean; deprecated 'Deprecated in 31';
    function isMock: Boolean; // Introduced in 31';
    procedure removeAccuracy; deprecated 'Deprecated in 26';
    procedure removeAltitude; deprecated 'Deprecated in 26';
    procedure removeBearing; deprecated 'Deprecated in 26';
    procedure removeSpeed; deprecated 'Deprecated in 26';
    procedure reset;
    procedure &set(const AArg0: JLocation);
    procedure setAccuracy(const AArg0: Single);
    procedure setAltitude(const AArg0: Double);
    procedure setBearing(const AArg0: Single);
    procedure setBearingAccuracyDegrees(const AArg0: Single); // Introduced in 26';
    procedure setElapsedRealtimeNanos(const AArg0: Int64);
    procedure setElapsedRealtimeUncertaintyNanos(const AArg0: Double); // Introduced in 29';
    procedure setExtras(const AArg0: JBundle);
    procedure setLatitude(const AArg0: Double);
    procedure setLongitude(const AArg0: Double);
    procedure setMock(const AArg0: Boolean); // Introduced in 31';
    procedure setProvider(const AArg0: JString);
    procedure setSpeed(const AArg0: Single);
    procedure setSpeedAccuracyMetersPerSecond(const AArg0: Single); // Introduced in 26';
    procedure setTime(const AArg0: Int64);
    procedure setVerticalAccuracyMeters(const AArg0: Single); // Introduced in 26';
    function toString: JString;
  end;

  [JavaClassSignature('android/location/Location')]
  TJLocation = class(TJObject, JLocation)
  private
    { methods }
    function bearingTo(const AArg0: JLocation): Single;
    function describeContents: Integer;
    function distanceTo(const AArg0: JLocation): Single;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getAccuracy: Single;
    function getAltitude: Double;
    function getBearing: Single;
    function getBearingAccuracyDegrees: Single; // Introduced in 26';
    function getElapsedRealtimeNanos: Int64;
    function getElapsedRealtimeUncertaintyNanos: Double; // Introduced in 29';
    function getExtras: JBundle;
    function getLatitude: Double;
    function getLongitude: Double;
    function getProvider: JString;
    function getSpeed: Single;
    function getSpeedAccuracyMetersPerSecond: Single; // Introduced in 26';
    function getTime: Int64;
    function getVerticalAccuracyMeters: Single; // Introduced in 26';
    function hasAccuracy: Boolean;
    function hasAltitude: Boolean;
    function hasBearing: Boolean;
    function hasBearingAccuracy: Boolean; // Introduced in 26';
    function hasElapsedRealtimeUncertaintyNanos: Boolean; // Introduced in 29';
    function hasSpeed: Boolean;
    function hasSpeedAccuracy: Boolean; // Introduced in 26';
    function hasVerticalAccuracy: Boolean; // Introduced in 26';
    function hashCode: Integer;
    function isFromMockProvider: Boolean; deprecated 'Deprecated in 31';
    function isMock: Boolean; // Introduced in 31';
    procedure removeAccuracy; deprecated 'Deprecated in 26';
    procedure removeAltitude; deprecated 'Deprecated in 26';
    procedure removeBearing; deprecated 'Deprecated in 26';
    procedure removeSpeed; deprecated 'Deprecated in 26';
    procedure reset;
    procedure &set(const AArg0: JLocation);
    procedure setAccuracy(const AArg0: Single);
    procedure setAltitude(const AArg0: Double);
    procedure setBearing(const AArg0: Single);
    procedure setBearingAccuracyDegrees(const AArg0: Single); // Introduced in 26';
    procedure setElapsedRealtimeNanos(const AArg0: Int64);
    procedure setElapsedRealtimeUncertaintyNanos(const AArg0: Double); // Introduced in 29';
    procedure setExtras(const AArg0: JBundle);
    procedure setLatitude(const AArg0: Double);
    procedure setLongitude(const AArg0: Double);
    procedure setMock(const AArg0: Boolean); // Introduced in 31';
    procedure setProvider(const AArg0: JString);
    procedure setSpeed(const AArg0: Single);
    procedure setSpeedAccuracyMetersPerSecond(const AArg0: Single); // Introduced in 26';
    procedure setTime(const AArg0: Int64);
    procedure setVerticalAccuracyMeters(const AArg0: Single); // Introduced in 26';
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
    class function convert(const AArg0: JString): Double; overload;
    class function convert(const AArg0: Double; const AArg1: Integer): JString; overload;
    class procedure distanceBetween(const AArg0: Double; const AArg1: Double; const AArg2: Double; const AArg3: Double; const AArg4: IJavaArray<Single>);
  end;

{ android.location.LocationListener - interface }

  [JavaClassSignature('android/location/LocationListener')]
  JLocationListener = interface(IJavaObject)
    ['{8D1D8ED7-9360-48F9-AD80-44BBAE0B7AF0}']
    procedure onLocationChanged(const AArg0: JLocation);
  end;

  [JavaClassSignature('android/location/LocationListener')]
  TJLocationListener = class(TJObject, JLocationListener)
  private
    { methods }
    procedure onLocationChanged(const AArg0: JLocation);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationListener; overload;
    class function Wrap(const AObject: IJNIObject): JLocationListener; overload;
  end;

{ android.location.LocationManager }

  [JavaClassSignature('android/location/LocationManager')]
  JLocationManager = interface(JObject)
    ['{1FD472B5-65EC-4DEB-9FE4-175E66BF8B17}']
    function addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean; deprecated 'Deprecated in 24';
    function addNmeaListener(const AArg0: JExecutor; const AArg1: JOnNmeaMessageListener): Boolean; overload; // Introduced in 30';
    function addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean; overload; deprecated 'Deprecated in 24';
    function addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean; overload; deprecated 'Deprecated in 30';
    function addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    procedure addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
    procedure addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer); overload;
    procedure addTestProvider(const AArg0: JString; const AArg1: JProviderProperties); overload; // Introduced in 31';
    procedure addTestProvider(const AArg0: JString; const AArg1: JProviderProperties; const AArg2: JSet); overload; // Introduced in 31';
    procedure clearTestProviderEnabled(const AArg0: JString); deprecated 'Deprecated in 29';
    procedure clearTestProviderLocation(const AArg0: JString); deprecated 'Deprecated in 29';
    procedure clearTestProviderStatus(const AArg0: JString); deprecated 'Deprecated in 29';
    function getAllProviders: JList;
    function getBestProvider(const AArg0: JCriteria; const AArg1: Boolean): JString;
    function getGnssAntennaInfos: JList; // Introduced in 31';
    function getGnssCapabilities: JGnssCapabilities; // Introduced in 30';
    function getGnssHardwareModelName: JString; // Introduced in 28';
    function getGnssYearOfHardware: Integer; // Introduced in 28';
    function getGpsStatus(const AArg0: JGpsStatus): JGpsStatus; deprecated 'Deprecated in 24';
    function getLastKnownLocation(const AArg0: JString): JLocation;
    function getProvider(const AArg0: JString): JLocationProvider; deprecated 'Deprecated in 31';
    function getProviderProperties(const AArg0: JString): JProviderProperties; // Introduced in 31';
    function getProviders(const AArg0: Boolean): JList; overload;
    function getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList; overload;
    function hasProvider(const AArg0: JString): Boolean; // Introduced in 31';
    function isLocationEnabled: Boolean; // Introduced in 28';
    function isProviderEnabled(const AArg0: JString): Boolean;
    function registerAntennaInfoListener(const AArg0: JExecutor; const AArg1: JGnssAntennaInfo_Listener): Boolean; // Introduced in 30';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementRequest; const AArg1: JExecutor; const AArg2: JGnssMeasurementsEvent_Callback): Boolean; overload; // Introduced in 31';
    function registerGnssMeasurementsCallback(const AArg0: JExecutor; const AArg1: JGnssMeasurementsEvent_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    function registerGnssNavigationMessageCallback(const AArg0: JExecutor; const AArg1: JGnssNavigationMessage_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssStatusCallback(const AArg0: JExecutor; const AArg1: JGnssStatus_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    procedure removeGpsStatusListener(const AArg0: JGpsStatus_Listener); deprecated 'Deprecated in 24';
    procedure removeNmeaListener(const AArg0: JGpsStatus_NmeaListener); overload; deprecated 'Deprecated in 24';
    procedure removeNmeaListener(const AArg0: JOnNmeaMessageListener); overload; // Introduced in 24';
    procedure removeProximityAlert(const AArg0: JPendingIntent);
    procedure removeTestProvider(const AArg0: JString);
    procedure removeUpdates(const AArg0: JPendingIntent); overload;
    procedure removeUpdates(const AArg0: JLocationListener); overload;
    procedure requestFlush(const AArg0: JString; const AArg1: JPendingIntent; const AArg2: Integer); overload; // Introduced in 31';
    procedure requestFlush(const AArg0: JString; const AArg1: JLocationListener; const AArg2: Integer); overload; // Introduced in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JExecutor; const AArg4: JLocationListener); overload; // Introduced in 30';
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JExecutor; const AArg4: JLocationListener); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JPendingIntent); overload; // Introduced in 31';
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JExecutor; const AArg3: JLocationListener); overload; // Introduced in 31';
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper); overload; deprecated 'Deprecated in 30';
    function sendExtraCommand(const AArg0: JString; const AArg1: JString; const AArg2: JBundle): Boolean;
    procedure setTestProviderEnabled(const AArg0: JString; const AArg1: Boolean);
    procedure setTestProviderLocation(const AArg0: JString; const AArg1: JLocation);
    procedure setTestProviderStatus(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle; const AArg3: Int64); deprecated 'Deprecated in 29';
    procedure unregisterAntennaInfoListener(const AArg0: JGnssAntennaInfo_Listener); // Introduced in 30';
    procedure unregisterGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback); // Introduced in 24';
    procedure unregisterGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback); // Introduced in 24';
    procedure unregisterGnssStatusCallback(const AArg0: JGnssStatus_Callback); // Introduced in 24';
  end;

  [JavaClassSignature('android/location/LocationManager')]
  TJLocationManager = class(TJObject, JLocationManager)
  private
    { methods }
    function addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean; deprecated 'Deprecated in 24';
    function addNmeaListener(const AArg0: JExecutor; const AArg1: JOnNmeaMessageListener): Boolean; overload; // Introduced in 30';
    function addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean; overload; deprecated 'Deprecated in 24';
    function addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean; overload; deprecated 'Deprecated in 30';
    function addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    procedure addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
    procedure addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer); overload;
    procedure addTestProvider(const AArg0: JString; const AArg1: JProviderProperties); overload; // Introduced in 31';
    procedure addTestProvider(const AArg0: JString; const AArg1: JProviderProperties; const AArg2: JSet); overload; // Introduced in 31';
    procedure clearTestProviderEnabled(const AArg0: JString); deprecated 'Deprecated in 29';
    procedure clearTestProviderLocation(const AArg0: JString); deprecated 'Deprecated in 29';
    procedure clearTestProviderStatus(const AArg0: JString); deprecated 'Deprecated in 29';
    function getAllProviders: JList;
    function getBestProvider(const AArg0: JCriteria; const AArg1: Boolean): JString;
    function getGnssAntennaInfos: JList; // Introduced in 31';
    function getGnssCapabilities: JGnssCapabilities; // Introduced in 30';
    function getGnssHardwareModelName: JString; // Introduced in 28';
    function getGnssYearOfHardware: Integer; // Introduced in 28';
    function getGpsStatus(const AArg0: JGpsStatus): JGpsStatus; deprecated 'Deprecated in 24';
    function getLastKnownLocation(const AArg0: JString): JLocation;
    function getProvider(const AArg0: JString): JLocationProvider; deprecated 'Deprecated in 31';
    function getProviderProperties(const AArg0: JString): JProviderProperties; // Introduced in 31';
    function getProviders(const AArg0: Boolean): JList; overload;
    function getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList; overload;
    function hasProvider(const AArg0: JString): Boolean; // Introduced in 31';
    function isLocationEnabled: Boolean; // Introduced in 28';
    function isProviderEnabled(const AArg0: JString): Boolean;
    function registerAntennaInfoListener(const AArg0: JExecutor; const AArg1: JGnssAntennaInfo_Listener): Boolean; // Introduced in 30';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementRequest; const AArg1: JExecutor; const AArg2: JGnssMeasurementsEvent_Callback): Boolean; overload; // Introduced in 31';
    function registerGnssMeasurementsCallback(const AArg0: JExecutor; const AArg1: JGnssMeasurementsEvent_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    function registerGnssNavigationMessageCallback(const AArg0: JExecutor; const AArg1: JGnssNavigationMessage_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean; overload; // Introduced in 24';
    function registerGnssStatusCallback(const AArg0: JExecutor; const AArg1: JGnssStatus_Callback): Boolean; overload; // Introduced in 30';
    function registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean; overload; deprecated 'Deprecated in 30';
    procedure removeGpsStatusListener(const AArg0: JGpsStatus_Listener); deprecated 'Deprecated in 24';
    procedure removeNmeaListener(const AArg0: JGpsStatus_NmeaListener); overload; deprecated 'Deprecated in 24';
    procedure removeNmeaListener(const AArg0: JOnNmeaMessageListener); overload; // Introduced in 24';
    procedure removeProximityAlert(const AArg0: JPendingIntent);
    procedure removeTestProvider(const AArg0: JString);
    procedure removeUpdates(const AArg0: JPendingIntent); overload;
    procedure removeUpdates(const AArg0: JLocationListener); overload;
    procedure requestFlush(const AArg0: JString; const AArg1: JPendingIntent; const AArg2: Integer); overload; // Introduced in 31';
    procedure requestFlush(const AArg0: JString; const AArg1: JLocationListener; const AArg2: Integer); overload; // Introduced in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JExecutor; const AArg4: JLocationListener); overload; // Introduced in 30';
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JExecutor; const AArg4: JLocationListener); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent); overload;
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener); overload;
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JPendingIntent); overload; // Introduced in 31';
    procedure requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent); overload; deprecated 'Deprecated in 31';
    procedure requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JExecutor; const AArg3: JLocationListener); overload; // Introduced in 31';
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper); overload; deprecated 'Deprecated in 30';
    procedure requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper); overload; deprecated 'Deprecated in 30';
    function sendExtraCommand(const AArg0: JString; const AArg1: JString; const AArg2: JBundle): Boolean;
    procedure setTestProviderEnabled(const AArg0: JString; const AArg1: Boolean);
    procedure setTestProviderLocation(const AArg0: JString; const AArg1: JLocation);
    procedure setTestProviderStatus(const AArg0: JString; const AArg1: Integer; const AArg2: JBundle; const AArg3: Int64); deprecated 'Deprecated in 29';
    procedure unregisterAntennaInfoListener(const AArg0: JGnssAntennaInfo_Listener); // Introduced in 30';
    procedure unregisterGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback); // Introduced in 24';
    procedure unregisterGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback); // Introduced in 24';
    procedure unregisterGnssStatusCallback(const AArg0: JGnssStatus_Callback); // Introduced in 24';
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationManager; overload;
    class function Wrap(const AObject: IJNIObject): JLocationManager; overload;
    { constants }
    class function ACTION_GNSS_CAPABILITIES_CHANGED: JString;
    class function EXTRA_GNSS_CAPABILITIES: JString;
    class function EXTRA_LOCATION_ENABLED: JString;
    class function EXTRA_PROVIDER_ENABLED: JString;
    class function EXTRA_PROVIDER_NAME: JString;
    class function FUSED_PROVIDER: JString;
    class function GPS_PROVIDER: JString;
    class function KEY_FLUSH_COMPLETE: JString;
    class function KEY_LOCATIONS: JString;
    class function KEY_LOCATION_CHANGED: JString;
    class function KEY_PROVIDER_ENABLED: JString;
    class function KEY_PROXIMITY_ENTERING: JString;
    class function KEY_STATUS_CHANGED: JString;
    class function MODE_CHANGED_ACTION: JString;
    class function NETWORK_PROVIDER: JString;
    class function PASSIVE_PROVIDER: JString;
    class function PROVIDERS_CHANGED_ACTION: JString;
  end;

{ android.location.LocationProvider }

  [JavaClassSignature('android/location/LocationProvider')]
  JLocationProvider = interface(JObject)
    ['{77B7DD7A-3FF3-49BC-BFFF-38D92B304DD8}']
    function getAccuracy: Integer; deprecated 'Deprecated in 31';
    function getName: JString; deprecated 'Deprecated in 31';
    function getPowerRequirement: Integer; deprecated 'Deprecated in 31';
    function hasMonetaryCost: Boolean; deprecated 'Deprecated in 31';
    function meetsCriteria(const AArg0: JCriteria): Boolean; deprecated 'Deprecated in 31';
    function requiresCell: Boolean; deprecated 'Deprecated in 31';
    function requiresNetwork: Boolean; deprecated 'Deprecated in 31';
    function requiresSatellite: Boolean; deprecated 'Deprecated in 31';
    function supportsAltitude: Boolean; deprecated 'Deprecated in 31';
    function supportsBearing: Boolean; deprecated 'Deprecated in 31';
    function supportsSpeed: Boolean; deprecated 'Deprecated in 31';
  end;

  [JavaClassSignature('android/location/LocationProvider')]
  TJLocationProvider = class(TJObject, JLocationProvider)
  private
    { methods }
    function getAccuracy: Integer; deprecated 'Deprecated in 31';
    function getName: JString; deprecated 'Deprecated in 31';
    function getPowerRequirement: Integer; deprecated 'Deprecated in 31';
    function hasMonetaryCost: Boolean; deprecated 'Deprecated in 31';
    function meetsCriteria(const AArg0: JCriteria): Boolean; deprecated 'Deprecated in 31';
    function requiresCell: Boolean; deprecated 'Deprecated in 31';
    function requiresNetwork: Boolean; deprecated 'Deprecated in 31';
    function requiresSatellite: Boolean; deprecated 'Deprecated in 31';
    function supportsAltitude: Boolean; deprecated 'Deprecated in 31';
    function supportsBearing: Boolean; deprecated 'Deprecated in 31';
    function supportsSpeed: Boolean; deprecated 'Deprecated in 31';
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

{ android.location.LocationRequest }

  [JavaClassSignature('android/location/LocationRequest')]
  JLocationRequest = interface(JObject)
    ['{9C5FA806-4BA7-464F-9F93-E9042DB726B1}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getDurationMillis: Int64;
    function getIntervalMillis: Int64;
    function getMaxUpdateDelayMillis: Int64;
    function getMaxUpdates: Integer;
    function getMinUpdateDistanceMeters: Single;
    function getMinUpdateIntervalMillis: Int64;
    function getQuality: Integer;
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/LocationRequest')]
  TJLocationRequest = class(TJObject, JLocationRequest)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getDurationMillis: Int64;
    function getIntervalMillis: Int64;
    function getMaxUpdateDelayMillis: Int64;
    function getMaxUpdates: Integer;
    function getMinUpdateDistanceMeters: Single;
    function getMinUpdateIntervalMillis: Int64;
    function getQuality: Integer;
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationRequest; overload;
    class function Wrap(const AObject: IJNIObject): JLocationRequest; overload;
    { constants }
    class function PASSIVE_INTERVAL: Int64;
    class function QUALITY_BALANCED_POWER_ACCURACY: Integer;
    class function QUALITY_HIGH_ACCURACY: Integer;
    class function QUALITY_LOW_POWER: Integer;
  end;

{ android.location.LocationRequest_Builder }

  [JavaClassSignature('android/location/LocationRequest$Builder')]
  JLocationRequest_Builder = interface(JObject)
    ['{55F9540D-2C38-4300-A89A-7D4940502FFE}']
    function build: JLocationRequest;
    function clearMinUpdateIntervalMillis: JLocationRequest_Builder;
    function setDurationMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setMaxUpdateDelayMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setMaxUpdates(const AArg0: Integer): JLocationRequest_Builder;
    function setMinUpdateDistanceMeters(const AArg0: Single): JLocationRequest_Builder;
    function setMinUpdateIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setQuality(const AArg0: Integer): JLocationRequest_Builder;
  end;

  [JavaClassSignature('android/location/LocationRequest$Builder')]
  TJLocationRequest_Builder = class(TJObject, JLocationRequest_Builder)
  private
    { methods }
    function build: JLocationRequest;
    function clearMinUpdateIntervalMillis: JLocationRequest_Builder;
    function setDurationMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setMaxUpdateDelayMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setMaxUpdates(const AArg0: Integer): JLocationRequest_Builder;
    function setMinUpdateDistanceMeters(const AArg0: Single): JLocationRequest_Builder;
    function setMinUpdateIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
    function setQuality(const AArg0: Integer): JLocationRequest_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JLocationRequest_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JLocationRequest_Builder; overload;
    { constructors }
    class function Create(const AArg0: Int64): JLocationRequest_Builder; overload;
    class function Create(const AArg0: JLocationRequest): JLocationRequest_Builder; overload;
  end;

{ android.location.OnNmeaMessageListener - interface }

  [JavaClassSignature('android/location/OnNmeaMessageListener')]
  JOnNmeaMessageListener = interface(IJavaObject)
    ['{52DC9A4F-87B9-4A6C-ADC9-5ED8B07B29EA}']
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

{ android.location.SettingInjectorService }

  [JavaClassSignature('android/location/SettingInjectorService')]
  JSettingInjectorService = interface(JService)
    ['{7FA3DAAF-2AD0-4B8C-9DFB-FA7E870DEB1A}']
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
    { methods }
    class procedure refreshSettings(const AArg0: JContext); // Introduced in 29';
  end;

{ android.location.provider.ProviderProperties }

  [JavaClassSignature('android/location/provider/ProviderProperties')]
  JProviderProperties = interface(JObject)
    ['{34166ACB-C7D3-464A-BE9C-2D467F260278}']
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean;
    function getAccuracy: Integer;
    function getPowerUsage: Integer;
    function hasAltitudeSupport: Boolean;
    function hasBearingSupport: Boolean;
    function hasCellRequirement: Boolean;
    function hasMonetaryCost: Boolean;
    function hasNetworkRequirement: Boolean;
    function hasSatelliteRequirement: Boolean;
    function hasSpeedSupport: Boolean;
    function hashCode: Integer;
    function toString: JString;
  end;

  [JavaClassSignature('android/location/provider/ProviderProperties')]
  TJProviderProperties = class(TJObject, JProviderProperties)
  private
    { methods }
    function describeContents: Integer;
    function equals(const AArg0: JObject): Boolean; reintroduce;
    function getAccuracy: Integer;
    function getPowerUsage: Integer;
    function hasAltitudeSupport: Boolean;
    function hasBearingSupport: Boolean;
    function hasCellRequirement: Boolean;
    function hasMonetaryCost: Boolean;
    function hasNetworkRequirement: Boolean;
    function hasSatelliteRequirement: Boolean;
    function hasSpeedSupport: Boolean;
    function hashCode: Integer;
    function toString: JString; reintroduce;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JProviderProperties; overload;
    class function Wrap(const AObject: IJNIObject): JProviderProperties; overload;
    { constants }
    class function ACCURACY_COARSE: Integer;
    class function ACCURACY_FINE: Integer;
    class function POWER_USAGE_HIGH: Integer;
    class function POWER_USAGE_LOW: Integer;
    class function POWER_USAGE_MEDIUM: Integer;
  end;

{ android.location.provider.ProviderProperties_Builder }

  [JavaClassSignature('android/location/provider/ProviderProperties$Builder')]
  JProviderProperties_Builder = interface(JObject)
    ['{819B45A5-159E-4416-8512-73D176F39423}']
    function build: JProviderProperties;
    function setAccuracy(const AArg0: Integer): JProviderProperties_Builder;
    function setHasAltitudeSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasBearingSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasCellRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasMonetaryCost(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasNetworkRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasSatelliteRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasSpeedSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setPowerUsage(const AArg0: Integer): JProviderProperties_Builder;
  end;

  [JavaClassSignature('android/location/provider/ProviderProperties$Builder')]
  TJProviderProperties_Builder = class(TJObject, JProviderProperties_Builder)
  private
    { methods }
    function build: JProviderProperties;
    function setAccuracy(const AArg0: Integer): JProviderProperties_Builder;
    function setHasAltitudeSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasBearingSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasCellRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasMonetaryCost(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasNetworkRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasSatelliteRequirement(const AArg0: Boolean): JProviderProperties_Builder;
    function setHasSpeedSupport(const AArg0: Boolean): JProviderProperties_Builder;
    function setPowerUsage(const AArg0: Integer): JProviderProperties_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JProviderProperties_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JProviderProperties_Builder; overload;
    { constructors }
    class function Create: JProviderProperties_Builder; overload;
    class function Create(const AArg0: JProviderProperties): JProviderProperties_Builder; overload;
  end;

implementation

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
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_COARSE', 'I');
end;

class function TJCriteria.ACCURACY_FINE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_FINE', 'I');
end;

class function TJCriteria.ACCURACY_HIGH: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_HIGH', 'I');
end;

class function TJCriteria.ACCURACY_LOW: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_LOW', 'I');
end;

class function TJCriteria.ACCURACY_MEDIUM: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_MEDIUM', 'I');
end;

class function TJCriteria.NO_REQUIREMENT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('NO_REQUIREMENT', 'I');
end;

class function TJCriteria.POWER_HIGH: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_HIGH', 'I');
end;

class function TJCriteria.POWER_LOW: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_LOW', 'I');
end;

class function TJCriteria.POWER_MEDIUM: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_MEDIUM', 'I');
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

{ TJGnssAntennaInfo }

class procedure TJGnssAntennaInfo.LoadConstructors;
begin
end;

class procedure TJGnssAntennaInfo.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getCarrierFrequencyMHz', '()D');
  AddMethod('getPhaseCenterOffset', '()Landroid/location/GnssAntennaInfo$PhaseCenterOffset;');
  AddMethod('getPhaseCenterVariationCorrections', '()Landroid/location/GnssAntennaInfo$SphericalCorrections;');
  AddMethod('getSignalGainCorrections', '()Landroid/location/GnssAntennaInfo$SphericalCorrections;');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssAntennaInfo.Wrap(const AObjectID: JNIObject): JGnssAntennaInfo;
begin
  Result := Wrap<TJGnssAntennaInfo, JGnssAntennaInfo>(AObjectId);
end;

class function TJGnssAntennaInfo.Wrap(const AObject: IJNIObject): JGnssAntennaInfo;
begin
  Result := Wrap<TJGnssAntennaInfo, JGnssAntennaInfo>(AObject);
end;

function TJGnssAntennaInfo.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssAntennaInfo.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssAntennaInfo.getCarrierFrequencyMHz: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getCarrierFrequencyMHz', '()D', []);
end;

function TJGnssAntennaInfo.getPhaseCenterOffset: JGnssAntennaInfo_PhaseCenterOffset;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_PhaseCenterOffset, JGnssAntennaInfo_PhaseCenterOffset>('getPhaseCenterOffset', '()Landroid/location/GnssAntennaInfo$PhaseCenterOffset;', []);
end;

function TJGnssAntennaInfo.getPhaseCenterVariationCorrections: JGnssAntennaInfo_SphericalCorrections;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_SphericalCorrections, JGnssAntennaInfo_SphericalCorrections>('getPhaseCenterVariationCorrections', '()Landroid/location/GnssAntennaInfo$SphericalCorrections;', []);
end;

function TJGnssAntennaInfo.getSignalGainCorrections: JGnssAntennaInfo_SphericalCorrections;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_SphericalCorrections, JGnssAntennaInfo_SphericalCorrections>('getSignalGainCorrections', '()Landroid/location/GnssAntennaInfo$SphericalCorrections;', []);
end;

function TJGnssAntennaInfo.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssAntennaInfo.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssAntennaInfo_Builder }

class procedure TJGnssAntennaInfo_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
  AddMethod('<init>', '(DLandroid/location/GnssAntennaInfo$PhaseCenterOffset;)V');
  AddMethod('<init>', '(Landroid/location/GnssAntennaInfo;)V');
end;

class procedure TJGnssAntennaInfo_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Landroid/location/GnssAntennaInfo;');
  AddMethod('setCarrierFrequencyMHz', '(D)Landroid/location/GnssAntennaInfo$Builder;');
  AddMethod('setPhaseCenterOffset', '(Landroid/location/GnssAntennaInfo$PhaseCenterOffset;)Landroid/location/GnssAntennaInfo$Builder;');
  AddMethod('setPhaseCenterVariationCorrections', '(Landroid/location/GnssAntennaInfo$SphericalCorrections;)Landroid/location/GnssAntennaInfo$Builder;');
  AddMethod('setSignalGainCorrections', '(Landroid/location/GnssAntennaInfo$SphericalCorrections;)Landroid/location/GnssAntennaInfo$Builder;');
end;

class function TJGnssAntennaInfo_Builder.Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_Builder;
begin
  Result := Wrap<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>(AObjectId);
end;

class function TJGnssAntennaInfo_Builder.Wrap(const AObject: IJNIObject): JGnssAntennaInfo_Builder;
begin
  Result := Wrap<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>(AObject);
end;

class function TJGnssAntennaInfo_Builder.Create: JGnssAntennaInfo_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJGnssAntennaInfo_Builder.Create(const AArg0: Double; const AArg1: JGnssAntennaInfo_PhaseCenterOffset): JGnssAntennaInfo_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(DLandroid/location/GnssAntennaInfo$PhaseCenterOffset;)V', [WrapDouble(AArg0), AArg1]);
  Result := O;
end;

class function TJGnssAntennaInfo_Builder.Create(const AArg0: JGnssAntennaInfo): JGnssAntennaInfo_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/GnssAntennaInfo;)V', [AArg0]);
  Result := O;
end;

function TJGnssAntennaInfo_Builder.build: JGnssAntennaInfo;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo, JGnssAntennaInfo>('build', '()Landroid/location/GnssAntennaInfo;', []);
end;

function TJGnssAntennaInfo_Builder.setCarrierFrequencyMHz(const AArg0: Double): JGnssAntennaInfo_Builder;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>('setCarrierFrequencyMHz', '(D)Landroid/location/GnssAntennaInfo$Builder;', [WrapDouble(AArg0)]);
end;

function TJGnssAntennaInfo_Builder.setPhaseCenterOffset(const AArg0: JGnssAntennaInfo_PhaseCenterOffset): JGnssAntennaInfo_Builder;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>('setPhaseCenterOffset', '(Landroid/location/GnssAntennaInfo$PhaseCenterOffset;)Landroid/location/GnssAntennaInfo$Builder;', [AArg0]);
end;

function TJGnssAntennaInfo_Builder.setPhaseCenterVariationCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>('setPhaseCenterVariationCorrections', '(Landroid/location/GnssAntennaInfo$SphericalCorrections;)Landroid/location/GnssAntennaInfo$Builder;', [AArg0]);
end;

function TJGnssAntennaInfo_Builder.setSignalGainCorrections(const AArg0: JGnssAntennaInfo_SphericalCorrections): JGnssAntennaInfo_Builder;
begin
  Result := CallObjectMethod<TJGnssAntennaInfo_Builder, JGnssAntennaInfo_Builder>('setSignalGainCorrections', '(Landroid/location/GnssAntennaInfo$SphericalCorrections;)Landroid/location/GnssAntennaInfo$Builder;', [AArg0]);
end;

{ TJGnssAntennaInfo_Listener }

class procedure TJGnssAntennaInfo_Listener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onGnssAntennaInfoReceived', '(Ljava/util/List;)V');
end;

class function TJGnssAntennaInfo_Listener.Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_Listener;
begin
  Result := Wrap<TJGnssAntennaInfo_Listener, JGnssAntennaInfo_Listener>(AObjectId);
end;

class function TJGnssAntennaInfo_Listener.Wrap(const AObject: IJNIObject): JGnssAntennaInfo_Listener;
begin
  Result := Wrap<TJGnssAntennaInfo_Listener, JGnssAntennaInfo_Listener>(AObject);
end;

procedure TJGnssAntennaInfo_Listener.onGnssAntennaInfoReceived(const AArg0: JList);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGnssAntennaInfoReceived', '(Ljava/util/List;)V', [AArg0]);
end;

{ TJGnssAntennaInfo_PhaseCenterOffset }

class procedure TJGnssAntennaInfo_PhaseCenterOffset.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(DDDDDD)V');
end;

class procedure TJGnssAntennaInfo_PhaseCenterOffset.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getXOffsetMm', '()D');
  AddMethod('getXOffsetUncertaintyMm', '()D');
  AddMethod('getYOffsetMm', '()D');
  AddMethod('getYOffsetUncertaintyMm', '()D');
  AddMethod('getZOffsetMm', '()D');
  AddMethod('getZOffsetUncertaintyMm', '()D');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssAntennaInfo_PhaseCenterOffset.Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_PhaseCenterOffset;
begin
  Result := Wrap<TJGnssAntennaInfo_PhaseCenterOffset, JGnssAntennaInfo_PhaseCenterOffset>(AObjectId);
end;

class function TJGnssAntennaInfo_PhaseCenterOffset.Wrap(const AObject: IJNIObject): JGnssAntennaInfo_PhaseCenterOffset;
begin
  Result := Wrap<TJGnssAntennaInfo_PhaseCenterOffset, JGnssAntennaInfo_PhaseCenterOffset>(AObject);
end;

class function TJGnssAntennaInfo_PhaseCenterOffset.Create(const AArg0: Double; const AArg1: Double; const AArg2: Double; const AArg3: Double; const AArg4: Double; const AArg5: Double): JGnssAntennaInfo_PhaseCenterOffset;
begin
  var O := CreateForWrap;
  O.NewObject('(DDDDDD)V', [WrapDouble(AArg0), WrapDouble(AArg1), WrapDouble(AArg2), WrapDouble(AArg3), WrapDouble(AArg4), WrapDouble(AArg5)]);
  Result := O;
end;

function TJGnssAntennaInfo_PhaseCenterOffset.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getXOffsetMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getXOffsetMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getXOffsetUncertaintyMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getXOffsetUncertaintyMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getYOffsetMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getYOffsetMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getYOffsetUncertaintyMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getYOffsetUncertaintyMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getZOffsetMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getZOffsetMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.getZOffsetUncertaintyMm: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getZOffsetUncertaintyMm', '()D', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssAntennaInfo_PhaseCenterOffset.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssAntennaInfo_SphericalCorrections }

class procedure TJGnssAntennaInfo_SphericalCorrections.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '([[D[[D)V');
end;

class procedure TJGnssAntennaInfo_SphericalCorrections.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getCorrectionUncertaintiesArray', '()[[D');
  AddMethod('getCorrectionsArray', '()[[D');
  AddMethod('getDeltaPhi', '()D');
  AddMethod('getDeltaTheta', '()D');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssAntennaInfo_SphericalCorrections.Wrap(const AObjectID: JNIObject): JGnssAntennaInfo_SphericalCorrections;
begin
  Result := Wrap<TJGnssAntennaInfo_SphericalCorrections, JGnssAntennaInfo_SphericalCorrections>(AObjectId);
end;

class function TJGnssAntennaInfo_SphericalCorrections.Wrap(const AObject: IJNIObject): JGnssAntennaInfo_SphericalCorrections;
begin
  Result := Wrap<TJGnssAntennaInfo_SphericalCorrections, JGnssAntennaInfo_SphericalCorrections>(AObject);
end;

class function TJGnssAntennaInfo_SphericalCorrections.Create(const AArg0: IJavaArray<Double>; const AArg1: IJavaArray<Double>): JGnssAntennaInfo_SphericalCorrections;
begin
  var O := CreateForWrap;
  O.NewObject('([[D[[D)V', [AArg0, AArg1]);
  Result := O;
end;

function TJGnssAntennaInfo_SphericalCorrections.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssAntennaInfo_SphericalCorrections.getCorrectionUncertaintiesArray: IJavaArray<Double>;
begin
  Result := CallArrayMethod<Double>('getCorrectionUncertaintiesArray', '()[[D', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.getCorrectionsArray: IJavaArray<Double>;
begin
  Result := CallArrayMethod<Double>('getCorrectionsArray', '()[[D', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.getDeltaPhi: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getDeltaPhi', '()D', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.getDeltaTheta: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getDeltaTheta', '()D', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssAntennaInfo_SphericalCorrections.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssCapabilities }

class procedure TJGnssCapabilities.LoadConstructors;
begin
end;

class procedure TJGnssCapabilities.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('hasAntennaInfo', '()Z');
  AddMethod('hasGnssAntennaInfo', '()Z');
  AddMethod('hasMeasurements', '()Z');
  AddMethod('hasNavigationMessages', '()Z');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssCapabilities.Wrap(const AObjectID: JNIObject): JGnssCapabilities;
begin
  Result := Wrap<TJGnssCapabilities, JGnssCapabilities>(AObjectId);
end;

class function TJGnssCapabilities.Wrap(const AObject: IJNIObject): JGnssCapabilities;
begin
  Result := Wrap<TJGnssCapabilities, JGnssCapabilities>(AObject);
end;

function TJGnssCapabilities.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssCapabilities.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssCapabilities.hasAntennaInfo: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAntennaInfo', '()Z', []);
end;

function TJGnssCapabilities.hasGnssAntennaInfo: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasGnssAntennaInfo', '()Z', []);
end;

function TJGnssCapabilities.hasMeasurements: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasMeasurements', '()Z', []);
end;

function TJGnssCapabilities.hasNavigationMessages: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasNavigationMessages', '()Z', []);
end;

function TJGnssCapabilities.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssCapabilities.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssCapabilities_Builder }

class procedure TJGnssCapabilities_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
  AddMethod('<init>', '(Landroid/location/GnssCapabilities;)V');
end;

class procedure TJGnssCapabilities_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Landroid/location/GnssCapabilities;');
  AddMethod('setHasAntennaInfo', '(Z)Landroid/location/GnssCapabilities$Builder;');
  AddMethod('setHasMeasurements', '(Z)Landroid/location/GnssCapabilities$Builder;');
  AddMethod('setHasNavigationMessages', '(Z)Landroid/location/GnssCapabilities$Builder;');
end;

class function TJGnssCapabilities_Builder.Wrap(const AObjectID: JNIObject): JGnssCapabilities_Builder;
begin
  Result := Wrap<TJGnssCapabilities_Builder, JGnssCapabilities_Builder>(AObjectId);
end;

class function TJGnssCapabilities_Builder.Wrap(const AObject: IJNIObject): JGnssCapabilities_Builder;
begin
  Result := Wrap<TJGnssCapabilities_Builder, JGnssCapabilities_Builder>(AObject);
end;

class function TJGnssCapabilities_Builder.Create: JGnssCapabilities_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJGnssCapabilities_Builder.Create(const AArg0: JGnssCapabilities): JGnssCapabilities_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/GnssCapabilities;)V', [AArg0]);
  Result := O;
end;

function TJGnssCapabilities_Builder.build: JGnssCapabilities;
begin
  Result := CallObjectMethod<TJGnssCapabilities, JGnssCapabilities>('build', '()Landroid/location/GnssCapabilities;', []);
end;

function TJGnssCapabilities_Builder.setHasAntennaInfo(const AArg0: Boolean): JGnssCapabilities_Builder;
begin
  Result := CallObjectMethod<TJGnssCapabilities_Builder, JGnssCapabilities_Builder>('setHasAntennaInfo', '(Z)Landroid/location/GnssCapabilities$Builder;', [AArg0]);
end;

function TJGnssCapabilities_Builder.setHasMeasurements(const AArg0: Boolean): JGnssCapabilities_Builder;
begin
  Result := CallObjectMethod<TJGnssCapabilities_Builder, JGnssCapabilities_Builder>('setHasMeasurements', '(Z)Landroid/location/GnssCapabilities$Builder;', [AArg0]);
end;

function TJGnssCapabilities_Builder.setHasNavigationMessages(const AArg0: Boolean): JGnssCapabilities_Builder;
begin
  Result := CallObjectMethod<TJGnssCapabilities_Builder, JGnssCapabilities_Builder>('setHasNavigationMessages', '(Z)Landroid/location/GnssCapabilities$Builder;', [AArg0]);
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
  AddMethod('getElapsedRealtimeNanos', '()J');
  AddMethod('getElapsedRealtimeUncertaintyNanos', '()D');
  AddMethod('getFullBiasNanos', '()J');
  AddMethod('getHardwareClockDiscontinuityCount', '()I');
  AddMethod('getLeapSecond', '()I');
  AddMethod('getReferenceCarrierFrequencyHzForIsb', '()D');
  AddMethod('getReferenceCodeTypeForIsb', '()Ljava/lang/String;');
  AddMethod('getReferenceConstellationTypeForIsb', '()I');
  AddMethod('getTimeNanos', '()J');
  AddMethod('getTimeUncertaintyNanos', '()D');
  AddMethod('hasBiasNanos', '()Z');
  AddMethod('hasBiasUncertaintyNanos', '()Z');
  AddMethod('hasDriftNanosPerSecond', '()Z');
  AddMethod('hasDriftUncertaintyNanosPerSecond', '()Z');
  AddMethod('hasElapsedRealtimeNanos', '()Z');
  AddMethod('hasElapsedRealtimeUncertaintyNanos', '()Z');
  AddMethod('hasFullBiasNanos', '()Z');
  AddMethod('hasLeapSecond', '()Z');
  AddMethod('hasReferenceCarrierFrequencyHzForIsb', '()Z');
  AddMethod('hasReferenceCodeTypeForIsb', '()Z');
  AddMethod('hasReferenceConstellationTypeForIsb', '()Z');
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

function TJGnssClock.getElapsedRealtimeNanos: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getElapsedRealtimeNanos', '()J', []);
end;

function TJGnssClock.getElapsedRealtimeUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getElapsedRealtimeUncertaintyNanos', '()D', []);
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

function TJGnssClock.getReferenceCarrierFrequencyHzForIsb: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getReferenceCarrierFrequencyHzForIsb', '()D', []);
end;

function TJGnssClock.getReferenceCodeTypeForIsb: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getReferenceCodeTypeForIsb', '()Ljava/lang/String;', []);
end;

function TJGnssClock.getReferenceConstellationTypeForIsb: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getReferenceConstellationTypeForIsb', '()I', []);
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

function TJGnssClock.hasElapsedRealtimeNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasElapsedRealtimeNanos', '()Z', []);
end;

function TJGnssClock.hasElapsedRealtimeUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasElapsedRealtimeUncertaintyNanos', '()Z', []);
end;

function TJGnssClock.hasFullBiasNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasFullBiasNanos', '()Z', []);
end;

function TJGnssClock.hasLeapSecond: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasLeapSecond', '()Z', []);
end;

function TJGnssClock.hasReferenceCarrierFrequencyHzForIsb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasReferenceCarrierFrequencyHzForIsb', '()Z', []);
end;

function TJGnssClock.hasReferenceCodeTypeForIsb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasReferenceCodeTypeForIsb', '()Z', []);
end;

function TJGnssClock.hasReferenceConstellationTypeForIsb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasReferenceConstellationTypeForIsb', '()Z', []);
end;

function TJGnssClock.hasTimeUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasTimeUncertaintyNanos', '()Z', []);
end;

function TJGnssClock.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
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
  AddMethod('getBasebandCn0DbHz', '()D');
  AddMethod('getCarrierCycles', '()J');
  AddMethod('getCarrierFrequencyHz', '()F');
  AddMethod('getCarrierPhase', '()D');
  AddMethod('getCarrierPhaseUncertainty', '()D');
  AddMethod('getCn0DbHz', '()D');
  AddMethod('getCodeType', '()Ljava/lang/String;');
  AddMethod('getConstellationType', '()I');
  AddMethod('getFullInterSignalBiasNanos', '()D');
  AddMethod('getFullInterSignalBiasUncertaintyNanos', '()D');
  AddMethod('getMultipathIndicator', '()I');
  AddMethod('getPseudorangeRateMetersPerSecond', '()D');
  AddMethod('getPseudorangeRateUncertaintyMetersPerSecond', '()D');
  AddMethod('getReceivedSvTimeNanos', '()J');
  AddMethod('getReceivedSvTimeUncertaintyNanos', '()J');
  AddMethod('getSatelliteInterSignalBiasNanos', '()D');
  AddMethod('getSatelliteInterSignalBiasUncertaintyNanos', '()D');
  AddMethod('getSnrInDb', '()D');
  AddMethod('getState', '()I');
  AddMethod('getSvid', '()I');
  AddMethod('getTimeOffsetNanos', '()D');
  AddMethod('hasAutomaticGainControlLevelDb', '()Z');
  AddMethod('hasBasebandCn0DbHz', '()Z');
  AddMethod('hasCarrierCycles', '()Z');
  AddMethod('hasCarrierFrequencyHz', '()Z');
  AddMethod('hasCarrierPhase', '()Z');
  AddMethod('hasCarrierPhaseUncertainty', '()Z');
  AddMethod('hasCodeType', '()Z');
  AddMethod('hasFullInterSignalBiasNanos', '()Z');
  AddMethod('hasFullInterSignalBiasUncertaintyNanos', '()Z');
  AddMethod('hasSatelliteInterSignalBiasNanos', '()Z');
  AddMethod('hasSatelliteInterSignalBiasUncertaintyNanos', '()Z');
  AddMethod('hasSnrInDb', '()Z');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJGnssMeasurement.LoadFields;
begin
  inherited;
  AddStaticField('ADR_STATE_CYCLE_SLIP', 'I');
  AddStaticField('ADR_STATE_HALF_CYCLE_REPORTED', 'I');
  AddStaticField('ADR_STATE_HALF_CYCLE_RESOLVED', 'I');
  AddStaticField('ADR_STATE_RESET', 'I');
  AddStaticField('ADR_STATE_UNKNOWN', 'I');
  AddStaticField('ADR_STATE_VALID', 'I');
  AddStaticField('MULTIPATH_INDICATOR_DETECTED', 'I');
  AddStaticField('MULTIPATH_INDICATOR_NOT_DETECTED', 'I');
  AddStaticField('MULTIPATH_INDICATOR_UNKNOWN', 'I');
  AddStaticField('STATE_2ND_CODE_LOCK', 'I');
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
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_CYCLE_SLIP', 'I');
end;

class function TJGnssMeasurement.ADR_STATE_HALF_CYCLE_REPORTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_HALF_CYCLE_REPORTED', 'I');
end;

class function TJGnssMeasurement.ADR_STATE_HALF_CYCLE_RESOLVED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_HALF_CYCLE_RESOLVED', 'I');
end;

class function TJGnssMeasurement.ADR_STATE_RESET: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_RESET', 'I');
end;

class function TJGnssMeasurement.ADR_STATE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_UNKNOWN', 'I');
end;

class function TJGnssMeasurement.ADR_STATE_VALID: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ADR_STATE_VALID', 'I');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_DETECTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_DETECTED', 'I');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_NOT_DETECTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_NOT_DETECTED', 'I');
end;

class function TJGnssMeasurement.MULTIPATH_INDICATOR_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('MULTIPATH_INDICATOR_UNKNOWN', 'I');
end;

class function TJGnssMeasurement.STATE_2ND_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_2ND_CODE_LOCK', 'I');
end;

class function TJGnssMeasurement.STATE_BDS_D2_BIT_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BDS_D2_BIT_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_BDS_D2_SUBFRAME_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BDS_D2_SUBFRAME_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_BIT_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_BIT_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_CODE_LOCK', 'I');
end;

class function TJGnssMeasurement.STATE_GAL_E1BC_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1BC_CODE_LOCK', 'I');
end;

class function TJGnssMeasurement.STATE_GAL_E1B_PAGE_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1B_PAGE_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_GAL_E1C_2ND_CODE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GAL_E1C_2ND_CODE_LOCK', 'I');
end;

class function TJGnssMeasurement.STATE_GLO_STRING_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_STRING_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_GLO_TOD_DECODED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_TOD_DECODED', 'I');
end;

class function TJGnssMeasurement.STATE_GLO_TOD_KNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_GLO_TOD_KNOWN', 'I');
end;

class function TJGnssMeasurement.STATE_MSEC_AMBIGUOUS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_MSEC_AMBIGUOUS', 'I');
end;

class function TJGnssMeasurement.STATE_SBAS_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SBAS_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_SUBFRAME_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SUBFRAME_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_SYMBOL_SYNC: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_SYMBOL_SYNC', 'I');
end;

class function TJGnssMeasurement.STATE_TOW_DECODED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_TOW_DECODED', 'I');
end;

class function TJGnssMeasurement.STATE_TOW_KNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_TOW_KNOWN', 'I');
end;

class function TJGnssMeasurement.STATE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATE_UNKNOWN', 'I');
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

function TJGnssMeasurement.getBasebandCn0DbHz: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getBasebandCn0DbHz', '()D', []);
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

function TJGnssMeasurement.getCodeType: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getCodeType', '()Ljava/lang/String;', []);
end;

function TJGnssMeasurement.getConstellationType: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getConstellationType', '()I', []);
end;

function TJGnssMeasurement.getFullInterSignalBiasNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getFullInterSignalBiasNanos', '()D', []);
end;

function TJGnssMeasurement.getFullInterSignalBiasUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getFullInterSignalBiasUncertaintyNanos', '()D', []);
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

function TJGnssMeasurement.getSatelliteInterSignalBiasNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getSatelliteInterSignalBiasNanos', '()D', []);
end;

function TJGnssMeasurement.getSatelliteInterSignalBiasUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getSatelliteInterSignalBiasUncertaintyNanos', '()D', []);
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

function TJGnssMeasurement.hasBasebandCn0DbHz: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBasebandCn0DbHz', '()Z', []);
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

function TJGnssMeasurement.hasCodeType: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCodeType', '()Z', []);
end;

function TJGnssMeasurement.hasFullInterSignalBiasNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasFullInterSignalBiasNanos', '()Z', []);
end;

function TJGnssMeasurement.hasFullInterSignalBiasUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasFullInterSignalBiasUncertaintyNanos', '()Z', []);
end;

function TJGnssMeasurement.hasSatelliteInterSignalBiasNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSatelliteInterSignalBiasNanos', '()Z', []);
end;

function TJGnssMeasurement.hasSatelliteInterSignalBiasUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSatelliteInterSignalBiasUncertaintyNanos', '()Z', []);
end;

function TJGnssMeasurement.hasSnrInDb: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSnrInDb', '()Z', []);
end;

function TJGnssMeasurement.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssMeasurementRequest }

class procedure TJGnssMeasurementRequest.LoadConstructors;
begin
end;

class procedure TJGnssMeasurementRequest.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('hashCode', '()I');
  AddMethod('isFullTracking', '()Z');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class function TJGnssMeasurementRequest.Wrap(const AObjectID: JNIObject): JGnssMeasurementRequest;
begin
  Result := Wrap<TJGnssMeasurementRequest, JGnssMeasurementRequest>(AObjectId);
end;

class function TJGnssMeasurementRequest.Wrap(const AObject: IJNIObject): JGnssMeasurementRequest;
begin
  Result := Wrap<TJGnssMeasurementRequest, JGnssMeasurementRequest>(AObject);
end;

function TJGnssMeasurementRequest.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssMeasurementRequest.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssMeasurementRequest.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssMeasurementRequest.isFullTracking: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isFullTracking', '()Z', []);
end;

function TJGnssMeasurementRequest.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJGnssMeasurementRequest_Builder }

class procedure TJGnssMeasurementRequest_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
  AddMethod('<init>', '(Landroid/location/GnssMeasurementRequest;)V');
end;

class procedure TJGnssMeasurementRequest_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Landroid/location/GnssMeasurementRequest;');
  AddMethod('setFullTracking', '(Z)Landroid/location/GnssMeasurementRequest$Builder;');
end;

class function TJGnssMeasurementRequest_Builder.Wrap(const AObjectID: JNIObject): JGnssMeasurementRequest_Builder;
begin
  Result := Wrap<TJGnssMeasurementRequest_Builder, JGnssMeasurementRequest_Builder>(AObjectId);
end;

class function TJGnssMeasurementRequest_Builder.Wrap(const AObject: IJNIObject): JGnssMeasurementRequest_Builder;
begin
  Result := Wrap<TJGnssMeasurementRequest_Builder, JGnssMeasurementRequest_Builder>(AObject);
end;

class function TJGnssMeasurementRequest_Builder.Create: JGnssMeasurementRequest_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJGnssMeasurementRequest_Builder.Create(const AArg0: JGnssMeasurementRequest): JGnssMeasurementRequest_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/GnssMeasurementRequest;)V', [AArg0]);
  Result := O;
end;

function TJGnssMeasurementRequest_Builder.build: JGnssMeasurementRequest;
begin
  Result := CallObjectMethod<TJGnssMeasurementRequest, JGnssMeasurementRequest>('build', '()Landroid/location/GnssMeasurementRequest;', []);
end;

function TJGnssMeasurementRequest_Builder.setFullTracking(const AArg0: Boolean): JGnssMeasurementRequest_Builder;
begin
  Result := CallObjectMethod<TJGnssMeasurementRequest_Builder, JGnssMeasurementRequest_Builder>('setFullTracking', '(Z)Landroid/location/GnssMeasurementRequest$Builder;', [AArg0]);
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
  AddStaticField('STATUS_NOT_ALLOWED', 'I');
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
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_LOCATION_DISABLED', 'I');
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_NOT_ALLOWED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_NOT_ALLOWED', 'I');
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_NOT_SUPPORTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_NOT_SUPPORTED', 'I');
end;

class function TJGnssMeasurementsEvent_Callback.STATUS_READY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_READY', 'I');
end;

procedure TJGnssMeasurementsEvent_Callback.onGnssMeasurementsReceived(const AArg0: JGnssMeasurementsEvent);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGnssMeasurementsReceived', '(Landroid/location/GnssMeasurementsEvent;)V', [AArg0]);
end;

procedure TJGnssMeasurementsEvent_Callback.onStatusChanged(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStatusChanged', '(I)V', [AArg0]);
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
  AddStaticField('TYPE_BDS_CNAV1', 'I');
  AddStaticField('TYPE_BDS_CNAV2', 'I');
  AddStaticField('TYPE_BDS_D1', 'I');
  AddStaticField('TYPE_BDS_D2', 'I');
  AddStaticField('TYPE_GAL_F', 'I');
  AddStaticField('TYPE_GAL_I', 'I');
  AddStaticField('TYPE_GLO_L1CA', 'I');
  AddStaticField('TYPE_GPS_CNAV2', 'I');
  AddStaticField('TYPE_GPS_L1CA', 'I');
  AddStaticField('TYPE_GPS_L2CNAV', 'I');
  AddStaticField('TYPE_GPS_L5CNAV', 'I');
  AddStaticField('TYPE_IRN_L5CA', 'I');
  AddStaticField('TYPE_QZS_L1CA', 'I');
  AddStaticField('TYPE_SBS', 'I');
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
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_PARITY_PASSED', 'I');
end;

class function TJGnssNavigationMessage.STATUS_PARITY_REBUILT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_PARITY_REBUILT', 'I');
end;

class function TJGnssNavigationMessage.STATUS_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_UNKNOWN', 'I');
end;

class function TJGnssNavigationMessage.TYPE_BDS_CNAV1: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_CNAV1', 'I');
end;

class function TJGnssNavigationMessage.TYPE_BDS_CNAV2: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_CNAV2', 'I');
end;

class function TJGnssNavigationMessage.TYPE_BDS_D1: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_D1', 'I');
end;

class function TJGnssNavigationMessage.TYPE_BDS_D2: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_BDS_D2', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GAL_F: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GAL_F', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GAL_I: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GAL_I', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GLO_L1CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GLO_L1CA', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GPS_CNAV2: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_CNAV2', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L1CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L1CA', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L2CNAV: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L2CNAV', 'I');
end;

class function TJGnssNavigationMessage.TYPE_GPS_L5CNAV: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_GPS_L5CNAV', 'I');
end;

class function TJGnssNavigationMessage.TYPE_IRN_L5CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_IRN_L5CA', 'I');
end;

class function TJGnssNavigationMessage.TYPE_QZS_L1CA: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_QZS_L1CA', 'I');
end;

class function TJGnssNavigationMessage.TYPE_SBS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_SBS', 'I');
end;

class function TJGnssNavigationMessage.TYPE_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TYPE_UNKNOWN', 'I');
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
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_LOCATION_DISABLED', 'I');
end;

class function TJGnssNavigationMessage_Callback.STATUS_NOT_SUPPORTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_NOT_SUPPORTED', 'I');
end;

class function TJGnssNavigationMessage_Callback.STATUS_READY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('STATUS_READY', 'I');
end;

procedure TJGnssNavigationMessage_Callback.onGnssNavigationMessageReceived(const AArg0: JGnssNavigationMessage);
begin
  JavaType.CallVoidMethod(ObjectID, 'onGnssNavigationMessageReceived', '(Landroid/location/GnssNavigationMessage;)V', [AArg0]);
end;

procedure TJGnssNavigationMessage_Callback.onStatusChanged(const AArg0: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStatusChanged', '(I)V', [AArg0]);
end;

{ TJGnssStatus }

class procedure TJGnssStatus.LoadConstructors;
begin
end;

class procedure TJGnssStatus.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getAzimuthDegrees', '(I)F');
  AddMethod('getBasebandCn0DbHz', '(I)F');
  AddMethod('getCarrierFrequencyHz', '(I)F');
  AddMethod('getCn0DbHz', '(I)F');
  AddMethod('getConstellationType', '(I)I');
  AddMethod('getElevationDegrees', '(I)F');
  AddMethod('getSatelliteCount', '()I');
  AddMethod('getSvid', '(I)I');
  AddMethod('hasAlmanacData', '(I)Z');
  AddMethod('hasBasebandCn0DbHz', '(I)Z');
  AddMethod('hasCarrierFrequencyHz', '(I)Z');
  AddMethod('hasEphemerisData', '(I)Z');
  AddMethod('hashCode', '()I');
  AddMethod('usedInFix', '(I)Z');
end;

class procedure TJGnssStatus.LoadFields;
begin
  inherited;
  AddStaticField('CONSTELLATION_BEIDOU', 'I');
  AddStaticField('CONSTELLATION_GALILEO', 'I');
  AddStaticField('CONSTELLATION_GLONASS', 'I');
  AddStaticField('CONSTELLATION_GPS', 'I');
  AddStaticField('CONSTELLATION_IRNSS', 'I');
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
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_BEIDOU', 'I');
end;

class function TJGnssStatus.CONSTELLATION_GALILEO: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GALILEO', 'I');
end;

class function TJGnssStatus.CONSTELLATION_GLONASS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GLONASS', 'I');
end;

class function TJGnssStatus.CONSTELLATION_GPS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_GPS', 'I');
end;

class function TJGnssStatus.CONSTELLATION_IRNSS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_IRNSS', 'I');
end;

class function TJGnssStatus.CONSTELLATION_QZSS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_QZSS', 'I');
end;

class function TJGnssStatus.CONSTELLATION_SBAS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_SBAS', 'I');
end;

class function TJGnssStatus.CONSTELLATION_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CONSTELLATION_UNKNOWN', 'I');
end;

function TJGnssStatus.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJGnssStatus.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJGnssStatus.getAzimuthDegrees(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getAzimuthDegrees', '(I)F', [AArg0]);
end;

function TJGnssStatus.getBasebandCn0DbHz(const AArg0: Integer): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getBasebandCn0DbHz', '(I)F', [AArg0]);
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

function TJGnssStatus.hasBasebandCn0DbHz(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBasebandCn0DbHz', '(I)Z', [AArg0]);
end;

function TJGnssStatus.hasCarrierFrequencyHz(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCarrierFrequencyHz', '(I)Z', [AArg0]);
end;

function TJGnssStatus.hasEphemerisData(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasEphemerisData', '(I)Z', [AArg0]);
end;

function TJGnssStatus.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJGnssStatus.usedInFix(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'usedInFix', '(I)Z', [AArg0]);
end;

{ TJGnssStatus_Builder }

class procedure TJGnssStatus_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJGnssStatus_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('addSatellite', '(IIFFFZZZZFZF)Landroid/location/GnssStatus$Builder;');
  AddMethod('build', '()Landroid/location/GnssStatus;');
  AddMethod('clearSatellites', '()Landroid/location/GnssStatus$Builder;');
end;

class function TJGnssStatus_Builder.Wrap(const AObjectID: JNIObject): JGnssStatus_Builder;
begin
  Result := Wrap<TJGnssStatus_Builder, JGnssStatus_Builder>(AObjectId);
end;

class function TJGnssStatus_Builder.Wrap(const AObject: IJNIObject): JGnssStatus_Builder;
begin
  Result := Wrap<TJGnssStatus_Builder, JGnssStatus_Builder>(AObject);
end;

class function TJGnssStatus_Builder.Create: JGnssStatus_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

function TJGnssStatus_Builder.addSatellite(const AArg0: Integer; const AArg1: Integer; const AArg2: Single; const AArg3: Single; const AArg4: Single; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Boolean; const AArg9: Single; const AArg10: Boolean; const AArg11: Single): JGnssStatus_Builder;
begin
  Result := CallObjectMethod<TJGnssStatus_Builder, JGnssStatus_Builder>('addSatellite', '(IIFFFZZZZFZF)Landroid/location/GnssStatus$Builder;', [AArg0, AArg1, AArg2, AArg3, AArg4, AArg5, AArg6, AArg7, AArg8, AArg9, AArg10, AArg11]);
end;

function TJGnssStatus_Builder.build: JGnssStatus;
begin
  Result := CallObjectMethod<TJGnssStatus, JGnssStatus>('build', '()Landroid/location/GnssStatus;', []);
end;

function TJGnssStatus_Builder.clearSatellites: JGnssStatus_Builder;
begin
  Result := CallObjectMethod<TJGnssStatus_Builder, JGnssStatus_Builder>('clearSatellites', '()Landroid/location/GnssStatus$Builder;', []);
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

{ TJGpsStatus }

class procedure TJGpsStatus.LoadConstructors;
begin
end;

class procedure TJGpsStatus.LoadMethods;
begin
  inherited;
  { methods }
  AddStaticMethod('create', '(Landroid/location/GnssStatus;I)Landroid/location/GpsStatus;');
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
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_FIRST_FIX', 'I');
end;

class function TJGpsStatus.GPS_EVENT_SATELLITE_STATUS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_SATELLITE_STATUS', 'I');
end;

class function TJGpsStatus.GPS_EVENT_STARTED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_STARTED', 'I');
end;

class function TJGpsStatus.GPS_EVENT_STOPPED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('GPS_EVENT_STOPPED', 'I');
end;

class function TJGpsStatus.create(const AArg0: JGnssStatus; const AArg1: Integer): JGpsStatus;
begin
  Result := CallStaticObjectMethod<TJGpsStatus, JGpsStatus>('create', '(Landroid/location/GnssStatus;I)Landroid/location/GpsStatus;', [AArg0, AArg1]);
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
  AddStaticMethod('convert', '(Ljava/lang/String;)D');
  AddStaticMethod('convert', '(DI)Ljava/lang/String;');
  AddMethod('describeContents', '()I');
  AddStaticMethod('distanceBetween', '(DDDD[F)V');
  AddMethod('distanceTo', '(Landroid/location/Location;)F');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getAccuracy', '()F');
  AddMethod('getAltitude', '()D');
  AddMethod('getBearing', '()F');
  AddMethod('getBearingAccuracyDegrees', '()F');
  AddMethod('getElapsedRealtimeNanos', '()J');
  AddMethod('getElapsedRealtimeUncertaintyNanos', '()D');
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
  AddMethod('hasElapsedRealtimeUncertaintyNanos', '()Z');
  AddMethod('hasSpeed', '()Z');
  AddMethod('hasSpeedAccuracy', '()Z');
  AddMethod('hasVerticalAccuracy', '()Z');
  AddMethod('hashCode', '()I');
  AddMethod('isFromMockProvider', '()Z');
  AddMethod('isMock', '()Z');
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
  AddMethod('setElapsedRealtimeUncertaintyNanos', '(D)V');
  AddMethod('setExtras', '(Landroid/os/Bundle;)V');
  AddMethod('setLatitude', '(D)V');
  AddMethod('setLongitude', '(D)V');
  AddMethod('setMock', '(Z)V');
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
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_DEGREES', 'I');
end;

class function TJLocation.FORMAT_MINUTES: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_MINUTES', 'I');
end;

class function TJLocation.FORMAT_SECONDS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FORMAT_SECONDS', 'I');
end;

function TJLocation.bearingTo(const AArg0: JLocation): Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'bearingTo', '(Landroid/location/Location;)F', [AArg0]);
end;

class function TJLocation.convert(const AArg0: JString): Double;
begin
  Result := StaticJavaType[Self].CallStaticDoubleMethod('convert', '(Ljava/lang/String;)D', [AArg0]);
end;

class function TJLocation.convert(const AArg0: Double; const AArg1: Integer): JString;
begin
  Result := CallStaticObjectMethod<TJString, JString>('convert', '(DI)Ljava/lang/String;', [WrapDouble(AArg0), AArg1]);
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

function TJLocation.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
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

function TJLocation.getElapsedRealtimeUncertaintyNanos: Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getElapsedRealtimeUncertaintyNanos', '()D', []);
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

function TJLocation.hasElapsedRealtimeUncertaintyNanos: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasElapsedRealtimeUncertaintyNanos', '()Z', []);
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

function TJLocation.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJLocation.isFromMockProvider: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isFromMockProvider', '()Z', []);
end;

function TJLocation.isMock: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isMock', '()Z', []);
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

procedure TJLocation.setElapsedRealtimeUncertaintyNanos(const AArg0: Double);
begin
  JavaType.CallVoidMethod(ObjectID, 'setElapsedRealtimeUncertaintyNanos', '(D)V', [WrapDouble(AArg0)]);
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

procedure TJLocation.setMock(const AArg0: Boolean);
begin
  JavaType.CallVoidMethod(ObjectID, 'setMock', '(Z)V', [AArg0]);
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

{ TJLocationListener }

class procedure TJLocationListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onLocationChanged', '(Landroid/location/Location;)V');
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

{ TJLocationManager }

class procedure TJLocationManager.LoadConstructors;
begin
end;

class procedure TJLocationManager.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('addGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)Z');
  AddMethod('addNmeaListener', '(Ljava/util/concurrent/Executor;Landroid/location/OnNmeaMessageListener;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/OnNmeaMessageListener;)Z');
  AddMethod('addNmeaListener', '(Landroid/location/OnNmeaMessageListener;Landroid/os/Handler;)Z');
  AddMethod('addProximityAlert', '(DDFJLandroid/app/PendingIntent;)V');
  AddMethod('addTestProvider', '(Ljava/lang/String;ZZZZZZZII)V');
  AddMethod('addTestProvider', '(Ljava/lang/String;Landroid/location/provider/ProviderProperties;)V');
  AddMethod('addTestProvider', '(Ljava/lang/String;Landroid/location/provider/ProviderProperties;Ljava/util/Set;)V');
  AddMethod('clearTestProviderEnabled', '(Ljava/lang/String;)V');
  AddMethod('clearTestProviderLocation', '(Ljava/lang/String;)V');
  AddMethod('clearTestProviderStatus', '(Ljava/lang/String;)V');
  AddMethod('getAllProviders', '()Ljava/util/List;');
  AddMethod('getBestProvider', '(Landroid/location/Criteria;Z)Ljava/lang/String;');
  AddMethod('getGnssAntennaInfos', '()Ljava/util/List;');
  AddMethod('getGnssCapabilities', '()Landroid/location/GnssCapabilities;');
  AddMethod('getGnssHardwareModelName', '()Ljava/lang/String;');
  AddMethod('getGnssYearOfHardware', '()I');
  AddMethod('getGpsStatus', '(Landroid/location/GpsStatus;)Landroid/location/GpsStatus;');
  AddMethod('getLastKnownLocation', '(Ljava/lang/String;)Landroid/location/Location;');
  AddMethod('getProvider', '(Ljava/lang/String;)Landroid/location/LocationProvider;');
  AddMethod('getProviderProperties', '(Ljava/lang/String;)Landroid/location/provider/ProviderProperties;');
  AddMethod('getProviders', '(Z)Ljava/util/List;');
  AddMethod('getProviders', '(Landroid/location/Criteria;Z)Ljava/util/List;');
  AddMethod('hasProvider', '(Ljava/lang/String;)Z');
  AddMethod('isLocationEnabled', '()Z');
  AddMethod('isProviderEnabled', '(Ljava/lang/String;)Z');
  AddMethod('registerAntennaInfoListener', '(Ljava/util/concurrent/Executor;Landroid/location/GnssAntennaInfo$Listener;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementRequest;Ljava/util/concurrent/Executor;Landroid/location/GnssMeasurementsEvent$Callback;)Z');
  AddMethod('registerGnssMeasurementsCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssMeasurementsEvent$Callback;)Z');
  AddMethod('registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)Z');
  AddMethod('registerGnssNavigationMessageCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssNavigationMessage$Callback;)Z');
  AddMethod('registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;Landroid/os/Handler;)Z');
  AddMethod('registerGnssStatusCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssStatus$Callback;)Z');
  AddMethod('registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)Z');
  AddMethod('removeGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)V');
  AddMethod('removeNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)V');
  AddMethod('removeNmeaListener', '(Landroid/location/OnNmeaMessageListener;)V');
  AddMethod('removeProximityAlert', '(Landroid/app/PendingIntent;)V');
  AddMethod('removeTestProvider', '(Ljava/lang/String;)V');
  AddMethod('removeUpdates', '(Landroid/app/PendingIntent;)V');
  AddMethod('removeUpdates', '(Landroid/location/LocationListener;)V');
  AddMethod('requestFlush', '(Ljava/lang/String;Landroid/app/PendingIntent;I)V');
  AddMethod('requestFlush', '(Ljava/lang/String;Landroid/location/LocationListener;I)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLjava/util/concurrent/Executor;Landroid/location/LocationListener;)V');
  AddMethod('requestLocationUpdates', '(JFLandroid/location/Criteria;Ljava/util/concurrent/Executor;Landroid/location/LocationListener;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/app/PendingIntent;)V');
  AddMethod('requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;Landroid/location/LocationRequest;Landroid/app/PendingIntent;)V');
  AddMethod('requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/app/PendingIntent;)V');
  AddMethod('requestLocationUpdates', '(Ljava/lang/String;Landroid/location/LocationRequest;Ljava/util/concurrent/Executor;Landroid/location/LocationListener;)V');
  AddMethod('requestSingleUpdate', '(Landroid/location/Criteria;Landroid/app/PendingIntent;)V');
  AddMethod('requestSingleUpdate', '(Ljava/lang/String;Landroid/app/PendingIntent;)V');
  AddMethod('requestSingleUpdate', '(Landroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('requestSingleUpdate', '(Ljava/lang/String;Landroid/location/LocationListener;Landroid/os/Looper;)V');
  AddMethod('sendExtraCommand', '(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Z');
  AddMethod('setTestProviderEnabled', '(Ljava/lang/String;Z)V');
  AddMethod('setTestProviderLocation', '(Ljava/lang/String;Landroid/location/Location;)V');
  AddMethod('setTestProviderStatus', '(Ljava/lang/String;ILandroid/os/Bundle;J)V');
  AddMethod('unregisterAntennaInfoListener', '(Landroid/location/GnssAntennaInfo$Listener;)V');
  AddMethod('unregisterGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)V');
  AddMethod('unregisterGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)V');
  AddMethod('unregisterGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)V');
end;

class procedure TJLocationManager.LoadFields;
begin
  inherited;
  AddStaticField('ACTION_GNSS_CAPABILITIES_CHANGED', 'Ljava/lang/String;');
  AddStaticField('EXTRA_GNSS_CAPABILITIES', 'Ljava/lang/String;');
  AddStaticField('EXTRA_LOCATION_ENABLED', 'Ljava/lang/String;');
  AddStaticField('EXTRA_PROVIDER_ENABLED', 'Ljava/lang/String;');
  AddStaticField('EXTRA_PROVIDER_NAME', 'Ljava/lang/String;');
  AddStaticField('FUSED_PROVIDER', 'Ljava/lang/String;');
  AddStaticField('GPS_PROVIDER', 'Ljava/lang/String;');
  AddStaticField('KEY_FLUSH_COMPLETE', 'Ljava/lang/String;');
  AddStaticField('KEY_LOCATIONS', 'Ljava/lang/String;');
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

class function TJLocationManager.ACTION_GNSS_CAPABILITIES_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_GNSS_CAPABILITIES_CHANGED', 'Ljava/lang/String;');
end;

class function TJLocationManager.EXTRA_GNSS_CAPABILITIES: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('EXTRA_GNSS_CAPABILITIES', 'Ljava/lang/String;');
end;

class function TJLocationManager.EXTRA_LOCATION_ENABLED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('EXTRA_LOCATION_ENABLED', 'Ljava/lang/String;');
end;

class function TJLocationManager.EXTRA_PROVIDER_ENABLED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('EXTRA_PROVIDER_ENABLED', 'Ljava/lang/String;');
end;

class function TJLocationManager.EXTRA_PROVIDER_NAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('EXTRA_PROVIDER_NAME', 'Ljava/lang/String;');
end;

class function TJLocationManager.FUSED_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('FUSED_PROVIDER', 'Ljava/lang/String;');
end;

class function TJLocationManager.GPS_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('GPS_PROVIDER', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_FLUSH_COMPLETE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_FLUSH_COMPLETE', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_LOCATIONS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_LOCATIONS', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_LOCATION_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_LOCATION_CHANGED', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_PROVIDER_ENABLED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_PROVIDER_ENABLED', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_PROXIMITY_ENTERING: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_PROXIMITY_ENTERING', 'Ljava/lang/String;');
end;

class function TJLocationManager.KEY_STATUS_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('KEY_STATUS_CHANGED', 'Ljava/lang/String;');
end;

class function TJLocationManager.MODE_CHANGED_ACTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('MODE_CHANGED_ACTION', 'Ljava/lang/String;');
end;

class function TJLocationManager.NETWORK_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('NETWORK_PROVIDER', 'Ljava/lang/String;');
end;

class function TJLocationManager.PASSIVE_PROVIDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('PASSIVE_PROVIDER', 'Ljava/lang/String;');
end;

class function TJLocationManager.PROVIDERS_CHANGED_ACTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('PROVIDERS_CHANGED_ACTION', 'Ljava/lang/String;');
end;

function TJLocationManager.addGpsStatusListener(const AArg0: JGpsStatus_Listener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)Z', [AArg0]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JExecutor; const AArg1: JOnNmeaMessageListener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Ljava/util/concurrent/Executor;Landroid/location/OnNmeaMessageListener;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JGpsStatus_NmeaListener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)Z', [AArg0]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JOnNmeaMessageListener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/OnNmeaMessageListener;)Z', [AArg0]);
end;

function TJLocationManager.addNmeaListener(const AArg0: JOnNmeaMessageListener; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'addNmeaListener', '(Landroid/location/OnNmeaMessageListener;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

procedure TJLocationManager.addProximityAlert(const AArg0: Double; const AArg1: Double; const AArg2: Single; const AArg3: Int64; const AArg4: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'addProximityAlert', '(DDFJLandroid/app/PendingIntent;)V', [WrapDouble(AArg0), WrapDouble(AArg1), AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.addTestProvider(const AArg0: JString; const AArg1: Boolean; const AArg2: Boolean; const AArg3: Boolean; const AArg4: Boolean; const AArg5: Boolean; const AArg6: Boolean; const AArg7: Boolean; const AArg8: Integer; const AArg9: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'addTestProvider', '(Ljava/lang/String;ZZZZZZZII)V', [AArg0, AArg1, AArg2, AArg3, AArg4, AArg5, AArg6, AArg7, AArg8, AArg9]);
end;

procedure TJLocationManager.addTestProvider(const AArg0: JString; const AArg1: JProviderProperties);
begin
  JavaType.CallVoidMethod(ObjectID, 'addTestProvider', '(Ljava/lang/String;Landroid/location/provider/ProviderProperties;)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.addTestProvider(const AArg0: JString; const AArg1: JProviderProperties; const AArg2: JSet);
begin
  JavaType.CallVoidMethod(ObjectID, 'addTestProvider', '(Ljava/lang/String;Landroid/location/provider/ProviderProperties;Ljava/util/Set;)V', [AArg0, AArg1, AArg2]);
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

function TJLocationManager.getGnssAntennaInfos: JList;
begin
  Result := CallObjectMethod<TJList, JList>('getGnssAntennaInfos', '()Ljava/util/List;', []);
end;

function TJLocationManager.getGnssCapabilities: JGnssCapabilities;
begin
  Result := CallObjectMethod<TJGnssCapabilities, JGnssCapabilities>('getGnssCapabilities', '()Landroid/location/GnssCapabilities;', []);
end;

function TJLocationManager.getGnssHardwareModelName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('getGnssHardwareModelName', '()Ljava/lang/String;', []);
end;

function TJLocationManager.getGnssYearOfHardware: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getGnssYearOfHardware', '()I', []);
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

function TJLocationManager.getProviderProperties(const AArg0: JString): JProviderProperties;
begin
  Result := CallObjectMethod<TJProviderProperties, JProviderProperties>('getProviderProperties', '(Ljava/lang/String;)Landroid/location/provider/ProviderProperties;', [AArg0]);
end;

function TJLocationManager.getProviders(const AArg0: Boolean): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getProviders', '(Z)Ljava/util/List;', [AArg0]);
end;

function TJLocationManager.getProviders(const AArg0: JCriteria; const AArg1: Boolean): JList;
begin
  Result := CallObjectMethod<TJList, JList>('getProviders', '(Landroid/location/Criteria;Z)Ljava/util/List;', [AArg0, AArg1]);
end;

function TJLocationManager.hasProvider(const AArg0: JString): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasProvider', '(Ljava/lang/String;)Z', [AArg0]);
end;

function TJLocationManager.isLocationEnabled: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isLocationEnabled', '()Z', []);
end;

function TJLocationManager.isProviderEnabled(const AArg0: JString): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isProviderEnabled', '(Ljava/lang/String;)Z', [AArg0]);
end;

function TJLocationManager.registerAntennaInfoListener(const AArg0: JExecutor; const AArg1: JGnssAntennaInfo_Listener): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerAntennaInfoListener', '(Ljava/util/concurrent/Executor;Landroid/location/GnssAntennaInfo$Listener;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;)Z', [AArg0]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementsEvent_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementsEvent$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JGnssMeasurementRequest; const AArg1: JExecutor; const AArg2: JGnssMeasurementsEvent_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Landroid/location/GnssMeasurementRequest;Ljava/util/concurrent/Executor;Landroid/location/GnssMeasurementsEvent$Callback;)Z', [AArg0, AArg1, AArg2]);
end;

function TJLocationManager.registerGnssMeasurementsCallback(const AArg0: JExecutor; const AArg1: JGnssMeasurementsEvent_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssMeasurementsCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssMeasurementsEvent$Callback;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssNavigationMessageCallback(const AArg0: JGnssNavigationMessage_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssNavigationMessageCallback', '(Landroid/location/GnssNavigationMessage$Callback;)Z', [AArg0]);
end;

function TJLocationManager.registerGnssNavigationMessageCallback(const AArg0: JExecutor; const AArg1: JGnssNavigationMessage_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssNavigationMessageCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssNavigationMessage$Callback;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssStatusCallback(const AArg0: JGnssStatus_Callback; const AArg1: JHandler): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;Landroid/os/Handler;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssStatusCallback(const AArg0: JExecutor; const AArg1: JGnssStatus_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssStatusCallback', '(Ljava/util/concurrent/Executor;Landroid/location/GnssStatus$Callback;)Z', [AArg0, AArg1]);
end;

function TJLocationManager.registerGnssStatusCallback(const AArg0: JGnssStatus_Callback): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'registerGnssStatusCallback', '(Landroid/location/GnssStatus$Callback;)Z', [AArg0]);
end;

procedure TJLocationManager.removeGpsStatusListener(const AArg0: JGpsStatus_Listener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeGpsStatusListener', '(Landroid/location/GpsStatus$Listener;)V', [AArg0]);
end;

procedure TJLocationManager.removeNmeaListener(const AArg0: JGpsStatus_NmeaListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeNmeaListener', '(Landroid/location/GpsStatus$NmeaListener;)V', [AArg0]);
end;

procedure TJLocationManager.removeNmeaListener(const AArg0: JOnNmeaMessageListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'removeNmeaListener', '(Landroid/location/OnNmeaMessageListener;)V', [AArg0]);
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

procedure TJLocationManager.requestFlush(const AArg0: JString; const AArg1: JPendingIntent; const AArg2: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestFlush', '(Ljava/lang/String;Landroid/app/PendingIntent;I)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestFlush(const AArg0: JString; const AArg1: JLocationListener; const AArg2: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestFlush', '(Ljava/lang/String;Landroid/location/LocationListener;I)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JExecutor; const AArg4: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLjava/util/concurrent/Executor;Landroid/location/LocationListener;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JExecutor; const AArg4: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(JFLandroid/location/Criteria;Ljava/util/concurrent/Executor;Landroid/location/LocationListener;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/app/PendingIntent;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JLocationListener; const AArg4: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener; const AArg4: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: Int64; const AArg2: Single; const AArg3: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;JFLandroid/location/LocationListener;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;Landroid/location/LocationRequest;Landroid/app/PendingIntent;)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: Int64; const AArg1: Single; const AArg2: JCriteria; const AArg3: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(JFLandroid/location/Criteria;Landroid/app/PendingIntent;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestLocationUpdates(const AArg0: JString; const AArg1: JLocationRequest; const AArg2: JExecutor; const AArg3: JLocationListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestLocationUpdates', '(Ljava/lang/String;Landroid/location/LocationRequest;Ljava/util/concurrent/Executor;Landroid/location/LocationListener;)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JCriteria; const AArg1: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Landroid/location/Criteria;Landroid/app/PendingIntent;)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JString; const AArg1: JPendingIntent);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Ljava/lang/String;Landroid/app/PendingIntent;)V', [AArg0, AArg1]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JCriteria; const AArg1: JLocationListener; const AArg2: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Landroid/location/Criteria;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2]);
end;

procedure TJLocationManager.requestSingleUpdate(const AArg0: JString; const AArg1: JLocationListener; const AArg2: JLooper);
begin
  JavaType.CallVoidMethod(ObjectID, 'requestSingleUpdate', '(Ljava/lang/String;Landroid/location/LocationListener;Landroid/os/Looper;)V', [AArg0, AArg1, AArg2]);
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

procedure TJLocationManager.unregisterAntennaInfoListener(const AArg0: JGnssAntennaInfo_Listener);
begin
  JavaType.CallVoidMethod(ObjectID, 'unregisterAntennaInfoListener', '(Landroid/location/GnssAntennaInfo$Listener;)V', [AArg0]);
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
  Result := StaticJavaType[Self].GetStaticIntField('AVAILABLE', 'I');
end;

class function TJLocationProvider.OUT_OF_SERVICE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('OUT_OF_SERVICE', 'I');
end;

class function TJLocationProvider.TEMPORARILY_UNAVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('TEMPORARILY_UNAVAILABLE', 'I');
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

{ TJLocationRequest }

class procedure TJLocationRequest.LoadConstructors;
begin
end;

class procedure TJLocationRequest.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getDurationMillis', '()J');
  AddMethod('getIntervalMillis', '()J');
  AddMethod('getMaxUpdateDelayMillis', '()J');
  AddMethod('getMaxUpdates', '()I');
  AddMethod('getMinUpdateDistanceMeters', '()F');
  AddMethod('getMinUpdateIntervalMillis', '()J');
  AddMethod('getQuality', '()I');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJLocationRequest.LoadFields;
begin
  inherited;
  AddStaticField('PASSIVE_INTERVAL', 'J');
  AddStaticField('QUALITY_BALANCED_POWER_ACCURACY', 'I');
  AddStaticField('QUALITY_HIGH_ACCURACY', 'I');
  AddStaticField('QUALITY_LOW_POWER', 'I');
end;

class function TJLocationRequest.Wrap(const AObjectID: JNIObject): JLocationRequest;
begin
  Result := Wrap<TJLocationRequest, JLocationRequest>(AObjectId);
end;

class function TJLocationRequest.Wrap(const AObject: IJNIObject): JLocationRequest;
begin
  Result := Wrap<TJLocationRequest, JLocationRequest>(AObject);
end;

class function TJLocationRequest.PASSIVE_INTERVAL: Int64;
begin
  Result := StaticJavaType[Self].GetStaticLongField('PASSIVE_INTERVAL', 'J');
end;

class function TJLocationRequest.QUALITY_BALANCED_POWER_ACCURACY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('QUALITY_BALANCED_POWER_ACCURACY', 'I');
end;

class function TJLocationRequest.QUALITY_HIGH_ACCURACY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('QUALITY_HIGH_ACCURACY', 'I');
end;

class function TJLocationRequest.QUALITY_LOW_POWER: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('QUALITY_LOW_POWER', 'I');
end;

function TJLocationRequest.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJLocationRequest.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJLocationRequest.getDurationMillis: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getDurationMillis', '()J', []);
end;

function TJLocationRequest.getIntervalMillis: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getIntervalMillis', '()J', []);
end;

function TJLocationRequest.getMaxUpdateDelayMillis: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getMaxUpdateDelayMillis', '()J', []);
end;

function TJLocationRequest.getMaxUpdates: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getMaxUpdates', '()I', []);
end;

function TJLocationRequest.getMinUpdateDistanceMeters: Single;
begin
  Result := JavaType.CallFloatMethod(ObjectID, 'getMinUpdateDistanceMeters', '()F', []);
end;

function TJLocationRequest.getMinUpdateIntervalMillis: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'getMinUpdateIntervalMillis', '()J', []);
end;

function TJLocationRequest.getQuality: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getQuality', '()I', []);
end;

function TJLocationRequest.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJLocationRequest.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJLocationRequest_Builder }

class procedure TJLocationRequest_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(J)V');
  AddMethod('<init>', '(Landroid/location/LocationRequest;)V');
end;

class procedure TJLocationRequest_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Landroid/location/LocationRequest;');
  AddMethod('clearMinUpdateIntervalMillis', '()Landroid/location/LocationRequest$Builder;');
  AddMethod('setDurationMillis', '(J)Landroid/location/LocationRequest$Builder;');
  AddMethod('setIntervalMillis', '(J)Landroid/location/LocationRequest$Builder;');
  AddMethod('setMaxUpdateDelayMillis', '(J)Landroid/location/LocationRequest$Builder;');
  AddMethod('setMaxUpdates', '(I)Landroid/location/LocationRequest$Builder;');
  AddMethod('setMinUpdateDistanceMeters', '(F)Landroid/location/LocationRequest$Builder;');
  AddMethod('setMinUpdateIntervalMillis', '(J)Landroid/location/LocationRequest$Builder;');
  AddMethod('setQuality', '(I)Landroid/location/LocationRequest$Builder;');
end;

class function TJLocationRequest_Builder.Wrap(const AObjectID: JNIObject): JLocationRequest_Builder;
begin
  Result := Wrap<TJLocationRequest_Builder, JLocationRequest_Builder>(AObjectId);
end;

class function TJLocationRequest_Builder.Wrap(const AObject: IJNIObject): JLocationRequest_Builder;
begin
  Result := Wrap<TJLocationRequest_Builder, JLocationRequest_Builder>(AObject);
end;

class function TJLocationRequest_Builder.Create(const AArg0: Int64): JLocationRequest_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(J)V', [AArg0]);
  Result := O;
end;

class function TJLocationRequest_Builder.Create(const AArg0: JLocationRequest): JLocationRequest_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/LocationRequest;)V', [AArg0]);
  Result := O;
end;

function TJLocationRequest_Builder.build: JLocationRequest;
begin
  Result := CallObjectMethod<TJLocationRequest, JLocationRequest>('build', '()Landroid/location/LocationRequest;', []);
end;

function TJLocationRequest_Builder.clearMinUpdateIntervalMillis: JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('clearMinUpdateIntervalMillis', '()Landroid/location/LocationRequest$Builder;', []);
end;

function TJLocationRequest_Builder.setDurationMillis(const AArg0: Int64): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setDurationMillis', '(J)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setIntervalMillis', '(J)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setMaxUpdateDelayMillis(const AArg0: Int64): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setMaxUpdateDelayMillis', '(J)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setMaxUpdates(const AArg0: Integer): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setMaxUpdates', '(I)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setMinUpdateDistanceMeters(const AArg0: Single): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setMinUpdateDistanceMeters', '(F)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setMinUpdateIntervalMillis(const AArg0: Int64): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setMinUpdateIntervalMillis', '(J)Landroid/location/LocationRequest$Builder;', [AArg0]);
end;

function TJLocationRequest_Builder.setQuality(const AArg0: Integer): JLocationRequest_Builder;
begin
  Result := CallObjectMethod<TJLocationRequest_Builder, JLocationRequest_Builder>('setQuality', '(I)Landroid/location/LocationRequest$Builder;', [AArg0]);
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
  AddStaticMethod('refreshSettings', '(Landroid/content/Context;)V');
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
  Result := GetStaticObjectField<TJString, JString>('ACTION_INJECTED_SETTING_CHANGED', 'Ljava/lang/String;');
end;

class function TJSettingInjectorService.ACTION_SERVICE_INTENT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_SERVICE_INTENT', 'Ljava/lang/String;');
end;

class function TJSettingInjectorService.ATTRIBUTES_NAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ATTRIBUTES_NAME', 'Ljava/lang/String;');
end;

class function TJSettingInjectorService.META_DATA_NAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('META_DATA_NAME', 'Ljava/lang/String;');
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

class procedure TJSettingInjectorService.refreshSettings(const AArg0: JContext);
begin
  StaticJavaType[Self].CallStaticVoidMethod('refreshSettings', '(Landroid/content/Context;)V', [AArg0]);
end;

{ TJProviderProperties }

class procedure TJProviderProperties.LoadConstructors;
begin
end;

class procedure TJProviderProperties.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('describeContents', '()I');
  AddMethod('equals', '(Ljava/lang/Object;)Z');
  AddMethod('getAccuracy', '()I');
  AddMethod('getPowerUsage', '()I');
  AddMethod('hasAltitudeSupport', '()Z');
  AddMethod('hasBearingSupport', '()Z');
  AddMethod('hasCellRequirement', '()Z');
  AddMethod('hasMonetaryCost', '()Z');
  AddMethod('hasNetworkRequirement', '()Z');
  AddMethod('hasSatelliteRequirement', '()Z');
  AddMethod('hasSpeedSupport', '()Z');
  AddMethod('hashCode', '()I');
  AddMethod('toString', '()Ljava/lang/String;');
end;

class procedure TJProviderProperties.LoadFields;
begin
  inherited;
  AddStaticField('ACCURACY_COARSE', 'I');
  AddStaticField('ACCURACY_FINE', 'I');
  AddStaticField('POWER_USAGE_HIGH', 'I');
  AddStaticField('POWER_USAGE_LOW', 'I');
  AddStaticField('POWER_USAGE_MEDIUM', 'I');
end;

class function TJProviderProperties.Wrap(const AObjectID: JNIObject): JProviderProperties;
begin
  Result := Wrap<TJProviderProperties, JProviderProperties>(AObjectId);
end;

class function TJProviderProperties.Wrap(const AObject: IJNIObject): JProviderProperties;
begin
  Result := Wrap<TJProviderProperties, JProviderProperties>(AObject);
end;

class function TJProviderProperties.ACCURACY_COARSE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_COARSE', 'I');
end;

class function TJProviderProperties.ACCURACY_FINE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACCURACY_FINE', 'I');
end;

class function TJProviderProperties.POWER_USAGE_HIGH: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_USAGE_HIGH', 'I');
end;

class function TJProviderProperties.POWER_USAGE_LOW: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_USAGE_LOW', 'I');
end;

class function TJProviderProperties.POWER_USAGE_MEDIUM: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('POWER_USAGE_MEDIUM', 'I');
end;

function TJProviderProperties.describeContents: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'describeContents', '()I', []);
end;

function TJProviderProperties.equals(const AArg0: JObject): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'equals', '(Ljava/lang/Object;)Z', [AArg0]);
end;

function TJProviderProperties.getAccuracy: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getAccuracy', '()I', []);
end;

function TJProviderProperties.getPowerUsage: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getPowerUsage', '()I', []);
end;

function TJProviderProperties.hasAltitudeSupport: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasAltitudeSupport', '()Z', []);
end;

function TJProviderProperties.hasBearingSupport: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasBearingSupport', '()Z', []);
end;

function TJProviderProperties.hasCellRequirement: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasCellRequirement', '()Z', []);
end;

function TJProviderProperties.hasMonetaryCost: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasMonetaryCost', '()Z', []);
end;

function TJProviderProperties.hasNetworkRequirement: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasNetworkRequirement', '()Z', []);
end;

function TJProviderProperties.hasSatelliteRequirement: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSatelliteRequirement', '()Z', []);
end;

function TJProviderProperties.hasSpeedSupport: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasSpeedSupport', '()Z', []);
end;

function TJProviderProperties.hashCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'hashCode', '()I', []);
end;

function TJProviderProperties.toString: JString;
begin
  Result := CallObjectMethod<TJString, JString>('toString', '()Ljava/lang/String;', []);
end;

{ TJProviderProperties_Builder }

class procedure TJProviderProperties_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
  AddMethod('<init>', '(Landroid/location/provider/ProviderProperties;)V');
end;

class procedure TJProviderProperties_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Landroid/location/provider/ProviderProperties;');
  AddMethod('setAccuracy', '(I)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasAltitudeSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasBearingSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasCellRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasMonetaryCost', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasNetworkRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasSatelliteRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setHasSpeedSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;');
  AddMethod('setPowerUsage', '(I)Landroid/location/provider/ProviderProperties$Builder;');
end;

class function TJProviderProperties_Builder.Wrap(const AObjectID: JNIObject): JProviderProperties_Builder;
begin
  Result := Wrap<TJProviderProperties_Builder, JProviderProperties_Builder>(AObjectId);
end;

class function TJProviderProperties_Builder.Wrap(const AObject: IJNIObject): JProviderProperties_Builder;
begin
  Result := Wrap<TJProviderProperties_Builder, JProviderProperties_Builder>(AObject);
end;

class function TJProviderProperties_Builder.Create: JProviderProperties_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

class function TJProviderProperties_Builder.Create(const AArg0: JProviderProperties): JProviderProperties_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('(Landroid/location/provider/ProviderProperties;)V', [AArg0]);
  Result := O;
end;

function TJProviderProperties_Builder.build: JProviderProperties;
begin
  Result := CallObjectMethod<TJProviderProperties, JProviderProperties>('build', '()Landroid/location/provider/ProviderProperties;', []);
end;

function TJProviderProperties_Builder.setAccuracy(const AArg0: Integer): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setAccuracy', '(I)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasAltitudeSupport(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasAltitudeSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasBearingSupport(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasBearingSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasCellRequirement(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasCellRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasMonetaryCost(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasMonetaryCost', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasNetworkRequirement(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasNetworkRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasSatelliteRequirement(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasSatelliteRequirement', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setHasSpeedSupport(const AArg0: Boolean): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setHasSpeedSupport', '(Z)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

function TJProviderProperties_Builder.setPowerUsage(const AArg0: Integer): JProviderProperties_Builder;
begin
  Result := CallObjectMethod<TJProviderProperties_Builder, JProviderProperties_Builder>('setPowerUsage', '(I)Landroid/location/provider/ProviderProperties$Builder;', [AArg0]);
end;

initialization
  TJavaTypesManager.RegisterJavaType(TJAddress, TypeInfo(IJavaArray<JAddress>), TJavaArray<JAddress>);
  TJavaTypesManager.RegisterJavaType(TJCriteria, TypeInfo(IJavaArray<JCriteria>), TJavaArray<JCriteria>);
  TJavaTypesManager.RegisterJavaType(TJGeocoder, TypeInfo(IJavaArray<JGeocoder>), TJavaArray<JGeocoder>);
  TJavaTypesManager.RegisterJavaType(TJGnssAntennaInfo, TypeInfo(IJavaArray<JGnssAntennaInfo>), TJavaArray<JGnssAntennaInfo>);
  TJavaTypesManager.RegisterJavaType(TJGnssAntennaInfo_Builder, TypeInfo(IJavaArray<JGnssAntennaInfo_Builder>), TJavaArray<JGnssAntennaInfo_Builder>);
  TJavaTypesManager.RegisterJavaType(TJGnssAntennaInfo_Listener, TypeInfo(IJavaArray<JGnssAntennaInfo_Listener>), TJavaArray<JGnssAntennaInfo_Listener>);
  TJavaTypesManager.RegisterJavaType(TJGnssAntennaInfo_PhaseCenterOffset, TypeInfo(IJavaArray<JGnssAntennaInfo_PhaseCenterOffset>), TJavaArray<JGnssAntennaInfo_PhaseCenterOffset>);
  TJavaTypesManager.RegisterJavaType(TJGnssAntennaInfo_SphericalCorrections, TypeInfo(IJavaArray<JGnssAntennaInfo_SphericalCorrections>), TJavaArray<JGnssAntennaInfo_SphericalCorrections>);
  TJavaTypesManager.RegisterJavaType(TJGnssCapabilities, TypeInfo(IJavaArray<JGnssCapabilities>), TJavaArray<JGnssCapabilities>);
  TJavaTypesManager.RegisterJavaType(TJGnssCapabilities_Builder, TypeInfo(IJavaArray<JGnssCapabilities_Builder>), TJavaArray<JGnssCapabilities_Builder>);
  TJavaTypesManager.RegisterJavaType(TJGnssClock, TypeInfo(IJavaArray<JGnssClock>), TJavaArray<JGnssClock>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurement, TypeInfo(IJavaArray<JGnssMeasurement>), TJavaArray<JGnssMeasurement>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementRequest, TypeInfo(IJavaArray<JGnssMeasurementRequest>), TJavaArray<JGnssMeasurementRequest>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementRequest_Builder, TypeInfo(IJavaArray<JGnssMeasurementRequest_Builder>), TJavaArray<JGnssMeasurementRequest_Builder>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementsEvent, TypeInfo(IJavaArray<JGnssMeasurementsEvent>), TJavaArray<JGnssMeasurementsEvent>);
  TJavaTypesManager.RegisterJavaType(TJGnssMeasurementsEvent_Callback, TypeInfo(IJavaArray<JGnssMeasurementsEvent_Callback>), TJavaArray<JGnssMeasurementsEvent_Callback>);
  TJavaTypesManager.RegisterJavaType(TJGnssNavigationMessage, TypeInfo(IJavaArray<JGnssNavigationMessage>), TJavaArray<JGnssNavigationMessage>);
  TJavaTypesManager.RegisterJavaType(TJGnssNavigationMessage_Callback, TypeInfo(IJavaArray<JGnssNavigationMessage_Callback>), TJavaArray<JGnssNavigationMessage_Callback>);
  TJavaTypesManager.RegisterJavaType(TJGnssStatus, TypeInfo(IJavaArray<JGnssStatus>), TJavaArray<JGnssStatus>);
  TJavaTypesManager.RegisterJavaType(TJGnssStatus_Builder, TypeInfo(IJavaArray<JGnssStatus_Builder>), TJavaArray<JGnssStatus_Builder>);
  TJavaTypesManager.RegisterJavaType(TJGnssStatus_Callback, TypeInfo(IJavaArray<JGnssStatus_Callback>), TJavaArray<JGnssStatus_Callback>);
  TJavaTypesManager.RegisterJavaType(TJGpsSatellite, TypeInfo(IJavaArray<JGpsSatellite>), TJavaArray<JGpsSatellite>);
  TJavaTypesManager.RegisterJavaType(TJGpsStatus, TypeInfo(IJavaArray<JGpsStatus>), TJavaArray<JGpsStatus>);
  TJavaTypesManager.RegisterJavaType(TJGpsStatus_Listener, TypeInfo(IJavaArray<JGpsStatus_Listener>), TJavaArray<JGpsStatus_Listener>);
  TJavaTypesManager.RegisterJavaType(TJGpsStatus_NmeaListener, TypeInfo(IJavaArray<JGpsStatus_NmeaListener>), TJavaArray<JGpsStatus_NmeaListener>);
  TJavaTypesManager.RegisterJavaType(TJLocation, TypeInfo(IJavaArray<JLocation>), TJavaArray<JLocation>);
  TJavaTypesManager.RegisterJavaType(TJLocationListener, TypeInfo(IJavaArray<JLocationListener>), TJavaArray<JLocationListener>);
  TJavaTypesManager.RegisterJavaType(TJLocationManager, TypeInfo(IJavaArray<JLocationManager>), TJavaArray<JLocationManager>);
  TJavaTypesManager.RegisterJavaType(TJLocationProvider, TypeInfo(IJavaArray<JLocationProvider>), TJavaArray<JLocationProvider>);
  TJavaTypesManager.RegisterJavaType(TJLocationRequest, TypeInfo(IJavaArray<JLocationRequest>), TJavaArray<JLocationRequest>);
  TJavaTypesManager.RegisterJavaType(TJLocationRequest_Builder, TypeInfo(IJavaArray<JLocationRequest_Builder>), TJavaArray<JLocationRequest_Builder>);
  TJavaTypesManager.RegisterJavaType(TJOnNmeaMessageListener, TypeInfo(IJavaArray<JOnNmeaMessageListener>), TJavaArray<JOnNmeaMessageListener>);
  TJavaTypesManager.RegisterJavaType(TJSettingInjectorService, TypeInfo(IJavaArray<JSettingInjectorService>), TJavaArray<JSettingInjectorService>);
  TJavaTypesManager.RegisterJavaType(TJProviderProperties, TypeInfo(IJavaArray<JProviderProperties>), TJavaArray<JProviderProperties>);
  TJavaTypesManager.RegisterJavaType(TJProviderProperties_Builder, TypeInfo(IJavaArray<JProviderProperties_Builder>), TJavaArray<JProviderProperties_Builder>);
end.
