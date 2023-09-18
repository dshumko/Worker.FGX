unit Base.BaseForm;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, System.SysUtils,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, FGX.NavigationBar.Types, FGX.NavigationBar, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.Button.Types, FGX.Button;

type
  TmwBaseForm = class(TfgForm)
    pnAnimation: TfgLayout;
    pnAnimationCenter: TfgLayout;
    aiWait: TfgActivityIndicator;
    lbAniComment: TfgLabel;
    nbForm: TfgNavigationBar;
    bnBack: TfgButton;
    procedure fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
    procedure fgFormSafeAreaChanged(Sender: TObject; const AScreenInsets: TRectF);
    procedure nbFormNavigationIconTap(Sender: TObject);
  public const
    EXCEPTION_CODE = 1000;
  private
  protected
    FLoading: Boolean;
    procedure SetLoading(const Value: Boolean); virtual;
    procedure ThreadSaveException(E: Exception); virtual;
    procedure ThreadLoadException(E: Exception); virtual;
    procedure DoCloseMe(Me: TmwBaseForm; noShowParent: Boolean = false);
    procedure CloseMe(Me: TmwBaseForm; noShowParent: Boolean = false);
  public
    FReloadProc: TThreadMethod;
    CanCloseWhileException: Boolean;
    ShowAfterLoad: Boolean;

    procedure AnimationStart(comment: string = ''); virtual;
    procedure AnimationStop; virtual;
    procedure AnimationComment(comment: string); virtual;

    procedure ThreadSave; virtual;
    procedure ThreadLoad; virtual;
    procedure AfterLoad; virtual;
    procedure Load; virtual;

    procedure CloseForm;
    procedure ShowForm(ATitle: string = ''; ASubtitle: string = '');
    procedure SetParams(Values: array of Variant); virtual;
    constructor Create(AOwner: TComponent); override;

    property Loading: Boolean read FLoading write SetLoading;
  end;

  TmwBaseFormClass = class of TmwBaseForm;

implementation

{$R *.xfm}

uses
  System.UITypes, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Animation,
  Form.Main;

{ TmwBasicForm }

procedure TmwBaseForm.AfterLoad;
begin
  AnimationStop();
  Loading := false;
  if ShowAfterLoad then
    Show;
end;

procedure TmwBaseForm.AnimationComment(comment: string);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
  begin
    TThread.synchronize(nil,
      procedure
      begin
        lbAniComment.Text := comment;
        lbAniComment.Visible := comment <> '';
      end);
  end
  else
  begin
    lbAniComment.Text := comment;
    lbAniComment.Visible := comment <> '';
  end;
end;

procedure TmwBaseForm.AnimationStart(comment: string);
begin
  pnAnimation.Visible := true;
  aiWait.IsAnimating := true;
  AnimationComment(comment);
end;

procedure TmwBaseForm.AnimationStop;
begin
  pnAnimation.Visible := false;
  aiWait.IsAnimating := false;
end;

procedure TmwBaseForm.CloseForm;
begin
  AnimationStart();
  TTask.Run(
    procedure
    begin
      try
        ThreadSave();
      except
        on E: Exception do
        begin
          ThreadSaveException(E);
        end;
      end;

      if CanCloseWhileException then
      begin
        TThread.synchronize(nil,
          procedure
          begin
            AnimationStop;
            CloseMe(Self);
            if Assigned(FReloadProc) then
              FReloadProc;
          end);
      end;
    end);
end;

procedure TmwBaseForm.CloseMe(Me: TmwBaseForm; noShowParent: Boolean);
begin
  DoCloseMe(Me, noShowParent);
  { Me.Hide;

    TThread.CreateAnonymousThread(procedure
    begin
    Sleep(1000);
    TThread.Synchronize(nil,procedure begin DoCloseMe(Me,noShowParent); end);
    end
    ).Start; }
end;

procedure TmwBaseForm.DoCloseMe(Me: TmwBaseForm; noShowParent: Boolean = false);
var
  hasParentForm: Boolean;
begin
  AnimationStop;
  hasParentForm := HasParent;
  // Close;
  // TfgAnimationHelper.HideModalForm(Me, [TfgAnimationOption.ReleaseOnFinish]);
  // Parent := nil;
  if hasParentForm then
  begin
    if noShowParent then
      FormMain.RemoveCurrentFrame(Self.ClassName, Self.Name, noShowParent)
    else
      FormMain.RemoveCurrentFrame(Self.ClassName, Self.Name)
  end
  else
    Close;
end;

constructor TmwBaseForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DefaultCloseAction := TfgFormCloseAction.Free;
  CanCloseWhileException := true;
  ShowAfterLoad := false;
end;

procedure TmwBaseForm.fgFormKey(Sender: TObject; const AKey: TfgKey; var AHandled: Boolean);
begin
  if (AKey.Code = vkHardwareBack) and (AKey.Action = TfgKeyAction.Up) then
  begin
    AHandled := true;
    if not pnAnimation.Visible then
      CloseForm;
  end;
end;

procedure TmwBaseForm.fgFormSafeAreaChanged(Sender: TObject; const AScreenInsets: TRectF);
const
  DefaultOneTitleHeight = 56;
begin
  nbForm.Height := DefaultOneTitleHeight + AScreenInsets.Top;
  nbForm.Realign;
end;

procedure TmwBaseForm.Load;
begin
  AnimationStart();
  TTask.Run(
    procedure
    begin
      try
        ThreadLoad;
      except
        on E: Exception do
        begin
          ThreadLoadException(E);
        end;
      end;
      TThread.Queue(nil, AfterLoad);
    end);
end;

procedure TmwBaseForm.nbFormNavigationIconTap(Sender: TObject);
begin
  if not pnAnimation.Visible then
    CloseMe(Self);
end;

procedure TmwBaseForm.SetLoading(const Value: Boolean);
begin
  FLoading := Value;
end;

procedure TmwBaseForm.SetParams(Values: array of Variant);
begin

end;

procedure TmwBaseForm.ShowForm(ATitle: string = ''; ASubtitle: string = '');
begin
  Load;
  nbForm.Title := ATitle;
  nbForm.Subtitle := ASubtitle;
  Show;
end;

procedure TmwBaseForm.ThreadLoad;
begin
  TThread.synchronize(nil,
    procedure
    begin
      Loading := true;
    end);
end;

procedure TmwBaseForm.ThreadLoadException(E: Exception);
begin

end;

procedure TmwBaseForm.ThreadSave;
begin

end;

procedure TmwBaseForm.ThreadSaveException(E: Exception);
begin

end;

end.
