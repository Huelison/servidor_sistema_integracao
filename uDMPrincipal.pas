unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  Data.DB, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmPrincipal = class(TDataModule)
    fdConexao: TFDConnection;
    fdTransacao: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qClientes: TFDQuery;
    qClientesID: TIntegerField;
    qClientesNOME: TStringField;
    qClientesFONE: TStringField;
    qClientesENDERECO: TStringField;
    qRotas: TFDQuery;
    qRotasID: TIntegerField;
    qRotasDESCRICAO: TStringField;
    qRotasTRANSPORTADOR: TStringField;
    qRotasClientes: TFDQuery;
    qRotasClientesID: TIntegerField;
    qColetas: TFDQuery;
    qColetasCLIFOR: TIntegerField;
    qColetasPRODUTO: TIntegerField;
    qColetasDATA: TDateField;
    qColetasTIKET: TIntegerField;
    qColetasQUANTIDADE: TIntegerField;
    qColetasPER_DESCONTO: TCurrencyField;
    qColetasALIZAROL: TStringField;
    qColetasHORA: TTimeField;
    qColetasTEMPERATURA: TBCDField;
    qColetasCAMINHAO: TIntegerField;
    qColetasROTA: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
