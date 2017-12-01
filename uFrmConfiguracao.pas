unit uFrmConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Inifiles;

type
  TfrmConfiguracao = class(TForm)
    edtDbName: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure getConfig();
    procedure setConfig();
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.dfm}

procedure TfrmConfiguracao.Button1Click(Sender: TObject);
begin
  setConfig();
end;

procedure TfrmConfiguracao.FormShow(Sender: TObject);
begin
  getConfig();
end;

procedure TfrmConfiguracao.getConfig();
var
  Arq: TIniFile;
begin
  try
    Arq := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\config.ini');
    edtDbName.Text := Arq.ReadString('Configuration', 'dbPath',
      'C:\Users\Huelison\faculdade\TCC\projeto\dados\ADMINISTRADOR.FDB');
  finally
    Arq.Free();
  end;
end;

procedure TfrmConfiguracao.setConfig;
var
  Arq: TIniFile;
begin
  try
    Arq := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\config.ini');
    Arq.WriteString('Configuration', 'dbPath', edtDbName.Text);
    ShowMessage('Configurações Salvas com sucesso!');
  finally
    Arq.Free();
  end;
end;

end.
