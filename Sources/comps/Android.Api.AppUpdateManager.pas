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


unit Android.Api.AppUpdateManager;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, Androidapi.Jni, Java.Bridge,
  Android.Api.ActivityAndView, Android.Api.JavaTypes;

type
  JAppUpdateInfo = interface;
  TJAppUpdateInfo = class;
  JAppUpdateManager = interface;
  TJAppUpdateManager = class;
  JAppUpdateManagerFactory = interface;
  TJAppUpdateManagerFactory = class;
  JAppUpdateOptions = interface;
  TJAppUpdateOptions = class;
  JAppUpdateOptions_Builder = interface;
  TJAppUpdateOptions_Builder = class;
  JInstallState = interface;
  TJInstallState = class;
  JInstallStateUpdatedListener = interface;
  TJInstallStateUpdatedListener = class;
  JActivityResult = interface;
  TJActivityResult = class;
  JAppUpdateType = interface;
  TJAppUpdateType = class;
  JInstallErrorCode = interface;
  TJInstallErrorCode = class;
  JInstallStatus = interface;
  TJInstallStatus = class;
  JUpdateAvailability = interface;
  TJUpdateAvailability = class;
  JStateUpdatedListener = interface;
  TJStateUpdatedListener = class;
  JNativeOnCompleteListener = interface;
  TJNativeOnCompleteListener = class;
  JOnCompleteListener = interface;
  TJOnCompleteListener = class;
  JOnFailureListener = interface;
  TJOnFailureListener = class;
  JOnSuccessListener = interface;
  TJOnSuccessListener = class;
  JTask = interface;
  TJTask = class;
  
{ com.google.android.play.core.appupdate.AppUpdateInfo }

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateInfo')]
  JAppUpdateInfo = interface(JObject)
    ['{33E471DC-D305-481F-9AFB-4F16F4A4AD44}']
    function availableVersionCode: Integer;
    function bytesDownloaded: Int64;
    function clientVersionStalenessDays: JInteger;
    function installStatus: Integer;
    function isUpdateTypeAllowed(const AArg0: Integer): Boolean; overload;
    function isUpdateTypeAllowed(const AArg0: JAppUpdateOptions): Boolean; overload;
    function packageName: JString;
    function totalBytesToDownload: Int64;
    function updateAvailability: Integer;
    function updatePriority: Integer;
  end;

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateInfo')]
  TJAppUpdateInfo = class(TJObject, JAppUpdateInfo)
  private
    { methods }
    function availableVersionCode: Integer;
    function bytesDownloaded: Int64;
    function clientVersionStalenessDays: JInteger;
    function installStatus: Integer;
    function isUpdateTypeAllowed(const AArg0: Integer): Boolean; overload;
    function isUpdateTypeAllowed(const AArg0: JAppUpdateOptions): Boolean; overload;
    function packageName: JString;
    function totalBytesToDownload: Int64;
    function updateAvailability: Integer;
    function updatePriority: Integer;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateInfo; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateInfo; overload;
    { methods }
    class function zzb(const AArg0: JString; const AArg1: Integer; const AArg2: Integer; const AArg3: Integer; const AArg4: JInteger; const AArg5: Integer; const AArg6: Int64; const AArg7: Int64; const AArg8: Int64; const AArg9: Int64; const AArg10: JPendingIntent; const AArg11: JPendingIntent; const AArg12: JPendingIntent; const AArg13: JPendingIntent): JAppUpdateInfo;
  end;

{ com.google.android.play.core.appupdate.AppUpdateManager - interface }

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateManager')]
  JAppUpdateManager = interface(IJavaObject)
    ['{37285394-5B33-4822-8AB5-BD22AB4D1C09}']
    function completeUpdate: JTask;
    function getAppUpdateInfo: JTask;
    procedure registerListener(const AArg0: JInstallStateUpdatedListener);
    function startUpdateFlow(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions): JTask;
    function startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions; const AArg3: Integer): Boolean; overload;
    function startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: Integer; const AArg2: JActivity; const AArg3: Integer): Boolean; overload;
    procedure unregisterListener(const AArg0: JInstallStateUpdatedListener);
  end;

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateManager')]
  TJAppUpdateManager = class(TJObject, JAppUpdateManager)
  private
    { methods }
    function completeUpdate: JTask;
    function getAppUpdateInfo: JTask;
    procedure registerListener(const AArg0: JInstallStateUpdatedListener);
    function startUpdateFlow(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions): JTask;
    function startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions; const AArg3: Integer): Boolean; overload;
    function startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: Integer; const AArg2: JActivity; const AArg3: Integer): Boolean; overload;
    procedure unregisterListener(const AArg0: JInstallStateUpdatedListener);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateManager; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateManager; overload;
  end;

{ com.google.android.play.core.appupdate.AppUpdateManagerFactory }

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateManagerFactory')]
  JAppUpdateManagerFactory = interface(JObject)
    ['{2D94F0C3-4072-4920-9C0F-E3B06704ACB0}']
  end;

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateManagerFactory')]
  TJAppUpdateManagerFactory = class(TJObject, JAppUpdateManagerFactory)
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateManagerFactory; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateManagerFactory; overload;
    { methods }
    class function create(const AArg0: JContext): JAppUpdateManager; overload;
  end;

{ com.google.android.play.core.appupdate.AppUpdateOptions }

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateOptions')]
  JAppUpdateOptions = interface(JObject)
    ['{5365B0F2-2A58-43F6-80D9-4AF8B5DACB8F}']
    function allowAssetPackDeletion: Boolean;
    function appUpdateType: Integer;
  end;

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateOptions')]
  TJAppUpdateOptions = class(TJObject, JAppUpdateOptions)
  private
    { methods }
    function allowAssetPackDeletion: Boolean;
    function appUpdateType: Integer;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateOptions; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateOptions; overload;
    { constructors }
    class function Create: JAppUpdateOptions; overload;
    { methods }
    class function defaultOptions(const AArg0: Integer): JAppUpdateOptions;
    class function newBuilder(const AArg0: Integer): JAppUpdateOptions_Builder;
  end;

