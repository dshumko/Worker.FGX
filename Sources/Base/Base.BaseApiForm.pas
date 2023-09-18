unit Base.BaseApiForm;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, System.SysUtils,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar,
  UVKCommonApi, ServiceUnit.API, Base.BaseForm, FGX.Button.Types, FGX.Button;

type
  TmwBaseApiForm = class(TmwBaseForm)
  protected
    procedure ThreadSaveException(E: Exception); override;
    procedure ThreadLoadException(E: Exception); override;
    procedure ThreadApiCall(API: TmwAPI); virtual;
    procedure ThreadFillData(API: TmwAPI); virtual;
  public
    FApiError: TErrRec;
    procedure ThreadLoad; override;
  end;

  TmwBaseApiFormClass = class of TmwBaseApiForm;

var
  mwBaseApiForm: TmwBaseApiForm;

implementation

{$R *.xfm}

uses
  FGX.Application, FGX.Dialogs, FGX.Log,
  ServiceUnit.Settings, Form.Main;

{ TBasicApiForm }

procedure TmwBaseApiForm.ThreadApiCall(API: TmwAPI);
begin
  //
end;

procedure TmwBaseApiForm.ThreadFillData(API: TmwAPI);
begin
  //
end;

procedure TmwBaseApiForm.ThreadLoad;
var
  API: TmwAPI;
begin
  inherited;
  API := TmwAPI.Clone(_API);
  API.Login := Settings.Login;
  API.Password := Settings.Password;
  try
    ThreadApiCall(API);
    FApiError := API.Err;
    if FApiError.Code <> 0 then
    begin
      Exit;
    end;
    ThreadFillData(API);
  finally
    API.free;
  end;
end;

procedure TmwBaseApiForm.ThreadLoadException(E: Exception);
begin
  if FApiError.Code = 0 then
  begin
    FApiError.Code := EXCEPTION_CODE;
    FApiError.Msg := E.Message;
  end;
end;

procedure TmwBaseApiForm.ThreadSaveException(E: Exception);
begin
  if FApiError.Code = 0 then
  begin
    FApiError.Code := EXCEPTION_CODE;
    FApiError.Msg := E.Message;
  end;
end;

end.
