program uwdt;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Dialogs,
  inpout32;

var
  i:integer;
  b, b1, b2, t:byte;
begin
   if (ParamCount > 2) or (ParamCount < 1) then
      begin
        writeLn('incorrect parameters');
        //readLn;
        exit;
      end;

   if ParamCount =1 then
    begin
     if (ParamStr(1) = 'stop') then
       begin
          //Stop WDT
        Out32($2E,$87); //connect to WDT
        Out32($2E,$87);

        Out32($2E,$07); //open registers WDT
        Out32($2F,$08);

        Out32($2E,$30); //enable function WDT
        b:=Inp32($2F);
        Out32($2F,$01);
        b1:=Inp32($2F);
       // writeLn(Format('%x %x',[$30, b]),' -> ',Format('%x',[01]), ' => ', Format('%x',[b1]));

        Out32($2E,$F6); //Stop count
        b:=Inp32($2F);
        Out32($2F,$00);
        b1:=Inp32($2F);
       // writeLn(Format('%x %x',[$F6, b]),' -> ',Format('%x',[00]), ' => ', Format('%x',[b1]));

        Out32($2E,$AA); //block WDT

        exit;
       end;
     {if (ParamStr(1) = 'reset') then
       begin
        //Reset WDT
        Out32($2E,$87); //connect to WDT
        Out32($2E,$87);

        Out32($2E,$07); //open registers WDT
        Out32($2F,$08);

        Out32($2E,$30); //enable function WDT
        b:=Inp32($2F);
        Out32($2F,$01);
        b1:=Inp32($2F);
        writeLn(Format('%x %x',[$30, b]),' -> ',Format('%x',[01]), ' => ', Format('%x',[b1]));

        Out32($2E,$F6);
        b:=Inp32($2F);    //read b from counter
        Out32($2F,b);          //write to counter
        b1:=Inp32($2F);
        writeLn(Format('%x %x',[$F6, b]),' -> ',Format('%x',[b]), ' => ', Format('%x',[b1]));

        Out32($2E,$AA); //block WDT

        exit;
       end;
     }
       if ParamStr(1)='help' then
        begin
          writeln ('start <num> - start WDT for <num> minutes');
          writeln ('stop - stop WDT');
          writeln ('help - out this topic');

          exit;
        end;
     end;
   if (ParamStr(1) = 'start') then
     if ParamCount = 2 then
       begin
          try
            t:=StrToInt(ParamStr(2));
          except
            writeLn('parameter must be integer');
            exit;
          end;
          begin
              //Start WDT
              Out32($2E,$87); //connect to WDT
              Out32($2E,$87);

              Out32($2E,$07); //open registers WDT
              Out32($2F,$08);

              Out32($2E,$30); //enable function WDT
              b:=Inp32($2F);
              Out32($2F,$01);
              b1:=Inp32($2F);
        //      writeLn(Format('%x %x',[$30, b]),' -> ',Format('%x',[01]), ' => ', Format('%x',[b1]));

              Out32($2E,$F5); //set minute as countin unit
              b:=Inp32($2F);
              b2:=b or $08;
              Out32($2F,b2);
              b1:=Inp32($2F);
        //      writeLn(Format('%x %x',[$F5, b]),' -> ',Format('%x',[b2]), ' => ', Format('%x',[b1]));

              Out32($2E,$F6); //set timeouts interval
              b:=Inp32($2F);
              Out32($2F,t);
              b1:=Inp32($2F);
              writeLn(Format('%x %x',[$F6, b]),' -> ',Format('%x',[t]), ' => ', Format('%x',[b1]));

              Out32($2E,$AA); //block WDT
              exit;
          end;
       end
      else
       begin
        writeLn('option start must have an integer parameter');
        exit;
       end;

   writeLn('incorrect parameters');
end.
