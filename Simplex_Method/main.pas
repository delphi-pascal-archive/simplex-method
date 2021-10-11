unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, sSkinManager, Menus, ShellAPI, Registry,
  sHintManager;

type
  TForm1 = class(TForm)
    sg1: TStringGrid;
    Button1: TButton;
    stb: TButton;
    l1: TLabel;
    l2: TLabel;
    sg2: TStringGrid;
    sSkinManager1: TsSkinManager;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Button5: TButton;
    fn: TEdit;
    Memo1: TMemo;
    Button2: TButton;
    Button4: TButton;
    sHintManager1: TsHintManager;
    PopupMenu2: TPopupMenu;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure stbClick(Sender: TObject);
    procedure sg1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure fnKeyPress(Sender: TObject; var Key: Char);
    procedure l1Click(Sender: TObject);
    procedure sg1KeyPress(Sender: TObject; var Key: Char);
    procedure fnClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function SM(num:integer):boolean;
    procedure Mask(num:integer);
    procedure Tsize();
    procedure Sh();
    procedure SaveGrid(Filename:string);
    procedure LoadGrid(Filename:string);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    function fW(s:string):string;
    procedure dg(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; num: integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,ki,kj,num_sg,n,k,l:integer;

implementation

{$R *.dfm}

procedure RegisterAppDocuments();
var
  reg: TRegistry;
begin
  reg := TRegistry.Create();
  reg.RootKey := HKEY_CLASSES_ROOT;
  //Вносим информаци. о нашем типе файлов в реестр
  //..само расширение
  if reg.OpenKey('.spx', True) then
  begin
    reg.WriteString('', 'Simplex.Method');
    reg.CloseKey();
  end;
  //..описание типа файла
  if reg.OpenKey('Simplex.Method', True) then
  begin
    reg.WriteString('', 'Документ Simplex.Method');
    reg.CloseKey();
  end;
  //..значок для файлов MYDOC-типа
  if reg.OpenKey('Simplex.Method\DefaultIcon', True) then
  begin
    reg.WriteString('', Application.ExeName + ', 1');
    reg.CloseKey();
  end;
  //..приложение, открывающее MYDOC-документ
  if reg.OpenKey('Simplex.Method\Shell\Open\Command', True) then
  begin
    reg.WriteString('', Application.ExeName + ' %1');
    reg.CloseKey();
  end;

  reg.Free();
end;

procedure UnregisterAppDocuments();
var
  reg: TRegistry;
begin
  reg := TRegistry.Create();
  reg.RootKey := HKEY_CLASSES_ROOT;
  //Удаление информации о типе файла из реестра
  reg.DeleteKey('.spx');
  reg.DeleteKey('Simplex.Method');
  reg.Free();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
RegisterAppDocuments();
l:=2;
sSkinManager1.SkinDirectory:=PAnsiChar(GetCurrentDir());
sSkinManager1.SkinName:='WMP11';
sSkinManager1.Active:=true;
 ki:=-1;kj:=-1;//цвет ключ. эл-тов
 num_sg:=1;
Mask(1);   DragAcceptFiles(Handle, True);
sh;   
if ParamCount() > 0 then
LoadGrid(ParamStr(1));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.stbClick(Sender: TObject);
begin
//чтоб не висло
n:=0;k:=0;   memo1.Clear;
Application.ProcessMessages;
try
repeat
if n<3 then n:=n+1 else n:=1;
if k<1001 then k:=k+1
else break;
until SM(n);
l2.Caption:=IntToStr(k+1);
Memo1.Lines.Add('Решено!');
except
 Memo1.Lines.Add('Неккоректные данные!');
end;
end;

procedure TForm1.sg1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
dg(Sender, ACol, ARow, Rect,State,1);
end;

function TForm1.SM(num: integer):boolean;
var mn,mnl:real;
    num2,r,m:integer;
begin //симплекс-метод: нахождение ключ-элемента
mn:=0;m:=0;
num2:=1;if num=1 then num2:=2;
num_sg:=num; mask(num);mask(2);Mask(1);
//ключ-столбец
for i:=3 to (FindComponent(Format('sg%d',[num])) as TStringGrid).ColCount-1 do
if StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).
Cells[i,(FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-1])<mn then
begin
mn:=StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).
Cells[i,(FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-1]);
ki:=i;
end;
//**
memo1.Lines.Add('*****Итерация №'+IntToStr(k)+'*****');
memo1.Lines.Add('Ключевым столбцом называется тот столбец, которому соответствует наибольшее по модулю значение итоговой строки.');
memo1.Lines.Add('Находим ключевой столбец: '+IntToStr(ki));
memo1.Lines.Add('Каждое неотрицательное число в столбце постоянных величин В делим на соответствующее число ключевого столбца,');
memo1.Lines.Add('из полученных значений выбираем наименьшее по модулю.');
//**
//ключ-строка
mn:=0; //***Ошибка!
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
if StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,i])<>0 then
begin
mn:=StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[2,i])/
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,i]);
//**
memo1.Lines.Add('[2,'+IntToStr(i)+']/['+IntToStr(ki)+','+IntToStr(i)+']='+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[2,i])+'/'+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,i])+'='+FloatToStr(mn)+';');
//**
if (mn>=0)and(
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[2,i])/
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,i])<=mn) then
kj:=i;
end;
//**
if l=1 then
begin
sg1.OnDrawCell:=sg1DrawCell;
sg2.OnDrawCell:=StringGrid1DrawCell;
end else
if l=2 then
begin
sg2.OnDrawCell:=sg2DrawCell;
sg1.OnDrawCell:=StringGrid1DrawCell;
end;
sg1.Repaint;sg2.Repaint;

