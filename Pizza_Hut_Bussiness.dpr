program Pizza_Hut_Bussiness;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Splash in 'U_Splash.pas' {FrSplash},
  U_Menu in 'U_Menu.pas' {FrMenu},
  uFormat in 'uFormat.pas',
  U_Home in 'U_Home.pas' {FrHome};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrSplash, FrSplash);
  Application.CreateForm(TFrHome, FrHome);
  Application.Run;
end.
