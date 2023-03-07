unit UntGerSql0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, UntClassSql0;

type
  TfrmGerSql0 = class(TForm)
    pnlBottom: TPanel;
    pnlBody: TPanel;
    pnlBoddyLeft: TPanel;
    pnlBodyRight: TPanel;
    lblTabelas: TLabel;
    fldTabela: TEdit;
    lblColunas: TLabel;
    mmoCampos: TMemo;
    lblCondicoes: TLabel;
    pnlBodyBody: TPanel;
    mmoCondicoes: TMemo;
    lblComando: TLabel;
    mmoComando: TMemo;
    btnGerarConsulta: TButton;
    btnGerarInsert: TButton;
    btnGerarUpdate: TButton;
    btnGerarDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGerarConsultaClick(Sender: TObject);
    procedure btnGerarInsertClick(Sender: TObject);
    procedure btnGerarUpdateClick(Sender: TObject);
    procedure btnGerarDeleteClick(Sender: TObject);
  private
    function ValidarRequisitosCampos(Operacao: TSQLOperation): Boolean;
    procedure GerarScript(Operacao: TSQLOperation);
  public
    { Public declarations }
  end;

var
  frmGerSql0: TfrmGerSql0;

implementation

{$R *.dfm}

procedure TfrmGerSql0.btnGerarConsultaClick(Sender: TObject);
begin
  GerarScript(soSelect);
end;

procedure TfrmGerSql0.btnGerarDeleteClick(Sender: TObject);
begin
  GerarScript(soDelete);
end;

procedure TfrmGerSql0.btnGerarInsertClick(Sender: TObject);
begin
  GerarScript(soInsert);
end;

procedure TfrmGerSql0.btnGerarUpdateClick(Sender: TObject);
begin
  GerarScript(soUpdate);
end;

procedure TfrmGerSql0.FormCreate(Sender: TObject);
begin
  frmGerSql0.Caption := 'Gerador de SQL';
end;

procedure TfrmGerSql0.GerarScript(Operacao: TSQLOperation);
var
  SQLBuilder: TSQLBuilder;
begin
  if ValidarRequisitosCampos(Operacao) then begin
    try
      SQLBuilder := TSQLBuilder.Create(Trim(fldTabela.Text));
      SQLBuilder.Campos.Assign(mmoCampos.Lines);
      SQLBuilder.Condicoes.Assign(mmoCondicoes.Lines);
      mmoComando.Lines.Assign(SQLBuilder.GerarSQL(Operacao));
    finally
      SQLBuilder.Free;
    end;
  end;
end;

function TfrmGerSql0.ValidarRequisitosCampos(Operacao: TSQLOperation): Boolean;
var
  bResult: Boolean;
begin
  bResult := Trim(fldTabela.Text) <> '';

  if Operacao in [soInsert, soUpdate] then
    bResult := bResult and (mmoCampos.Lines.Count > 0);

  if Operacao in [soUpdate, soDelete] then
    bResult := bResult and (mmoCondicoes.Lines.Count > 0);

  if not bResult then
    raise Exception.Create('Existem informações faltando para gerar o SQL!');

  Result := bResult;
end;

end.

