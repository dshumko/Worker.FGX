unit Form.Main;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, System.Messaging, Generics.Collections,
  FGX.Layout.Types,
  FGX.NavigationBar.Types, FGX.ListMenu.Types, FGX.ListMenu, FGX.StaticLabel,
  FGX.DrawerLayout, FGX.NavigationBar, FGX.Layout, FGX.Controls,
  FGX.Forms, FGX.Forms.Types, FGX.Controls.Types, FGX.CollectionView, FGX.Image,
  FGX.PushNotification,
  XSuperObject,
  UVKCommonApi, Base.BaseForm, Base.BaseApiForm, ServiceUnit.mwClasses,
  FGX.Sensors, FGX.Timer, FGX.Sensors.Components;

type
  TFrameStackItem = class
    FrameClass: TmwBaseFormClass;
    Values: array of Variant;
    FrameName: string;
    ATitle: string;
    ASubTitle: string;
    procedure Assign(Source: TFrameStackItem);
  end;

type
  TListMenuItem = class
  public
    Name: string;
    Icon: string;
    Tag: Integer;
  end;

type
  TFormMain = class(TfgForm)
    pnDrawer: TfgDrawerLayout;
    nbMain: TfgNavigationBar;
    pnDrawer_Drawer: TfgDrawer;
    pnDrawer_Content: TfgMainContent;
    lbMenuAppName: TfgLabel;
    lbMenuAppMail: TfgLabel;
    mnMain: TfgListMenu;
    pnMain: TfgLayout;
    lvMenu_Style1: TfgCollectionViewStyle;
    lvMenu: TfgCollectionView;
    lvMenu_Styles: TfgCollectionViewStyles;
    fgImage1: TfgImage;
    fgLabel1: TfgLabel;
    tmGPSInterval: TfgTimer;
    AService: TfgPushNotificationService;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure ShowSubFrame(index: Integer);
    procedure fgFormSafeAreaChanged(Sender: TObject; const AScreenInsets: TRectF);
    procedure fgFormDestroy(Sender: TObject);
    function lvMenuGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    function lvMenuGetItemCount(Sender: TObject): Integer;
    procedure lvMenuBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string; const AItem: TfgItemWrapper);
    procedure lvMenuTapItem(Sender: TObject; const AIndex: Integer);
    procedure mnMainTapItem(Sender: TObject; const AItem: TfgListMenuItem);
    procedure tmGPSIntervalTimer(Sender: TObject);
    procedure aGPSLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure AServiceStatusChanged(Sender: TObject; const AStatus: TfgPushServiceStatus);
    procedure AServicePushNotificationReceived(Sender: TObject; const ANotification: TfgPushNotification);
    procedure AServiceDeviceTokenChanged(Sender: TObject; const ADeviceToken: string);
    procedure AServiceError(Sender: TObject; const AMessage: string);
  private
    { Private declarations }
    aGps: TLocationSensor;
    FBackPressed: Cardinal;
    FLoggedIn: Boolean;
    FRights: TmwUserRights;
    FDeviceID, FDeviceToken: string;
    FActiveSubFrame: TmwBaseForm;
    FormStack: TObjectList<TFrameStackItem>;
    FMenuList: TObjectList<TListMenuItem>;
    FStackSize: Integer;
    FGPSLastTime: TDateTime;
    FcurrentLat, FCurrentLon: Double;
    FStartObjectType: Variant;
    FStartObjectId: Variant;
    procedure AddMenuItems;
    procedure SetActiveSubFrame(const Value: TmwBaseForm);
    function CheckGPS: Boolean;
    procedure CloseProgram;
    procedure ShowMenu;
    procedure RegisterPushService;
    procedure ShowNotification(ANotification: TfgPushNotification); overload;
    procedure ShowNotification(ATitle, AText: string); overload;
    procedure SendToken;
    procedure GotoRequest(ARequestId: string);
    procedure ConfirmClose;
  protected
{$IFDEF ANDROID}
    procedure ActivityNewIntentHandler(const Sender: TObject; const M: TMessage);
{$ENDIF}
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartWork;
    procedure SetRights(X: ISuperObject);
    procedure RunFrame(FrameClass: TmwBaseFormClass; Values: array of Variant; ATitle: string = '';
      ASubTitle: string = '');
    procedure RemoveCurrentFrame(Value: string; FrameName: string; noShowParent: Boolean = false);
    procedure ClearFrameStack;
    procedure AddToStack(AFrameClass: TmwBaseFormClass; AFrameName: string; AValues: array of Variant; ATitle: string;
      ASubTitle: string);
    procedure SetNavigation(aVisible: Boolean; ATitle: string = 'Мобильный сотрудник'; ASubTitle: string = '';
      aNavigationIcon: string = 'menu');
    property ActiveSubFrame: TmwBaseForm read FActiveSubFrame write SetActiveSubFrame;
    property Rights: TmwUserRights read FRights;
    property CurrentLat: Double read FcurrentLat;
    property CurrentLon: Double read FCurrentLon;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.StrUtils, System.Threading, System.UITypes, System.DateUtils, System.Variants,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Animation, FGX.Toasts, FGX.Permissions,
{$IFDEF ANDROID}FGX.Helpers.Android, FGX.Platform.Android, Android.Api.ActivityAndView,
  Android.Api.JavaTypes, Android.Api.Providers.Settings, {$ENDIF}
{$IFDEF IOS} iOS.Api.CoreLocation, {$ENDIF}
  Assets.Consts, ServiceUnit.Api, ServiceUnit.Settings, FGX.Any.Utils,
  Frame.FormLogin, Frame.FormStreets, Frame.FormPromotions,
  Frame.FormContacts, Frame.FormBookMarks, Frame.FormBids, Frame.FormMap, Frame.FormBidInfo;

