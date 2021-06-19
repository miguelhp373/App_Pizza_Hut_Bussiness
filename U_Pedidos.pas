unit U_Pedidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.TabControl,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;
type
  TFrPedidos = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    Layout2: TLayout;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Button1: TButton;
    Layout3: TLayout;
    Layout4: TLayout;
    Label2: TLabel;
    Layout5: TLayout;
    cliente: TLabel;
    Layout6: TLayout;
    Label4: TLabel;
    Layout7: TLayout;
    cpf: TLabel;
    Layout10: TLayout;
    Layout11: TLayout;
    Label9: TLabel;
    senha: TLabel;
    total: TLabel;
    LinkListControlToField1: TLinkListControlToField;
    Button2: TButton;
    codigo: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    nome: TLabel;
    cpfcliente: TLabel;
    valortotal: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConsultaPedidos;
  end;

var
  FrPedidos: TFrPedidos;

implementation

{$R *.fmx}

uses U_Module;

procedure TFrPedidos.ConsultaPedidos;
begin
    with module.Consulta_Pedidos do
    begin
      close;
      SQL.Clear;

      SQL.Add('select COD, COD_CLIENTE, CLIENTE_NOME, CPF_CLIENTE, VALOR_TOTAL from tb_pedidos');

      Active := true;

      open;
  end;
end;


procedure TFrPedidos.Button1Click(Sender: TObject);
begin

  with module.Consulta_Pedidos do
           begin
            close;
             SQL.Clear;

              SQL.Add('Delete from tb_pedidos');

              ExecSQL;
        end;

        ShowMessage('Pronto!');
end;

procedure TFrPedidos.Button2Click(Sender: TObject);
var
  CodigoRegistro : string;
begin
  CodigoRegistro := codigo.Text;

    with module.Consulta_Pedidos do
           begin
            close;
             SQL.Clear;

              SQL.Add('Delete from tb_pedidos WHERE COD = :COD');
              ParamByName('COD').AsString := CodigoRegistro;

              ExecSQL;
        end;

        if(TabControl1.ActiveTab  = TabItem2)then
          begin
                CodigoRegistro := '';
                ShowMessage('Pedido Finalizado com Sucesso!');

                ConsultaPedidos;

                TabControl1.Previous();

                 if(module.Consulta_Pedidos.RecordCount <= 0)then
                  begin
                    ShowMessage('Nenhum Registro Encontrado!');
                    abort;
                 end;
        end;


end;



procedure TFrPedidos.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;

  if(TabControl1.ActiveTab = TabItem1)then
    begin
      senha.Visible := false;
  end;

  BorderIcons := [];

  ConsultaPedidos;

  if(module.Consulta_Pedidos.RecordCount <= 0)then
    begin
      ShowMessage('Nenhum Registro Encontrado!');
      abort;
 end;


end;

procedure TFrPedidos.ListView1Change(Sender: TObject);
begin
  if(TabControl1.ActiveTab = TabItem1)then
    begin
      senha.Visible := true;
      cliente.Text := nome.Text;
      cpf.Text :=   cpfcliente.Text;
      total.Text := valortotal.Text;
      TabControl1.Next();
  end;

end;

procedure TFrPedidos.SpeedButton1Click(Sender: TObject);
begin
  if(TabControl1.ActiveTab = TabItem1)then
    begin
       close;
  end
  else
    begin
      senha.Visible := false;
      TabControl1.Previous();
      ConsultaPedidos;
  end;


end;

end.
