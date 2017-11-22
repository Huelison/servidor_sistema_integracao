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
  Vcl.ImgList, rest.JSON, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPrincipal = class(TForm)
    Memo1: TMemo;
    Button2: TButton;
    imgLista: TImageList;
    Panel1: TPanel;
    btnImportarColetas: TBitBtn;
    btnGravarClientes: TBitBtn;
    btnGravarMotVeic: TBitBtn;
    BitBtn2: TBitBtn;
    btnGravarRotas: TBitBtn;
    btnCriarUsuario: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gravarClientes();
    procedure gravarRotas();
    procedure importarColetas();
    procedure gravarCaminhaoUsuario();
    procedure cadastrarUsuario(Email: String; Senha: String);
    procedure btnGravarClientesClick(Sender: TObject);
    procedure btnImportarColetasClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnGravarRotasClick(Sender: TObject);
    procedure btnCriarUsuarioClick(Sender: TObject);
    procedure btnGravarMotVeicClick(Sender: TObject);
    // function InputCombo(const ACaption, APrompt: string; const AList: TStrings): string;
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
  frmPrincipal: TfrmPrincipal;
  BaseURL: string; // caminho do firebase

implementation

{$R *.dfm}

uses uDMPrincipal;

function InputCombo(const ACaption, APrompt: string; const AList: TStrings): string;

  function GetCharSize(Canvas: TCanvas): TPoint;
  var
    i: integer;
    Buffer: array [0 .. 51] of Char;
  begin
    for i := 0 to 25 do
      Buffer[i] := Chr(i + Ord('A'));
    for i := 0 to 25 do
      Buffer[i + 26] := Chr(i + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

var
  Form: TForm;
  Prompt: TLabel;
  Combo: TComboBox;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: integer;
begin
  Result := '';
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := true;
      end;
      Combo := TComboBox.Create(Form);
      with Combo do
      begin
        Parent := Form;
        Style := csDropDownList; // Caso o item possa ser digitado, altere aqui para csDropDowns
        Items.Assign(AList);
        ItemIndex := 0;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
      end;
      ButtonTop := Combo.Top + Combo.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'OK';
        ModalResult := mrOk;
        default := true;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'Cancelar';
        ModalResult := mrCancel;
        Cancel := true;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Combo.Top + Combo.Height + 15, ButtonWidth,
          ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Result := Combo.Text;
      end;
    finally
      Form.Free;
    end;
end;

procedure TfrmPrincipal.btnImportarColetasClick(Sender: TObject);
begin
  importarColetas;
end;

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
begin
  cadastrarUsuario('huelisonkemerich20  01110@hotmail.com', '221123');
  // FComunicacao.CadastraUsuario('AIzaSyA-XNBTD3Q3F4EFD9qFPMdfl1pYkeYZAss', );
end;

procedure TfrmPrincipal.btnCriarUsuarioClick(Sender: TObject);
var
  Email: String;
  Senha: String;
begin
  if (InputQuery('Coleta Leite', 'Informe um email!', Email)) then
  begin
    if (InputQuery('Coleta Leite', 'Informe uma senha!', Senha)) then
    begin
      cadastrarUsuario(Email, Senha);
    end;
  end;
end;

procedure TfrmPrincipal.btnGravarClientesClick(Sender: TObject);
begin
  gravarClientes;
end;

procedure TfrmPrincipal.btnGravarMotVeicClick(Sender: TObject);
begin
  gravarCaminhaoUsuario;
end;

procedure TfrmPrincipal.btnGravarRotasClick(Sender: TObject);
begin
  gravarRotas;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  // na criação do formulário, o objeto TComunicação
  // é criado e recebe por parâmetro a url do projeto
  BaseURL := 'https://teste-92e08.firebaseio.com/';
  if not Assigned(FComunicacao) then
    FComunicacao := TComunicacao.Create(BaseURL);
end;

procedure TfrmPrincipal.gravarClientes;
var
  clientes, cliente_object: TJSONObject;
begin
  clientes := TJSONObject.Create; // a váriavel clientes irá armazenar
  dmPrincipal.qClientes.Close; // a lista de clientes que será gravada
  dmPrincipal.qClientes.open; // no Firebase
  dmPrincipal.qClientes.first;
  while not(dmPrincipal.qClientes.Eof) do
  begin
    // A variável cliente_object irá armazenar os dados de cada cliente,
    //ja no formato JSON
    cliente_object := TJSONObject.Create;
    cliente_object.AddPair('nome', dmPrincipal.qClientesNOME.AsString);
    if not(dmPrincipal.qClientesFONE.IsNull) then
      cliente_object.AddPair('fone', dmPrincipal.qClientesFONE.AsString);
    cliente_object.AddPair('endereco', dmPrincipal.qClientesENDERECO.AsString);
    cliente_object.AddPair('id', dmPrincipal.qClientesID.AsString);

    // Neste momento é criado um par de chave/valor em que a chave é composta por
    // -key + id do cliente
    clientes.AddPair(TJSONPair.Create('-key' + dmPrincipal.qClientesID.AsString,
                      cliente_object));

    dmPrincipal.qClientes.Next;
  end;

  // Com o evento GravaDados é possível salvar a lista no Firebase
  if (FComunicacao.GravaDados('clientes.json', clientes.ToString)) then
    ShowMessage('Sincronização de clientes realizada com sucesso!');
end;

procedure TfrmPrincipal.gravarCaminhaoUsuario;
var
  usuarios, usuario_object, caminhoes, caminhoes_object: TJSONObject;
begin
  usuarios := TJSONObject.Create; // a váriavel clientes irá armazenar
  dmPrincipal.qMotoristas.Close; // a lista de clientes que será gravada
  dmPrincipal.qMotoristas.open; // no Firebase
  dmPrincipal.qMotoristas.first;

  while not(dmPrincipal.qMotoristas.Eof) do
  begin
    if not(dmPrincipal.qMotoristasUID.IsNull) then
    begin
      usuario_object := TJSONObject.Create;
      usuario_object.AddPair('nome', dmPrincipal.qMotoristasNOME.AsString);
      usuario_object.AddPair('email', dmPrincipal.qMotoristasEMAIL.AsString);
      usuario_object.AddPair('uID', dmPrincipal.qMotoristasUID.AsString);
      usuario_object.AddPair('caminhao', dmPrincipal.qMotoristasCAMINHAO.AsString);

      usuarios.AddPair(TJSONPair.Create(dmPrincipal.qMotoristasUID.AsString, usuario_object));
    end;
    dmPrincipal.qMotoristas.Next;
  end;

  // Com o evento GravaDados é possível salvar a lista no Firebase
  if (FComunicacao.GravaDados('usuarios.json', usuarios.ToString)) then
  begin
    caminhoes := TJSONObject.Create; // a váriavel clientes irá armazenar
    dmPrincipal.qCaminhoes.Close; // a lista de clientes que será gravada
    dmPrincipal.qCaminhoes.open; // no Firebase
    dmPrincipal.qCaminhoes.first;

    while not(dmPrincipal.qCaminhoes.Eof) do
    begin
      caminhoes_object := TJSONObject.Create;
      caminhoes_object.AddPair('id', dmPrincipal.qCaminhoesID.AsString);
      caminhoes_object.AddPair('placa', dmPrincipal.qCaminhoesPLACA.AsString);

      caminhoes.AddPair(TJSONPair.Create('-key' + dmPrincipal.qCaminhoesID.AsString,
        caminhoes_object));

      dmPrincipal.qCaminhoes.Next;
    end;

    // Com o evento GravaDados é possível salvar a lista no Firebase
    if (FComunicacao.GravaDados('caminhoes.json', caminhoes.ToString)) then
    begin
      ShowMessage('Sincronização de Motoristas e caminhões realizada com sucesso!');
    end;
  end;

end;

procedure TfrmPrincipal.gravarRotas;
var
  rota, rota_object, rota_cliente, rota_cliente_object: TJSONObject;
  contador: integer;
begin
  rota := TJSONObject.Create;
  dmPrincipal.qRotas.Close;
  dmPrincipal.qRotas.open();
  dmPrincipal.qRotas.first;

  while not(dmPrincipal.qRotas.Eof) do
  begin
    rota_object := TJSONObject.Create;
    rota_object.AddPair('id', dmPrincipal.qRotasID.AsString);
    rota_object.AddPair('nome', dmPrincipal.qRotasDESCRICAO.AsString);
    rota_object.AddPair('caminhao_atual', dmPrincipal.qRotasTRANSPORTADOR.AsString);

    dmPrincipal.qRotasClientes.Close;
    dmPrincipal.qRotasClientes.ParamByName('pRota').Value := dmPrincipal.qRotasID.Value;
    dmPrincipal.qRotasClientes.open();
    contador := 0;
    rota_cliente := TJSONObject.Create;
    while not(dmPrincipal.qRotasClientes.Eof) do
    begin
      rota_cliente_object := TJSONObject.Create;
      contador := contador + 1;
      rota_cliente_object.AddPair('cliente', dmPrincipal.qRotasClientesID.AsString);
      rota_cliente_object.AddPair('ordem', IntToStr(contador));
      rota_cliente.AddPair(TJSONPair.Create('-key' + dmPrincipal.qRotasClientesID.AsString,
        rota_cliente_object));
      dmPrincipal.qRotasClientes.Next
    end;
    rota_object.AddPair(TJSONPair.Create('RotaCliente', rota_cliente));
    rota.AddPair(TJSONPair.Create('-key' + dmPrincipal.qRotasID.AsString, rota_object));
    dmPrincipal.qRotas.Next;
  end;
  if (FComunicacao.GravaDados('rotas.json', rota.ToString)) then
    ShowMessage('Sincronização de rotas realizada com sucesso!');
  Memo1.Text := rota.ToJSON;
end;

procedure TfrmPrincipal.importarColetas;
var
  coletas_object, t: TJSONObject;
  coleta, coletaClientes: TJSONValue;
  i, j: integer;

begin
  Memo1.Lines.add('     .::Importando Coletas::.     ');

  if FComunicacao.ObtemDados('/Coletas.json?orderBy="sincronizado"&equalTo="N"') then
  begin
    ShowMessage('sucesso');
    coletas_object := TJSONObject.ParseJSONValue(FComunicacao.ResponseJson) as TJSONObject;
    Memo1.Lines.add('    .::Conteudo da Resposta::.  ');
    Memo1.Lines.add(coletas_object.ToString());
    for i := 0 to coletas_object.Count - 1 do
    begin
      coleta := coletas_object.Pairs[i].JsonValue;

      Memo1.Lines.add(coleta.GetValue<string>('data'));
      Memo1.Lines.add(coleta.GetValue<string>('rota'));
      Memo1.Lines.add(coleta.GetValue<string>('caminhao'));
      for j := 0 to coleta.GetValue<TJSONArray>('ColetaCliente').Count - 1 do
      begin
        dmPrincipal.fdTransacao.StartTransaction;
        coletaClientes := coleta.GetValue<TJSONArray>('ColetaCliente').Items[j];
        if (coletaClientes.GetValue<string>('quantidade', '') <> '') then
        begin
          if (coletaClientes.GetValue<integer>('quantidade') > 0) then
          begin
            dmPrincipal.qColetas.Close;
            dmPrincipal.qColetas.Active := true;
            dmPrincipal.qColetas.Insert;

            dmPrincipal.qColetasCLIFOR.AsInteger := coletaClientes.GetValue<integer>('cliente');
            dmPrincipal.qColetasPRODUTO.AsInteger := 1;
            dmPrincipal.qColetasDATA.AsDateTime :=
              StrToDate(copy(coleta.GetValue<string>('data'), 0, 2) + '/' +
              copy(coleta.GetValue<string>('data'), 4, 2) + '/20' +
              copy(coleta.GetValue<string>('data'), 7, 2));
            dmPrincipal.qColetasQUANTIDADE.AsFloat := coletaClientes.GetValue<Double>('quantidade');
            dmPrincipal.qColetasALIZAROL.AsString := coletaClientes.GetValue<String>('alizarol');
            dmPrincipal.qColetasHORA.AsDateTime :=
              StrToTime(coletaClientes.GetValue<String>('hora'));
            dmPrincipal.qColetasTEMPERATURA.AsFloat :=
              coletaClientes.GetValue<Double>('temperatura');
            dmPrincipal.qColetasCAMINHAO.AsInteger := coleta.GetValue<integer>('caminhao');
            dmPrincipal.qColetasROTA.AsInteger := coleta.GetValue<integer>('rota');
            dmPrincipal.qColetas.Post;
          end;
          if dmPrincipal.fdTransacao.Active then
            dmPrincipal.fdTransacao.Commit;
        end;
        Memo1.Lines.add(coletaClientes.GetValue<string>('quantidade'));
      end;
      t := TJSONObject.Create;
      t.AddPair('sincronizado', 'S');
      FComunicacao.GravaDados('/Coletas/' + coletas_object.Pairs[i].JsonString.Value + '.json',
        t.ToString);
      Memo1.Lines.add(coleta.GetValue<TJSONArray>('ColetaCliente').Items[0].ToString);
    end;
  end
  else
    ShowMessage('ferro!!!');
end;

function TfrmPrincipal.getComunicacao: TComunicacao;
begin
  Result := FComunicacao;
end;

procedure TfrmPrincipal.setComunicacao(const Value: TComunicacao);
begin
  FComunicacao := Value;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FComunicacao) then
    FComunicacao.DisposeOf;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  List: TStringList;
  vResult: String;
  indice: integer;
