const MaxErr=0.1;
      hc=0.1;
function f(x:extended):extended;
begin
 f:=x/(hc+abs(x));
end;
function df(x:extended):extended;
begin
 df:=hc/sqr(hc+abs(x));
end;

var fw:file of extended;
    ft:file of byte;
    a,b:byte;
    p,total:longint;
    ps1,ps2,ps3:string;
    count:array[$00..$ff]of longint;
    freq,wei:array[$00..$ff]of extended;
    sum,res,err,corr:extended;
BEGIN
 randomize;
{ writeln('Text identificator trainer (C) 1997 by Vasilyev Sergei');}
 if(paramcount<>3)then
  begin
   writeln('Usage: Train.exe <text> <weights> <Y|N>');
   halt;
  end;
 ps1:=paramstr(1); ps2:=paramstr(2); ps3:=paramstr(3);

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

 if(upcase(ps3[1])='Y')then
  corr:=1 else
  if(upcase(ps3[1])='N')then
   corr:=-1 else
   corr:=0;


 write('Teaching... ');
 repeat
  {fire}
  sum:=0;
  for a:=$00to $ff do
   sum:=sum+wei[a]*freq[a];
  res:=f(sum);
  {teach}
  err:=corr-res;
  err:=err*df(sum);
  for a:=$00 to $ff do
   wei[a]:=wei[a]+err*freq[a];
  {fire}
  sum:=0;
  for a:=$00to $ff do
   sum:=sum+wei[a]*freq[a];
  res:=f(sum);
 until(abs(corr-res)<MaxErr);


 assign(fw,ps2);
 rewrite(fw);
 for a:=$00 to $ff do
  write(fw,wei[a]);
 close(fw);

 writeln;
END.