{ com.google.android.play.core.appupdate.AppUpdateOptions_Builder }

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateOptions$Builder')]
  JAppUpdateOptions_Builder = interface(JObject)
    ['{A8E1CB1B-CC69-4080-B214-BBFF74A14B7D}']
    function build: JAppUpdateOptions;
    function setAllowAssetPackDeletion(const AArg0: Boolean): JAppUpdateOptions_Builder;
    function setAppUpdateType(const AArg0: Integer): JAppUpdateOptions_Builder;
  end;

  [JavaClassSignature('com/google/android/play/core/appupdate/AppUpdateOptions$Builder')]
  TJAppUpdateOptions_Builder = class(TJObject, JAppUpdateOptions_Builder)
  private
    { methods }
    function build: JAppUpdateOptions;
    function setAllowAssetPackDeletion(const AArg0: Boolean): JAppUpdateOptions_Builder;
    function setAppUpdateType(const AArg0: Integer): JAppUpdateOptions_Builder;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateOptions_Builder; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateOptions_Builder; overload;
    { constructors }
    class function Create: JAppUpdateOptions_Builder; overload;
  end;

{ com.google.android.play.core.install.InstallState }

  [JavaClassSignature('com/google/android/play/core/install/InstallState')]
  JInstallState = interface(JObject)
    ['{7F9EAD5C-586D-47BD-99EF-317796B7292B}']
    function bytesDownloaded: Int64;
    function installErrorCode: Integer;
    function installStatus: Integer;
    function packageName: JString;
    function totalBytesToDownload: Int64;
  end;

  [JavaClassSignature('com/google/android/play/core/install/InstallState')]
  TJInstallState = class(TJObject, JInstallState)
  private
    { methods }
    function bytesDownloaded: Int64;
    function installErrorCode: Integer;
    function installStatus: Integer;
    function packageName: JString;
    function totalBytesToDownload: Int64;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JInstallState; overload;
    class function Wrap(const AObject: IJNIObject): JInstallState; overload;
    { constructors }
    class function Create: JInstallState; overload;
    { methods }
    class function zza(const AArg0: Integer; const AArg1: Int64; const AArg2: Int64; const AArg3: Integer; const AArg4: JString): JInstallState;
  end;
{ com.google.android.play.core.listener.StateUpdatedListener - interface }

  [JavaClassSignature('com/google/android/play/core/listener/StateUpdatedListener')]
  JStateUpdatedListener = interface(IJavaObject)
    ['{89C9A902-5519-4377-B16D-683F7C24A592}']
    procedure onStateUpdate(const AArg0: JObject);
  end;

  [JavaClassSignature('com/google/android/play/core/listener/StateUpdatedListener')]
  TJStateUpdatedListener = class(TJObject, JStateUpdatedListener)
  private
    { methods }
    procedure onStateUpdate(const AArg0: JObject);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JStateUpdatedListener; overload;
    class function Wrap(const AObject: IJNIObject): JStateUpdatedListener; overload;
  end;


{ com.google.android.play.core.install.InstallStateUpdatedListener - interface }

  [JavaClassSignature('com/google/android/play/core/install/InstallStateUpdatedListener')]
  JInstallStateUpdatedListener = interface(JStateUpdatedListener)
    ['{37605577-2E49-45F1-BC74-709BE5A1A807}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/InstallStateUpdatedListener')]
  TJInstallStateUpdatedListener = class(TJStateUpdatedListener, JInstallStateUpdatedListener)
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JInstallStateUpdatedListener; overload;
    class function Wrap(const AObject: IJNIObject): JInstallStateUpdatedListener; overload;
  end;

{ com.google.android.play.core.install.model.ActivityResult }

  [JavaClassSignature('com/google/android/play/core/install/model/ActivityResult')]
  JActivityResult = interface(JObject)
    ['{197DF019-C9C8-4D90-8093-7E2023FEBF6E}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/model/ActivityResult')]
  TJActivityResult = class(TJObject, JActivityResult)
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JActivityResult; overload;
    class function Wrap(const AObject: IJNIObject): JActivityResult; overload;
    { constants }
    class function RESULT_IN_APP_UPDATE_FAILED: Integer;
  end;

{ com.google.android.play.core.install.model.AppUpdateType - interface }

  [JavaClassSignature('com/google/android/play/core/install/model/AppUpdateType')]
  JAppUpdateType = interface(JAnnotation)
    ['{D11A3F4E-FD2C-4821-B8E8-58ADAB3884FC}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/model/AppUpdateType')]
  TJAppUpdateType = class(TJAnnotation, JAppUpdateType)
  protected
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JAppUpdateType; overload;
    class function Wrap(const AObject: IJNIObject): JAppUpdateType; overload;
    { constants }
    class function FLEXIBLE: Integer;
    class function IMMEDIATE: Integer;
  end;

{ com.google.android.play.core.install.model.InstallErrorCode - interface }

  [JavaClassSignature('com/google/android/play/core/install/model/InstallErrorCode')]
  JInstallErrorCode = interface(JAnnotation)
    ['{6B890B00-0761-466C-B1F1-1D1C951B7D51}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/model/InstallErrorCode')]
  TJInstallErrorCode = class(TJAnnotation, JInstallErrorCode)
  protected
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JInstallErrorCode; overload;
    class function Wrap(const AObject: IJNIObject): JInstallErrorCode; overload;
    { constants }
    class function ERROR_API_NOT_AVAILABLE: Integer;
    class function ERROR_APP_NOT_OWNED: Integer;
    class function ERROR_DOWNLOAD_NOT_PRESENT: Integer;
    class function ERROR_INSTALL_NOT_ALLOWED: Integer;
    class function ERROR_INSTALL_UNAVAILABLE: Integer;
    class function ERROR_INTERNAL_ERROR: Integer;
    class function ERROR_INVALID_REQUEST: Integer;
    class function ERROR_PLAY_STORE_NOT_FOUND: Integer;
    class function ERROR_UNKNOWN: Integer;
    class function NO_ERROR: Integer;
    class function NO_ERROR_PARTIALLY_ALLOWED: Integer;
  end;

{ com.google.android.play.core.install.model.InstallStatus - interface }

  [JavaClassSignature('com/google/android/play/core/install/model/InstallStatus')]
  JInstallStatus = interface(JAnnotation)
    ['{C8B05902-709D-47E3-8357-C3984F855553}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/model/InstallStatus')]
  TJInstallStatus = class(TJAnnotation, JInstallStatus)
  protected
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JInstallStatus; overload;
    class function Wrap(const AObject: IJNIObject): JInstallStatus; overload;
    { constants }
    class function CANCELED: Integer;
    class function DOWNLOADED: Integer;
    class function DOWNLOADING: Integer;
    class function FAILED: Integer;
    class function INSTALLED: Integer;
    class function INSTALLING: Integer;
    class function PENDING: Integer;
    class function REQUIRES_UI_INTENT: Integer;
    class function UNKNOWN: Integer;
  end;

