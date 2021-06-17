unit U_Cardapio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.ImageList,
  FMX.ImgList, FMX.TabControl, FMX.ListBox, FMX.Edit;

type
  TFrCardapio = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    titlePage: TLabel;
    btnrighttop: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    Rectangle2: TRectangle;
    Button1: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Layout2: TLayout;
    Layout10: TLayout;
    Label5: TLabel;
    Layout11: TLayout;
    ppreco: TEdit;
    Layout3: TLayout;
    Label2: TLabel;
    Layout4: TLayout;
    nprod: TEdit;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    Label4: TLabel;
    Layout7: TLayout;
    dprod: TEdit;
    Layout8: TLayout;
    ComboBox1: TComboBox;
    Layout9: TLayout;
    Layout12: TLayout;
    Rectangle3: TRectangle;
    SpeedButton3: TSpeedButton;
    codpro: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnrighttopClick(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Consulta_Cardapio_ListView;
    procedure LimpaTudo;
    procedure ConsultaPreco;
    procedure GridProdutos;
  end;

var
  FrCardapio : TFrCardapio;

  cod        : integer;
  titulo     : string;
  subtitulo  : string;
  preco      : string;
  imageindex : string;

implementation

{$R *.fmx}

uses U_Module, U_NovoProduto;

procedure TFrCardapio.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TFNovoProduto,FNovoProduto);
  FNovoProduto.Show;
end;

procedure TFrCardapio.ConsultaPreco;
begin
    with module.ConsultaPreco do
      begin
          close;
          SQL.Clear;
          sql.Add('SELECT preco FROM TB_Cardapio WHERE cod = :cod ');
          ParamByName('cod').AsInteger := cod;
          Active:= true;

          Open;

          preco := floattostr(FieldByName('preco').AsFloat);
      end;
end;

procedure TFrCardapio.Consulta_Cardapio_ListView;
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

procedure TFrCardapio.FormCreate(Sender: TObject);
begin
  BorderIcons := [];
  Active:= false;
  TabControl1.ActiveTab := TabItem1;
  Consulta_Cardapio_ListView; // executa ao abrir a tela a consulta
end;

procedure TFrCardapio.GridProdutos;
begin
      titlePage.Text := 'Cardápio';
      btnrighttop.stylelookup :=  'refreshtoolbutton';
end;

procedure TFrCardapio.LimpaTudo;
begin
   nprod.Text := '';
   dprod.Text := '';
   ComboBox1.ItemIndex := 0;
end;

procedure TFrCardapio.ListView1Change(Sender: TObject);
var
  GetIndex : integer;
begin

  GetIndex := 0;
  GetIndex := ListView1.ItemIndex;

        titulo       := ListView1.Items[GetIndex].Text ;
        subtitulo    := ListView1.items[GetIndex].Detail;
        imageindex   := inttostr(ListView1.Items[GetIndex].ImageIndex);


    TabControl1.Next();

    LimpaTudo;

    titlePage.Text := 'Alteração';
    btnrighttop.stylelookup :=  'trashtoolbutton';

    cod := strtoint(codpro.Text);
    ConsultaPreco;

    nprod.Text := titulo;
    dprod.Text := subtitulo;

    ppreco.Text := preco;
    ComboBox1.ItemIndex := strtoint(imageindex);
end;

procedure TFrCardapio.SpeedButton1Click(Sender: TObject);
begin

  if TabControl1.ActiveTab <> TabItem1 then  TabControl1.Previous()
  else                                       close;

  if TabControl1.ActiveTab = TabItem1 then
    begin
      Consulta_Cardapio_ListView;//atualiza listview
      GridProdutos;
    end;
  
end;

procedure TFrCardapio.SpeedButton3Click(Sender: TObject);
begin
       with module.AtualizaProduto do
              begin
                Close;
                SQL.Clear;

                SQL.Add('UPDATE TB_Cardapio');
                SQL.Add('SET titulo = :Titulo_Prod,');
                SQL.Add('descricao = :Descricao_Prod,');
                SQL.Add('preco = :Preco_prod,');
                SQL.Add('cod_imagem = :Imagem_cod');
                Sql.Add('WHERE cod = :cod');

                ParambyName('cod').AsInteger := strtoint(codpro.Text);
                ParamByName('Titulo_Prod').AsString := nprod.Text ;
                ParamByName('Descricao_Prod').AsString := dprod.Text;
                ParamByName('Preco_prod').AsFloat :=  Strtofloat(ppreco.Text);
                ParamByName('Imagem_cod').AsInteger := strtoint(ComboBox1.Selected.Text);

                ExecSQL;
              end;

              TabControl1.Previous();
              GridProdutos;
              Consulta_Cardapio_ListView;//atualiza listview
end;

procedure TFrCardapio.btnrighttopClick(Sender: TObject);
begin
  if TabControl1.ActiveTab = TabItem1 then
    begin
      Consulta_Cardapio_ListView;//atualiza listview
    end
  else  if TabControl1.ActiveTab = TabItem2 then
    begin
        with module.DeletaItem do
          begin
            Close;
            SQL.Clear;

            SQL.Add('DELETE FROM TB_Cardapio WHERE cod = :cod');
            ParamByName('cod').AsInteger := cod;

            ExecSQL;
        end;
        TabControl1.Previous();
        GridProdutos;
        Consulta_Cardapio_ListView;//atualiza listview
  end;
end;

end.
