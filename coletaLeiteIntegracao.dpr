program coletaLeiteIntegracao;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uDMPrincipal in 'uDMPrincipal.pas' {dmPrincipal: TDataModule},
  uCComunicacao in 'uCComunicacao.pas',
  uFrmVinculaFunc in 'uFrmVinculaFunc.pas' {frmVinculaFunc},
  uFrmConfiguracao in 'uFrmConfiguracao.pas' {frmConfiguracao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmVinculaFunc, frmVinculaFunc);
  Application.CreateForm(TfrmConfiguracao, frmConfiguracao);
  Application.Run;

end.