{$IFDEF ANDROID}

procedure TFormMain.ActivityNewIntentHandler(const Sender: TObject; const M: TMessage);
var
  Msg: TfgActivityNewIntentMessage;
  Intent: JIntent;
  Extras: JBundle;
  DataIterator: JIterator;
  Key: JString;
  Value: JString;
  requestId: String;
begin
  Msg := TfgActivityNewIntentMessage(M);
  Intent := Msg.Value;
  Extras := Intent.getExtras;
  if Extras = nil then
    Exit;
  DataIterator := Extras.keySet.iterator;
  while DataIterator.hasNext do
  begin
    Key := TJString.Wrap(DataIterator.next);
    Value := Extras.getString(Key);
    if SameText(Js2S(Key), 'requestId') then
    begin
      requestId := Js2S(Value);
      if FLoggedIn then
        GotoRequest(requestId)
      else
      begin
        FStartObjectType := -10;
        FStartObjectId := requestId;
      end
    end;
  end;
end;
{$ENDIF}

function IsGPSActive(HIGH_ACCURACY: Boolean = false): Boolean;
{$IFDEF ANDROID}
var
  LocationMode: Integer;
{$ENDIF}
begin
{$IFDEF ANDROID}
  LocationMode := TJSettings_Secure.getInt(TfgAndroidHelper.Context.getContentResolver,
    TJSettings_Secure.LOCATION_MODE);
  if HIGH_ACCURACY then
    Result := LocationMode <> TJSettings_Secure.LOCATION_MODE_HIGH_ACCURACY
  else
    Result := LocationMode <> TJSettings_Secure.LOCATION_MODE_OFF;
{$ELSE}
  Result := True;
{$ENDIF}
end;

procedure TFormMain.AddMenuItems;
var
  item: TListMenuItem;
  I: Integer;
  li: TfgListMenuItem;
