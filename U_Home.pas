unit U_Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrHome = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Button1: TButton;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Button2: TButton;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    Button3: TButton;
    Layout5: TLayout;
    Rectangle4: TRectangle;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrHome: TFrHome;

implementation

{$R *.fmx}

uses U_menu;

procedure TFrHome.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFrHome.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TFrMenu,FrMenu);
  FrMenu.Show;
end;

end.
