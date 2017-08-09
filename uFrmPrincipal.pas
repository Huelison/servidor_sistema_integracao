unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.JSON, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uCComunicacao, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    qClientes: TFDQuery;
    qClientesID: TIntegerField;
    qClientesNOME: TStringField;
    qClientesFONE: TStringField;
    qClientesENDERECO: TStringField;
    Button2: TButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    qRotas: TFDQuery;
    qRotasClientes: TFDQuery;
    qRotasID: TIntegerField;
    qRotasDESCRICAO: TStringField;
    qRotasTRANSPORTADOR: TStringField;
    qRotasClientesID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gravarClientes();
    procedure gravarRotas();
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FComunicacao: TComunicacao;
    function getComunicacao: TComunicacao;
    procedure setComunicacao(const Value: TComunicacao);
    { Private declarations }
  public
    { Public declarations }
    property Comunicacao: TComunicacao read getComunicacao write setComunicacao;
  end;

var
  Form3: TForm3;
  BaseURL: string; // caminho do firebase

implementation

{$R *.dfm}

uses uDMPrincipal;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  gravarRotas;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
  gravarClientes;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  if FComunicacao.ObtemDados('/teste.json') then
  begin
    ShowMessage('sucesso');
    Memo1.Lines.add(FComunicacao.ResponseJson);
  end
  else
    ShowMessage('ferro!!!');
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  BaseURL := 'https://teste-92e08.firebaseio.com/';
  if not Assigned(FComunicacao) then
    FComunicacao := TComunicacao.Create(BaseURL);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  if Assigned(FComunicacao) then
    FComunicacao.DisposeOf;
end;

function TForm3.getComunicacao: TComunicacao;
begin
  Result := FComunicacao;
end;

procedure TForm3.gravarClientes;
var
  clifor, clifor_object: TJSONObject;
  contador: integer;
begin
  // RESTClient1.
  clifor := TJSONObject.Create;
  qClientes.Close;
  qClientes.open;
  qClientes.first;
  contador := 0;
  while not(qClientes.Eof) do
  begin
    clifor_object := TJSONObject.Create;
    clifor_object.AddPair('nome', qClientesNOME.Value);
    if not(qClientesFONE.IsNull) then
      clifor_object.AddPair('fone', qClientesFONE.Value);
    clifor_object.AddPair('endereco', qClientesENDERECO.Value);
    clifor_object.AddPair('id', qClientesID.AsString);
    // FComunicacao.GravaDados('/teste/'+FDQuery1ID.AsString+'.json',clifor_object.tojson);

    clifor.AddPair(TJSONPair.Create('-key' + qClientesID.AsString,
      clifor_object));
    qClientes.Next;
  end;
  if (FComunicacao.GravaDados('clientes.json', clifor.ToString)) then
    ShowMessage('Sincronização de clientes realizada com sucesso!');
  Memo1.Text := clifor.ToJSON;
end;

procedure TForm3.gravarRotas;
var
  rota, rota_object, rota_cliente, rota_cliente_object: TJSONObject;
  contador: integer;
begin
  rota := TJSONObject.Create;
  qRotas.Close;
  qRotas.open();
  qRotas.first;
  contador := 0;

  while not(qRotas.Eof) do
  begin
    rota_object := TJSONObject.Create;
    rota_object.AddPair('id', qRotasID.AsString);
    rota_object.AddPair('nome', qRotasDESCRICAO.AsString);
    rota_object.AddPair('caminhao_atual', qRotasTRANSPORTADOR.AsString);
    qRotasClientes.Close;
    qRotasClientes.ParamByName('pRota').Value := qRotasID.Value;
    qRotasClientes.open();
    contador := 0;
    rota_cliente := TJSONObject.Create;
    while not(qRotasClientes.Eof) do
    begin
      rota_cliente_object := TJSONObject.Create;
      contador := contador + 1;
      rota_cliente_object.AddPair('cliente', qRotasClientesID.AsString);
      rota_cliente_object.AddPair('ordem', IntToStr(contador));
      rota_cliente.AddPair(TJSONPair.Create('-key' + qRotasClientesID.AsString,
        rota_cliente_object));
      qRotasClientes.Next
    end;
    rota_object.AddPair(TJSONPair.Create('RotaCliente', rota_cliente));
    rota.AddPair(TJSONPair.Create('-key' + qRotasID.AsString, rota_object));
    qRotas.Next;
  end;
  if (FComunicacao.GravaDados('rotas.json', rota.ToString)) then
    ShowMessage('Sincronização de rotas realizada com sucesso!');
  Memo1.Text := rota.ToJSON;
  // RESTClient1.
  { clifor := TJSONObject.Create;
    qClientes.Close;
    qClientes.open;
    qClientes.first;
    contador:=0;
    while not(qClientes.Eof) do
    begin
    clifor_object:=TJSONObject.Create;
    clifor_object.AddPair('nome',qClientesNOME.Value);
    if not(qClientesFONE.IsNull) then
    clifor_object.AddPair('fone',qClientesFONE.Value);
    clifor_object.AddPair('endereco',qClientesENDERECO.Value);
    clifor_object.AddPair('id',qClientesID.AsString);
    //FComunicacao.GravaDados('/teste/'+FDQuery1ID.AsString+'.json',clifor_object.tojson);

    clifor.AddPair(TJSONPair.Create(qClientesID.AsString, clifor_object));
    qClientes.Next;
    end;
    FComunicacao.GravaDados('testes.json',clifor.ToString);
    Memo1.Text:=clifor.ToJSON; }
end;

procedure TForm3.setComunicacao(const Value: TComunicacao);
begin
  FComunicacao := Value;
end;

end.