begin
  item := TListMenuItem.Create;
  item.Name := 'Заявки';
  item.Icon := R.Bitmap.ICONS_LIST;
  item.Tag := 0;
  FMenuList.Add(item);
  item := TListMenuItem.Create;
  item.Name := 'Адреса';
  item.Icon := R.Bitmap.ICONS_BUSINESS;
  item.Tag := 1;
  FMenuList.Add(item);
  item := TListMenuItem.Create;
  item.Name := 'Акции';
  item.Icon := R.Bitmap.ICONS_LOCAL_ACTIVITY;
  item.Tag := 2;
  FMenuList.Add(item);
  item := TListMenuItem.Create;
  item.Name := 'Телефоны';
  item.Icon := R.Bitmap.ICONS_PHONE;
  item.Tag := 3;
  FMenuList.Add(item);
  item := TListMenuItem.Create;
  item.Name := 'Закладки';
  item.Icon := R.Bitmap.ICONS_BOOKMARK_BIG;
  item.Tag := 4;
  FMenuList.Add(item);
  item := TListMenuItem.Create;
  item.Name := 'Карта';
  item.Icon := R.Bitmap.ICONS_MAP_BIG;
  item.Tag := 5;
  FMenuList.Add(item);

  lvMenu.Visible := True;
  if TOSVersion.Platform = TOSVersion.TPlatform.pfiOS then
    mnMain.Items.BeginUpdate;
  try
    mnMain.Items.Clear;
    lvMenu.ReloadItems;
    for I := 0 to FMenuList.Count - 1 do
    begin
      li := TfgListMenuItem.Create(mnMain.Items);
      li.Title := FMenuList[I].Name;
      li.IconName := FMenuList[I].Icon;
      li.Tag := FMenuList[I].Tag;
    end;
    li := TfgListMenuItem.Create(mnMain.Items);
    li.Title := 'Выход';
    li.IconName := R.Bitmap.ICONS_CLOSE;
    li.Tag := 10;
  finally
    if TOSVersion.Platform = TOSVersion.TPlatform.pfiOS then
      mnMain.Items.EndUpdate;

  end;

end;

procedure TFormMain.AddToStack(AFrameClass: TmwBaseFormClass; AFrameName: string; AValues: array of Variant;
  ATitle, ASubTitle: string);
var
  NewFrame: TFrameStackItem;
  I: Integer;
begin
  NewFrame := TFrameStackItem.Create;
  NewFrame.FrameClass := AFrameClass;
  SetLength(NewFrame.Values, Length(AValues));
  for I := 0 to Length(AValues) - 1 do
    NewFrame.Values[I] := AValues[I];
  NewFrame.FrameName := AFrameName;
  NewFrame.ATitle := ATitle;
  NewFrame.ASubTitle := ASubTitle;
  FormStack.Add(NewFrame);
  FStackSize := FormStack.Count;
end;

procedure TFormMain.aGPSLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
var
  Api: TmwApi;
begin
  FGPSLastTime := Now();
  aGps.Active := false;
  FcurrentLat := NewLocation.Latitude;
  FCurrentLon := NewLocation.Longitude;

  TTask.Run(
    procedure
    begin
      Api := TmwApi.Clone(_API);
      try
        Api.Login := Settings.Login;
        Api.Password := Settings.Password;
        Api.setLocation(FcurrentLat, FCurrentLon);
      finally
        Api.Free;
      end
    end);
end;

procedure TFormMain.AServiceDeviceTokenChanged(Sender: TObject; const ADeviceToken: string);
begin
{$IFDEF ANDROID}
  FDeviceID := AService.DeviceId;
{$ENDIF}
  FDeviceToken := ADeviceToken;
  SendToken;
end;

procedure TFormMain.AServiceError(Sender: TObject; const AMessage: string);
begin
  TfgLog.Error('[Push]: ' + Format('Error: "%s"', [AMessage]));
end;

