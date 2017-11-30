unit uFrmVinculaFunc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmVinculaFunc = class(TForm)
    dbComboUsuario: TDBLookupComboBox;
    edtId: TDBEdit;
    edtNome: TDBEdit;
    DBGrid1: TDBGrid;
    btnSalvar: TButton;
    btnCancelar: TButton;
    cdsDataSet: TClientDataSet;
    cdsDataSetemail: TStringField;
    cdsDataSetuid: TStringField;
    dsMotorista: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dsUsuario: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dsMotoristaStateChange(Sender: TObject);
    procedure dbComboUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVinculaFunc: TfrmVinculaFunc;

implementation

{$R *.dfm}

uses uDMPrincipal;

procedure TfrmVinculaFunc.btnCancelarClick(Sender: TObject);
begin
  dmPrincipal.qMotoristas.Cancel;
  if dmPrincipal.fdTransacao.Active then
    dmPrincipal.fdTransacao.Rollback;
  dmPrincipal.qMotoristas.Close;
  dmPrincipal.qMotoristas.Open;
  dmPrincipal.qMotoristas.FetchAll;
end;

procedure TfrmVinculaFunc.btnSalvarClick(Sender: TObject);
begin
  dmPrincipal.qMotoristasEMAIL.AsString := cdsDataSetemail.AsString;
  dmPrincipal.qMotoristas.Post;
  if dmPrincipal.fdTransacao.Active then
    dmPrincipal.fdTransacao.Commit;
  dmPrincipal.qMotoristas.Close;
  dmPrincipal.qMotoristas.Open;
  dmPrincipal.qMotoristas.FetchAll;

end;

procedure TfrmVinculaFunc.dbComboUsuarioClick(Sender: TObject);
begin
  dmPrincipal.qMotoristasEMAIL.AsString := cdsDataSetemail.AsString;
end;

procedure TfrmVinculaFunc.dsMotoristaStateChange(Sender: TObject);
begin
  btnSalvar.Enabled := dmPrincipal.qMotoristas.State in [dsEdit];
  btnCancelar.Enabled := dmPrincipal.qMotoristas.State in [dsEdit];
end;

procedure TfrmVinculaFunc.FormShow(Sender: TObject);
begin
  dmPrincipal.qMotoristas.Close;
  dmPrincipal.qMotoristas.Open;
  dmPrincipal.qMotoristas.FetchAll;

end;

end.
