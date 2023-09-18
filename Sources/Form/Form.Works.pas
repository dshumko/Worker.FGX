unit Form.Works;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.AutocompleteEdit.Types, FGX.CollectionView, FGX.Edit,
  FGX.AutocompleteEdit, FGX.SearchEdit, FGX.StaticLabel, FGX.ActivityIndicator,
  FGX.NavigationBar, FGX.Image, FGX.CardPanel, FGX.Button.Types, FGX.Button,
  ServiceUnit.mwClasses, ServiceUnit.API, XSuperObject;

type
  TmwFormWorks = class(TmwBaseListViewForm)
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    lvAvailable: TfgCollectionView;
    lvAvailable_Styles: TfgCollectionViewStyles;
    lvAvailable_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    fgLayout1: TfgLayout;
    fgLabel1: TfgLabel;
    fgLabel2: TfgLabel;
    fgImage1: TfgImage;
    fgLayout2: TfgLayout;
    lbHeaderPrimary: TfgLabel;
    lvAvailable_Style2: TfgCollectionViewStyle;
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemCount(Sender: TObject): Integer;
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvAvailableBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvAvailableGetItemCount(Sender: TObject): Integer;
    function lvAvailableGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvAvailableTapItem(Sender: TObject; const AIndex: Integer);
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure fgFormShow(Sender: TObject);
    procedure seSearchChanging(Sender: TObject); override;
  private
    FObjectId: Integer;
    FCurrentList: TObjectList<TmwWorkItem>;
    FSelectedList: TObjectList<TmwWorkItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); virtual;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Math,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Animation, FGX.Animation.Types,
  ServiceUnit.Utils, Form.MaterialAddRemove;

{ TmwFormWorks }

procedure TmwFormWorks.lvAvailableBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  if AStyle <> 'Style-Empty' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := '';
  end;
end;

function TmwFormWorks.lvAvailableGetItemCount(Sender: TObject): Integer;
begin
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormWorks.lvAvailableGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormWorks.lvAvailableTapItem(Sender: TObject; const AIndex: Integer);
var
  fAddRemove: TmwMaterialAddRemove;
begin
  inherited;
  if FCurrentList[AIndex].rest.ToSingle = 0 then
    Exit;
  lvAvailable.Opacity := 0.3;
  lvContent.Opacity := 0.3;
  edSearch.Opacity := 0.3;
  fAddRemove := TmwMaterialAddRemove.Create(Application);
  fAddRemove.SetParams(FCurrentList[AIndex].id, FCurrentList[AIndex].name, FCurrentList[AIndex].rest,
    FCurrentList[AIndex].rest.ToSingle, 0, True, FCurrentList[AIndex].int.ToBoolean, false);
  fAddRemove.OnApplyParameters :=
      procedure(const AId: Integer; const ADirection: Boolean; const ACount: Single; const AInt: Boolean)
    var
      item: TmwWorkItem;
      i: Integer;
      rest: Single;
      found: Boolean;
      name: string;
    begin
      lvAvailable.Opacity := 1;
      lvContent.Opacity := 1;
      edSearch.Opacity := 1;
      if ACount > 0 then
      begin
        for i := 0 to FCurrentList.Count - 1 do
        begin
          if FCurrentList[i].id = AId then
          begin
            rest := FCurrentList[i].rest.ToSingle - ACount;
            FCurrentList[i].rest := rest.ToString;
            name := FCurrentList[i].name;
            Break;
          end;
        end;
        found := false;
        for i := 0 to FSelectedList.Count - 1 do
        begin
          if FSelectedList[i].id = AId then
          begin
            rest := FSelectedList[i].rest.ToSingle + ACount;
            FSelectedList[i].rest := rest.ToString;
            found := True;
            Break;
          end;
        end;
        if (not found) and (ACount > 0) then
        begin
          item := TmwWorkItem.Create;
          item.id := AId;
          item.name := name;
          item.rest := RoundTo(ACount, -2).ToString;
          item.int := AInt.ToInteger;
          FSelectedList.Add(item);
        end;
        lvContent.ReloadItems;
        lvAvailable.ReloadItems;
      end;
    end;
  TfgAnimationHelper.ShowModalForm(fAddRemove, [TfgAnimationOption.StartFromCurrent]);
end;

procedure TmwFormWorks.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwWorkItem>.Create(True);
  FSelectedList := TObjectList<TmwWorkItem>.Create(True);
end;

procedure TmwFormWorks.fgFormDestroy(Sender: TObject);
begin
  inherited;
  FCurrentList.Free;
  FSelectedList.Free;
end;

