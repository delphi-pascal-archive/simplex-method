program SimplexM;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}
{$R WindowsXP.res}
begin
  Application.Initialize;
  Application.Title := 'SimplexM';
  Application.HelpFile := 'C:\Documents and Settings\Администратор\Рабочий стол\КУРСОВИК_МАТ\Demo\SIMPLEXHELP.HLP';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
