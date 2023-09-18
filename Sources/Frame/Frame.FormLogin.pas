unit Frame.FormLogin;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar, FGX.Button.Types, FGX.Button,
  FGX.CheckBox, FGX.Edit,
  UVKCommonAPI, Base.BaseForm;

type
  TmwFormLogin = class(TmwBaseForm)
    lbCompany: TfgLabel;
    edCompany: TfgEdit;
    lbUserAcc: TfgLabel;
    edUserAcc: TfgEdit;
    lbUserPass: TfgLabel;
    edUserPass: TfgEdit;
    chbAutoenter: TfgCheckBox;
    bnUserAuth: TfgButton;
    procedure bnUserAuthTap(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
  private
    { Private declarations }
    FApiError: TErrRec;
    FNeedCheckValidURL: Boolean;
    procedure DoLogin;
  public
    { Public declarations }
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts,
  XSuperObject,
  ServiceUnit.API, ServiceUnit.Settings, Form.Main;

procedure TmwFormLogin.bnUserAuthTap(Sender: TObject);
begin
  AnimationStart;
  bnUserAuth.Enabled := false;
  TTask.Run(DoLogin);
end;

procedure TmwFormLogin.DoLogin;
var
  API: TmwAPI;
  rightsO: ISuperObject;
begin
  API := TmwAPI.Clone(_API);
  try
    API.Company := edCompany.Text;
    // if FNeedCheckValidURL then
    API.RecheckBaseUrl;
    API.UserAuth(edUserAcc.Text, edUserPass.Text);
    FApiError := API.Err;
    if FApiError.Code <> 0 then
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          AnimationStop;
          bnUserAuth.Enabled := true;
          TfgToastFactory.Show('Неверный логин или пароль', TfgToastDuration.Short);
        end);
      Exit;
    end;
    _API.Company := edCompany.Text;
    _API.Login := edUserAcc.Text;
    _API.Password := edUserPass.Text;
    TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        Settings.Login := edUserAcc.Text;
        Settings.Password := edUserPass.Text;
        Settings.Company := edCompany.Text;
        Settings.autoEnter := chbAutoenter.IsChecked;
        Settings.gpsInterval := API.ResultJson['struct'].AsArray.O[0].i['gps'];
        Settings.validURL := API.BaseURL;
        Settings.validURLDate := API.validURLDate;
        Settings.SaveToFile(Settings.GetFileName);
        rightsO := API.ResultJson['struct'].AsArray.O[0].O['rights'];
        FormMain.SetRights(rightsO);
        FormMain.StartWork;
        AnimationStop;
      end);
  finally
    API.Free;
  end
end;

procedure TmwFormLogin.fgFormCreate(Sender: TObject);
begin
  Settings.LoadFromFile(Settings.GetFileName);
  edUserAcc.Text := Settings.Login;
  edUserPass.Text := Settings.Password;
  edCompany.Text := Settings.Company;
  chbAutoenter.IsChecked := Settings.autoEnter;
  if not Settings.validURL.IsEmpty then
  begin
    FNeedCheckValidURL := not(Settings.validURLDate = Date());
    FNeedCheckValidURL := FNeedCheckValidURL or (Settings.validURLDate >= (Date() + 7));
  end
  else
    FNeedCheckValidURL := true;
  if chbAutoenter.IsChecked then
    bnUserAuthTap(nil);

end;

procedure TmwFormLogin.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
begin;
end;

end.
