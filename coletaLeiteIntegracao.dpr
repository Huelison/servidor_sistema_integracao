program coletaLeiteIntegracao;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {Form3},
  uDMPrincipal in 'uDMPrincipal.pas' {dmPrincipal: TDataModule},
  uCComunicacao in 'uCComunicacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