procedure TFormMain.AServicePushNotificationReceived(Sender: TObject; const ANotification: TfgPushNotification);
begin
  if FLoggedIn then
    ShowNotification(ANotification);
end;

procedure TFormMain.AServiceStatusChanged(Sender: TObject; const AStatus: TfgPushServiceStatus);
begin
  TfgLog.Debug('[Push]: ' + Format('Status changed: status="%s"', [AStatus.ToString]));
end;

procedure TFormMain.CloseProgram;
begin
{$IFDEF ANDROID}
  TfgAndroidHelper.Activity.finish;
{$ELSE}
  Close;
{$ENDIF}
end;

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited;
{$IFDEF ANDROID}
  TMessageManager.DefaultManager.SubscribeToMessage(TfgActivityNewIntentMessage, ActivityNewIntentHandler);
{$ENDIF}
end;

destructor TFormMain.Destroy;
begin
{$IFDEF ANDROID}
  TMessageManager.DefaultManager.Unsubscribe(TfgActivityNewIntentMessage, ActivityNewIntentHandler);
{$ENDIF}
  inherited;
end;

function TFormMain.CheckGPS: Boolean;
begin
  Result := Settings.gpsInterval > 0;
  if Result and (not IsGPSActive) then
  begin
    TfgToastFactory.Show('Отключен GPS. Работа приложения может быть нарушена.');
    Result := false;
  end;
end;

procedure TFormMain.ClearFrameStack;
begin
  if Assigned(FActiveSubFrame) then
    FActiveSubFrame.Close;

  FActiveSubFrame := nil;
  while (FormStack.Count > 0) do
  begin
    FormStack.Delete(FormStack.Count - 1);
  end;

  if FActiveSubFrame = nil then
    SetNavigation(True);
end;

procedure TFormMain.lvMenuBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
const AItem: TfgItemWrapper);
begin
  AItem.GetControlByLookupName<TfgLabel>('primary').Text := FMenuList[AIndex].Name;
  AItem.GetControlByLookupName<TfgImage>('icon').ImageName := FMenuList[AIndex].Icon;
end;

function TFormMain.lvMenuGetItemCount(Sender: TObject): Integer;
begin
  if FMenuList <> nil then
    Result := FMenuList.Count
  else
    Result := 0;
end;

function TFormMain.lvMenuGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  Result := 'Style-Menu';
end;

procedure TFormMain.lvMenuTapItem(Sender: TObject; const AIndex: Integer);
begin
  ShowSubFrame(FMenuList[AIndex].Tag);
end;

procedure TFormMain.fgFormCreate(Sender: TObject);
var
  Notifications: TArray<TfgPushNotification>;
  Notification: TfgPushNotification;
  xJS: ISuperObject;
  FRequestId: string;
begin
  aGps := TLocationSensor.Create(Self);
  aGps.OnLocationChanged := aGPSLocationChanged;
  aGps.Active := false;
  FStartObjectType := Null;
  FStartObjectId := Null;
  Notifications := AService.StartupNotifications;
  for Notification in Notifications do
  begin
    xJS := SO(Notification.Json.ToString);
    FRequestId := xJS.S['requestId'];
    if not FRequestId.IsEmpty then
    begin
      FStartObjectType := -10;
      FStartObjectId := FRequestId;
    end;
  end;
  FLoggedIn := false;
  FStackSize := 0;
  FormStack := TObjectList<TFrameStackItem>.Create(True);
  FMenuList := TObjectList<TListMenuItem>.Create(True);
  FRights := TmwUserRights.Create;
  RunFrame(TmwFormLogin, [], '', '');
end;

procedure TFormMain.fgFormDestroy(Sender: TObject);
begin
  FormStack.Free;
  FMenuList.Free;
  FRights.Free;
  // if Assigned(AService) then
  // AService.Free;
end;

