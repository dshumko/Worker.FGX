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


unit Android.Api.Exif;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, Androidapi.Jni, Java.Bridge,
  Android.Api.JavaTypes, Android.Api.ActivityAndView;

type
  JExifInterface = interface;
  TJExifInterface = class;

{ android.media.ExifInterface }

  [JavaClassSignature('android/media/ExifInterface')]
  JExifInterface = interface(JObject)
    ['{4CFF1B8F-D0E2-4A1F-8374-B798006C2C77}']
    function getAltitude(const AArg0: Double): Double;
    function getAttribute(const AArg0: JString): JString;
    function getAttributeDouble(const AArg0: JString; const AArg1: Double): Double;
    function getAttributeInt(const AArg0: JString; const AArg1: Integer): Integer;
    function getLatLong(const AArg0: IJavaArray<Single>): Boolean;
    function getThumbnail: IJavaArray<Byte>;
    function getThumbnailBitmap: JBitmap;
    function getThumbnailBytes: IJavaArray<Byte>;
    function getThumbnailRange: IJavaArray<Int64>;
    function hasThumbnail: Boolean;
    function isThumbnailCompressed: Boolean;
    procedure saveAttributes;
    procedure setAttribute(const AArg0: JString; const AArg1: JString);
  end;

  [JavaClassSignature('android/media/ExifInterface')]
  TJExifInterface = class(TJObject, JExifInterface)
  private
    { methods }
    function getAltitude(const AArg0: Double): Double;
    function getAttribute(const AArg0: JString): JString;
    function getAttributeDouble(const AArg0: JString; const AArg1: Double): Double;
    function getAttributeInt(const AArg0: JString; const AArg1: Integer): Integer;
    function getLatLong(const AArg0: IJavaArray<Single>): Boolean;
    function getThumbnail: IJavaArray<Byte>;
    function getThumbnailBitmap: JBitmap;
    function getThumbnailBytes: IJavaArray<Byte>;
    function getThumbnailRange: IJavaArray<Int64>;
    function hasThumbnail: Boolean;
    function isThumbnailCompressed: Boolean;
    procedure saveAttributes;
    procedure setAttribute(const AArg0: JString; const AArg1: JString);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JExifInterface; overload;
    class function Wrap(const AObject: IJNIObject): JExifInterface; overload;
    { constructors }
    class function Create(const AArg0: JString): JExifInterface; overload;
    class function Create(const AArg0: JFileDescriptor): JExifInterface; overload;
    class function Create(const AArg0: JInputStream): JExifInterface; overload;
    { constants }
    class function ORIENTATION_FLIP_HORIZONTAL: Integer;
    class function ORIENTATION_FLIP_VERTICAL: Integer;
    class function ORIENTATION_NORMAL: Integer;
    class function ORIENTATION_ROTATE_180: Integer;
    class function ORIENTATION_ROTATE_270: Integer;
    class function ORIENTATION_ROTATE_90: Integer;
    class function ORIENTATION_TRANSPOSE: Integer;
    class function ORIENTATION_TRANSVERSE: Integer;
    class function ORIENTATION_UNDEFINED: Integer;
    class function TAG_APERTURE: JString;
    class function TAG_APERTURE_VALUE: JString;
    class function TAG_ARTIST: JString;
    class function TAG_BITS_PER_SAMPLE: JString;
    class function TAG_BRIGHTNESS_VALUE: JString;
    class function TAG_CFA_PATTERN: JString;
    class function TAG_COLOR_SPACE: JString;
    class function TAG_COMPONENTS_CONFIGURATION: JString;
    class function TAG_COMPRESSED_BITS_PER_PIXEL: JString;
    class function TAG_COMPRESSION: JString;
    class function TAG_CONTRAST: JString;
    class function TAG_COPYRIGHT: JString;
    class function TAG_CUSTOM_RENDERED: JString;
    class function TAG_DATETIME: JString;
    class function TAG_DATETIME_DIGITIZED: JString;
    class function TAG_DATETIME_ORIGINAL: JString;
    class function TAG_DEFAULT_CROP_SIZE: JString;
    class function TAG_DEVICE_SETTING_DESCRIPTION: JString;
    class function TAG_DIGITAL_ZOOM_RATIO: JString;
    class function TAG_DNG_VERSION: JString;
    class function TAG_EXIF_VERSION: JString;
    class function TAG_EXPOSURE_BIAS_VALUE: JString;
    class function TAG_EXPOSURE_INDEX: JString;
    class function TAG_EXPOSURE_MODE: JString;
    class function TAG_EXPOSURE_PROGRAM: JString;
    class function TAG_EXPOSURE_TIME: JString;
    class function TAG_FILE_SOURCE: JString;
    class function TAG_FLASH: JString;
    class function TAG_FLASHPIX_VERSION: JString;
    class function TAG_FLASH_ENERGY: JString;
    class function TAG_FOCAL_LENGTH: JString;
    class function TAG_FOCAL_LENGTH_IN_35MM_FILM: JString;
    class function TAG_FOCAL_PLANE_RESOLUTION_UNIT: JString;
    class function TAG_FOCAL_PLANE_X_RESOLUTION: JString;
    class function TAG_FOCAL_PLANE_Y_RESOLUTION: JString;
    class function TAG_F_NUMBER: JString;
    class function TAG_GAIN_CONTROL: JString;
    class function TAG_GPS_ALTITUDE: JString;
    class function TAG_GPS_ALTITUDE_REF: JString;
    class function TAG_GPS_AREA_INFORMATION: JString;
    class function TAG_GPS_DATESTAMP: JString;
    class function TAG_GPS_DEST_BEARING: JString;
    class function TAG_GPS_DEST_BEARING_REF: JString;
    class function TAG_GPS_DEST_DISTANCE: JString;
    class function TAG_GPS_DEST_DISTANCE_REF: JString;
    class function TAG_GPS_DEST_LATITUDE: JString;
    class function TAG_GPS_DEST_LATITUDE_REF: JString;
    class function TAG_GPS_DEST_LONGITUDE: JString;
    class function TAG_GPS_DEST_LONGITUDE_REF: JString;
    class function TAG_GPS_DIFFERENTIAL: JString;
    class function TAG_GPS_DOP: JString;
    class function TAG_GPS_IMG_DIRECTION: JString;
    class function TAG_GPS_IMG_DIRECTION_REF: JString;
    class function TAG_GPS_LATITUDE: JString;
    class function TAG_GPS_LATITUDE_REF: JString;
    class function TAG_GPS_LONGITUDE: JString;
    class function TAG_GPS_LONGITUDE_REF: JString;
    class function TAG_GPS_MAP_DATUM: JString;
    class function TAG_GPS_MEASURE_MODE: JString;
    class function TAG_GPS_PROCESSING_METHOD: JString;
    class function TAG_GPS_SATELLITES: JString;
    class function TAG_GPS_SPEED: JString;
    class function TAG_GPS_SPEED_REF: JString;
    class function TAG_GPS_STATUS: JString;
    class function TAG_GPS_TIMESTAMP: JString;
    class function TAG_GPS_TRACK: JString;
    class function TAG_GPS_TRACK_REF: JString;
    class function TAG_GPS_VERSION_ID: JString;
    class function TAG_IMAGE_DESCRIPTION: JString;
    class function TAG_IMAGE_LENGTH: JString;
    class function TAG_IMAGE_UNIQUE_ID: JString;
    class function TAG_IMAGE_WIDTH: JString;
    class function TAG_INTEROPERABILITY_INDEX: JString;
    class function TAG_ISO: JString;
    class function TAG_ISO_SPEED_RATINGS: JString;
    class function TAG_JPEG_INTERCHANGE_FORMAT: JString;
    class function TAG_JPEG_INTERCHANGE_FORMAT_LENGTH: JString;
    class function TAG_LIGHT_SOURCE: JString;
    class function TAG_MAKE: JString;
    class function TAG_MAKER_NOTE: JString;
    class function TAG_MAX_APERTURE_VALUE: JString;
    class function TAG_METERING_MODE: JString;
    class function TAG_MODEL: JString;
    class function TAG_NEW_SUBFILE_TYPE: JString;
    class function TAG_OECF: JString;
    class function TAG_ORF_ASPECT_FRAME: JString;
    class function TAG_ORF_PREVIEW_IMAGE_LENGTH: JString;
    class function TAG_ORF_PREVIEW_IMAGE_START: JString;
    class function TAG_ORF_THUMBNAIL_IMAGE: JString;
    class function TAG_ORIENTATION: JString;
    class function TAG_PHOTOMETRIC_INTERPRETATION: JString;
    class function TAG_PIXEL_X_DIMENSION: JString;
    class function TAG_PIXEL_Y_DIMENSION: JString;
    class function TAG_PLANAR_CONFIGURATION: JString;
    class function TAG_PRIMARY_CHROMATICITIES: JString;
    class function TAG_REFERENCE_BLACK_WHITE: JString;
    class function TAG_RELATED_SOUND_FILE: JString;
    class function TAG_RESOLUTION_UNIT: JString;
    class function TAG_ROWS_PER_STRIP: JString;
    class function TAG_RW2_ISO: JString;
    class function TAG_RW2_JPG_FROM_RAW: JString;
    class function TAG_RW2_SENSOR_BOTTOM_BORDER: JString;
    class function TAG_RW2_SENSOR_LEFT_BORDER: JString;
    class function TAG_RW2_SENSOR_RIGHT_BORDER: JString;
    class function TAG_RW2_SENSOR_TOP_BORDER: JString;
    class function TAG_SAMPLES_PER_PIXEL: JString;
    class function TAG_SATURATION: JString;
    class function TAG_SCENE_CAPTURE_TYPE: JString;
    class function TAG_SCENE_TYPE: JString;
    class function TAG_SENSING_METHOD: JString;
    class function TAG_SHARPNESS: JString;
    class function TAG_SHUTTER_SPEED_VALUE: JString;
    class function TAG_SOFTWARE: JString;
    class function TAG_SPATIAL_FREQUENCY_RESPONSE: JString;
    class function TAG_SPECTRAL_SENSITIVITY: JString;
    class function TAG_STRIP_BYTE_COUNTS: JString;
    class function TAG_STRIP_OFFSETS: JString;
    class function TAG_SUBFILE_TYPE: JString;
    class function TAG_SUBJECT_AREA: JString;
    class function TAG_SUBJECT_DISTANCE: JString;
    class function TAG_SUBJECT_DISTANCE_RANGE: JString;
    class function TAG_SUBJECT_LOCATION: JString;
    class function TAG_SUBSEC_TIME: JString;
    class function TAG_SUBSEC_TIME_DIG: JString;
    class function TAG_SUBSEC_TIME_DIGITIZED: JString;
    class function TAG_SUBSEC_TIME_ORIG: JString;
    class function TAG_SUBSEC_TIME_ORIGINAL: JString;
    class function TAG_THUMBNAIL_IMAGE_LENGTH: JString;
    class function TAG_THUMBNAIL_IMAGE_WIDTH: JString;
    class function TAG_TRANSFER_FUNCTION: JString;
    class function TAG_USER_COMMENT: JString;
    class function TAG_WHITE_BALANCE: JString;
    class function TAG_WHITE_POINT: JString;
    class function TAG_X_RESOLUTION: JString;
    class function TAG_Y_CB_CR_COEFFICIENTS: JString;
    class function TAG_Y_CB_CR_POSITIONING: JString;
    class function TAG_Y_CB_CR_SUB_SAMPLING: JString;
    class function TAG_Y_RESOLUTION: JString;
    class function WHITEBALANCE_AUTO: Integer;
    class function WHITEBALANCE_MANUAL: Integer;
  end;

