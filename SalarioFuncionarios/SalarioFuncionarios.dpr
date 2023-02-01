program SalarioFuncionarios;

uses
  Vcl.Forms,
  untCnsFunc0 in 'src\frm\Func\untCnsFunc0.pas' {FrmCnsFunc0},
  untClassFunc0 in 'src\obj\Func\untClassFunc0.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCnsFunc0, frmCnsFunc0);
  Application.Run;
end.

