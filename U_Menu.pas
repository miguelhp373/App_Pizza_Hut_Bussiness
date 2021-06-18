unit U_Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

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
    tot: TLabel;
    ListView2: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure generatedClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure ListView2Change(Sender: TObject);
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


implementation

{$R *.fmx}

uses U_Module;

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

procedure TFrMenu.ListView2Change(Sender: TObject);
begin

cod := codProd.Text;    //codigo do produto

with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('DELETE FROM TB_Carrinho WHERE cod = :cod');
        ParamByName('cod').AsInteger := strToInt(cod);

        ExecSQL;

        ConsultaCarrinho;
    end;
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

    with module.CarrinhoOperacoes do
      begin
        close;
        SQL.Clear;

        SQL.Add('SELECT cod_item, SUM(preco_item)as preco_total FROM TB_Carrinho');

        Active:= true;

        Open;

        PrecoTotal := FieldByName('preco_total').AsString;
    end;


    with module.cadastra_pedido do
      begin
        close;
        SQL.Clear;

        SQL.Add('INSERT INTO TB_Pedidos(cod_cliente, cliente_nome, cpf_cliente, valor_total)VALUES(:cod_cliente, :cliente_nome, :cpf_cliente, :valor_total)');

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
   end;

   if tabmenu.ActiveTab = TabItem3 then
    begin
      lb_title.Text := 'Carrinho';
   end;

   if tabmenu.ActiveTab = TabItem4 then
    begin
      lb_title.Text := 'Pagamento';
   end;

end;

procedure TFrMenu.SpeedButton2Click(Sender: TObject);
begin
   tabmenu.Next();
   if tabmenu.ActiveTab = TabItem1 then
    begin
         Salva_Cliente_Tela01;

    end;
   if tabmenu.ActiveTab = TabItem2 then
    begin
      lb_title.Text := 'Selecione os Items';
      ConsultaCardapio;
   end;

   if tabmenu.ActiveTab = TabItem3 then
    begin
      lb_title.Text := 'Carrinho';
      ConsultaCarrinho
   end;

   if tabmenu.ActiveTab = TabItem4 then
    begin
      lb_title.Text := 'Pagamento';
      Salva_Cliente_Tela01;
   end;
end;

procedure TFrMenu.SpeedButton4Click(Sender: TObject);
begin
  tabmenu.Next();
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

        SQL.Add('select count(cod_item)as tot_items from TB_Carrinho,TB_Cardapio where TB_Cardapio.cod  =  TB_Carrinho.cod_item');

        Active:= true;

        Open;

        tot.Text := FieldByName('tot_items').AsString;
    end;
end;

procedure TFrMenu.FormCreate(Sender: TObject);
begin
  BorderIcons := [];
  tot.Text := '';
  generated.Enabled := true;
  senha_cliente.Text := '';
  tabmenu.ActiveTab := TabItem1;
end;


end.