procedure TmwFormWorks.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwFormWorks.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  if AStyle <> 'Style-Empty' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FSelectedList[AIndex].name;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := RoundTo(FSelectedList[AIndex].rest.ToSingle,
      -2).ToString;
  end;
end;

function TmwFormWorks.lvContentGetItemCount(Sender: TObject): Integer;
begin
  if FSelectedList <> nil then
    Result := FSelectedList.Count
  else
    Result := 0;
end;

function TmwFormWorks.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FSelectedList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormWorks.lvContentTapItem(Sender: TObject; const AIndex: Integer);
var
  fAddRemove: TmwMaterialAddRemove;
begin
  inherited;
  lvAvailable.Opacity := 0.3;
  lvContent.Opacity := 0.3;
  edSearch.Opacity := 0.3;
  fAddRemove := TmwMaterialAddRemove.Create(Application);
  fAddRemove.SetParams(FSelectedList[AIndex].id, FSelectedList[AIndex].name, FSelectedList[AIndex].rest,
    FSelectedList[AIndex].rest.ToSingle, 0, false, FSelectedList[AIndex].int.ToBoolean, True);
  fAddRemove.OnApplyParameters :=
      procedure(const AId: Integer; const ADirection: Boolean; const ACount: Single; const AInt: Boolean)
    var
      item: TmwWorkItem;
      i: Integer;
      rest: Single;
      found: Boolean;
      name: string;
    begin
      lvAvailable.Opacity := 1;
      lvContent.Opacity := 1;
      edSearch.Opacity := 1;
      if ACount > 0 then
      begin
        for i := 0 to FSelectedList.Count - 1 do
        begin
          if FSelectedList[i].id = AId then
          begin
            rest := FSelectedList[i].rest.ToSingle - ACount;
            name := FSelectedList[i].name;
            if rest = 0 then
              FSelectedList.Delete(i)
            else
              FSelectedList[i].rest := rest.ToString;
            Break;
          end;
        end;
        found := false;
        for i := 0 to FCurrentList.Count - 1 do
        begin
          if FCurrentList[i].id = AId then
          begin
            rest := FCurrentList[i].rest.ToSingle + ACount;
            FCurrentList[i].rest := rest.ToString;
            found := True;
            Break;
          end;
        end;
        if not found then
        begin
          item := TmwWorkItem.Create;
          item.id := AId;
          item.name := name;
          item.rest := RoundTo(ACount, -2).ToString;
          FCurrentList.Add(item);
        end;
        lvContent.ReloadItems;
        lvAvailable.ReloadItems;
      end;
    end;
  TfgAnimationHelper.ShowModalForm(fAddRemove, [TfgAnimationOption.StartFromCurrent]);
end;

procedure TmwFormWorks.nbFormNavigationIconTap(Sender: TObject);
var
  aIDS, aCounts: string;
  i: Integer;
begin
  aIDS := '';
  aCounts := '';

  for i := 0 to FSelectedList.Count - 1 do
  begin
    aIDS := aIDS + ',' + FSelectedList[i].id.ToString;
    aCounts := aCounts + ',' + FSelectedList[i].rest;
  end;
  aIDS := aIDS.Trim([',']);
  aCounts := aCounts.Trim([',']);
  SaveLocalBidWorks(FObjectId, aIDS, aCounts);
  inherited;
end;

procedure TmwFormWorks.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvAvailable.ReloadItems;
  lvContent.ReloadItems;
end;

procedure TmwFormWorks.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
  begin
    FObjectId := Values[0];
  end;
end;

procedure TmwFormWorks.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetWorks;
end;

procedure TmwFormWorks.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: Integer;
  item, selItem: TmwWorkItem;
  selWorks: TmwLocalBidWorks;
  arrIDs, arrCounts: TArray<string>;
  idx: Integer;
  ol: ISuperArray;
begin
  inherited;
  LoadLocalBidWorks(FObjectId, selWorks);
  if Assigned(selWorks) then
  begin
    arrIDs := selWorks.ids.Split([',']);
    arrCounts := selWorks.counts.Split([',']);
  end;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      item := TmwWorkItem.Create;
      item.LoadFromJSON(x);
      item.rest := '999999';
      idx := TGenericsUtils.AScan(arrIDs, item.id.ToString);
      if idx >= 0 then
      begin
        selItem := TmwWorkItem.Create;
        selItem.id := item.id;
        selItem.name := item.name;
        selItem.rest := arrCounts[idx];
        selItem.int := item.int;
        item.rest := RoundTo(item.rest.ToSingle - selItem.rest.ToSingle, -2).ToString;
        ol.Add(selItem.AsJsonObj);
        FSelectedList.Add(selItem);
      end;
      FCurrentList.Add(item)
    end;
  end;
end;

end.