procedure TFormMain.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
const
  DoubleTapDuration = 2000; // msec
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := True;
    if ((FBackPressed + DoubleTapDuration) > MilliSecondOfTheDay(Now)) then
      AHandled := false
    else
    begin
      FBackPressed := MilliSecondOfTheDay(Now);
      TfgToastFactory.Show('Нажмите еще раз для выхода', TfgToastDuration.Short);
    end
  end;
end;

procedure TFormMain.fgFormSafeAreaChanged(Sender: TObject; const AScreenInsets: TRectF);
const
  DefaultOneTitleHeight = 56;
begin
  nbMain.Height := DefaultOneTitleHeight + AScreenInsets.Top;
  pnDrawer_Drawer.Padding.Top := AScreenInsets.Top;
  nbMain.Realign;
  pnDrawer_Drawer.Realign;
end;

procedure TFormMain.GotoRequest(ARequestId: string);
var
  prevItem: TFrameStackItem;
begin
  prevItem := nil;
  if Assigned(FActiveSubFrame) then
  begin
    if FormStack.Count > 0 then
    begin
      prevItem := TFrameStackItem.Create;
      prevItem.Assign(FormStack[FormStack.Count - 1]);
    end;
    RemoveCurrentFrame(FActiveSubFrame.ClassName, FActiveSubFrame.Name, True);
    if prevItem <> nil then
    begin
      AddToStack(prevItem.FrameClass, prevItem.FrameName, prevItem.Values, prevItem.ATitle, prevItem.ASubTitle);
    end
  end;
  RunFrame(TmwFormBidInfo, [ARequestId.ToInteger], 'Заявка', ARequestId);
end;

procedure TFormMain.mnMainTapItem(Sender: TObject; const AItem: TfgListMenuItem);
begin
  ShowSubFrame(AItem.Tag);
end;

procedure TFormMain.RegisterPushService;
begin
  // AService := TfgPushNotificationService.Create(nil);
  // AService.OnDeviceTokenChanged := AServiceDeviceTokenChanged;
  // AService.OnPushNotificationReceived := AServicePushNotificationReceived;
  // AService.OnStatusChanged := AServiceStatusChanged;
  // AService.OnError := AServiceError;
end;

procedure TFormMain.RemoveCurrentFrame(Value: string; FrameName: string; noShowParent: Boolean = false);
var
  I: Integer;
  Frames: string;
begin
  if Assigned(FActiveSubFrame) then
  begin
    FActiveSubFrame.Close;
    FActiveSubFrame := nil;
  end;
  if (FormStack.Count > 0) then
  begin
    Frames := '';
    for I := 0 to FormStack.Count - 1 do
      Frames := Frames + ',' + FormStack[I].FrameName;
    if SameText(Value, FormStack[FormStack.Count - 1].FrameClass.ClassName) and
      (SameText(FrameName, FormStack[FormStack.Count - 1].FrameName)) then
    begin
      FormStack.Delete(FormStack.Count - 1);
    end;
    Frames := '';
    for I := 0 to FormStack.Count - 1 do
      Frames := Frames + ',' + FormStack[I].FrameName;
    FStackSize := FormStack.Count;
    if not noShowParent then
      if (FStackSize > 0) (* and SameText(FormStack[FormStack.Count - 1].FrameClass.ClassName, ACallerForm) *) then
        RunFrame(FormStack[FormStack.Count - 1].FrameClass, FormStack[FormStack.Count - 1].Values,
          FormStack[FormStack.Count - 1].ATitle, FormStack[FormStack.Count - 1].ASubTitle);
  end;
  if FActiveSubFrame = nil then
    SetNavigation(True);
end;

procedure TFormMain.RunFrame(FrameClass: TmwBaseFormClass; Values: array of Variant; ATitle: string = '';
ASubTitle: string = '');
var
  I: Integer;
  NewValues: array of Variant;
  guid: TGuid;