{ com.google.android.play.core.install.model.UpdateAvailability - interface }

  [JavaClassSignature('com/google/android/play/core/install/model/UpdateAvailability')]
  JUpdateAvailability = interface(JAnnotation)
    ['{705B1968-076C-4D37-82F2-D48A0FFF0BF2}']
  end;

  [JavaClassSignature('com/google/android/play/core/install/model/UpdateAvailability')]
  TJUpdateAvailability = class(TJAnnotation, JUpdateAvailability)
  protected
    class procedure LoadMethods; override;
    class procedure LoadFields; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JUpdateAvailability; overload;
    class function Wrap(const AObject: IJNIObject): JUpdateAvailability; overload;
    { constants }
    class function DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS: Integer;
    class function UNKNOWN: Integer;
    class function UPDATE_AVAILABLE: Integer;
    class function UPDATE_NOT_AVAILABLE: Integer;
  end;

{ com.google.android.play.core.install.model.zza }

  [JavaClassSignature('com/google/android/play/core/install/model/zza')]
  Jzza = interface(JObject)
    ['{3A9E5BBB-3352-4B73-BC2A-8AAC6781F217}']
  end;

{ com.google.android.play.core.tasks.NativeOnCompleteListener }

  [JavaClassSignature('com/google/android/play/core/tasks/NativeOnCompleteListener')]
  JNativeOnCompleteListener = interface(JObject)
    ['{4620271D-F6C4-4401-9C23-4190BD1C1AE4}']
    procedure nativeOnComplete(const AArg0: Int64; const AArg1: Integer; const AArg2: JObject; const AArg3: Integer);
    procedure onComplete(const AArg0: JTask);
  end;

  [JavaClassSignature('com/google/android/play/core/tasks/NativeOnCompleteListener')]
  TJNativeOnCompleteListener = class(TJObject, JNativeOnCompleteListener)
  private
    { methods }
    procedure nativeOnComplete(const AArg0: Int64; const AArg1: Integer; const AArg2: JObject; const AArg3: Integer);
    procedure onComplete(const AArg0: JTask);
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JNativeOnCompleteListener; overload;
    class function Wrap(const AObject: IJNIObject): JNativeOnCompleteListener; overload;
    { constructors }
    class function Create(const AArg0: Int64; const AArg1: Integer): JNativeOnCompleteListener; overload;
  end;

{ com.google.android.play.core.tasks.OnCompleteListener - interface }

  [JavaClassSignature('com/google/android/play/core/tasks/OnCompleteListener')]
  JOnCompleteListener = interface(IJavaObject)
    ['{EF08A6D4-312E-40F7-9898-1EBD2C85E5A2}']
    procedure onComplete(const AArg0: JTask);
  end;

  [JavaClassSignature('com/google/android/play/core/tasks/OnCompleteListener')]
  TJOnCompleteListener = class(TJObject, JOnCompleteListener)
  private
    { methods }
    procedure onComplete(const AArg0: JTask);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JOnCompleteListener; overload;
    class function Wrap(const AObject: IJNIObject): JOnCompleteListener; overload;
  end;

{ com.google.android.play.core.tasks.OnFailureListener - interface }

  [JavaClassSignature('com/google/android/play/core/tasks/OnFailureListener')]
  JOnFailureListener = interface(IJavaObject)
    ['{7C88B489-4DA8-4CF5-B931-26B8900DFE07}']
    procedure onFailure(const AArg0: JException);
  end;

  [JavaClassSignature('com/google/android/play/core/tasks/OnFailureListener')]
  TJOnFailureListener = class(TJObject, JOnFailureListener)
  private
    { methods }
    procedure onFailure(const AArg0: JException);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JOnFailureListener; overload;
    class function Wrap(const AObject: IJNIObject): JOnFailureListener; overload;
  end;

{ com.google.android.play.core.tasks.OnSuccessListener - interface }

  [JavaClassSignature('com/google/android/play/core/tasks/OnSuccessListener')]
  JOnSuccessListener = interface(IJavaObject)
    ['{F67954EA-1F82-41A5-9CC0-03435227628E}']
    procedure onSuccess(const AArg0: JObject);
  end;

  [JavaClassSignature('com/google/android/play/core/tasks/OnSuccessListener')]
  TJOnSuccessListener = class(TJObject, JOnSuccessListener)
  private
    { methods }
    procedure onSuccess(const AArg0: JObject);
  protected
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JOnSuccessListener; overload;
    class function Wrap(const AObject: IJNIObject): JOnSuccessListener; overload;
  end;

{ com.google.android.play.core.tasks.RuntimeExecutionException }


{ com.google.android.play.core.tasks.Task }

  [JavaClassSignature('com/google/android/play/core/tasks/Task')]
  JTask = interface(JObject)
    ['{561B86F7-B1D8-4D4A-A833-C9AEF4608FDB}']
    function addOnCompleteListener(const AArg0: JOnCompleteListener): JTask; overload;
    function addOnFailureListener(const AArg0: JOnFailureListener): JTask; overload;
    function addOnSuccessListener(const AArg0: JOnSuccessListener): JTask; overload;
    function getException: JException;
    function getResult(const AArg0: JClass): JObject; overload;
    function getResult: JObject; overload;
    function isComplete: Boolean;
    function isSuccessful: Boolean;
  end;

  [JavaClassSignature('com/google/android/play/core/tasks/Task')]
  TJTask = class(TJObject, JTask)
  private
    { methods }
    function addOnCompleteListener(const AArg0: JOnCompleteListener): JTask; overload;
    function addOnFailureListener(const AArg0: JOnFailureListener): JTask; overload;
    function addOnSuccessListener(const AArg0: JOnSuccessListener): JTask; overload;
    function getException: JException;
    function getResult(const AArg0: JClass): JObject; overload;
    function getResult: JObject; overload;
    function isComplete: Boolean;
    function isSuccessful: Boolean;
  protected
    class procedure LoadConstructors; override;
    class procedure LoadMethods; override;
  public
    { wrapping }
    class function Wrap(const AObjectID: JNIObject): JTask; overload;
    class function Wrap(const AObject: IJNIObject): JTask; overload;
    { constructors }
    class function Create: JTask; overload;
  end;


implementation

{ TJAppUpdateInfo }

class procedure TJAppUpdateInfo.LoadConstructors;
begin
end;