memo1.Lines.Add('Минимальное по модулю число равно '+FloatToStr(
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[2,kj])/
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj]))+'.');
memo1.Lines.Add('Находим ключевую строку: '+IntToStr(kj));
memo1.Lines.Add('Ключевым элементом является элемент, находящийся на пересечении ключ- столбца и строки.');
memo1.Lines.Add('Находим ключевой элемент: ['+IntToStr(ki)+','+IntToStr(kj)+']='+(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj]);
//**
//***Возможно, ошибка...
(FindComponent(Format('sg%d',[num])) as TStringGrid).Repaint;
{*****Формирование новой симплекс-таблицы*****}
memo1.Lines.Add('Расчёт новых элементов, кот. не принадлежат к ключ- столбцу и строке:');
memo1.Lines.Add('Новый элемент = Старый элемент - (Соответствующий элемент ключ-строки * Соответствующий элемент ключ-столбца)/Ключ-элемент');
memo1.Lines.Add('Находим данные элементы:');
//Расчёт новых элементов, кот. не принадлежат к ключ- столбцу и строке
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).ColCount-1 do
for j:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
begin

(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[i,j]:=
FloatToStr(
(StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,j]))-
(StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,j]))*
(StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,kj]))/
(StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj])));
//**
memo1.Lines.Add('['+IntToStr(i)+','+IntToStr(j)+']=['+
IntToStr(i)+','+IntToStr(j)+']-(['+
IntToStr(ki)+','+IntToStr(j)+']*['+
IntToStr(i)+','+IntToStr(kj)+'])/['+
IntToStr(ki)+','+IntToStr(kj)+']='+
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,j]+'-('+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,j])+'*'+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,kj])+')/'+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj])+'='+
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[i,j]+';');
//**
end;
//Расчёт новых элементов, кот. принадлежат к ключ-столбцу
//**
memo1.Lines.Add('Находим новые элементы ключевого столбца: они равны 0. Ключевой элемент равен 1.');
memo1.Lines.Add('Находим новые элементы ключевой строки: Соответствующий элемент ключ-строки / Ключевой элемент.');
memo1.Lines.Add('**Примечание 1**: Если в ключевом столбце 0 ,то все элементы строки, содержащей этот 0 переписываются без измененений.');
memo1.Lines.Add('**Примечание 2**: Если в ключевой строке 0 ,то все элементы столбца, содержащего этот 0 переписываются без измененений.');
memo1.Lines.Add('**Примечание 3**: Данная программная реализация предусматривает примечания 1 и 2 , но мы выведем расчёт всех элементов:');
//**
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
if i=kj then (FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[ki,i]:='1'
else (FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[ki,i]:='0';
//Расчёт новых элементов, кот. принадлежат к ключ-строке
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).ColCount-1 do
begin
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[i,kj]:=
FloatToStr(
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,kj])/
StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj]));
//**
memo1.Lines.Add('['+IntToStr(i)+','+IntToStr(kj)+']=['+
IntToStr(i)+','+IntToStr(kj)+']/['+IntToStr(ki)+','+IntToStr(kj)+']='+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,kj])+'/'+
fw((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,kj])+'='+
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[i,kj]+';');
//**
end;
//Если в ключ. столбце 0 ,то все эл-ты строки,
//содержащей этот 0 переписываются без измененений
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
if StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,i])=0 then
for j:=2 to (FindComponent(Format('sg%d',[num2])) as TStringGrid).ColCount-1 do
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[j,i]:=
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[j,i];
//Если в ключ. строке 0 ,то все эл-ты столбца,
//содержащего этот 0 переписываются без измененений
for i:=3 to (FindComponent(Format('sg%d',[num])) as TStringGrid).ColCount-1 do
if StrToFloat((FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,kj])=0 then
for j:=2 to (FindComponent(Format('sg%d',[num2])) as TStringGrid).RowCount-2 do
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[i,j]:=
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[i,j];
//Смена базисного элемента
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
begin
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[1,i]:=
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[1,i];
//Визуализация Xi
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[0,i]:=
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[0,i];
end;
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[1,kj]:=
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[ki,0];
//**
memo1.Lines.Add('Вводим в базис элемент Х'+inttostr(ki-2)+'='+(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[ki,0]
+', выводим из базиса элемент Х'+IntToStr(ki)+'='+
(FindComponent(Format('sg%d',[num])) as TStringGrid).Cells[1,kj]+'.');
//**
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[0,kj]:='x'+inttostr(ki-2);
//Расчёт симплекс-разностей
mn:=0; r:=0;
//**
memo1.Lines.Add('Находим симплексные разности: D[i] = Ak[i] * Cб[i] - ~Ck[i].');
//**
for j:=3 to (FindComponent(Format('sg%d',[num2])) as TStringGrid).ColCount-1 do
for i:=2 to (FindComponent(Format('sg%d',[num2])) as TStringGrid).RowCount-2 do
begin
mn:=mn+StrToFloat((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[1,i])*
       StrToFloat((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[j,i]);
if i=(FindComponent(Format('sg%d',[num2])) as TStringGrid).RowCount-2 then
begin
//**
m:=m+1;mnl:=mn;
//**
mn:=mn-StrToFloat((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[j,0]);
if mn>=0 then r:=r+1;
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[j,
(FindComponent(Format('sg%d',[num2])) as TStringGrid).RowCount-1]:=FloatToStr(mn);
//**
memo1.Lines.Add('D['+IntToStr(m)+']='+FloatToStr(mnl)+'-'+
fw((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[j,0])+'='+
FloatToStr(mn)+';');
//**
mn:=0;
end;
end;
//Расчёт целевой функции Z
mn:=0;
for i:=2 to (FindComponent(Format('sg%d',[num])) as TStringGrid).RowCount-2 do
mn:=mn+
StrToFloat((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[1,i])*
StrToFloat((FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[2,i]);
(FindComponent(Format('sg%d',[num2])) as TStringGrid).Cells[2,
(FindComponent(Format('sg%d',[num2])) as TStringGrid).RowCount-1]:=FloatToStr(mn);
//**
memo1.Lines.Add('Находим значение целевой функции Z в точке ~Х'+IntToStr(k+1)+': Cб[i] * В[i] = '+FloatToStr(mn)+'.');
//**
if r=(FindComponent(Format('sg%d',[num2])) as TStringGrid).ColCount-3 then
begin
stb.Enabled:=false;
button3.Enabled:=false;
Result:=true;
end;
end;

procedure TForm1.Mask(num: integer);
begin
//Шаблон с-таблицы
for i:=3 to (FindComponent(Format('sg%d',[1]))as TStringGrid).ColCount-1 do
(FindComponent(Format('sg%d',[2])) as TStringGrid).Cells[i,0]:=
(FindComponent(Format('sg%d',[1])) as TStringGrid).Cells[i,0];
with (FindComponent(Format('sg%d',[num])) as TStringGrid) do
begin
Cells[0,1]:='Базис';
Cells[1,1]:='Cб';
Cells[2,0]:='C~';
Cells[2,1]:='B';
Cells[1,RowCount-1]:='Z~   =';
for i:=3 to ColCount-1 do
Cells[i,1]:='A'+inttostr(i-2);  Repaint;
end;
end;

procedure TForm1.sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
dg(Sender, ACol, ARow, Rect,State,2);
end;

procedure TForm1.Tsize;
begin
 sg1.RowCount:=StrToInt(Edit1.Text)+3;
 sg1.ColCount:=StrToInt(Edit2.Text)+StrToInt(Edit1.Text)+3;
 sg2.RowCount:=StrToInt(Edit1.Text)+3;
 sg2.ColCount:=StrToInt(Edit2.Text)+StrToInt(Edit1.Text)+3;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
try
case key of
#13:begin tsize;mask(1);sh;end;
'0'..'9',#8:
else key:=#13;
end;
except
Memo1.Lines.Add('Неккоректные данные!');
end;
end;

procedure TForm1.Sh;
begin
for i:=2 to sg1.RowCount-2 do
begin
sg1.Cells[0,i]:='x'+inttostr(i+1);
sg1.Cells[1,i]:='0';
end;mask(1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if l=1 then l:=2 else l:=1;
Application.ProcessMessages;//чтоб не висло
try
SG2.Visible:=true;
stb.Visible:=false;
form1.Height:=664;
button3.Caption:='Далее';
 k:=k+1;
l2.Caption:=IntToStr(k+1);
if SM(l) then
begin
Memo1.Lines.Add('Решено!');
l:=2; 
end;
except
 Memo1.Lines.Add('Неккоректные данные!');
 k:=0;
end;

end;

procedure TForm1.N1Click(Sender: TObject);
begin
SG2.Visible:=false;
stb.Visible:=true;
form1.Height:=460;
button3.Caption:='Пошаговый';
k:=0; l2.Caption:='0';
end;

procedure TForm1.FormDblClick(Sender: TObject);
begin
for I:=0 to Sg1.RowCount-1 do Sg1.Rows[I].Clear();
mask(1);sh; k:=0;l2.Caption:='0';
end;

procedure TForm1.SaveGrid(Filename:string);
var
f: textfile;
begin
fn.Text:='Укажите имя файла для сохранения';

if filename=Copy(filename,Pos('.',filename),length(filename)) then
assignfile(f,filename+'.spx') else
assignfile(f,Copy(Filename,0,Pos('.',Filename))+'spx');

rewrite(f);
writeln(f, sg1.colcount);
writeln(f, sg1.rowcount);
for i := 0 to sg1.colcount - 1 do
   for j := 0 to sg1.rowcount - 1 do
     writeln(F, sg1.cells[i, j]);
closefile(f);
end;

procedure TForm1.LoadGrid(Filename: string);
var
f: textfile;
temp: integer;
tempstr: string;
begin
assignfile(f, Filename);
reset(f);
readln(f, temp);
sg1.colcount := temp;
readln(f, temp);
sg1.rowcount := temp;
for i := 0 to sg1.colcount - 1 do
   for j := 0 to sg1.rowcount - 1 do
   begin
     readln(F, tempstr);
     sg1.cells[i, j] := tempstr;
   end;
closefile(f);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
SaveGrid(fn.Text);
end;

procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
var
CFileName: array[0..MAX_PATH] of Char; // переменная, хранящая имя файла
begin
try
try
FlashWindow(Handle, TRUE);
If DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH)> 0 then
// получение пути файла
begin
LoadGrid(CFileName);
Msg.Result := 0;
N1.Click;
stb.Enabled:=true;
button3.Enabled:=true;
end;
finally
DragFinish(Msg.Drop); // отпустить файл
Memo1.Clear;
Memo1.Lines.Add('Файл успешно загружен!');
end;
except
 Memo1.Clear;
 Memo1.Lines.Add('Перетащите нормальный файл!');
end;
Application.BringtoFront;
end;

procedure TForm1.fnKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then SaveGrid(fn.Text);
end;

procedure TForm1.l1Click(Sender: TObject);
begin
UnregisterAppDocuments();
end;

procedure TForm1.sg1KeyPress(Sender: TObject; var Key: Char);
begin
case key of
'0'..'9','.',',','-':;
#13,#8:
else
key:=#13; end ;
stb.Enabled:=true;
button3.Enabled:=true;
end;

procedure TForm1.fnClick(Sender: TObject);
begin
fn.Clear;
end;

function TForm1.fW(s: string): string;
begin
if StrToFloat(s)<0 then s:='('+s+')';
fw:=s;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
//**
end;

procedure TForm1.dg(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; num: integer);
Const   //здесь определяем цвет
clPaleGreen = TColor($CCFFCC);
begin
with (FindComponent(Format('sg%d',[num])) as TStringGrid) do
begin
//Если ячейка получает фокус, то нам надо закрасить её другими цветами
if (gdFocused in State) then begin
  Canvas.Brush.Color := clWhite;
  Canvas.Font.Color := clBlack;
end
else //Если же ячейка теряет фокус, то закрашиваем её зелёным
  if ACol = ki  //колонка будет зелёной
   then Canvas.Brush.color := clPaleGreen;
  if ARow = kj  //колонка будет зелёной
   then Canvas.Brush.color := clPaleGreen;
//Закрашиваем бэкграунд
   canvas.fillRect(Rect);
//Закрашиваем текст
   canvas.TextOut(Rect.Left,Rect.Top,Cells[ACol,ARow]);
end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Form1.Enabled:=false;
 if
 MessageBox(0,'Программа SimplexM написана с использованием:'
 +chr(13)+'Borland Delphi Enterprise 7 - код программы;'
 +chr(13)+'GNU Image Manipulation Program 2.4.2 (GIMP) - иконка программы;'
 +chr(13)+'Набор компонентов AlphaControls - визуальное оформление;'
 +chr(13)+'Microsoft Office Word 2003, Microsoft Help WorkShop - cправочная система;'
 +chr(13)+'Ultimate Packer for eXecutables (UPX) - cжатие программы.'
 +chr(13)+'Авторские права © 2009. Бабушкин Алексей, гр. ПОВТ-271 БФ ГОУ ВПО СибГУТИ,декабрь 2009 года.','О программе',MB_OK+MB_ICONINFORMATION)=ID_OK
 then Form1.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
Application.HelpCommand(HELP_QUIT, 0); 
end;

end.