begin
  if FrameClass = nil then
    Exit;
  if (FActiveSubFrame <> nil) and (FrameClass <> nil) and (FActiveSubFrame.ClassName = FrameClass.ClassName) then
    Exit;

  SetLength(NewValues, Length(Values));
  for I := 0 to Length(Values) - 1 do
    NewValues[I] := Values[I];

  if FrameClass <> TmwFormLogin then
    SetNavigation(false)
  else begin
    pnDrawer.SwipeEnabled := false;
    nbMain.ButtonsOptions.NavigationImageName := '';
  end;

  FActiveSubFrame := FrameClass.Create(Self);
  CreateGuid(guid);
  FActiveSubFrame.Name := FrameClass.ClassName + ReplaceStr(Copy(GUIDToString(guid), 2, 36), '-', '');

  if FormStack.Count > 0 then
    FormStack[FormStack.Count - 1].FrameName := FActiveSubFrame.Name;

  if FActiveSubFrame is TmwBaseApiForm then
  begin
    TmwBaseApiForm(FActiveSubFrame).nbForm.Title := mnMain.Items[index].Title;
    TmwBaseApiForm(FActiveSubFrame).nbForm.Subtitle := '';
    TmwBaseApiForm(FActiveSubFrame).SetParams(NewValues);
  end;

  FActiveSubFrame.PositionMode := TfgPositionMode.Relative;
  FActiveSubFrame.Alignment.FlexGrow := 1;
  FActiveSubFrame.FullScreen := false;
  FActiveSubFrame.Parent := pnMain;
  FActiveSubFrame.ShowForm(ATitle, ASubTitle);
end;

procedure TFormMain.SendToken;
begin
  if not FLoggedIn then
    Exit;
  if not FDeviceID.IsEmpty and not FDeviceToken.IsEmpty then
  begin
    TTask.Run(
      procedure
      var
        Api: TmwApi;
      begin
        Api := TmwApi.Clone(_API);
        try
          Api.Login := Settings.Login;
          Api.Password := Settings.Password;
          Api.SaveToken(FDeviceID, FDeviceToken);
        finally
          Api.Free;
        end
      end);
  end;
end;

procedure TFormMain.SetActiveSubFrame(const Value: TmwBaseForm);
begin
  FActiveSubFrame := Value;
end;

procedure TFormMain.SetNavigation(aVisible: Boolean; ATitle, ASubTitle, aNavigationIcon: string);
begin
  nbMain.Visible := aVisible;
  if aVisible then
  begin
    // pnDrawer.Open();
    pnDrawer.SwipeEnabled := True;
    lvMenu.Visible := True;
    nbMain.ButtonsOptions.NavigationImageName := aNavigationIcon;
  end
  else
  begin
    pnDrawer.Close();
    lvMenu.Visible := false;
  end;
  nbMain.Title := ATitle;
  nbMain.Subtitle := ASubTitle;
end;

procedure TFormMain.SetRights(X: ISuperObject);
begin
  FRights.LoadFromJSON(X);
end;

procedure TFormMain.ShowMenu;
begin
  tmGPSInterval.Enabled := CheckGPS;
  AddMenuItems;
  if not VarIsNull(FStartObjectType) then
  begin
    if FStartObjectType = -10 then
      GotoRequest(FStartObjectId);
    FStartObjectType := Null;
    FStartObjectId := Null;
  end;
end;

procedure TFormMain.ShowNotification(ANotification: TfgPushNotification);
var
  FTitle, FText: string;
  xJS: ISuperObject;
begin
  xJS := SO(ANotification.Json.ToString);
  if xJS.Contains('aps') then
  begin
    FText := xJS.O['aps'].O['alert'].S['body'];
    FTitle := xJS.O['aps'].O['alert'].S['title'];
  end
  else
  begin
    FText := xJS.S['gcm.notification.body'];
    FTitle := xJS.S['gcm.notification.title'];
  end;
  if (FTitle.IsEmpty) and (FText.IsEmpty) then
    Exit;
  ShowNotification(FTitle, FText);