class procedure TJAppUpdateInfo.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('availableVersionCode', '()I');
  AddMethod('bytesDownloaded', '()J');
  AddMethod('clientVersionStalenessDays', '()Ljava/lang/Integer;');
  AddMethod('installStatus', '()I');
  AddMethod('isUpdateTypeAllowed', '(I)Z');
  AddMethod('isUpdateTypeAllowed', '(Lcom/google/android/play/core/appupdate/AppUpdateOptions;)Z');
  AddMethod('packageName', '()Ljava/lang/String;');
  AddMethod('totalBytesToDownload', '()J');
  AddMethod('updateAvailability', '()I');
  AddMethod('updatePriority', '()I');
  AddStaticMethod('zzb', '(Ljava/lang/String;IIILjava/lang/Integer;IJJJJLandroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Lcom/google/android/play/core/appupdate/AppUpdateInfo;');
end;

class function TJAppUpdateInfo.Wrap(const AObjectID: JNIObject): JAppUpdateInfo;
begin
  Result := Wrap<TJAppUpdateInfo, JAppUpdateInfo>(AObjectId);
end;

class function TJAppUpdateInfo.Wrap(const AObject: IJNIObject): JAppUpdateInfo;
begin
  Result := Wrap<TJAppUpdateInfo, JAppUpdateInfo>(AObject);
end;

function TJAppUpdateInfo.availableVersionCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'availableVersionCode', '()I', []);
end;

function TJAppUpdateInfo.bytesDownloaded: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'bytesDownloaded', '()J', []);
end;

function TJAppUpdateInfo.clientVersionStalenessDays: JInteger;
begin
  Result := CallObjectMethod<TJInteger, JInteger>('clientVersionStalenessDays', '()Ljava/lang/Integer;', []);
end;

function TJAppUpdateInfo.installStatus: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'installStatus', '()I', []);
end;

function TJAppUpdateInfo.isUpdateTypeAllowed(const AArg0: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isUpdateTypeAllowed', '(I)Z', [AArg0]);
end;

function TJAppUpdateInfo.isUpdateTypeAllowed(const AArg0: JAppUpdateOptions): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isUpdateTypeAllowed', '(Lcom/google/android/play/core/appupdate/AppUpdateOptions;)Z', [AArg0]);
end;

function TJAppUpdateInfo.packageName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('packageName', '()Ljava/lang/String;', []);
end;

function TJAppUpdateInfo.totalBytesToDownload: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'totalBytesToDownload', '()J', []);
end;

function TJAppUpdateInfo.updateAvailability: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'updateAvailability', '()I', []);
end;

function TJAppUpdateInfo.updatePriority: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'updatePriority', '()I', []);
end;

class function TJAppUpdateInfo.zzb(const AArg0: JString; const AArg1: Integer; const AArg2: Integer; const AArg3: Integer; const AArg4: JInteger; const AArg5: Integer; const AArg6: Int64; const AArg7: Int64; const AArg8: Int64; const AArg9: Int64; const AArg10: JPendingIntent; const AArg11: JPendingIntent; const AArg12: JPendingIntent; const AArg13: JPendingIntent): JAppUpdateInfo;
begin
  Result := CallStaticObjectMethod<TJAppUpdateInfo, JAppUpdateInfo>('zzb', '(Ljava/lang/String;IIILjava/lang/Integer;IJJJJLandroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Lcom/google/android/play/core/appupdate/AppUpdateInfo;', [AArg0, AArg1, AArg2, AArg3, AArg4, AArg5, AArg6, AArg7, AArg8, AArg9, AArg10, AArg11, AArg12, AArg13]);
end;

{ TJAppUpdateManager }

class procedure TJAppUpdateManager.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('completeUpdate', '()Lcom/google/android/play/core/tasks/Task;');
  AddMethod('getAppUpdateInfo', '()Lcom/google/android/play/core/tasks/Task;');
  AddMethod('registerListener', '(Lcom/google/android/play/core/install/InstallStateUpdatedListener;)V');
  AddMethod('startUpdateFlow', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;Landroid/app/Activity;Lcom/google/android/play/core/appupdate/AppUpdateOptions;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('startUpdateFlowForResult', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;Landroid/app/Activity;Lcom/google/android/play/core/appupdate/AppUpdateOptions;I)Z');
  AddMethod('startUpdateFlowForResult', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;ILandroid/app/Activity;I)Z');
  AddMethod('unregisterListener', '(Lcom/google/android/play/core/install/InstallStateUpdatedListener;)V');
end;

class function TJAppUpdateManager.Wrap(const AObjectID: JNIObject): JAppUpdateManager;
begin
  Result := Wrap<TJAppUpdateManager, JAppUpdateManager>(AObjectId);
end;

class function TJAppUpdateManager.Wrap(const AObject: IJNIObject): JAppUpdateManager;
begin
  Result := Wrap<TJAppUpdateManager, JAppUpdateManager>(AObject);
end;

function TJAppUpdateManager.completeUpdate: JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('completeUpdate', '()Lcom/google/android/play/core/tasks/Task;', []);
end;

function TJAppUpdateManager.getAppUpdateInfo: JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('getAppUpdateInfo', '()Lcom/google/android/play/core/tasks/Task;', []);
end;

procedure TJAppUpdateManager.registerListener(const AArg0: JInstallStateUpdatedListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'registerListener', '(Lcom/google/android/play/core/install/InstallStateUpdatedListener;)V', [GetObjectId(AArg0)]);
end;

function TJAppUpdateManager.startUpdateFlow(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions): JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('startUpdateFlow', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;Landroid/app/Activity;Lcom/google/android/play/core/appupdate/AppUpdateOptions;)Lcom/google/android/play/core/tasks/Task;', [AArg0, AArg1, AArg2]);
end;

function TJAppUpdateManager.startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: JActivity; const AArg2: JAppUpdateOptions; const AArg3: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'startUpdateFlowForResult', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;Landroid/app/Activity;Lcom/google/android/play/core/appupdate/AppUpdateOptions;I)Z', [AArg0, AArg1, AArg2, AArg3]);
end;

function TJAppUpdateManager.startUpdateFlowForResult(const AArg0: JAppUpdateInfo; const AArg1: Integer; const AArg2: JActivity; const AArg3: Integer): Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'startUpdateFlowForResult', '(Lcom/google/android/play/core/appupdate/AppUpdateInfo;ILandroid/app/Activity;I)Z', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJAppUpdateManager.unregisterListener(const AArg0: JInstallStateUpdatedListener);
begin
  JavaType.CallVoidMethod(ObjectID, 'unregisterListener', '(Lcom/google/android/play/core/install/InstallStateUpdatedListener;)V', [GetObjectId(AArg0)]);
end;

{ TJAppUpdateManagerFactory }

class procedure TJAppUpdateManagerFactory.LoadConstructors;
begin
end;

class procedure TJAppUpdateManagerFactory.LoadMethods;
begin
  inherited;
  { methods }
  AddStaticMethod('create', '(Landroid/content/Context;)Lcom/google/android/play/core/appupdate/AppUpdateManager;');
