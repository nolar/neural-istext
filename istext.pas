const hc=0.1;
function f(x:extended):extended;
begin
 f:=x/(hc+abs(x));
end;

var fw:file of extended;
    ft:file of byte;
    a,b:byte;
    p,total:longint;
    ps1,ps2:string;
    count:array[$00..$ff]of longint;
    freq,wei:array[$00..$ff]of extended;
    sum,res:extended;
BEGIN
 randomize;
{ writeln('Text identificator tester (C) 1997 by Vasilyev Sergei');}
 if(paramcount<>2)then
  begin
   writeln('Usage: Test.exe <text> <weights>');
   halt;
  end;
 ps1:=paramstr(1); ps2:=paramstr(2);

 write(ps1,': ');
 write('Reading... ');
 assign(ft,ps1);
 reset(ft);
 total:=filesize(ft);
 for a:=$00 to $ff do
  count[a]:=0;
 for p:=1 to total do
  begin
   read(ft,b);
   count[b]:=count[b]+1;
  end;
 close(ft);
 for a:=$00 to $ff do
  freq[a]:=count[a]/total;

 write('Creating... ');
 assign(fw,ps2);
 {$I-}reset(fw);{$I+}
 if(ioresult=0)then
  begin
   for a:=$00 to $ff do
    read(fw,wei[a]);
   close(fw);
  end else
  for a:=$00 to $ff do
   if(random<0.5)then
    wei[a]:=random else
    wei[a]:=-random;

 {fire}
 sum:=0;
 for a:=$00to $ff do
  sum:=sum+wei[a]*freq[a];
 res:=f(sum);

 if(res>0)then
  write('This is text (',round(res*100),'%)') else
  write('This isn''t text (',round(-res*100),'%)');

 writeln;
END.
