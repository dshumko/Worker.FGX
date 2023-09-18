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


unit Android.Api.PowerManager;

{$SCOPEDENUMS ON}
{$WARN SYMBOL_DEPRECATED OFF}

interface

uses
  System.SysUtils, Androidapi.Jni, Java.Bridge,
  Android.Api.JavaTypes, Android.Api.ActivityAndView;

type
//  JSettings = interface;
//  TJSettings = class;
//  JSettings_NameValueTable = interface;
//  TJSettings_NameValueTable = class;
//  JSettings_Secure = interface;
//  TJSettings_Secure = class;
  JPowerManager = interface;
  TJPowerManager = class;

{ android.os.PowerManager }

  [JavaClassSignature('android/os/PowerManager')]
  JPowerManager = interface(JObject)
    ['{8A057605-E13D-48DC-B13C-A646AA7FC4F1}']
    function isDeviceIdleMode: Boolean;
    function isIgnoringBatteryOptimizations(const AArg0: JString): Boolean;
    function isInteractive: Boolean;
    function isPowerSaveMode: Boolean;
    function isScreenOn: Boolean; deprecated 'Deprecated in 20';
    function isSustainedPerformanceModeSupported: Boolean;
    function isWakeLockLevelSupported(const AArg0: Integer): Boolean;
    procedure reboot(const AArg0: JString);
  end;

  [JavaClassSignature('android/os/PowerManager')]
  TJPowerManager = class(TJObject, JPowerManager)
  private
    { methods }
    function isDeviceIdleMode: Boolean;
    function isIgnoringBatteryOptimizations(const AArg0: JString): Boolean;
    function isInteractive: Boolean;
    function isPowerSaveMode: Boolean;
    function isScreenOn: Boolean; deprecated 'Deprecated in 20';
    function isSustainedPerformanceModeSupported: Boolean;
    function isWakeLockLevelSupported(const AArg0: Integer): Boolean;
    procedure reboot(const AArg0: JString);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JPowerManager; overload;
    class function Wrap(const AObject: IJNIObject): JPowerManager; overload;
    { constants }
    class function ACQUIRE_CAUSES_WAKEUP: Integer;
    class function ACTION_DEVICE_IDLE_MODE_CHANGED: JString;
    class function ACTION_POWER_SAVE_MODE_CHANGED: JString;
    class function FULL_WAKE_LOCK: Integer;
    class function ON_AFTER_RELEASE: Integer;
    class function PARTIAL_WAKE_LOCK: Integer;
    class function PROXIMITY_SCREEN_OFF_WAKE_LOCK: Integer;
    class function RELEASE_FLAG_WAIT_FOR_NO_PROXIMITY: Integer;
    class function SCREEN_BRIGHT_WAKE_LOCK: Integer;
    class function SCREEN_DIM_WAKE_LOCK: Integer;
  end;

implementation

{ TJPowerManager }

class procedure TJPowerManager.LoadConstructors;
begin
end;

class procedure TJPowerManager.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('isDeviceIdleMode', '()Z');
  AddMethod('isIgnoringBatteryOptimizations', '(Ljava/lang/String;)Z');
  AddMethod('isInteractive', '()Z');
  AddMethod('isPowerSaveMode', '()Z');
  AddMethod('isScreenOn', '()Z');
  AddMethod('isSustainedPerformanceModeSupported', '()Z');
  AddMethod('isWakeLockLevelSupported', '(I)Z');
  AddMethod('reboot', '(Ljava/lang/String;)V');
end;

class procedure TJPowerManager.LoadFields;
begin
  inherited;
  AddStaticField('ACQUIRE_CAUSES_WAKEUP', 'I');
  AddStaticField('ACTION_DEVICE_IDLE_MODE_CHANGED', 'Ljava/lang/String;');
  AddStaticField('ACTION_POWER_SAVE_MODE_CHANGED', 'Ljava/lang/String;');
  AddStaticField('FULL_WAKE_LOCK', 'I');
  AddStaticField('ON_AFTER_RELEASE', 'I');
  AddStaticField('PARTIAL_WAKE_LOCK', 'I');
  AddStaticField('PROXIMITY_SCREEN_OFF_WAKE_LOCK', 'I');
  AddStaticField('RELEASE_FLAG_WAIT_FOR_NO_PROXIMITY', 'I');
  AddStaticField('SCREEN_BRIGHT_WAKE_LOCK', 'I');
  AddStaticField('SCREEN_DIM_WAKE_LOCK', 'I');
end;

class function TJPowerManager.Wrap(const AObjectID: JNIObject): JPowerManager;
begin
  Result := Wrap<TJPowerManager, JPowerManager>(AObjectId);
end;

class function TJPowerManager.Wrap(const AObject: IJNIObject): JPowerManager;
begin
  Result := Wrap<TJPowerManager, JPowerManager>(AObject);
end;

class function TJPowerManager.ACQUIRE_CAUSES_WAKEUP: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ACQUIRE_CAUSES_WAKEUP');
end;

class function TJPowerManager.ACTION_DEVICE_IDLE_MODE_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_DEVICE_IDLE_MODE_CHANGED');
end;

class function TJPowerManager.ACTION_POWER_SAVE_MODE_CHANGED: JString;
begin
  Result := GetStaticObjectField<TJString, JString>('ACTION_POWER_SAVE_MODE_CHANGED');
end;

class function TJPowerManager.FULL_WAKE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FULL_WAKE_LOCK');
end;

class function TJPowerManager.ON_AFTER_RELEASE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ON_AFTER_RELEASE');
end;

class function TJPowerManager.PARTIAL_WAKE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('PARTIAL_WAKE_LOCK');
end;

class function TJPowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('PROXIMITY_SCREEN_OFF_WAKE_LOCK');
end;

class function TJPowerManager.RELEASE_FLAG_WAIT_FOR_NO_PROXIMITY: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('RELEASE_FLAG_WAIT_FOR_NO_PROXIMITY');
end;

class function TJPowerManager.SCREEN_BRIGHT_WAKE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('SCREEN_BRIGHT_WAKE_LOCK');
end;

class function TJPowerManager.SCREEN_DIM_WAKE_LOCK: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('SCREEN_DIM_WAKE_LOCK');
end;

function TJPowerManager.isDeviceIdleMode: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isDeviceIdleMode', '()Z', []);
end;

function TJPowerManager.isIgnoringBatteryOptimizations(const AArg0: JString): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isIgnoringBatteryOptimizations', '(Ljava/lang/String;)Z', [AArg0]);
end;

function TJPowerManager.isInteractive: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isInteractive', '()Z', []);
end;

function TJPowerManager.isPowerSaveMode: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isPowerSaveMode', '()Z', []);
end;

function TJPowerManager.isScreenOn: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isScreenOn', '()Z', []);
end;

function TJPowerManager.isSustainedPerformanceModeSupported: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isSustainedPerformanceModeSupported', '()Z', []);
end;

function TJPowerManager.isWakeLockLevelSupported(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isWakeLockLevelSupported', '(I)Z', [AArg0]);
end;

procedure TJPowerManager.reboot(const AArg0: JString);
begin
  JavaType.CallVoidMethod(ObjectID, 'reboot', '(Ljava/lang/String;)V', [AArg0]);
end;

initialization
  TJavaTypesManager.RegisterJavaType(TJPowerManager, TypeInfo(IJavaArray<JPowerManager>), TJavaArray<JPowerManager>);
end.