end;

class function TJAppUpdateManagerFactory.Wrap(const AObjectID: JNIObject): JAppUpdateManagerFactory;
begin
  Result := Wrap<TJAppUpdateManagerFactory, JAppUpdateManagerFactory>(AObjectId);
end;

class function TJAppUpdateManagerFactory.Wrap(const AObject: IJNIObject): JAppUpdateManagerFactory;
begin
  Result := Wrap<TJAppUpdateManagerFactory, JAppUpdateManagerFactory>(AObject);
end;

class function TJAppUpdateManagerFactory.create(const AArg0: JContext): JAppUpdateManager;
begin
  Result := CallStaticObjectMethod<TJAppUpdateManager, JAppUpdateManager>('create', '(Landroid/content/Context;)Lcom/google/android/play/core/appupdate/AppUpdateManager;', [AArg0]);
end;

{ TJAppUpdateOptions }

class procedure TJAppUpdateOptions.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJAppUpdateOptions.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('allowAssetPackDeletion', '()Z');
  AddMethod('appUpdateType', '()I');
  AddStaticMethod('defaultOptions', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions;');
  AddStaticMethod('newBuilder', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;');
end;

class function TJAppUpdateOptions.Wrap(const AObjectID: JNIObject): JAppUpdateOptions;
begin
  Result := Wrap<TJAppUpdateOptions, JAppUpdateOptions>(AObjectId);
end;

class function TJAppUpdateOptions.Wrap(const AObject: IJNIObject): JAppUpdateOptions;
begin
  Result := Wrap<TJAppUpdateOptions, JAppUpdateOptions>(AObject);
end;

class function TJAppUpdateOptions.Create: JAppUpdateOptions;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

function TJAppUpdateOptions.allowAssetPackDeletion: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'allowAssetPackDeletion', '()Z', []);
end;

function TJAppUpdateOptions.appUpdateType: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'appUpdateType', '()I', []);
end;

