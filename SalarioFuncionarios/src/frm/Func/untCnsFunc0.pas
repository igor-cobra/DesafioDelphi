unit untCnsFunc0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Datasnap.DBClient,
  untClassFunc0;

type
  TFrmCnsFunc0 = class(TForm)
    pnlBottom: TPanel;
    dbgFuncionario: TDBGrid;
    cdsFuncionario: TClientDataSet;
    cdsFuncionarioID_FUNCIONARIO: TIntegerField;
    cdsFuncionarioNM_FUNCIONARIO: TStringField;
    cdsFuncionarioVL_SALARIO: TFloatField;
    dsFuncionario: TDataSource;
    rgFiltrarFunc: TRadioGroup;
    lblIdFuncionario: TLabel;
    fldListaFuncionario: TEdit;
    lblExemplo: TLabel;
    rgTipoCalculo: TRadioGroup;
    fldResultado: TEdit;
    btnCalcular: TButton;
    lblResultado: TLabel;
    procedure dbgFuncionarioDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rgFiltrarFuncClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCalcularClick(Sender: TObject);
  private
    Funcionario: TFuncionario;
    function ValidarListaFuncionario: Boolean;
    function ValidarIdsInformados: Boolean;
  public
    { Public declarations }
  end;

var
  FrmCnsFunc0: TFrmCnsFunc0;

const
  RG_NAO = 0;
  RG_SIM = 1;
  RG_SOMAR = 0;
  RG_MEDIA = 1;

implementation

{$R *.dfm}

procedure TFrmCnsFunc0.btnCalcularClick(Sender: TObject);
var
  Ids: TArray<Integer>;
  nValor: Real;
begin
 if not ValidarListaFuncionario then
    Exit;
  if rgFiltrarFunc.ItemIndex = RG_NAO then begin
    Ids := Funcionario.GetTodosIds;
  end else begin
    if not ValidarIdsInformados then
      Exit;
    Ids := Funcionario.GetIds(fldListaFuncionario.Text);
  end;

  if rgTipoCalculo.ItemIndex = RG_SOMAR then
      nValor := Funcionario.GetSalarioTotal(Ids)
    else
      nValor := Funcionario.GetMediaSalario(Ids);

  fldResultado.Text := FormatFloat('#,###0.00', nValor);
end;

procedure TFrmCnsFunc0.dbgFuncionarioDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color := clGradientInactiveCaption
  else
    TDBGrid(Sender).Canvas.Brush.Color := clWindow;
end;

procedure TFrmCnsFunc0.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Funcionario.Free;
end;

procedure TFrmCnsFunc0.FormCreate(Sender: TObject);
begin
  FrmCnsFunc0.Caption := 'Funcionários';
  Funcionario := TFuncionario.Create(cdsFuncionario);
end;

procedure TFrmCnsFunc0.rgFiltrarFuncClick(Sender: TObject);
begin
  fldListaFuncionario.Enabled := rgFiltrarFunc.ItemIndex = RG_SIM;
end;

function TFrmCnsFunc0.ValidarIdsInformados: Boolean;
var
  Ids: TArray<Integer>;
  sIds: TArray<string>;
  sLista: string;
  iCont: Integer;
  Id: Integer;
begin
  Result := True;
  if rgFiltrarFunc.ItemIndex = RG_SIM then begin
    if Trim(fldListaFuncionario.Text) = '' then begin
      ShowMessage('Deve ser informado pelo menos um funcionário.');
    end;


    Ids := [];
    sLista := fldListaFuncionario.Text;
    sIds := sLista.Split([';']);
    for iCont := 0 to High(sIds) do begin
      if not TryStrToInt(sIds[iCont], Id) then begin
        ShowMessage('Um ou mais IDs informados são inválidos.');
        Result := False;
        Exit;
      end;

      if not Funcionario.ExisteId(Id) then begin
        ShowMessage(Format('O ID %d não foi encontrado.', [Id]));
        Result := False;
        Exit;
      end;
      Ids := Ids + [Id];
    end;
  end;
end;

function TFrmCnsFunc0.ValidarListaFuncionario: Boolean;
var
  iCont: Integer;
begin
  Result := True;
  for iCont := 1 to Length(fldListaFuncionario.Text) do begin
    if not CharInSet(fldListaFuncionario.Text[iCont], ['0'..'9', ';']) then begin
      ShowMessage('O campo de IDs possui caracteres inválidos.');
      Result := False;
      Exit;
    end;
  end;
end;

end.

