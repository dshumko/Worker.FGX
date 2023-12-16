unit Frame.LanPopup;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.SysUtils, System.Classes, FGX.Controls, FGX.Controls.Types, FGX.Layout, FGX.Frames, FGX.Layout.Types,
  FGX.Button.Types, FGX.Button, FGX.Popup;

type
  TFrameLanPopUp = class(TfgFrame)
    btnxPing: TfgButton;
    btnxTest: TfgButton;
    procedure btnxPingTap(Sender: TObject);
    procedure btnxTestTap(Sender: TObject);
  private
    { Private declarations }
    FeqId: Integer;
    FeqType: Integer;
    FPopupOwner: TfgPopup;
  public
    property eqId:Integer write FeqId;
    property eqType:Integer write FeqType;
    property PopupOwner:TfgPopup write FPopupOwner;
  end;


implementation

uses
  System.Threading,
  FGX.Toasts, FGX.Dialogs, FGX.Application,
  ServiceUnit.Settings, ServiceUnit.API, Form.ShowHtml;

{$R *.xfm}
procedure TFrameLanPopUp.btnxPingTap(Sender: TObject);
var
  API: TmwAPI;
begin
  TfgToastFactory.Show('Ping');
  TTask.Run(
    procedure
    var aJson: string;
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        aJson := API.ActionEquipment(FEqId, FeqType, 'ping');
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            TfgDialogs.ShowMessage(API.ResultJson['result'].AsString);
          end);
      finally
        API.Free;
      end
    end);

  TThread.ForceQueue(nil, procedure begin FPopupOwner.Close; end);
end;

procedure TFrameLanPopUp.btnxTestTap(Sender: TObject);
var
  API: TmwAPI;
begin
  TfgToastFactory.Show('Test');
  TTask.Run(
    procedure
    var aJson: string;
    begin
      API := TmwAPI.Clone(_API);
      try
        API.Login := Settings.Login;
        API.Password := Settings.Password;
        aJson := API.ActionEquipment(FEqId, FeqType, 'test', 'html');
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          var
            answer : string;
            fHtml: TfmShowHtml;
          begin
            answer := API.ResultJson['result'].AsString;
            fHtml := TfmShowHtml.Create(Application);
            fHtml.SetParams([answer]);
            fHtml.ShowForm('Тест', '');

            //hf := TfgPopupFactory.CreatePopup(TFrameHtmlPopUp);

            //(hf as TFrameHtmlPopUp).Html
            //(hf as TFrameLanPopUp).PopupOwner := FPopupOwner;
            //hf.ThemeName := Self.ThemeName;
            // hf.DropDown(self);
          end);
      finally
        API.Free;
      end
    end);
  TThread.ForceQueue(nil, procedure begin FPopupOwner.Close; end);
end;

end.