implementation

{ TJExifInterface }

class procedure TJExifInterface.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(Ljava/lang/String;)V');
  AddMethod('<init>', '(Ljava/io/FileDescriptor;)V');
  AddMethod('<init>', '(Ljava/io/InputStream;)V');
end;

class procedure TJExifInterface.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('getAltitude', '(D)D');
  AddMethod('getAttribute', '(Ljava/lang/String;)Ljava/lang/String;');
  AddMethod('getAttributeDouble', '(Ljava/lang/String;D)D');
  AddMethod('getAttributeInt', '(Ljava/lang/String;I)I');
  AddMethod('getLatLong', '([F)Z');
  AddMethod('getThumbnail', '()[B');
  AddMethod('getThumbnailBitmap', '()Landroid/graphics/Bitmap;');
  AddMethod('getThumbnailBytes', '()[B');
  AddMethod('getThumbnailRange', '()[J');
  AddMethod('hasThumbnail', '()Z');
  AddMethod('isThumbnailCompressed', '()Z');
  AddMethod('saveAttributes', '()V');
  AddMethod('setAttribute', '(Ljava/lang/String;Ljava/lang/String;)V');
end;

class procedure TJExifInterface.LoadFields;
begin
  inherited;
  AddStaticField('ORIENTATION_FLIP_HORIZONTAL', 'I');
  AddStaticField('ORIENTATION_FLIP_VERTICAL', 'I');
  AddStaticField('ORIENTATION_NORMAL', 'I');
  AddStaticField('ORIENTATION_ROTATE_180', 'I');
  AddStaticField('ORIENTATION_ROTATE_270', 'I');
  AddStaticField('ORIENTATION_ROTATE_90', 'I');
  AddStaticField('ORIENTATION_TRANSPOSE', 'I');
  AddStaticField('ORIENTATION_TRANSVERSE', 'I');
  AddStaticField('ORIENTATION_UNDEFINED', 'I');
  AddStaticField('TAG_APERTURE', 'Ljava/lang/String;');
  AddStaticField('TAG_APERTURE_VALUE', 'Ljava/lang/String;');
  AddStaticField('TAG_ARTIST', 'Ljava/lang/String;');
  AddStaticField('TAG_BITS_PER_SAMPLE', 'Ljava/lang/String;');
  AddStaticField('TAG_BRIGHTNESS_VALUE', 'Ljava/lang/String;');
  AddStaticField('TAG_CFA_PATTERN', 'Ljava/lang/String;');
  AddStaticField('TAG_COLOR_SPACE', 'Ljava/lang/String;');
  AddStaticField('TAG_COMPONENTS_CONFIGURATION', 'Ljava/lang/String;');
  AddStaticField('TAG_COMPRESSED_BITS_PER_PIXEL', 'Ljava/lang/String;');
  AddStaticField('TAG_COMPRESSION', 'Ljava/lang/String;');
  AddStaticField('TAG_CONTRAST', 'Ljava/lang/String;');
  AddStaticField('TAG_COPYRIGHT', 'Ljava/lang/String;');
  AddStaticField('TAG_CUSTOM_RENDERED', 'Ljava/lang/String;');
  AddStaticField('TAG_DATETIME', 'Ljava/lang/String;');
  AddStaticField('TAG_DATETIME_DIGITIZED', 'Ljava/lang/String;');
  AddStaticField('TAG_DATETIME_ORIGINAL', 'Ljava/lang/String;');
  AddStaticField('TAG_DEFAULT_CROP_SIZE', 'Ljava/lang/String;');
  AddStaticField('TAG_DEVICE_SETTING_DESCRIPTION', 'Ljava/lang/String;');
  AddStaticField('TAG_DIGITAL_ZOOM_RATIO', 'Ljava/lang/String;');
  AddStaticField('TAG_DNG_VERSION', 'Ljava/lang/String;');
  AddStaticField('TAG_EXIF_VERSION', 'Ljava/lang/String;');
  AddStaticField('TAG_EXPOSURE_BIAS_VALUE', 'Ljava/lang/String;');
  AddStaticField('TAG_EXPOSURE_INDEX', 'Ljava/lang/String;');
  AddStaticField('TAG_EXPOSURE_MODE', 'Ljava/lang/String;');
  AddStaticField('TAG_EXPOSURE_PROGRAM', 'Ljava/lang/String;');
  AddStaticField('TAG_EXPOSURE_TIME', 'Ljava/lang/String;');
  AddStaticField('TAG_FILE_SOURCE', 'Ljava/lang/String;');
  AddStaticField('TAG_FLASH', 'Ljava/lang/String;');
  AddStaticField('TAG_FLASHPIX_VERSION', 'Ljava/lang/String;');
  AddStaticField('TAG_FLASH_ENERGY', 'Ljava/lang/String;');
  AddStaticField('TAG_FOCAL_LENGTH', 'Ljava/lang/String;');
  AddStaticField('TAG_FOCAL_LENGTH_IN_35MM_FILM', 'Ljava/lang/String;');
  AddStaticField('TAG_FOCAL_PLANE_RESOLUTION_UNIT', 'Ljava/lang/String;');
  AddStaticField('TAG_FOCAL_PLANE_X_RESOLUTION', 'Ljava/lang/String;');
  AddStaticField('TAG_FOCAL_PLANE_Y_RESOLUTION', 'Ljava/lang/String;');
  AddStaticField('TAG_F_NUMBER', 'Ljava/lang/String;');
  AddStaticField('TAG_GAIN_CONTROL', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_ALTITUDE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_ALTITUDE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_AREA_INFORMATION', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DATESTAMP', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_BEARING', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_BEARING_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_DISTANCE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_DISTANCE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_LATITUDE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_LATITUDE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_LONGITUDE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DEST_LONGITUDE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DIFFERENTIAL', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_DOP', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_IMG_DIRECTION', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_IMG_DIRECTION_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_LATITUDE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_LATITUDE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_LONGITUDE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_LONGITUDE_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_MAP_DATUM', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_MEASURE_MODE', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_PROCESSING_METHOD', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_SATELLITES', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_SPEED', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_SPEED_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_STATUS', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_TIMESTAMP', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_TRACK', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_TRACK_REF', 'Ljava/lang/String;');
  AddStaticField('TAG_GPS_VERSION_ID', 'Ljava/lang/String;');
  AddStaticField('TAG_IMAGE_DESCRIPTION', 'Ljava/lang/String;');
  AddStaticField('TAG_IMAGE_LENGTH', 'Ljava/lang/String;');
  AddStaticField('TAG_IMAGE_UNIQUE_ID', 'Ljava/lang/String;');
  AddStaticField('TAG_IMAGE_WIDTH', 'Ljava/lang/String;');
  AddStaticField('TAG_INTEROPERABILITY_INDEX', 'Ljava/lang/String;');
  AddStaticField('TAG_ISO', 'Ljava/lang/String;');
  AddStaticField('TAG_ISO_SPEED_RATINGS', 'Ljava/lang/String;');
  AddStaticField('TAG_JPEG_INTERCHANGE_FORMAT', 'Ljava/lang/String;');
  AddStaticField('TAG_JPEG_INTERCHANGE_FORMAT_LENGTH', 'Ljava/lang/String;');
  AddStaticField('TAG_LIGHT_SOURCE', 'Ljava/lang/String;');
  AddStaticField('TAG_MAKE', 'Ljava/lang/String;');
  AddStaticField('TAG_MAKER_NOTE', 'Ljava/lang/String;');
  AddStaticField('TAG_MAX_APERTURE_VALUE', 'Ljava/lang/String;');
  AddStaticField('TAG_METERING_MODE', 'Ljava/lang/String;');
  AddStaticField('TAG_MODEL', 'Ljava/lang/String;');
  AddStaticField('TAG_NEW_SUBFILE_TYPE', 'Ljava/lang/String;');
  AddStaticField('TAG_OECF', 'Ljava/lang/String;');
  AddStaticField('TAG_ORF_ASPECT_FRAME', 'Ljava/lang/String;');
  AddStaticField('TAG_ORF_PREVIEW_IMAGE_LENGTH', 'Ljava/lang/String;');
  AddStaticField('TAG_ORF_PREVIEW_IMAGE_START', 'Ljava/lang/String;');
  AddStaticField('TAG_ORF_THUMBNAIL_IMAGE', 'Ljava/lang/String;');
  AddStaticField('TAG_ORIENTATION', 'Ljava/lang/String;');
  AddStaticField('TAG_PHOTOMETRIC_INTERPRETATION', 'Ljava/lang/String;');
  AddStaticField('TAG_PIXEL_X_DIMENSION', 'Ljava/lang/String;');
  AddStaticField('TAG_PIXEL_Y_DIMENSION', 'Ljava/lang/String;');
  AddStaticField('TAG_PLANAR_CONFIGURATION', 'Ljava/lang/String;');
  AddStaticField('TAG_PRIMARY_CHROMATICITIES', 'Ljava/lang/String;');
  AddStaticField('TAG_REFERENCE_BLACK_WHITE', 'Ljava/lang/String;');
  AddStaticField('TAG_RELATED_SOUND_FILE', 'Ljava/lang/String;');
  AddStaticField('TAG_RESOLUTION_UNIT', 'Ljava/lang/String;');
  AddStaticField('TAG_ROWS_PER_STRIP', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_ISO', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_JPG_FROM_RAW', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_SENSOR_BOTTOM_BORDER', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_SENSOR_LEFT_BORDER', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_SENSOR_RIGHT_BORDER', 'Ljava/lang/String;');
  AddStaticField('TAG_RW2_SENSOR_TOP_BORDER', 'Ljava/lang/String;');
  AddStaticField('TAG_SAMPLES_PER_PIXEL', 'Ljava/lang/String;');
  AddStaticField('TAG_SATURATION', 'Ljava/lang/String;');
  AddStaticField('TAG_SCENE_CAPTURE_TYPE', 'Ljava/lang/String;');
  AddStaticField('TAG_SCENE_TYPE', 'Ljava/lang/String;');
  AddStaticField('TAG_SENSING_METHOD', 'Ljava/lang/String;');
  AddStaticField('TAG_SHARPNESS', 'Ljava/lang/String;');
  AddStaticField('TAG_SHUTTER_SPEED_VALUE', 'Ljava/lang/String;');
  AddStaticField('TAG_SOFTWARE', 'Ljava/lang/String;');
  AddStaticField('TAG_SPATIAL_FREQUENCY_RESPONSE', 'Ljava/lang/String;');
  AddStaticField('TAG_SPECTRAL_SENSITIVITY', 'Ljava/lang/String;');
  AddStaticField('TAG_STRIP_BYTE_COUNTS', 'Ljava/lang/String;');
  AddStaticField('TAG_STRIP_OFFSETS', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBFILE_TYPE', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBJECT_AREA', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBJECT_DISTANCE', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBJECT_DISTANCE_RANGE', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBJECT_LOCATION', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBSEC_TIME', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBSEC_TIME_DIG', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBSEC_TIME_DIGITIZED', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBSEC_TIME_ORIG', 'Ljava/lang/String;');
  AddStaticField('TAG_SUBSEC_TIME_ORIGINAL', 'Ljava/lang/String;');
  AddStaticField('TAG_THUMBNAIL_IMAGE_LENGTH', 'Ljava/lang/String;');
  AddStaticField('TAG_THUMBNAIL_IMAGE_WIDTH', 'Ljava/lang/String;');
  AddStaticField('TAG_TRANSFER_FUNCTION', 'Ljava/lang/String;');
  AddStaticField('TAG_USER_COMMENT', 'Ljava/lang/String;');
  AddStaticField('TAG_WHITE_BALANCE', 'Ljava/lang/String;');
  AddStaticField('TAG_WHITE_POINT', 'Ljava/lang/String;');
  AddStaticField('TAG_X_RESOLUTION', 'Ljava/lang/String;');
  AddStaticField('TAG_Y_CB_CR_COEFFICIENTS', 'Ljava/lang/String;');
  AddStaticField('TAG_Y_CB_CR_POSITIONING', 'Ljava/lang/String;');
  AddStaticField('TAG_Y_CB_CR_SUB_SAMPLING', 'Ljava/lang/String;');
  AddStaticField('TAG_Y_RESOLUTION', 'Ljava/lang/String;');
  AddStaticField('WHITEBALANCE_AUTO', 'I');
  AddStaticField('WHITEBALANCE_MANUAL', 'I');
end;

class function TJExifInterface.Wrap(const AObjectID: JNIObject): JExifInterface;
begin
  Result := Wrap<TJExifInterface, JExifInterface>(AObjectId);
end;

class function TJExifInterface.Wrap(const AObject: IJNIObject): JExifInterface;
begin
  Result := Wrap<TJExifInterface, JExifInterface>(AObject);
end;

class function TJExifInterface.Create(const AArg0: JString): JExifInterface;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/lang/String;)V', [AArg0]);
  Result := O;
end;

class function TJExifInterface.Create(const AArg0: JFileDescriptor): JExifInterface;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/io/FileDescriptor;)V', [AArg0]);
  Result := O;
end;

class function TJExifInterface.Create(const AArg0: JInputStream): JExifInterface;
begin
  var O := CreateForWrap;
  O.NewObject('(Ljava/io/InputStream;)V', [AArg0]);
  Result := O;
end;

class function TJExifInterface.ORIENTATION_FLIP_HORIZONTAL: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_FLIP_HORIZONTAL');
end;

class function TJExifInterface.ORIENTATION_FLIP_VERTICAL: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_FLIP_VERTICAL');
end;

class function TJExifInterface.ORIENTATION_NORMAL: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_NORMAL');
end;

class function TJExifInterface.ORIENTATION_ROTATE_180: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_ROTATE_180');
end;

class function TJExifInterface.ORIENTATION_ROTATE_270: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_ROTATE_270');
end;

class function TJExifInterface.ORIENTATION_ROTATE_90: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_ROTATE_90');
end;

class function TJExifInterface.ORIENTATION_TRANSPOSE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_TRANSPOSE');
end;

class function TJExifInterface.ORIENTATION_TRANSVERSE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_TRANSVERSE');
end;

class function TJExifInterface.ORIENTATION_UNDEFINED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ORIENTATION_UNDEFINED');
end;

class function TJExifInterface.TAG_APERTURE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_APERTURE');
end;

class function TJExifInterface.TAG_APERTURE_VALUE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_APERTURE_VALUE');
end;

class function TJExifInterface.TAG_ARTIST: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ARTIST');
end;

class function TJExifInterface.TAG_BITS_PER_SAMPLE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_BITS_PER_SAMPLE');
end;

class function TJExifInterface.TAG_BRIGHTNESS_VALUE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_BRIGHTNESS_VALUE');
end;

class function TJExifInterface.TAG_CFA_PATTERN: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_CFA_PATTERN');
end;

class function TJExifInterface.TAG_COLOR_SPACE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_COLOR_SPACE');
end;

class function TJExifInterface.TAG_COMPONENTS_CONFIGURATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_COMPONENTS_CONFIGURATION');
end;

class function TJExifInterface.TAG_COMPRESSED_BITS_PER_PIXEL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_COMPRESSED_BITS_PER_PIXEL');
end;

class function TJExifInterface.TAG_COMPRESSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_COMPRESSION');
end;

class function TJExifInterface.TAG_CONTRAST: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_CONTRAST');
end;

class function TJExifInterface.TAG_COPYRIGHT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_COPYRIGHT');
end;

class function TJExifInterface.TAG_CUSTOM_RENDERED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_CUSTOM_RENDERED');
end;

class function TJExifInterface.TAG_DATETIME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DATETIME');
end;

class function TJExifInterface.TAG_DATETIME_DIGITIZED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DATETIME_DIGITIZED');
end;

class function TJExifInterface.TAG_DATETIME_ORIGINAL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DATETIME_ORIGINAL');
end;

class function TJExifInterface.TAG_DEFAULT_CROP_SIZE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DEFAULT_CROP_SIZE');
end;

class function TJExifInterface.TAG_DEVICE_SETTING_DESCRIPTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DEVICE_SETTING_DESCRIPTION');
end;

class function TJExifInterface.TAG_DIGITAL_ZOOM_RATIO: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DIGITAL_ZOOM_RATIO');
end;

class function TJExifInterface.TAG_DNG_VERSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_DNG_VERSION');
end;

class function TJExifInterface.TAG_EXIF_VERSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXIF_VERSION');
end;

class function TJExifInterface.TAG_EXPOSURE_BIAS_VALUE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXPOSURE_BIAS_VALUE');
end;

class function TJExifInterface.TAG_EXPOSURE_INDEX: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXPOSURE_INDEX');
end;

class function TJExifInterface.TAG_EXPOSURE_MODE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXPOSURE_MODE');
end;

class function TJExifInterface.TAG_EXPOSURE_PROGRAM: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXPOSURE_PROGRAM');
end;

class function TJExifInterface.TAG_EXPOSURE_TIME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_EXPOSURE_TIME');
end;

class function TJExifInterface.TAG_FILE_SOURCE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FILE_SOURCE');
end;

class function TJExifInterface.TAG_FLASH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FLASH');
end;

class function TJExifInterface.TAG_FLASHPIX_VERSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FLASHPIX_VERSION');
end;

class function TJExifInterface.TAG_FLASH_ENERGY: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FLASH_ENERGY');
end;

class function TJExifInterface.TAG_FOCAL_LENGTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FOCAL_LENGTH');
end;

class function TJExifInterface.TAG_FOCAL_LENGTH_IN_35MM_FILM: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FOCAL_LENGTH_IN_35MM_FILM');
end;

class function TJExifInterface.TAG_FOCAL_PLANE_RESOLUTION_UNIT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FOCAL_PLANE_RESOLUTION_UNIT');
end;

class function TJExifInterface.TAG_FOCAL_PLANE_X_RESOLUTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FOCAL_PLANE_X_RESOLUTION');
end;

class function TJExifInterface.TAG_FOCAL_PLANE_Y_RESOLUTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_FOCAL_PLANE_Y_RESOLUTION');
end;

class function TJExifInterface.TAG_F_NUMBER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_F_NUMBER');
end;

class function TJExifInterface.TAG_GAIN_CONTROL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GAIN_CONTROL');
end;

class function TJExifInterface.TAG_GPS_ALTITUDE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_ALTITUDE');
end;

class function TJExifInterface.TAG_GPS_ALTITUDE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_ALTITUDE_REF');
end;

class function TJExifInterface.TAG_GPS_AREA_INFORMATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_AREA_INFORMATION');
end;

class function TJExifInterface.TAG_GPS_DATESTAMP: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DATESTAMP');
end;

class function TJExifInterface.TAG_GPS_DEST_BEARING: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_BEARING');
end;

class function TJExifInterface.TAG_GPS_DEST_BEARING_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_BEARING_REF');
end;

class function TJExifInterface.TAG_GPS_DEST_DISTANCE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_DISTANCE');
end;

class function TJExifInterface.TAG_GPS_DEST_DISTANCE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_DISTANCE_REF');
end;

class function TJExifInterface.TAG_GPS_DEST_LATITUDE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_LATITUDE');
end;

class function TJExifInterface.TAG_GPS_DEST_LATITUDE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_LATITUDE_REF');
end;

class function TJExifInterface.TAG_GPS_DEST_LONGITUDE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_LONGITUDE');
end;

class function TJExifInterface.TAG_GPS_DEST_LONGITUDE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DEST_LONGITUDE_REF');
end;

class function TJExifInterface.TAG_GPS_DIFFERENTIAL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DIFFERENTIAL');
end;

class function TJExifInterface.TAG_GPS_DOP: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_DOP');
end;

class function TJExifInterface.TAG_GPS_IMG_DIRECTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_IMG_DIRECTION');
end;

class function TJExifInterface.TAG_GPS_IMG_DIRECTION_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_IMG_DIRECTION_REF');
end;

class function TJExifInterface.TAG_GPS_LATITUDE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_LATITUDE');
end;

class function TJExifInterface.TAG_GPS_LATITUDE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_LATITUDE_REF');
end;

class function TJExifInterface.TAG_GPS_LONGITUDE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_LONGITUDE');
end;

class function TJExifInterface.TAG_GPS_LONGITUDE_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_LONGITUDE_REF');
end;

class function TJExifInterface.TAG_GPS_MAP_DATUM: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_MAP_DATUM');
end;

class function TJExifInterface.TAG_GPS_MEASURE_MODE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_MEASURE_MODE');
end;

class function TJExifInterface.TAG_GPS_PROCESSING_METHOD: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_PROCESSING_METHOD');
end;

class function TJExifInterface.TAG_GPS_SATELLITES: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_SATELLITES');
end;

class function TJExifInterface.TAG_GPS_SPEED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_SPEED');
end;

class function TJExifInterface.TAG_GPS_SPEED_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_SPEED_REF');
end;

class function TJExifInterface.TAG_GPS_STATUS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_STATUS');
end;

class function TJExifInterface.TAG_GPS_TIMESTAMP: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_TIMESTAMP');
end;

class function TJExifInterface.TAG_GPS_TRACK: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_TRACK');
end;

class function TJExifInterface.TAG_GPS_TRACK_REF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_TRACK_REF');
end;

class function TJExifInterface.TAG_GPS_VERSION_ID: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_GPS_VERSION_ID');
end;

class function TJExifInterface.TAG_IMAGE_DESCRIPTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_IMAGE_DESCRIPTION');
end;

class function TJExifInterface.TAG_IMAGE_LENGTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_IMAGE_LENGTH');
end;

class function TJExifInterface.TAG_IMAGE_UNIQUE_ID: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_IMAGE_UNIQUE_ID');
end;

class function TJExifInterface.TAG_IMAGE_WIDTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_IMAGE_WIDTH');
end;

class function TJExifInterface.TAG_INTEROPERABILITY_INDEX: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_INTEROPERABILITY_INDEX');
end;

class function TJExifInterface.TAG_ISO: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ISO');
end;

class function TJExifInterface.TAG_ISO_SPEED_RATINGS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ISO_SPEED_RATINGS');
end;

class function TJExifInterface.TAG_JPEG_INTERCHANGE_FORMAT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_JPEG_INTERCHANGE_FORMAT');
end;

class function TJExifInterface.TAG_JPEG_INTERCHANGE_FORMAT_LENGTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_JPEG_INTERCHANGE_FORMAT_LENGTH');
end;

class function TJExifInterface.TAG_LIGHT_SOURCE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_LIGHT_SOURCE');
end;

class function TJExifInterface.TAG_MAKE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_MAKE');
end;

class function TJExifInterface.TAG_MAKER_NOTE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_MAKER_NOTE');
end;

class function TJExifInterface.TAG_MAX_APERTURE_VALUE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_MAX_APERTURE_VALUE');
end;

class function TJExifInterface.TAG_METERING_MODE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_METERING_MODE');
end;

class function TJExifInterface.TAG_MODEL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_MODEL');
end;

class function TJExifInterface.TAG_NEW_SUBFILE_TYPE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_NEW_SUBFILE_TYPE');
end;

class function TJExifInterface.TAG_OECF: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_OECF');
end;

class function TJExifInterface.TAG_ORF_ASPECT_FRAME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ORF_ASPECT_FRAME');
end;

class function TJExifInterface.TAG_ORF_PREVIEW_IMAGE_LENGTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ORF_PREVIEW_IMAGE_LENGTH');
end;

class function TJExifInterface.TAG_ORF_PREVIEW_IMAGE_START: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ORF_PREVIEW_IMAGE_START');
end;

class function TJExifInterface.TAG_ORF_THUMBNAIL_IMAGE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ORF_THUMBNAIL_IMAGE');
end;

class function TJExifInterface.TAG_ORIENTATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ORIENTATION');
end;

class function TJExifInterface.TAG_PHOTOMETRIC_INTERPRETATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_PHOTOMETRIC_INTERPRETATION');
end;

class function TJExifInterface.TAG_PIXEL_X_DIMENSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_PIXEL_X_DIMENSION');
end;

class function TJExifInterface.TAG_PIXEL_Y_DIMENSION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_PIXEL_Y_DIMENSION');
end;

class function TJExifInterface.TAG_PLANAR_CONFIGURATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_PLANAR_CONFIGURATION');
end;

class function TJExifInterface.TAG_PRIMARY_CHROMATICITIES: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_PRIMARY_CHROMATICITIES');
end;

class function TJExifInterface.TAG_REFERENCE_BLACK_WHITE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_REFERENCE_BLACK_WHITE');
end;

class function TJExifInterface.TAG_RELATED_SOUND_FILE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RELATED_SOUND_FILE');
end;

class function TJExifInterface.TAG_RESOLUTION_UNIT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RESOLUTION_UNIT');
end;

class function TJExifInterface.TAG_ROWS_PER_STRIP: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_ROWS_PER_STRIP');
end;

class function TJExifInterface.TAG_RW2_ISO: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_ISO');
end;

class function TJExifInterface.TAG_RW2_JPG_FROM_RAW: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_JPG_FROM_RAW');
end;

class function TJExifInterface.TAG_RW2_SENSOR_BOTTOM_BORDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_SENSOR_BOTTOM_BORDER');
end;

class function TJExifInterface.TAG_RW2_SENSOR_LEFT_BORDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_SENSOR_LEFT_BORDER');
end;

class function TJExifInterface.TAG_RW2_SENSOR_RIGHT_BORDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_SENSOR_RIGHT_BORDER');
end;

class function TJExifInterface.TAG_RW2_SENSOR_TOP_BORDER: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_RW2_SENSOR_TOP_BORDER');
end;

class function TJExifInterface.TAG_SAMPLES_PER_PIXEL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SAMPLES_PER_PIXEL');
end;

class function TJExifInterface.TAG_SATURATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SATURATION');
end;

class function TJExifInterface.TAG_SCENE_CAPTURE_TYPE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SCENE_CAPTURE_TYPE');
end;

class function TJExifInterface.TAG_SCENE_TYPE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SCENE_TYPE');
end;

class function TJExifInterface.TAG_SENSING_METHOD: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SENSING_METHOD');
end;

class function TJExifInterface.TAG_SHARPNESS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SHARPNESS');
end;

class function TJExifInterface.TAG_SHUTTER_SPEED_VALUE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SHUTTER_SPEED_VALUE');
end;

class function TJExifInterface.TAG_SOFTWARE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SOFTWARE');
end;

class function TJExifInterface.TAG_SPATIAL_FREQUENCY_RESPONSE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SPATIAL_FREQUENCY_RESPONSE');
end;

class function TJExifInterface.TAG_SPECTRAL_SENSITIVITY: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SPECTRAL_SENSITIVITY');
end;

class function TJExifInterface.TAG_STRIP_BYTE_COUNTS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_STRIP_BYTE_COUNTS');
end;

class function TJExifInterface.TAG_STRIP_OFFSETS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_STRIP_OFFSETS');
end;

class function TJExifInterface.TAG_SUBFILE_TYPE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBFILE_TYPE');
end;

class function TJExifInterface.TAG_SUBJECT_AREA: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBJECT_AREA');
end;

class function TJExifInterface.TAG_SUBJECT_DISTANCE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBJECT_DISTANCE');
end;

class function TJExifInterface.TAG_SUBJECT_DISTANCE_RANGE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBJECT_DISTANCE_RANGE');
end;

class function TJExifInterface.TAG_SUBJECT_LOCATION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBJECT_LOCATION');
end;

class function TJExifInterface.TAG_SUBSEC_TIME: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBSEC_TIME');
end;

class function TJExifInterface.TAG_SUBSEC_TIME_DIG: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBSEC_TIME_DIG');
end;

class function TJExifInterface.TAG_SUBSEC_TIME_DIGITIZED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBSEC_TIME_DIGITIZED');
end;

class function TJExifInterface.TAG_SUBSEC_TIME_ORIG: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBSEC_TIME_ORIG');
end;

class function TJExifInterface.TAG_SUBSEC_TIME_ORIGINAL: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_SUBSEC_TIME_ORIGINAL');
end;

class function TJExifInterface.TAG_THUMBNAIL_IMAGE_LENGTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_THUMBNAIL_IMAGE_LENGTH');
end;

class function TJExifInterface.TAG_THUMBNAIL_IMAGE_WIDTH: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_THUMBNAIL_IMAGE_WIDTH');
end;

class function TJExifInterface.TAG_TRANSFER_FUNCTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_TRANSFER_FUNCTION');
end;

class function TJExifInterface.TAG_USER_COMMENT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_USER_COMMENT');
end;

class function TJExifInterface.TAG_WHITE_BALANCE: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_WHITE_BALANCE');
end;

class function TJExifInterface.TAG_WHITE_POINT: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_WHITE_POINT');
end;

class function TJExifInterface.TAG_X_RESOLUTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_X_RESOLUTION');
end;

class function TJExifInterface.TAG_Y_CB_CR_COEFFICIENTS: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_Y_CB_CR_COEFFICIENTS');
end;

class function TJExifInterface.TAG_Y_CB_CR_POSITIONING: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_Y_CB_CR_POSITIONING');
end;

class function TJExifInterface.TAG_Y_CB_CR_SUB_SAMPLING: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_Y_CB_CR_SUB_SAMPLING');
end;

class function TJExifInterface.TAG_Y_RESOLUTION: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('TAG_Y_RESOLUTION');
end;

class function TJExifInterface.WHITEBALANCE_AUTO: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('WHITEBALANCE_AUTO');
end;

class function TJExifInterface.WHITEBALANCE_MANUAL: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('WHITEBALANCE_MANUAL');
end;

function TJExifInterface.getAltitude(const AArg0: Double): Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAltitude', '(D)D', [WrapDouble(AArg0)]);
end;

function TJExifInterface.getAttribute(const AArg0: JString): JString;
begin
  Result := CallObjectMethod<TJString, JString>('getAttribute', '(Ljava/lang/String;)Ljava/lang/String;', [AArg0]);
end;

function TJExifInterface.getAttributeDouble(const AArg0: JString; const AArg1: Double): Double;
begin
  Result := JavaType.CallDoubleMethod(ObjectID, 'getAttributeDouble', '(Ljava/lang/String;D)D', [AArg0, WrapDouble(AArg1)]);
end;

function TJExifInterface.getAttributeInt(const AArg0: JString; const AArg1: Integer): Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'getAttributeInt', '(Ljava/lang/String;I)I', [AArg0, AArg1]);
end;

