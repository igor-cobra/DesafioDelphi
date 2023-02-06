unit UntClassForm0;

interface

uses
  Datasnap.DBClient, Vcl.Forms, System.Classes, System.SysUtils,
  System.Generics.Collections, Vcl.StdCtrls, Vcl.Controls, System.IOUtils,
  Vcl.ExtCtrls;

type
  TFormDinamico = class
  private
    FClientDataSet: TClientDataSet;
    FForm: TForm;
    FComponents: TList<TComponent>;
    FButtonSave: TButton;
    FComboSave: TComboBox;
    FCurrentTop, FCurrentLeft: Integer;
    procedure CreateComponents;
    procedure SalvarDados(Sender: TObject);
  public
    constructor Create(AClientDataSet: TClientDataSet);
    destructor Destroy; override;
    procedure ShowForm;
  end;

implementation

{ TFormDinamico }

constructor TFormDinamico.Create(AClientDataSet: TClientDataSet);
begin
  inherited Create;
  FClientDataSet := AClientDataSet;
  FForm := TForm.Create(Application);
  FComponents := TList<TComponent>.Create;
end;

procedure TFormDinamico.CreateComponents;
var
  CompClass: TComponentClass;
  Comp: TComponent;
  LabelComp: TLabel;
  lineWidth: Integer;
  Items: TArray<String>;
begin
  FCurrentTop := 0;
  FCurrentLeft := 0;
  with FClientDataSet do begin
    First;
    while not Eof do begin
      LabelComp := TLabel.Create(FForm);
      FComponents.Add(LabelComp);
      LabelComp.Parent := FForm;
      LabelComp.Left := 0 + 1;
      LabelComp.Top := FCurrentTop + 1;
      LabelComp.Caption := FieldByName('LABELCAPTION').AsString;
      LabelComp.Visible := True;

      CompClass := TComponentClass(FindClass(FieldByName('TIPOCOMPONENTE').AsString));
      Comp := CompClass.Create(FForm);
      FComponents.Add(Comp);
      if Comp is TEdit then begin
        TEdit(Comp).Parent := FForm;
        TEdit(Comp).Left := LabelComp.Width + 2;
        TEdit(Comp).Top := FCurrentTop + 1;
        TEdit(Comp).Width := FieldByName('LARGURACOMPONENTE').AsInteger;
        TEdit(Comp).Height := FieldByName('ALTURACOMPONENTE').AsInteger;
        TEdit(Comp).Visible := True;

        FCurrentTop := TEdit(Comp).Top + TEdit(Comp).Height + 10;
        lineWidth :=  LabelComp.Width + TEdit(Comp).Width + 3;
      end else if Comp is TComboBox then begin
        TComboBox(Comp).Parent := FForm;
        TComboBox(Comp).Left := LabelComp.Width + 2;
        TComboBox(Comp).Top := FCurrentTop + 1;
        TComboBox(Comp).Width := FieldByName('LARGURACOMPONENTE').AsInteger;
        TComboBox(Comp).Height := FieldByName('ALTURACOMPONENTE').AsInteger;
        TComboBox(Comp).Visible := True;
        TComboBox(Comp).Items.Delimiter := ';';
        TComboBox(Comp).Items.DelimitedText := FieldByName('ITENS').AsString;
        TComboBox(Comp).ItemIndex := 0;

        FCurrentTop := TComboBox(Comp).Top + TComboBox(Comp).Height + 10;
        lineWidth :=  LabelComp.Width + TComboBox(Comp).Width + 3;
      end else if Comp is TRadioGroup then begin
        TRadioGroup(Comp).Parent := FForm;
        TRadioGroup(Comp).Left := LabelComp.Width + 2;
        TRadioGroup(Comp).Top := FCurrentTop + 1;
        TRadioGroup(Comp).Width := FieldByName('LARGURACOMPONENTE').AsInteger;
        TRadioGroup(Comp).Height := FieldByName('ALTURACOMPONENTE').AsInteger;
        TRadioGroup(Comp).Visible := True;
        TRadioGroup(Comp).Items.Delimiter := ';';
        TRadioGroup(Comp).Items.DelimitedText := FieldByName('ITENS').AsString;
        TRadioGroup(Comp).ItemIndex := 0;

        FCurrentTop := TRadioGroup(Comp).Top + TRadioGroup(Comp).Height + 10;
        lineWidth :=  LabelComp.Width + TRadioGroup(Comp).Width + 3;
      end;


      if lineWidth > fCurrentLeft then
        FCurrentLeft := lineWidth;
      Next;
    end;
  end;
end;

destructor TFormDinamico.Destroy;
begin
  FComponents.Free;
  FForm.Free;
  inherited;
end;

procedure TFormDinamico.SalvarDados(Sender: TObject);
var
  Data: TStringList;
  Comp: TComponent;
begin
  Data := TStringList.Create;
  try
    for Comp in FComponents do begin
      if Comp is TComboBox then
        Data.Add(TComboBox(Comp).Items.Text)
      else if Comp is TRadioGroup then
        Data.Add(TRadioGroup(Comp).Items.Text)
      else if Comp is TEdit then
        Data.Add(TEdit(Comp).Text);
    end;
    TFile.WriteAllText(ExtractFilePath(Application.ExeName) + 'Prova.txt', Data.Text);
  finally
    Data.Free;
  end;
end;

procedure TFormDinamico.ShowForm;
begin
  CreateComponents;

  FButtonSave := TButton.Create(FForm);
  FComponents.Add(FButtonSave);
  FButtonSave.Parent := FForm;
  FButtonSave.Left := 10;
  FButtonSave.Top := FCurrentTop + 10;
  FButtonSave.Width := 100;
  FButtonSave.Height := 30;
  FButtonSave.Caption := 'Salvar';
  FButtonSave.OnClick := SalvarDados;
  FButtonSave.Visible := True;

  FForm.Width := FCurrentLeft + 50;
  FForm.Height := FCurrentTop + 50;
  FForm.Caption := 'Formulário Dinâmico';
  FForm.ShowModal;
end;

end.