class function TJAppUpdateOptions.defaultOptions(const AArg0: Integer): JAppUpdateOptions;
begin
  Result := CallStaticObjectMethod<TJAppUpdateOptions, JAppUpdateOptions>('defaultOptions', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions;', [AArg0]);
end;

class function TJAppUpdateOptions.newBuilder(const AArg0: Integer): JAppUpdateOptions_Builder;
begin
  Result := CallStaticObjectMethod<TJAppUpdateOptions_Builder, JAppUpdateOptions_Builder>('newBuilder', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;', [AArg0]);
end;

{ TJAppUpdateOptions_Builder }

class procedure TJAppUpdateOptions_Builder.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJAppUpdateOptions_Builder.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('build', '()Lcom/google/android/play/core/appupdate/AppUpdateOptions;');
  AddMethod('setAllowAssetPackDeletion', '(Z)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;');
  AddMethod('setAppUpdateType', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;');
end;

class function TJAppUpdateOptions_Builder.Wrap(const AObjectID: JNIObject): JAppUpdateOptions_Builder;
begin
  Result := Wrap<TJAppUpdateOptions_Builder, JAppUpdateOptions_Builder>(AObjectId);
end;

class function TJAppUpdateOptions_Builder.Wrap(const AObject: IJNIObject): JAppUpdateOptions_Builder;
begin
  Result := Wrap<TJAppUpdateOptions_Builder, JAppUpdateOptions_Builder>(AObject);
end;

class function TJAppUpdateOptions_Builder.Create: JAppUpdateOptions_Builder;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

function TJAppUpdateOptions_Builder.build: JAppUpdateOptions;
begin
  Result := CallObjectMethod<TJAppUpdateOptions, JAppUpdateOptions>('build', '()Lcom/google/android/play/core/appupdate/AppUpdateOptions;', []);
end;

function TJAppUpdateOptions_Builder.setAllowAssetPackDeletion(const AArg0: Boolean): JAppUpdateOptions_Builder;
begin
  Result := CallObjectMethod<TJAppUpdateOptions_Builder, JAppUpdateOptions_Builder>('setAllowAssetPackDeletion', '(Z)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;', [AArg0]);
end;

function TJAppUpdateOptions_Builder.setAppUpdateType(const AArg0: Integer): JAppUpdateOptions_Builder;
begin
  Result := CallObjectMethod<TJAppUpdateOptions_Builder, JAppUpdateOptions_Builder>('setAppUpdateType', '(I)Lcom/google/android/play/core/appupdate/AppUpdateOptions$Builder;', [AArg0]);
end;



{ TJInstallState }

class procedure TJInstallState.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJInstallState.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('bytesDownloaded', '()J');
  AddMethod('installErrorCode', '()I');
  AddMethod('installStatus', '()I');
  AddMethod('packageName', '()Ljava/lang/String;');
  AddMethod('totalBytesToDownload', '()J');
  AddStaticMethod('zza', '(IJJILjava/lang/String;)Lcom/google/android/play/core/install/InstallState;');
end;

class function TJInstallState.Wrap(const AObjectID: JNIObject): JInstallState;
begin
  Result := Wrap<TJInstallState, JInstallState>(AObjectId);
end;

class function TJInstallState.Wrap(const AObject: IJNIObject): JInstallState;
begin
  Result := Wrap<TJInstallState, JInstallState>(AObject);
end;

class function TJInstallState.Create: JInstallState;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;

function TJInstallState.bytesDownloaded: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'bytesDownloaded', '()J', []);
end;

function TJInstallState.installErrorCode: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'installErrorCode', '()I', []);
end;

function TJInstallState.installStatus: Integer;
begin
  Result := JavaType.CallIntMethod(ObjectID, 'installStatus', '()I', []);
end;

function TJInstallState.packageName: JString;
begin
  Result := CallObjectMethod<TJString, JString>('packageName', '()Ljava/lang/String;', []);
end;

function TJInstallState.totalBytesToDownload: Int64;
begin
  Result := JavaType.CallLongMethod(ObjectID, 'totalBytesToDownload', '()J', []);
end;

class function TJInstallState.zza(const AArg0: Integer; const AArg1: Int64; const AArg2: Int64; const AArg3: Integer; const AArg4: JString): JInstallState;
begin
  Result := CallStaticObjectMethod<TJInstallState, JInstallState>('zza', '(IJJILjava/lang/String;)Lcom/google/android/play/core/install/InstallState;', [AArg0, AArg1, AArg2, AArg3, AArg4]);
end;

{ TJInstallStateUpdatedListener }

class procedure TJInstallStateUpdatedListener.LoadMethods;
begin
  inherited;
end;

class function TJInstallStateUpdatedListener.Wrap(const AObjectID: JNIObject): JInstallStateUpdatedListener;
begin
  Result := Wrap<TJInstallStateUpdatedListener, JInstallStateUpdatedListener>(AObjectId);
end;

class function TJInstallStateUpdatedListener.Wrap(const AObject: IJNIObject): JInstallStateUpdatedListener;
begin
  Result := Wrap<TJInstallStateUpdatedListener, JInstallStateUpdatedListener>(AObject);
end;

{ TJActivityResult }

class procedure TJActivityResult.LoadConstructors;
begin
end;

class procedure TJActivityResult.LoadMethods;
begin
  inherited;
end;

class procedure TJActivityResult.LoadFields;
begin
  inherited;
  AddStaticField('RESULT_IN_APP_UPDATE_FAILED', 'I');
end;

class function TJActivityResult.Wrap(const AObjectID: JNIObject): JActivityResult;
begin
  Result := Wrap<TJActivityResult, JActivityResult>(AObjectId);
end;

class function TJActivityResult.Wrap(const AObject: IJNIObject): JActivityResult;
begin
  Result := Wrap<TJActivityResult, JActivityResult>(AObject);
end;

class function TJActivityResult.RESULT_IN_APP_UPDATE_FAILED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('RESULT_IN_APP_UPDATE_FAILED');
end;

{ TJAppUpdateType }

class procedure TJAppUpdateType.LoadMethods;
begin
  inherited;
end;

class procedure TJAppUpdateType.LoadFields;
begin
  inherited;
  AddStaticField('FLEXIBLE', 'I');
  AddStaticField('IMMEDIATE', 'I');
end;

class function TJAppUpdateType.Wrap(const AObjectID: JNIObject): JAppUpdateType;
begin
  Result := Wrap<TJAppUpdateType, JAppUpdateType>(AObjectId);
end;

class function TJAppUpdateType.Wrap(const AObject: IJNIObject): JAppUpdateType;
begin
  Result := Wrap<TJAppUpdateType, JAppUpdateType>(AObject);
end;

class function TJAppUpdateType.FLEXIBLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FLEXIBLE');
end;

class function TJAppUpdateType.IMMEDIATE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('IMMEDIATE');
end;

{ TJInstallErrorCode }

class procedure TJInstallErrorCode.LoadMethods;
begin
  inherited;
end;

class procedure TJInstallErrorCode.LoadFields;
begin
  inherited;
  AddStaticField('ERROR_API_NOT_AVAILABLE', 'I');
  AddStaticField('ERROR_APP_NOT_OWNED', 'I');
  AddStaticField('ERROR_DOWNLOAD_NOT_PRESENT', 'I');
  AddStaticField('ERROR_INSTALL_NOT_ALLOWED', 'I');
  AddStaticField('ERROR_INSTALL_UNAVAILABLE', 'I');
  AddStaticField('ERROR_INTERNAL_ERROR', 'I');
  AddStaticField('ERROR_INVALID_REQUEST', 'I');
  AddStaticField('ERROR_PLAY_STORE_NOT_FOUND', 'I');
  AddStaticField('ERROR_UNKNOWN', 'I');
  AddStaticField('NO_ERROR', 'I');
  AddStaticField('NO_ERROR_PARTIALLY_ALLOWED', 'I');
end;

class function TJInstallErrorCode.Wrap(const AObjectID: JNIObject): JInstallErrorCode;
begin
  Result := Wrap<TJInstallErrorCode, JInstallErrorCode>(AObjectId);
end;

class function TJInstallErrorCode.Wrap(const AObject: IJNIObject): JInstallErrorCode;
begin
  Result := Wrap<TJInstallErrorCode, JInstallErrorCode>(AObject);
end;

class function TJInstallErrorCode.ERROR_API_NOT_AVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_API_NOT_AVAILABLE');
end;

class function TJInstallErrorCode.ERROR_APP_NOT_OWNED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_APP_NOT_OWNED');
end;

class function TJInstallErrorCode.ERROR_DOWNLOAD_NOT_PRESENT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_DOWNLOAD_NOT_PRESENT');
end;

class function TJInstallErrorCode.ERROR_INSTALL_NOT_ALLOWED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_INSTALL_NOT_ALLOWED');
end;

class function TJInstallErrorCode.ERROR_INSTALL_UNAVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_INSTALL_UNAVAILABLE');
end;

class function TJInstallErrorCode.ERROR_INTERNAL_ERROR: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_INTERNAL_ERROR');
end;

class function TJInstallErrorCode.ERROR_INVALID_REQUEST: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_INVALID_REQUEST');
end;

class function TJInstallErrorCode.ERROR_PLAY_STORE_NOT_FOUND: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_PLAY_STORE_NOT_FOUND');
end;

class function TJInstallErrorCode.ERROR_UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('ERROR_UNKNOWN');
end;

class function TJInstallErrorCode.NO_ERROR: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('NO_ERROR');
end;

class function TJInstallErrorCode.NO_ERROR_PARTIALLY_ALLOWED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('NO_ERROR_PARTIALLY_ALLOWED');
end;

{ TJInstallStatus }

class procedure TJInstallStatus.LoadMethods;
begin
  inherited;
end;

class procedure TJInstallStatus.LoadFields;
begin
  inherited;
  AddStaticField('CANCELED', 'I');
  AddStaticField('DOWNLOADED', 'I');
  AddStaticField('DOWNLOADING', 'I');
  AddStaticField('FAILED', 'I');
  AddStaticField('INSTALLED', 'I');
  AddStaticField('INSTALLING', 'I');
  AddStaticField('PENDING', 'I');
  AddStaticField('REQUIRES_UI_INTENT', 'I');
  AddStaticField('UNKNOWN', 'I');
end;

class function TJInstallStatus.Wrap(const AObjectID: JNIObject): JInstallStatus;
begin
  Result := Wrap<TJInstallStatus, JInstallStatus>(AObjectId);
end;

class function TJInstallStatus.Wrap(const AObject: IJNIObject): JInstallStatus;
begin
  Result := Wrap<TJInstallStatus, JInstallStatus>(AObject);
end;

class function TJInstallStatus.CANCELED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('CANCELED');
end;

class function TJInstallStatus.DOWNLOADED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('DOWNLOADED');
end;

class function TJInstallStatus.DOWNLOADING: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('DOWNLOADING');
end;

class function TJInstallStatus.FAILED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('FAILED');
end;

class function TJInstallStatus.INSTALLED: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('INSTALLED');
end;

class function TJInstallStatus.INSTALLING: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('INSTALLING');
end;

class function TJInstallStatus.PENDING: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('PENDING');
end;

class function TJInstallStatus.REQUIRES_UI_INTENT: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('REQUIRES_UI_INTENT');
end;

class function TJInstallStatus.UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('UNKNOWN');
end;

{ TJUpdateAvailability }

class procedure TJUpdateAvailability.LoadMethods;
begin
  inherited;
end;

class procedure TJUpdateAvailability.LoadFields;
begin
  inherited;
  AddStaticField('DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS', 'I');
  AddStaticField('UNKNOWN', 'I');
  AddStaticField('UPDATE_AVAILABLE', 'I');
  AddStaticField('UPDATE_NOT_AVAILABLE', 'I');
end;

class function TJUpdateAvailability.Wrap(const AObjectID: JNIObject): JUpdateAvailability;
begin
  Result := Wrap<TJUpdateAvailability, JUpdateAvailability>(AObjectId);
end;

class function TJUpdateAvailability.Wrap(const AObject: IJNIObject): JUpdateAvailability;
begin
  Result := Wrap<TJUpdateAvailability, JUpdateAvailability>(AObject);
end;

class function TJUpdateAvailability.DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS');
end;

class function TJUpdateAvailability.UNKNOWN: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('UNKNOWN');
end;

class function TJUpdateAvailability.UPDATE_AVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('UPDATE_AVAILABLE');
end;

class function TJUpdateAvailability.UPDATE_NOT_AVAILABLE: Integer;
begin
  Result := StaticJavaType[Self].GetStaticIntField('UPDATE_NOT_AVAILABLE');
end;


{ TJStateUpdatedListener }

class procedure TJStateUpdatedListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onStateUpdate', '(Ljava/lang/Object;)V');
end;

class function TJStateUpdatedListener.Wrap(const AObjectID: JNIObject): JStateUpdatedListener;
begin
  Result := Wrap<TJStateUpdatedListener, JStateUpdatedListener>(AObjectId);
end;

class function TJStateUpdatedListener.Wrap(const AObject: IJNIObject): JStateUpdatedListener;
begin
  Result := Wrap<TJStateUpdatedListener, JStateUpdatedListener>(AObject);
end;

procedure TJStateUpdatedListener.onStateUpdate(const AArg0: JObject);
begin
  JavaType.CallVoidMethod(ObjectID, 'onStateUpdate', '(Ljava/lang/Object;)V', [AArg0]);
end;

{ TJNativeOnCompleteListener }

class procedure TJNativeOnCompleteListener.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '(JI)V');
end;