function TJExifInterface.getLatLong(const AArg0: IJavaArray<Single>): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'getLatLong', '([F)Z', [AArg0]);
end;

function TJExifInterface.getThumbnail: IJavaArray<Byte>;
begin
  Result := CallArrayMethod<Byte>('getThumbnail', '()[B', []);
end;

function TJExifInterface.getThumbnailBitmap: JBitmap;
begin
  Result := CallObjectMethod<TJBitmap, JBitmap>('getThumbnailBitmap', '()Landroid/graphics/Bitmap;', []);
end;

function TJExifInterface.getThumbnailBytes: IJavaArray<Byte>;
begin
  Result := CallArrayMethod<Byte>('getThumbnailBytes', '()[B', []);
end;

function TJExifInterface.getThumbnailRange: IJavaArray<Int64>;
begin
  Result := CallArrayMethod<Int64>('getThumbnailRange', '()[J', []);
end;

function TJExifInterface.hasThumbnail: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'hasThumbnail', '()Z', []);
end;

function TJExifInterface.isThumbnailCompressed: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isThumbnailCompressed', '()Z', []);
end;

procedure TJExifInterface.saveAttributes;
begin
  JavaType.CallVoidMethod(ObjectID, 'saveAttributes', '()V', []);
end;

procedure TJExifInterface.setAttribute(const AArg0: JString; const AArg1: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'setAttribute', '(Ljava/lang/String;Ljava/lang/String;)V', [AArg0, AArg1]);
end;

initialization
  TJavaTypesManager.RegisterJavaType(TJExifInterface, TypeInfo(IJavaArray<JExifInterface>), TJavaArray<JExifInterface>);
end.
