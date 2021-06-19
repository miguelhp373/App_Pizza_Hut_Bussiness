unit U_Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.ImageList, FMX.ImgList;

type
  TFrMenu = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    lb_title: TLabel;
    tabmenu: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Layout4: TLayout;
    Layout5: TLayout;
    nome: TEdit;
    Label2: TLabel;
    Layout6: TLayout;
    cpf: TEdit;
    Label6: TLabel;
    Layout10: TLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    senha_cliente: TLabel;
    Label4: TLabel;
    generated: TButton;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    codProd: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    SpeedButton2: TSpeedButton;
    ListView2: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    Label1: TLabel;
    Layout3: TLayout;
    SpeedButton3: TSpeedButton;
    ImageList1: TImageList;
    SpeedButton4: TSpeedButton;
    Rectangle3: TRectangle;
    Label3: TLabel;
    valtot: TLabel;
    tot: TSpeedButton;
    Button1: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure generatedClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure totClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cpfTyping(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Salva_Cliente_Tela01;
    procedure ConsultaCardapio;
    procedure SalvaProdutosNoCarrinho;
    procedure ConsultaCarrinho;
  end;

var
  FrMenu: TFrMenu;
  vr_nome_cliente  : string;
  vr_cpf_cliente   : string;
  vr_senha_cliente : string;

  cod              : string;
  preco            : string;
  PrecoTotal       : string;
  v_activeEnd      : string;
  v_tipoPaga       : string;


implementation

{$R *.fmx}

uses U_Module, uFormat;

procedure TFrMenu.generatedClick(Sender: TObject);
begin
  Randomize;
  senha_cliente.Text := inttostr(random(10000));
  vr_senha_cliente  := senha_cliente.Text;

  generated.Enabled := false;
end;

procedure TFrMenu.ListView1Change(Sender: TObject);
var
  GetIndex : integer;
begin

  GetIndex := 0;
  GetIndex := ListView1.ItemIndex;

  cod := codProd.Text;    //codigo do produto

  SalvaProdutosNoCarrinho;
end;

procedure TFrMenu.SalvaProdutosNoCarrinho;
begin


    with module.ConsultaPreco do
      begin
          close;
          SQL.Clear;
          sql.Add('SELECT preco FROM TB_Cardapio WHERE cod = :cod ');
          ParamByName('cod').AsInteger := strToInt(cod);
          Active:= true;

          Open;

          preco := floattostr(FieldByName('preco').AsFloat);
      end;

  with module.CarrinhoOperacoes do
    begin
      close;
      SQL.Clear;

      SQL.Add('INSERT INTO TB_Carrinho(cod_item, senha_cliente, preco_item)VALUES(:cod_item, :senha_cliente, :preco_item)');
      ParamByName('cod_item').AsInteger := strtoint(cod);
      ParamByName('senha_cliente').AsInteger := strtoint(vr_senha_cliente);
      ParamByName('preco_item').AsFloat := StrToFloat(preco);

      ExecSQL;
  end;
end;

procedure TFrMenu.Salva_Cliente_Tela01;
begin
    vr_nome_cliente    := nome.Text;
    vr_cpf_cliente     := cpf.Text;




    with module.cadastra_pedido do
      begin
        close;
        SQL.Clear;

        SQL.Add('INSERT INTO TB_Pedidos(cod_cliente, cliente_nome, cpf_cliente, valor_total)VALUES(:cod_cliente, :cliente_nome, :cpf_cliente ,:valor_total)');

        ParamByName('cod_cliente').AsInteger := strtoint(vr_senha_cliente);
        ParamByName('cliente_nome').AsString := vr_nome_cliente;
        ParamByName('cpf_cliente').AsString := vr_cpf_cliente;
        ParamByName('valor_total').AsFloat := strtofloat(PrecoTotal);

        ExecSQL;
    end;


    with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('DELETE FROM TB_Carrinho');

        ExecSQL;
    end;


    FrMenu.Close;

end;

procedure TFrMenu.SpeedButton1Click(Sender: TObject);
begin

  if tabmenu.ActiveTab <> TabItem1 then  tabmenu.Previous()
  else                                   close;

    if tabmenu.ActiveTab = TabItem2 then
    begin
      lb_title.Text := 'Selecione os Items';
      SpeedButton2.Text :=  'Proximo';
      SpeedButton2.Enabled := true;
      tot.Visible := false;
   end;

   if tabmenu.ActiveTab = TabItem3 then
    begin
      lb_title.Text := 'Carrinho';
      SpeedButton2.Text :=  'Proximo';
      SpeedButton2.Enabled := true;
      tot.Visible := false;
   end;

   if tabmenu.ActiveTab = TabItem4 then
    begin
      lb_title.Text := 'Pagamento';
      SpeedButton2.Text :=  'Finalizar';
   end;

end;

procedure TFrMenu.SpeedButton2Click(Sender: TObject);
begin

   if (cpf.Text = '') or (nome.Text = '') or (senha_cliente.Text = '') then
    begin
      ShowMessage('Preencha os Campos Antes de Prosseguir!');
      abort;
   end
   else   tabmenu.Next();

   if tabmenu.ActiveTab = TabItem2 then
    begin
      lb_title.Text := 'Selecione os Items';
      SpeedButton2.Text :=  'Proximo';
      SpeedButton2.Enabled := true;
      ConsultaCardapio;
   end;

   if tabmenu.ActiveTab = TabItem3 then
    begin
      lb_title.Text := 'Carrinho';
      ConsultaCarrinho;
       SpeedButton2.Text :=  'Proximo';
       SpeedButton2.Enabled := true;
       tot.Visible := true;
   end;

   if tabmenu.ActiveTab = TabItem4 then
    begin
      lb_title.Text := 'Pagamento';
      SpeedButton2.Text := 'Finalizar';

      SpeedButton2.Enabled := false;
      Button1.Enabled := true;

      tot.stylelookup :=  'cleareditbutton';
      tot.Text := '';
      tot.Enabled := true;


     with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('SELECT SUM(preco_item)as preco_total,');
        SQL.Add('(SELECT titulo FROM TB_Cardapio)as titulo, (SELECT cod_imagem FROM TB_Cardapio)as cod_imagem');
        SQL.Add('FROM TB_Carrinho');

        Active:= true;

        Open;

        PrecoTotal := FieldByName('preco_total').AsString;
        valtot.Text := 'R$' + PrecoTotal;
     end;


     if v_activeEnd = 'S' then
      begin
         Salva_Cliente_Tela01;
         ShowMessage('Pedido Efetuado com Sucesso!');
         close;
     end;


   end;
end;

procedure TFrMenu.SpeedButton3Click(Sender: TObject);
begin
  SpeedButton4.Enabled := false;
  SpeedButton2.Enabled := true;

  v_tipoPaga := 'cartão';
  v_activeEnd := 'S';
end;

procedure TFrMenu.SpeedButton4Click(Sender: TObject);
begin
   SpeedButton3.Enabled := false;
   SpeedButton2.Enabled := true;
   v_tipoPaga := 'dinheiro';
   v_activeEnd := 'S';
end;

procedure TFrMenu.totClick(Sender: TObject);
begin
  SpeedButton3.Enabled := true;
  SpeedButton4.Enabled := true;
  SpeedButton2.Enabled := false;
  v_activeEnd := 'N';
end;

procedure TFrMenu.Button1Click(Sender: TObject);
begin
  with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('DELETE FROM TB_Carrinho');

        ExecSQL;
    end;
    ConsultaCardapio;
    Button1.Enabled := false;
    tot.Text := '0';
end;

procedure TFrMenu.ConsultaCardapio;
begin
      with module.Q_ConsultaCardapio do
      begin
          close;
          SQL.Clear;
          sql.Add('SELECT cod, titulo, descricao, preco, cod_imagem FROM TB_Cardapio');
          Active:= true;

          Open;
      end;
end;

procedure TFrMenu.ConsultaCarrinho;
begin
      with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('select DISTINCT titulo, cod_imagem,');
        SQL.Add('(SELECT COUNT(cod_item)from TB_Carrinho)as tot');
        SQL.Add('from TB_Cardapio,');
        SQL.Add('TB_Carrinho');
        SQL.Add('where');
        SQL.Add('TB_Cardapio.cod  =  TB_Carrinho.cod_item');

        Active:= true;

        Open;

        tot.Text := FieldByName('tot').AsString;
    end;
end;



procedure TFrMenu.cpfTyping(Sender: TObject);
begin
  Formatar(cpf, TFormato.CPF); //formata o cpf
end;

procedure TFrMenu.FormCreate(Sender: TObject);
begin
  BorderIcons := [];
  tot.Text := '';
  tot.Enabled := false;
  generated.Enabled := true;
  senha_cliente.Text := '';
  v_activeEnd := 'N';
  tabmenu.ActiveTab := TabItem1;
end;


end.
