program GeradorSql;

uses
  Vcl.Forms,
  UntGerSql0 in 'src\frm\Sql\UntGerSql0.pas' {Form1},
  UntClassSql0 in 'src\obj\Sql\UntClassSql0.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGerSql0, frmGerSql0);
  Application.Run;
end.