class procedure TJNativeOnCompleteListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('nativeOnComplete', '(JILjava/lang/Object;I)V');
  AddMethod('onComplete', '(Lcom/google/android/play/core/tasks/Task;)V');
end;

class function TJNativeOnCompleteListener.Wrap(const AObjectID: JNIObject): JNativeOnCompleteListener;
begin
  Result := Wrap<TJNativeOnCompleteListener, JNativeOnCompleteListener>(AObjectId);
end;

class function TJNativeOnCompleteListener.Wrap(const AObject: IJNIObject): JNativeOnCompleteListener;
begin
  Result := Wrap<TJNativeOnCompleteListener, JNativeOnCompleteListener>(AObject);
end;

class function TJNativeOnCompleteListener.Create(const AArg0: Int64; const AArg1: Integer): JNativeOnCompleteListener;
begin
  var O := CreateForWrap;
  O.NewObject('(JI)V', [AArg0, AArg1]);
  Result := O;
end;

procedure TJNativeOnCompleteListener.nativeOnComplete(const AArg0: Int64; const AArg1: Integer; const AArg2: JObject; const AArg3: Integer);
begin
  JavaType.CallVoidMethod(ObjectID, 'nativeOnComplete', '(JILjava/lang/Object;I)V', [AArg0, AArg1, AArg2, AArg3]);
end;

procedure TJNativeOnCompleteListener.onComplete(const AArg0: JTask);
begin
  JavaType.CallVoidMethod(ObjectID, 'onComplete', '(Lcom/google/android/play/core/tasks/Task;)V', [AArg0]);
end;

{ TJOnCompleteListener }

class procedure TJOnCompleteListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onComplete', '(Lcom/google/android/play/core/tasks/Task;)V');
end;

class function TJOnCompleteListener.Wrap(const AObjectID: JNIObject): JOnCompleteListener;
begin
  Result := Wrap<TJOnCompleteListener, JOnCompleteListener>(AObjectId);
end;

class function TJOnCompleteListener.Wrap(const AObject: IJNIObject): JOnCompleteListener;
begin
  Result := Wrap<TJOnCompleteListener, JOnCompleteListener>(AObject);
end;

procedure TJOnCompleteListener.onComplete(const AArg0: JTask);
begin
  JavaType.CallVoidMethod(ObjectID, 'onComplete', '(Lcom/google/android/play/core/tasks/Task;)V', [AArg0]);
end;

{ TJOnFailureListener }

class procedure TJOnFailureListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onFailure', '(Ljava/lang/Exception;)V');
end;

class function TJOnFailureListener.Wrap(const AObjectID: JNIObject): JOnFailureListener;
begin
  Result := Wrap<TJOnFailureListener, JOnFailureListener>(AObjectId);
end;

class function TJOnFailureListener.Wrap(const AObject: IJNIObject): JOnFailureListener;
begin
  Result := Wrap<TJOnFailureListener, JOnFailureListener>(AObject);
end;

procedure TJOnFailureListener.onFailure(const AArg0: JException);
begin
  JavaType.CallVoidMethod(ObjectID, 'onFailure', '(Ljava/lang/Exception;)V', [AArg0]);
end;

{ TJOnSuccessListener }

class procedure TJOnSuccessListener.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('onSuccess', '(Ljava/lang/Object;)V');
end;

class function TJOnSuccessListener.Wrap(const AObjectID: JNIObject): JOnSuccessListener;
begin
  Result := Wrap<TJOnSuccessListener, JOnSuccessListener>(AObjectId);
end;

class function TJOnSuccessListener.Wrap(const AObject: IJNIObject): JOnSuccessListener;
begin
  Result := Wrap<TJOnSuccessListener, JOnSuccessListener>(AObject);
end;

procedure TJOnSuccessListener.onSuccess(const AArg0: JObject);
begin
  JavaType.CallVoidMethod(ObjectID, 'onSuccess', '(Ljava/lang/Object;)V', [AArg0]);
end;


{ TJTask }

class procedure TJTask.LoadConstructors;
begin
  { constructors }
  AddMethod('<init>', '()V');
end;