end;

procedure TFormMain.ShowNotification(ATitle, AText: string);
begin
  TfgToastFactory.Show(ATitle + sLineBreak + AText, TfgToastDuration.Long);
end;

procedure TFormMain.ConfirmClose;
begin
  TfgDialogs.MessageDialog('Выйти из программы?', [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
        CloseProgram;
    end);
end;

procedure TFormMain.ShowSubFrame(index: Integer);
var
  FrameClass: TmwBaseApiFormClass;
  Values: array of Variant;
begin
  pnDrawer.Close(True);
  lvMenu.Visible := false;
  FrameClass := nil;
  Values := [];
  case index of
    0:
      FrameClass := TmwBidList;
    1:
      FrameClass := TmwFormStreets;
    2:
      FrameClass := TmwFormPromotions;
    3:
      FrameClass := TmwFormContacts;
    4:
      FrameClass := TmwFormBookMarks;
    5:
      FrameClass := TmwFormMap;
    10:
      ConfirmClose;
  else
    Exit;
  end;

  if Assigned(FActiveSubFrame) and Assigned(FrameClass) and SameText(FActiveSubFrame.ClassName, FrameClass.ClassName)
  then
    Exit;

  ClearFrameStack;
  if Assigned(FrameClass) then
  begin
    nbMain.Visible := false;
    AddToStack(FrameClass, '', Values, mnMain.Items[index].Title, '');
    RunFrame(FrameClass, Values, mnMain.Items[index].Title, '');
  end;
end;

procedure TFormMain.StartWork;
{$IFDEF ANDROID}
const
  AccessCoarseLocationPermission = 'android.permission.ACCESS_COARSE_LOCATION';
  FineLocationPermission = 'android.permission.ACCESS_FINE_LOCATION';
{$ENDIF}
begin
  FLoggedIn := True;
  RegisterPushService;
  SendToken;

  if Assigned(FActiveSubFrame) then
    RemoveCurrentFrame(FActiveSubFrame.ClassName, FActiveSubFrame.Name);

  if (Settings.gpsInterval > 0) then
  begin
{$IFDEF ANDROID}
    TfgPermissionService.RequestPermissionsAsync([AccessCoarseLocationPermission, FineLocationPermission],
      procedure(const APermissionsInfos: TArray<TfgPermissionInfo>)
      var
        PermissionInfo: TfgPermissionInfo;
        granted: Boolean;
      begin
        granted := True;
        for PermissionInfo in APermissionsInfos do
          if PermissionInfo.CheckResult = TPermissionCheckResult.Denied then
            granted := false;
        if granted then
          ShowMenu
        else
        begin
          TfgToastFactory.Show
            ('Необходимо разрешение на использование местоположения. Работа приложения может быть нарушена.');
          ShowMenu;
        end;
      end);
{$ENDIF}
{$IFDEF IOS}
    TCLLocationManager.Create.requestWhenInUseAuthorization;
    ShowMenu;
{$ENDIF}
  end
  else
    ShowMenu;
end;

procedure TFormMain.tmGPSIntervalTimer(Sender: TObject);
begin
  if (CheckGPS) and (System.DateUtils.MinutesBetween(Now(), FGPSLastTime) >= Settings.gpsInterval) and (not aGps.Active)
  then
    aGps.Active := True;
end;

{ TFrameStackItem }

procedure TFrameStackItem.Assign(Source: TFrameStackItem);
var
  I: Integer;
begin
  Self.FrameClass := Source.FrameClass;
  Self.FrameName := Source.FrameName;
  Self.ATitle := Source.ATitle;
  Self.ASubTitle := Source.ASubTitle;
  SetLength(Values, Length(Source.Values));

  for I := 0 to Length(Source.Values) - 1 do
    Self.Values[I] := Source.Values[I];
end;

end.