begin

  try
    List := TStringList.Create;

    vResult := InputCombo('Selecione o motorista', 'Nome:', List);

    indice := List.IndexOf(vResult);

    ShowMessage(List[indice]);
  finally
    List.Free;
  end;

  // Testando o retorno string

end;

procedure TfrmPrincipal.cadastrarUsuario(Email, Senha: String);
var
  usuario: TJSONObject;
  resposta: string;
begin
  usuario := TJSONObject.Create();
  usuario.AddPair('email', Email);
  usuario.AddPair('password', Senha);
  usuario.AddPair('returnSecureToken', 'true');
  Memo1.Lines.add(usuario.ToString);
  FComunicacao.CadastraUsuario('AIzaSyA-XNBTD3Q3F4EFD9qFPMdfl1pYkeYZAss', usuario.ToString);
  Memo1.Lines.add(FComunicacao.ResponseJson);
  resposta := FComunicacao.ResponseJson;

  if ((TJSONObject.ParseJSONValue(resposta) as TJSONObject).GetValue<string>('localId', '') = '')
  then
  begin
    Memo1.Lines.add('------------------------------');
    Memo1.Lines.add((TJSONObject.ParseJSONValue(resposta) as TJSONObject).Pairs[0].ToString);
    Memo1.Lines.add('------------------------------');
    ShowMessage('Ocorreu um erro ao cadastrar o usuário:' + sLineBreak +
      (TJSONObject.ParseJSONValue(resposta) as TJSONObject).Pairs[0].JsonValue.GetValue<string>
      ('message', 'Erro não identificado'));
  end
  else
  begin
    ShowMessage('Usuário cadastrado com sucesso!');
  end;

end;

end.