class procedure TJTask.LoadMethods;
begin
  inherited;
  { methods }
  AddMethod('addOnCompleteListener', '(Ljava/util/concurrent/Executor;Lcom/google/android/play/core/tasks/OnCompleteListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('addOnCompleteListener', '(Lcom/google/android/play/core/tasks/OnCompleteListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('addOnFailureListener', '(Ljava/util/concurrent/Executor;Lcom/google/android/play/core/tasks/OnFailureListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('addOnFailureListener', '(Lcom/google/android/play/core/tasks/OnFailureListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('addOnSuccessListener', '(Ljava/util/concurrent/Executor;Lcom/google/android/play/core/tasks/OnSuccessListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('addOnSuccessListener', '(Lcom/google/android/play/core/tasks/OnSuccessListener;)Lcom/google/android/play/core/tasks/Task;');
  AddMethod('getException', '()Ljava/lang/Exception;');
  AddMethod('getResult', '(Ljava/lang/Class;)Ljava/lang/Object;');
  AddMethod('getResult', '()Ljava/lang/Object;');
  AddMethod('isComplete', '()Z');
  AddMethod('isSuccessful', '()Z');
end;

class function TJTask.Wrap(const AObjectID: JNIObject): JTask;
begin
  Result := Wrap<TJTask, JTask>(AObjectId);
end;

class function TJTask.Wrap(const AObject: IJNIObject): JTask;
begin
  Result := Wrap<TJTask, JTask>(AObject);
end;

class function TJTask.Create: JTask;
begin
  var O := CreateForWrap;
  O.NewObject('()V', []);
  Result := O;
end;


function TJTask.addOnCompleteListener(const AArg0: JOnCompleteListener): JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('addOnCompleteListener', '(Lcom/google/android/play/core/tasks/OnCompleteListener;)Lcom/google/android/play/core/tasks/Task;', [GetObjectId(AArg0)]);
end;

function TJTask.addOnFailureListener(const AArg0: JOnFailureListener): JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('addOnFailureListener', '(Lcom/google/android/play/core/tasks/OnFailureListener;)Lcom/google/android/play/core/tasks/Task;', [GetObjectId(AArg0)]);
end;

function TJTask.addOnSuccessListener(const AArg0: JOnSuccessListener): JTask;
begin
  Result := CallObjectMethod<TJTask, JTask>('addOnSuccessListener', '(Lcom/google/android/play/core/tasks/OnSuccessListener;)Lcom/google/android/play/core/tasks/Task;', [GetObjectId(AArg0)]);
end;

function TJTask.getException: JException;
begin
  Result := CallObjectMethod<TJException, JException>('getException', '()Ljava/lang/Exception;', []);
end;

function TJTask.getResult(const AArg0: JClass): JObject;
begin
  Result := CallObjectMethod<TJObject, JObject>('getResult', '(Ljava/lang/Class;)Ljava/lang/Object;', [AArg0]);
end;

function TJTask.getResult: JObject;
begin
  Result := CallObjectMethod<TJObject, JObject>('getResult', '()Ljava/lang/Object;', []);
end;

function TJTask.isComplete: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isComplete', '()Z', []);
end;

function TJTask.isSuccessful: Boolean;
begin
  Result := JavaType.CallBooleanMethod(ObjectID, 'isSuccessful', '()Z', []);
end;


initialization
  TJavaTypesManager.RegisterJavaType(TJAppUpdateInfo, TypeInfo(IJavaArray<JAppUpdateInfo>), TJavaArray<JAppUpdateInfo>);
  TJavaTypesManager.RegisterJavaType(TJAppUpdateManager, TypeInfo(IJavaArray<JAppUpdateManager>), TJavaArray<JAppUpdateManager>);
  TJavaTypesManager.RegisterJavaType(TJAppUpdateManagerFactory, TypeInfo(IJavaArray<JAppUpdateManagerFactory>), TJavaArray<JAppUpdateManagerFactory>);
  TJavaTypesManager.RegisterJavaType(TJAppUpdateOptions, TypeInfo(IJavaArray<JAppUpdateOptions>), TJavaArray<JAppUpdateOptions>);
  TJavaTypesManager.RegisterJavaType(TJAppUpdateOptions_Builder, TypeInfo(IJavaArray<JAppUpdateOptions_Builder>), TJavaArray<JAppUpdateOptions_Builder>);
  TJavaTypesManager.RegisterJavaType(TJInstallState, TypeInfo(IJavaArray<JInstallState>), TJavaArray<JInstallState>);
  TJavaTypesManager.RegisterJavaType(TJInstallStateUpdatedListener, TypeInfo(IJavaArray<JInstallStateUpdatedListener>), TJavaArray<JInstallStateUpdatedListener>);
  TJavaTypesManager.RegisterJavaType(TJActivityResult, TypeInfo(IJavaArray<JActivityResult>), TJavaArray<JActivityResult>);
  TJavaTypesManager.RegisterJavaType(TJAppUpdateType, TypeInfo(IJavaArray<JAppUpdateType>), TJavaArray<JAppUpdateType>);
  TJavaTypesManager.RegisterJavaType(TJInstallErrorCode, TypeInfo(IJavaArray<JInstallErrorCode>), TJavaArray<JInstallErrorCode>);
  TJavaTypesManager.RegisterJavaType(TJInstallStatus, TypeInfo(IJavaArray<JInstallStatus>), TJavaArray<JInstallStatus>);
  TJavaTypesManager.RegisterJavaType(TJUpdateAvailability, TypeInfo(IJavaArray<JUpdateAvailability>), TJavaArray<JUpdateAvailability>);
  TJavaTypesManager.RegisterJavaType(TJStateUpdatedListener, TypeInfo(IJavaArray<JStateUpdatedListener>), TJavaArray<JStateUpdatedListener>);
  TJavaTypesManager.RegisterJavaType(TJNativeOnCompleteListener, TypeInfo(IJavaArray<JNativeOnCompleteListener>), TJavaArray<JNativeOnCompleteListener>);
  TJavaTypesManager.RegisterJavaType(TJOnCompleteListener, TypeInfo(IJavaArray<JOnCompleteListener>), TJavaArray<JOnCompleteListener>);
  TJavaTypesManager.RegisterJavaType(TJOnFailureListener, TypeInfo(IJavaArray<JOnFailureListener>), TJavaArray<JOnFailureListener>);
  TJavaTypesManager.RegisterJavaType(TJOnSuccessListener, TypeInfo(IJavaArray<JOnSuccessListener>), TJavaArray<JOnSuccessListener>);
  TJavaTypesManager.RegisterJavaType(TJTask, TypeInfo(IJavaArray<JTask>), TJavaArray<JTask>);
end.
