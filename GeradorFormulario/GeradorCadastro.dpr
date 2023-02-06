program GeradorCadastro;

uses
  Vcl.Forms,
  UntCds0 in 'src\frm\cds\UntCds0.pas' {frmCdsCad0},
  untNavigator in 'src\obj\dbNav\untNavigator.pas',
  UntClassForm0 in 'src\obj\form\UntClassForm0.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCdsCad0, frmCdsCad0);
  Application.Run;
end.
