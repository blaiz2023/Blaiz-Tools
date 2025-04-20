program blaiztools;

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,// this includes the LCL widgetset
  forms,
  gossgui,
  main,
  gossdat,
  gossimg,
  gossio,
  gossnet,
  gossroot,
  gosssnd,
  gosswin;
  { you can add units after this }


//{$R *.RES}
//include multi-format icon - Delphi 3 can't compile an icon of 256x256 @ 32 bit -> resource error/out of memory error - 19nov2024
{$R app-icon-16-256px.res}

begin
//(1)false=event driven disabled, (2)false=file handle caching disabled, (3)true=gui app mode
app__boot(true,false,not isconsole);
end.
