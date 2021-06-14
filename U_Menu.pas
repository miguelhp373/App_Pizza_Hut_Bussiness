unit U_Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Edit,
  uFormat;

type
  TFrMenu = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    tabmenu: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Layout3: TLayout;
    Sum01: TButton;
    personCount: TLabel;
    Min01: TButton;
    Layout4: TLayout;
    Label5: TLabel;
    Layout5: TLayout;
    Edit1: TEdit;
    Label2: TLabel;
    Layout6: TLayout;
    Edit2: TEdit;
    Label6: TLabel;
    Layout7: TLayout;
    Label3: TLabel;
    Layout8: TLayout;
    Sum02: TButton;
    childCount: TLabel;
    Min02: TButton;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Button6: TButton;
    Layout12: TLayout;
    procedure Edit2Typing(Sender: TObject);
    procedure Sum01Click(Sender: TObject);
    procedure Min01Click(Sender: TObject);
    procedure Sum02Click(Sender: TObject);
    procedure Min02Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    personsCount : Integer;
    childsCount  : Integer;
  end;

var
  FrMenu: TFrMenu;

implementation

{$R *.fmx}

procedure TFrMenu.Button6Click(Sender: TObject);
begin
  tabmenu.Next();
end;

procedure TFrMenu.Edit2Typing(Sender: TObject);
begin
  Formatar(Edit2, TFormato.CPF);
end;


procedure TFrMenu.SpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TFrMenu.Sum01Click(Sender: TObject);
begin
  personsCount := personsCount + 1;
  personCount.Text := IntToStr(personsCount);
end;

procedure TFrMenu.FormCreate(Sender: TObject);
begin
  personsCount := 0;
  childsCount  := 0;
end;

procedure TFrMenu.Min01Click(Sender: TObject);
begin
  if(personsCount > 0)then personsCount := personsCount - 1;
  personCount.Text := IntToStr(personsCount);
end;


procedure TFrMenu.Sum02Click(Sender: TObject);
begin
  childsCount := childsCount + 1;
  childCount.Text := IntToStr(childsCount);
end;

procedure TFrMenu.Min02Click(Sender: TObject);
begin
  if(childsCount > 0)then childsCount := childsCount - 1;
  childCount.Text := IntToStr(childsCount);
end;

end.
