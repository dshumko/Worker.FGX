unit Form.ShowHtml;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseForm, FGX.NavigationBar.Types,
  FGX.Button.Types, FGX.Button, FGX.StaticLabel, FGX.ActivityIndicator,
  FGX.NavigationBar, FGX.WebBrowser;

type
  TfmShowHtml = class(TmwBaseForm)
    fgwbBrowser: TfgWebBrowser;
    fgLayout2: TfgLayout;
    bnClose: TfgButton;
    procedure bnCloseTap(Sender: TObject);
  private
    FHtmlText: String;
    procedure ShowHtml;
  public
    procedure AfterLoad; override;
    procedure SetParams(Values: array of Variant); virtual;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

procedure TfmShowHtml.bnCloseTap(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmShowHtml.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
  begin
    FHtmlText := Values[0];
  end;
end;

procedure TfmShowHtml.AfterLoad;
begin
  inherited;
  ShowHtml;
end;

procedure TfmShowHtml.ShowHtml;
begin
  if not FHtmlText.IsEmpty then
  begin
    fgwbBrowser.LoadHTML(FHtmlText, 'http://127.0.0.1');
  end
end;

end.
