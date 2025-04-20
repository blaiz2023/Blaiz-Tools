unit main;

interface

uses

{$ifdef gui3} {$define gui2} {$endif}
{$ifdef gui2} {$define gui}  {$define jpeg} {$endif}
{$ifdef gui} {$define bmp} {$define ico} {$define gif} {$define snd} {$endif}

{$ifdef con3} {$define con2} {$endif}
{$ifdef con2} {$define bmp} {$define ico} {$define gif} {$define jpeg} {$endif}

{$ifdef fpc} {$mode delphi}{$define laz} {$define d3laz} {$undef d3} {$else} {$define d3} {$define d3laz} {$undef laz} {$endif}
{$ifdef d3laz} windows, messages, sysutils, classes, graphics, forms, dialogs, math, gossroot, {$ifdef gui}gossgui,{$endif} {$ifdef snd}gosssnd,{$endif} gosswin, gossio, gossimg, gossnet; {$endif}
{$B-} {generate short-circuit boolean evaluation code -> stop evaluating logic as soon as value is known}

//## ==========================================================================================================================================================================================================================
//##
//## MIT License
//##
//## Copyright 2025 Blaiz Enterprises ( http://www.blaizenterprises.com )
//##
//## Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
//## files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
//## modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
//## is furnished to do so, subject to the following conditions:
//##
//## The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//##
//## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//## OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//## LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//## CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//##
//## ==========================================================================================================================================================================================================================
//## Library.................. app code (main.pas)
//## Version.................. 1.00.2677 (+6)
//## Items.................... 4
//## Last Updated ............ 21apr2025, 13apr2025, 11apr2025, 01apr2025
//## Lines of Code............ 6,400+
//##
//## main.pas ................ app code
//## gossroot.pas ............ console/gui app startup and control
//## gossio.pas .............. file io
//## gossimg.pas ............. image/graphics
//## gossnet.pas ............. network
//## gosswin.pas ............. 32bit windows api's
//## gosssnd.pas ............. sound/audio/midi/chimes
//## gossgui.pas ............. gui management/controls
//## gossdat.pas ............. static data/icons/splash/help settings/help document(gui only)
//##
//## ==========================================================================================================================================================================================================================
//## | Name                   | Hierarchy         | Version   | Date        | Update history / brief description of function
//## |------------------------|-------------------|-----------|-------------|--------------------------------------------------------
//## | tapp                   | tbasicapp         | 1.00.120  | 21apr2025   | Custom app code goes inside this control - 20jul2024
//## | tworkpanel             | tbasiccols        | 1.00.2145 | 21apr2025   | General and Gossamer related tools and operations
//## | d2laz__*               | family of procs   | 1.00.040  | 01apr2025   | Delphi 3 to Lazarus to conversion procs
//## | choco__*               | family of procs   | 1.00.370  | 21apr2025   | Chocolatey portable package (*.nupkg) creation - 11apr2025
//## ==========================================================================================================================================================================================================================
//## Performance Note:
//##
//## The runtime compiler options "Range Checking" and "Overflow Checking", when enabled under Delphi 3
//## (Project > Options > Complier > Runtime Errors) slow down graphics calculations by about 50%,
//## causing ~2x more CPU to be consumed.  For optimal performance, these options should be disabled
//## when compiling.
//## ==========================================================================================================================================================================================================================


const
   //data type
   dtNone  =0;
   dtText  =1;
   dtImage =2;
   dtMax   =3;

   //command strings
   cs_browsersupportedimages         ='browsersupportedimages';
   cs_capsep                         =' > ';
   cs_nil                            ='nil';
   cs_zip                            ='zip';
   cs_sep                            ='.';
   cs_subfolders                     ='subfolders';

   //.array
   cs_pastetext_makearray            ='pastetext_makearray';
   cs_pastecolorscheme_makearray     ='pastecolorscheme_makearray';
   cs_opencolorscheme_makearray      ='opencolorscheme_makearray';
   cs_fromfile_makearray             ='fromfile_makearray';
   cs_openimage_makearray            ='openimage_makearray';
   cs_pasteimage_makearray           ='pasteimage_makearray';
   cs_packfiles_makearray            ='packfiles_makearray';
   cs_packfiles_makeunit             ='packfiles_makeunit';

   //.base64
   cs_fromfile_makebase64            ='fromfile_makebase64';
   cs_openimage_makebase64           ='openimage_makebase64';
   cs_pasteimage_makebase64          ='pasteimage_makebase64';
   cs_pastetext_makebase64           ='pastetext_makebase64';

   cs_fromfile_makebase64_xxc        ='fromfile_makebase64_xxc';
   cs_pastetext_makebase64_xxc       ='pastetextmakebase64_xxc';

   //.file
   cs_packfiles                      ='packfiles';
   cs_convertimage                   ='convertimage';
   cs_convertimage_web               ='convertimage_web';
   cs_choco                          ='choco';

   //.text
   cs_pastetext_manipulate           ='pastetext_manipulate';
   cs_pastetext_manipulate_spacetabs ='pastetext_manipulate_spacetabs';
   cs_pastetext_manipulate_strip     ='pastetext_manipulate_strip';
   cs_pastetext_manipulate_remchar   ='pastetext_manipulate_remchar';
   cs_pastetext_forcereturncodes     ='pastetext_forcereturncodes';
   cs_pre_post_lines                 ='pre_post_lines';
   cs_sortlines                      ='sortlines';
   cs_remleadingstr_lines            ='remleadingstr_lines';
   cs_utf8_to_ascii                  ='utf8_to_ascii';
   cs_remdup                         ='remdup';

   //.code
   cs_markduplicates_code            ='markduplicates_code';
   cs_make_lazarusproject_fromdelphi ='make_lazarusproject_fromdelphi';
   cs_cleanproject                   ='cleanproject';
   cs_cleanunitfiles                 ='cleanunitfiles';
   cs_charinfo                       ='charinfo';

   //.images
   cs_blankimages                    ='blankimages';
   cs_imagetemplate                  ='imagetemplate';

   //.by type
   cs_concise_part1                  ='concise_part1';
   cs_concise_part2                  ='concise_part2';
   cs_concise_part3                  ='concise_part3';
   cs_concise_part4                  ='concise_part4';

   cs_text_part1                     ='text_part1';
   cs_text_part2                     ='text_part2';
   cs_text_part3                     ='text_part3';
   cs_text_part4                     ='text_part4';

   cs_image_part1                    ='image_part1';
   cs_image_part2                    ='image_part2';
   cs_image_part3                    ='image_part3';
   cs_image_part4                    ='image_part4';
   cs_image_part5                    ='image_part5';
   cs_image_part6                    ='image_part6';

   cs_code_part1                     ='code_part1';
   cs_code_part2                     ='code_part2';
   cs_code_part3                     ='code_part3';
   
var
   itimerbusy:boolean=false;
   iapp:tobject=nil;

   //support vars --------------------------------------------------------------
   sup_init            :boolean=false;
   sup_use             :boolean=false;

   sup_preval          :string='';
   sup_postval         :string='';

   sup_data            :tstr8=nil;
   sup_data2           :tstr8=nil;
   sup_image           :trawimage=nil;
   sup_image2          :trawimage=nil;
   sup_list            :tdynamicstring=nil;
   sup_list2           :tdynamicstring=nil;
   sup_openfile        :string='';
   sup_openfilter      :longint=0;
   sup_openimagefile0  :string='';
   sup_openimagefilter0:longint=0;
   sup_openimagefile   :string='';
   sup_openimagefilter :longint=0;
   sup_savefile        :string='';
   sup_savefilter      :longint=0;
   sup_saveimagefile   :string='';
   sup_openfolder      :string='';
   sup_undoformat      :longint=0;//0=empty, 1=text
   sup_undo            :tstr8=nil;
   //.label support
   sup_imageindex      :longint=0;
   sup_imageext        :string='';
   sup_imagemime       :string='';
   sup_imagetep        :longint=tepBMP20;
   sup_imagelabel      :string='';

   sup_docindex        :longint=0;
   sup_docext          :string='';
   sup_docmime         :string='';
   sup_doctep          :longint=tepTXT20;
   sup_doclabel        :string='';

type
//xxxxxxxxxxxxxxxxxxxx//333333333333333333
   tchocolist=class(tobjectex)
   private
    icore:tfastvars;
    ilist:tbasicmenu;//pointer only
    function getmarked(x:string):boolean;
    procedure setmarked(x:string;v:boolean);
    function gettext:string;
    procedure settext(x:string);
   public
    //create
    constructor create;
    destructor destroy; override;
    function list__onitem(sender:tobject;xindex:longint;var xtab,xtep,xtepcolor:longint;var xcaption,xcaplabel,xhelp,xcode2:string;var xcode,xshortcut,xindent:longint;var xflash,xenabled,xtitle,xsep,xbold:boolean):boolean;
    procedure list__onclick(sender:tobject);
    //workers
    property marked[xname:string]:boolean read getmarked write setmarked;
    procedure clear;
    procedure listConnect(x:tbasicmenu);
    procedure listDisconnect(x:tbasicmenu);
    //io
    property textline:string read gettext write settext;
   end;

{tworkpanel}
   tworkpanel=class(tbasiccols)
   private
    icapsep:string;
    ibar:array[0..19] of tbasictoolbar;
    icurrentbar:tbasictoolbar;
    icount,ibuttoncount:longint;
    function getbar(xindex:longint):tbasictoolbar;
    procedure __onclick(sender:tobject);
    procedure xcmd(sender:tobject;xcode:longint;xcode2:string);
    function xnewbar:tbasictoolbar;
    function xnewbar2(xremcount:longint):tbasictoolbar;
    procedure xenhance(xval:string;var x:string);
    procedure al;//new line
    procedure at(xname,xhelp:string);//add title
    procedure ab(xtep:longint;xcmd,xname,xhelp:string);//add button
    procedure ab1(xtep:longint;xcmd,xcmd2,v1,xhelp:string);
    procedure ab2(xtep:longint;xcmd,xcmd2,v1,v2,xhelp:string);
    procedure ab20(xtep:longint;xcmd,xcmd2,v1,v2,xhelp:string);
    procedure ab3(xtep:longint;xcmd,xcmd2,v1,v2,v3,xhelp:string);
    procedure addbyname(n:string);
   public
    //create
    constructor create(xparent:tobject); override;
    destructor destroy; override;
    //information
    property count:longint read icount;
    property bar[x:longint]:tbasictoolbar read getbar;
    //makers
    procedure makeconcise;
    procedure makeimage;
    procedure maketext;
    procedure makecode;
   end;

{tapp}
   tapp=class(tbasicapp)
   private
    itimer500:comp;
    iloaded,ibuildingcontrol:boolean;
    procedure xcmd(sender:tobject;xcode:longint;xcode2:string);
    procedure __onclick(sender:tobject);
    procedure __ontimer(sender:tobject); override;
    procedure xshowmenuFill1(sender:tobject;xstyle:string;xmenudata:tstr8;var ximagealign:longint;var xmenuname:string);
    function xshowmenuClick1(sender:tbasiccontrol;xstyle:string;xcode:longint;xcode2:string;xtepcolor:longint):boolean;
    procedure xloadsettings;
    procedure xsavesettings;
    procedure xautosavesettings;
   public
    //create
    constructor create; virtual;
    destructor destroy; override;
   end;

//info procs -------------------------------------------------------------------
function app__info(xname:string):string;
function info__app(xname:string):string;//information specific to this unit of code - 20jul2024: program defaults added, 23jun2024


//app procs --------------------------------------------------------------------
//.create / destroy
procedure app__create;
procedure app__destroy;

//.event handlers
function app__onmessage(m,w,l:longint):longint;
procedure app__onpaintOFF;//called when screen was live and visible but is now not live, and output is back to line by line
procedure app__onpaint(sw,sh:longint);
procedure app__ontimer;

//.support procs
function app__netmore:tnetmore;//optional - return a custom "tnetmore" object for a custom helper object for each network record -> once assigned to a network record, the object remains active and ".clear()" proc is used to reduce memory/clear state info when record is reset/reused
function app__findcustomtep(xindex:longint;var xdata:tlistptr):boolean;
function app__syncandsavesettings:boolean;


//support procs ----------------------------------------------------------------
function low__findv(xvalue:string):longint;//find value "!v.."


//init
procedure sup__start;
procedure sup__stop;

//.data
function sup__data:tstr8;
function sup__data2:tstr8;
function sup__datalen:longint;
function sup__datalen2:longint;
function sup__dataclear:boolean;//used for open/save prompt io
function sup__dataclear2:boolean;
function sup__datatobase64(dext:string;var e:string):boolean;
function sup__imagetemplate(xname:string;dw,dh:longint;dwhite:boolean;var e:string):boolean;

//.list
function sup__listclear:boolean;
function sup__listclear2:boolean;

//.image
function sup__imageclear:boolean;
function sup__imageclear2:boolean;
function sup__image:trawimage;
function sup__image2:trawimage;
function sup__imagetodata(dext,daction:string;var e:string):boolean;
function sup__datatoimage(var e:string):boolean;

//.prompt dialogs
function sup__openprompt(const xformatlst:string;var e:string):boolean;
function sup__openprompt2(const xformatlst:string;xloadfile:boolean;var e:string):boolean;
function sup__saveprompt(const xformatlst:string;var e:string):boolean;
function sup__saveprompt2(const xformatlst:string;xinsertUNITNAME:boolean;var e:string):boolean;
function sup__openfolder(xfilterlist:string):boolean;
function sup__openimageprompt(var e:string):boolean;
function sup__openimageprompt_browsersupported(var e:string):boolean;
function sup__saveimageprompt(var e:string):boolean;

//.base64
function sup__tob64(xlinelen:longint;var e:string):boolean;
function sup__tob642(xlinelen:longint;var e:string):boolean;

//.compress
function sup__compress(var e:string):boolean;
function sup__decompress(var e:string):boolean;

//.copy
function sup__datacopy12:boolean;//copy data to data2
function sup__datacopy21:boolean;//copy data2 to data1

//.clipboard
function sup__copytext(var e:string):boolean;
function sup__copyimage(var e:string):boolean;
function sup__copyimage2(var e:string):boolean;
function sup__pastetext(var e:string):boolean;
function sup__pastebinary(dimgformat:string;var e:string):boolean;
function sup__pasteimage(var e:string):boolean;

//.undo
function sup__undoclear:boolean;
function sup__canundo:boolean;
function sup__undohasformat(x:longint):boolean;
function sup__undofill(xformat:longint):boolean;
function sup__undofill2(xformat:longint):boolean;

//.workers
function sup__uniquename(xsourcefolder,xdestext:string;var xdestfolderORfilename:string):boolean;
function sup__forcereturncodestyle(r10,r13,xinclude_blanklines:boolean):boolean;//force return code style
function sup__zip(var e:string):boolean;
function sup__makeuppercase(xup:boolean):boolean;
function sup__makearray(xname:string;var e:string):boolean;
function sup__makecolors(xname:string):boolean;
function sup__packfiles(xfolder:string;xsubfolders:boolean;var e:string):boolean;
function sup__cleanproject(xfolder:string;xsubfolders:boolean;var xcount:longint;var e:string):boolean;
function sup__inlist(x:string;const xlist:array of string;xtruewhenlistempty:boolean):boolean;

//.label procs
function sup__pname(xpre,x:string):string;
function sup__pascallabel(x:string):string;//0..9, A..Z, a..z, "_"
function sup__extlabel(xext:string):string;
function sup__extlabel2(xext:string;xlongname:boolean):string;
function sup__extinfo(xext:string;xlongname:boolean;var xlabel,xmime:string;var xtep:longint):boolean;
function sup__extmime(xext:string):string;
function sup__extbrowsersupported(xext:string):boolean;
function sup__labelsep:string;
function sup__label2(v1,v2:string):string;
function sup__label3(v1,v2,v3:string):string;
function sup__imageext:string;
function sup__imageextU:string;
function sup__imagemime:string;
function sup__imagetep:longint;
function sup__imagelabel:string;
function sup__imagelist(xreset:boolean):boolean;//cycle through supported image list of extensions

function sup__docext:string;
function sup__docextU:string;
function sup__docmime:string;
function sup__doctep:longint;
function sup__doclabel:string;
function sup__doclist(xreset:boolean):boolean;//cycle through supported doc list of extensions

//.code
procedure sup__markduplicate_procnames(sfilename:string;snamepartafterDualunderscore,xsubfolders:boolean);//19mar2025
procedure sup__cleanunitfiles(xfolder:string;xsubfolders:boolean);
procedure sup__charinfo;
function sup__packfiles_makeunit(xfolder,xincludemask,xexcludemask:string;xcompress,xsubfolders:boolean;var e:string):boolean;

//.text manipulation
function sup__manipulatetext(n:string;var e:string):boolean;
function sup__insertspace(xspacecount:longint;var e:string):boolean;//insert X (-10..+10) spaces at beginning of each line of text - skip blank lines
function sup__stripwhitespace(xstripleading,xstriptrailing,xstriprcodes,xspaceforstrippedrcode:boolean;var e:string):boolean;
function sup__pre_post_lines(xincludeblanklines,xnumber:boolean;xpre,xpost,xrcode:string;var e:string):boolean;
function sup__sortlines(xsortAZ:boolean;var e:string):boolean;
function sup__removeleadingstr_lines(xscan1,xscan2,xscan3:string;var e:string):boolean;
function sup__utf8_to_ascii(var e:string):boolean;
function sup__remdup(xscanpastwhitespace:boolean;var e:string):boolean;


//.support
function workpanel__new(xrootwin:tbasicscroll;xtep:longint;xname,xpagename,xhelp:string):tworkpanel;

//.lists
function sup__listofsizes(var xpos,xsize:longint):boolean;


//Delphi to Lazarus project conversion procs -----------------------------------
procedure d2laz__makeproject(xall:boolean);//this app
function d2laz__makeproject2(xfilename:string;var e:string):boolean;//a specific app -> expects a ".dpr" filename - 30mar2025, 21mar2025
function d2laz__makeproject3(xfolder:string;xsubfolders:boolean;var xmakecount:longint;var e:string):boolean;//all apps in folder optional subfolders


//Chocolatey procs -------------------------------------------------------------
//xxxxxxxxxxxxxxxxxxxxx//1111111111111111111
function choco__appnameOK(var x:string):boolean;
function choco__appverOK(var x:string):boolean;
function choco__appdesOK(var x:string):boolean;//18apr2025
function choco__appdesOK2(var x:string;xallow_morethan:boolean):boolean;//20apr2025
function choco__urlOK(var x:string):boolean;
function choco__apptagsOK(var x:string):boolean;//keywords
function choco__multi_to_singleline(const x:string):string;
function choco__single_to_multiline(const x:string):string;
function choco__default_license:string;
function choco__default_verification:string;
function choco__form(var xdata:string;var xsavechanges,xduplicatetofolder:boolean;xexelist:tchocolist;sfilelist:tdynamicstring;xduplicatefiles:tfastvars):boolean;
function choco__makeportablepackage(xdata:pobject;xfolder:string;xallfiles,xsubfolders:boolean;xduplicatefiles:tfastvars;var xpromptagain:boolean;var xoutname,e:string):boolean;//18apr2025, 11apr2025
function choco__saveduplicates(dfilename:string;xduplicatefiles:tfastvars;var e:string):boolean;//20apr2025

implementation

{$ifdef gui}
uses
    gossdat;
{$endif}


//info procs -------------------------------------------------------------------
function app__info(xname:string):string;
begin
result:=info__rootfind(xname);
end;

function info__app(xname:string):string;//information specific to this unit of code - 20jul2024: program defaults added, 23jun2024
begin
//defaults
result:='';

try
//init
xname:=strlow(xname);

//get
if      (xname='slogan')              then result:=info__app('name')+' by Blaiz Enterprises'
else if (xname='width')               then result:='920'
else if (xname='height')              then result:='680'
else if (xname='ver')                 then result:='1.00.2677'
else if (xname='date')                then result:='21apr2025'
else if (xname='name')                then result:='Blaiz Tools'
else if (xname='web.name')            then result:='blaiztools'//used for website name
else if (xname='des')                 then result:='Tools for working with the Gossamer codebase and app sourecode'
else if (xname='infoline')            then result:=info__app('name')+#32+info__app('des')+' v'+app__info('ver')+' (c) 1997-'+low__yearstr(2025)+' Blaiz Enterprises'
else if (xname='size')                then result:=low__b(io__filesize64(io__exename),true)
else if (xname='diskname')            then result:=io__extractfilename(io__exename)
else if (xname='service.name')        then result:=info__app('name')
else if (xname='service.displayname') then result:=info__app('service.name')
else if (xname='service.description') then result:=info__app('des')
else if (xname='new.instance')        then result:='1'//1=allow new instance, else=only one instance of app permitted
else if (xname='screensizelimit%')    then result:='95'//95% of screen area
else if (xname='realtimehelp')        then result:='0'//1=show realtime help, 0=don't
else if (xname='hint')                then result:='1'//1=show hints, 0=don't
//.links and values
else if (xname='linkname')            then result:=info__app('name')+' by Blaiz Enterprises.lnk'
else if (xname='linkname.vintage')    then result:=info__app('name')+' (Vintage) by Blaiz Enterprises.lnk'
//.author
else if (xname='author.shortname')    then result:='Blaiz'
else if (xname='author.name')         then result:='Blaiz Enterprises'
else if (xname='portal.name')         then result:='Blaiz Enterprises - Portal'
else if (xname='portal.tep')          then result:=inttostr(tepBE20)
//.software
else if (xname='software.tep')        then result:=inttostr(low__aorb(tepNext20,tepIcon20,sizeof(program_icon20h)>=2))
else if (xname='url.software')        then result:='https://www.blaizenterprises.com/'+info__app('web.name')+'.html'
else if (xname='url.software.zip')    then result:='https://www.blaizenterprises.com/'+info__app('web.name')+'.zip'
//.urls
else if (xname='url.portal')          then result:='https://www.blaizenterprises.com'
else if (xname='url.contact')         then result:='https://www.blaizenterprises.com/contact.html'
else if (xname='url.facebook')        then result:='https://web.facebook.com/blaizenterprises'
else if (xname='url.mastodon')        then result:='https://mastodon.social/@BlaizEnterprises'
else if (xname='url.twitter')         then result:='https://twitter.com/blaizenterprise'
else if (xname='url.x')               then result:=info__app('url.twitter')
else if (xname='url.instagram')       then result:='https://www.instagram.com/blaizenterprises'
else if (xname='url.sourceforge')     then result:='https://sourceforge.net/u/blaiz2023/profile/'
else if (xname='url.github')          then result:='https://github.com/blaiz2023'
//.program/splash
else if (xname='license')             then result:='MIT License'
else if (xname='copyright')           then result:='© 1997-'+low__yearstr(2024)+' Blaiz Enterprises'
else if (xname='splash.web')          then result:='Web Portal: '+app__info('url.portal')

//.program values -> defaults and fallback values
else if (xname='focused.opacity')     then result:='255'//range: 50..255
else if (xname='unfocused.opacity')   then result:='255'//range: 30..255
else if (xname='opacity.speed')       then result:='9'//range: 1..10 (1=slowest, 10=fastest)

else if (xname='head.large')          then result:='1'//1=large window header, 0=small header
else if (xname='head.center')         then result:='0'//1=center window title, 0=left align window title
else if (xname='head.sleek')          then result:='1'//0=normal window head, 1=in head toolbar (sleek)
else if (xname='head.align')          then result:='1'//0=left, 1=center, 2=right -> head based toolbar alignment

else if (xname='scroll.size')         then result:='20'//scrollbar size: 5..72
else if (xname='scroll.minimal')      then result:='1'//0=normal scrollbars, 1=sleek scrollbars
else if (xname='slider.minimal')      then result:='1'//0=normal sliders, 1=sleek sliders

else if (xname='bordersize')          then result:='12'//0..72 - frame size
else if (xname='sparkle')             then result:='7'//0..20 - default sparkle level -> set 1st time app is run, range: 0-20 where 0=off, 10=medium and 20=heavy)
else if (xname='brightness')          then result:='100'//60..130 - default brightness

else if (xname='ecomode')             then result:='0'//1=economy mode on, 0=economy mode off
else if (xname='glow')                then result:='0'//0=off, 1=on
else if (xname='emboss')              then result:='1'//0=off, 1=on
else if (xname='sleek')               then result:='1'//0=off, 1=on
else if (xname='shade.focus')         then result:='1'//1=focus shading for lists/menus etc, 0=flat focus
else if (xname='shade.round')         then result:='1'//curved shading: 0=off, 1=on
else if (xname='color.name')          then result:='black 5'//white 5'//default color scheme name
else if (xname='back.name')           then result:='balls 7'//default background name
else if (xname='frame.name')          then result:='narrow'//default frame name
else if (xname='frame.max')           then result:='1'//0=no frame when maximised, 1=frame when maximised
//.font
else if (xname='font.name')           then result:='Arial'//default GUI font name
else if (xname='font.size')           then result:='10'//default GUI font size
//.font2
else if (xname='font2.use')           then result:='1'//0=don't use, 1=use this font for text boxes (special cases)
else if (xname='font2.name')          then result:='Courier New'
else if (xname='font2.size')          then result:='12'
//.help
else if (xname='help.maxwidth')       then result:='500'//pixels - right column when help shown

//.paid/store support
else if (xname='paid')                then result:='0'//desktop paid status ->  programpaid -> 0=free, 1..N=paid - also works inconjunction with "system_storeapp" and it's cost value to determine PAID status is used within help etc
else if (xname='paid.store')          then result:='1'//store paid status
//.anti-tamper programcode checker - updated dual version (program EXE must be secured using "Blaiz Tools") - 11oct2022
else if (xname='check.mode')          then result:='-91234356'//disable check
//else if (xname='check.mode')          then result:='234897'//enable check
else
   begin
   //nil
   end;

except;end;
end;




//app procs --------------------------------------------------------------------
procedure app__create;
begin
{$ifdef gui}
iapp:=tapp.create;
{$else}

//.starting...
app__writeln('');
//app__writeln('Starting server...');

//.visible - true=live stats, false=standard console output
scn__setvisible(false);


{$endif}
end;

procedure app__destroy;
begin
try
//save
//.save app settings
app__syncandsavesettings;

//free the app
freeobj(@iapp);
except;end;
end;

function app__findcustomtep(xindex:longint;var xdata:tlistptr):boolean;

  procedure m(const x:array of byte);//map array to pointer record
  begin
  {$ifdef gui}
  xdata:=low__maplist(x);
  {$else}
  xdata.count:=0;
  xdata.bytes:=nil;
  {$endif}
  end;
begin//Provide the program with a set of optional custom "tep" images, supports images in the TEA format (binary text image)
//defaults
result:=false;

//sample custom image support

//m(tep_none);
{
case xindex of
5000:m(tep_write32);
5001:m(tep_search32);
end;
}

//successful
//result:=(xdata.count>=1);
end;

function app__syncandsavesettings:boolean;
begin
//defaults
result:=false;
try
//.settings
{
app__ivalset('powerlevel',ipowerlevel);
app__ivalset('ramlimit',iramlimit);
{}


//.save
app__savesettings;

//successful
result:=true;
except;end;
end;

function app__netmore:tnetmore;//optional - return a custom "tnetmore" object for a custom helper object for each network record -> once assigned to a network record, the object remains active and ".clear()" proc is used to reduce memory/clear state info when record is reset/reused
begin
result:=tnetbasic.create;
end;

function app__onmessage(m,w,l:longint):longint;
begin
//defaults
result:=0;
end;

procedure app__onpaintOFF;//called when screen was live and visible but is now not live, and output is back to line by line
begin
//nil
end;

procedure app__onpaint(sw,sh:longint);
begin
//console app only
end;

procedure app__ontimer;
begin
try
//check
if itimerbusy then exit else itimerbusy:=true;//prevent sync errors

//last timer - once only
if app__lasttimer then
   begin

   end;

//check
if not app__running then exit;


//first timer - once only
if app__firsttimer then
   begin

   end;



except;end;
try
itimerbusy:=false;
except;end;
end;


//support procs ----------------------------------------------------------------
function low__findv(xvalue:string):longint;//find value "!v.."
var
   lp,p:longint;
   n:string;
begin
//defaults
result:=0;

try
if (xvalue='') then exit;
//init
n:=xvalue+'.';
lp:=0;
//find
for p:=1 to low__len(n) do
begin
if (strbyte1(n,p)=ssDot) then
   begin
   if (strbyte1(n,p+1)=llv) and (strbyte1(n,p+2)=ssColon) then lp:=p+3
   else if (lp>=1) then
      begin
      result:=strint(strcopy1(n,lp,p-lp));
      break;
      end;
   end;
end;//p
except;end;
end;

procedure sup__start;
begin
//start
if sup_init then exit else sup_init:=true;

//init
sup_data       :=str__new8;
sup_data2      :=str__new8;
sup_image      :=misraw32(1,1);
sup_image2     :=misraw32(1,1);
sup_list       :=tdynamicstring.create;
sup_list2      :=tdynamicstring.create;

//.undo
sup_undoformat :=dtNone;
sup_undo       :=str__new8;

//ready for use
sup_use:=true;
end;

procedure sup__stop;
begin
//stop
if not sup_use then exit else sup_use:=false;

//free
str__free(@sup_data);
str__free(@sup_data2);
freeobj(@sup_image);
freeobj(@sup_image2);
freeobj(@sup_list);
freeobj(@sup_list2);
str__free(@sup_undo);
end;

function sup__data:tstr8;
begin
result:=sup_data;
end;

function sup__data2:tstr8;
begin
result:=sup_data2;
end;

function sup__datalen:longint;
begin
result:=str__len(@sup_data);
end;

function sup__datalen2:longint;
begin
result:=str__len(@sup_data2);
end;

function sup__dataclear:boolean;
begin
result:=true;str__clear(@sup_data);
end;

function sup__dataclear2:boolean;
begin
result:=true;str__clear(@sup_data2);
end;

function sup__datatobase64(dext:string;var e:string):boolean;
var
   etmp:string;
begin
//defaults
result:=false;

//get
if sup__tob64(0,etmp) and sup__data.sins('data:'+sup__extmime(dext)+';base64,',0) then result:=true else etmp:=gecTaskfailed;
if not result then e:=etmp;
end;

function sup__imageclear:boolean;
begin
result:=true;missize(sup_image,1,1);
end;

function sup__imageclear2:boolean;
begin
result:=true;missize(sup_image2,1,1);
end;

function sup__image:trawimage;
begin
result:=sup_image;
end;

function sup__image2:trawimage;
begin
result:=sup_image2;
end;

function sup__imagetodata(dext,daction:string;var e:string):boolean;
var
   etmp:string;
begin
result:=sup__dataclear and mis__todata2(sup_image,@sup_data,dext,daction,etmp);
if not result then e:=etmp;
end;

function sup__datatoimage(var e:string):boolean;
var
   etmp:string;
begin
result:=mis__fromdata(sup_image,@sup_data,etmp);
if not result then e:=etmp;
end;

function sup__imagetemplate(xname:string;dw,dh:longint;dwhite:boolean;var e:string):boolean;
label
   skipend;
var
   a:trawimage;
   s,m:tstr8;
   ds,aw,ah,ddw,ddh:longint;
   xmaskoutline:boolean;

   function etaskfailed:boolean;
   begin
   result:=true;
   e:=gecTaskfailed;
   end;

   function n(x:string):boolean;
   begin
   result:=strmatch(x,xname);
   end;

   function aload(const x:array of byte):boolean;
   var
      etmp:string;
   begin
   s.clear;
   result:=s.aadd(x) and mis__fromdata(a,@s,etmp);
   if not result then e:=etmp;
   end;

   function asizecopy(dw,dh:longint):boolean;
   begin
   result:=missize(sup_image,dw,dh) and miscopyarea32(0,0,dw,dh,misarea(a),sup_image,a);
   if not result then e:=gecTaskfailed;
   end;

   function xmarkmask(var e:string):boolean;
   label
      skipend;
   var
      etmp:string;
      sr32:pcolorrow32;
      dc32:tcolor32;
      dx,dy,dw,dh:longint;
   begin
   //defaults
   result :=false;
   etmp   :=gecTaskfailed;
   dw     :=misw(sup_image);
   dh     :=mish(sup_image);
   dc32   :=inta__c32(low__aorb(clblack,clwhite,dwhite),0);

   try
   //get
   for dy:=0 to (dh-1) do
   begin
   if not misscan32(sup_image,dy,sr32) then goto skipend;
   for dx:=0 to (dw-1) do if (sr32[dx].a=0) then sr32[dx]:=dc32;
   end;//dy

   //successful
   result:=true;
   skipend:
   except;end;
   if not result then e:=etmp;
   end;
begin
//defaults
result:=false;
s     :=nil;
m     :=nil;
a     :=nil;
sup__imageclear;
xmaskoutline:=false;

//range
dw    :=frcmin32(dw,1);
dh    :=frcmin32(dh,1);
ds    :=largest32(dw,dh);

try
//init
s     :=str__new8;
m     :=str__new8;
a     :=misraw32(1,1);

//load template
if n('squircle') then
   begin
   case ds of
   129..maxint:if not aload(template_squircle_2560px) then goto skipend;
   else        if not aload(template_squircle_128px)  then goto skipend;
   end;//case
   xmaskoutline:=true;
   end
else if n('circle') then
   begin
   if not aload(template_circle_2560px)       then goto skipend;
   xmaskoutline:=true;
   end
else if n('square') then
   begin
   missize(a,2560,2560);
   misclsarea3(a,maxarea,0,0,255,255);
   end
else if etaskfailed                           then goto skipend;

//extract mask
if (not mask__todata2(a,@m,clnone)) and etaskfailed then goto skipend;

//crop source image to destination image
if not sup__pasteimage(e)                              then goto skipend;
aw:=misw(a);
ah:=mish(a);
low__scalecrop(aw,ah,misw(sup_image),mish(sup_image),ddw,ddh);
if (not miscopyarea32((aw-ddw) div 2,(ah-ddh) div 2,ddw,ddh,misarea(sup_image),a,sup_image)) and etaskfailed then goto skipend;
if (not mask__fromdata(a,@m)) and etaskfailed          then goto skipend;
if not asizecopy(dw,dh)                                then goto skipend;

if xmaskoutline then
   begin
   misclsarea3(sup_image,area__make(0,0,dw-1,0),0,0,0,0);//top
   misclsarea3(sup_image,area__make(0,dh-1,dw-1,dh-1),0,0,0,0);//bottom
   misclsarea3(sup_image,area__make(0,0,0,dh-1),0,0,0,0);//left
   misclsarea3(sup_image,area__make(dw-1,0,dw-1,dh-1),0,0,0,0);//right
   end;

if not mis__nowhite_noblack(sup_image) and etaskfailed then goto skipend;
if not xmarkmask(e)                                    then goto skipend;

//successful
result:=true;
skipend:
except;end;
//free
str__free(@s);
str__free(@m);
freeobj(@a);
//clear
if not result then sup__imageclear;
end;

function sup__listclear:boolean;
begin
result:=true;sup_list.clear;
end;

function sup__listclear2:boolean;
begin
result:=true;sup_list2.clear;
end;

function sup__undoclear:boolean;
begin
result:=true;
sup_undoformat:=dtNone;
str__clear(@sup_undo);
end;

function sup__canundo:boolean;
begin
result:=(sup_undoformat<>dtNone);
end;

function sup__undohasformat(x:longint):boolean;
begin
result:=(sup_undoformat=x);
end;

function sup__undofill(xformat:longint):boolean;
begin
result:=true;
sup_undoformat:=frcrange32(xformat,0,dtmax);
str__clear(@sup_undo);
sup_undo.add(sup_data);
end;

function sup__undofill2(xformat:longint):boolean;
begin
result:=true;
sup_undoformat:=frcrange32(xformat,0,dtmax);
str__clear(@sup_undo);
sup_undo.add(sup_data2);
end;

function sup__openprompt(const xformatlst:string;var e:string):boolean;
begin
result:=sup__openprompt2(xformatlst,true,e);
end;

function sup__openprompt2(const xformatlst:string;xloadfile:boolean;var e:string):boolean;
var
   etmp:string;
begin
result:=app__gui.popopen3(sup_openfile,sup_openfilter,xformatlst,'','',true);
if not result then e:='';//no error

if result and xloadfile then
   begin
   sup__dataclear;
   result:=io__fromfile(sup_openfile,@sup_data,etmp);
   if not result then e:=etmp;
   end;
end;

function sup__openimageprompt(var e:string):boolean;
var
   etmp:string;
begin
result:=app__gui.popopenimg(sup_openimagefile,sup_openimagefilter,'');
if not result then e:='';//no error

if result then
   begin
   sup__dataclear;
   result:=io__fromfile(sup_openimagefile,@sup_data,etmp);
   if not result then e:=etmp;
   end;
end;

function sup__openimageprompt_browsersupported(var e:string):boolean;
var
   etmp:string;
begin
result:=app__gui.popopen3(sup_openimagefile0,sup_openimagefilter0,pebrowserallimgs,'','',true);
if not result then e:='';//no error

if result then
   begin
   sup__dataclear;
   result:=io__fromfile(sup_openimagefile0,@sup_data,etmp);
   if not result then e:=etmp;
   end;
end;

function sup__uniquename(xsourcefolder,xdestext:string;var xdestfolderORfilename:string):boolean;
begin
result:=true;
xdestfolderORfilename:=io__asfoldernil(io__extractfilepath(xdestfolderORfilename))+low__datetimename2(now)+'__'+io__lastfoldername(xsourcefolder,'Untitled')+insstr('.',xdestext<>'')+xdestext;
end;

function sup__saveprompt(const xformatlst:string;var e:string):boolean;
begin
result:=sup__saveprompt2(xformatlst,false,e);
end;

function sup__saveprompt2(const xformatlst:string;xinsertunitname:boolean;var e:string):boolean;
var
   xaction,df,etmp:string;
begin
//defaults
result   :=false;
xaction  :='';
df       :=strdefb(sup_savefile,sup_openfile);

//prompt
if app__gui.popsave3(df,xformatlst,'','',xaction,true) then
   begin
   //insert Pascal "unit name" here before saving stream
   if xinsertunitname then sup_data.sins('unit '+low__remcharb(io__remlastext(io__extractfilename(df)),#39)+';'+rcode,0);//need unique name here

   //save
   sup_savefile:=df;
   result      :=io__tofile(df,@sup_data,etmp);
   if not result then e:=etmp;
   end
else e:='';//no error
end;

function sup__saveimageprompt(var e:string):boolean;
var
   xaction,df,etmp:string;
begin
//defaults
result   :=false;
xaction  :='';
df       :=strdefb(sup_saveimagefile,sup_openimagefile);

//prompt
if app__gui.popsaveimg(df,'',xaction) then
   begin
   sup_saveimagefile :=df;
   result            :=mis__tofile2(sup__image,sup_saveimagefile,io__lastext(sup_saveimagefile),xaction,etmp);
   if not result then e:=etmp;
   end
else e:='';//no error
end;

function sup__openfolder(xfilterlist:string):boolean;
begin
result:=app__gui.popfolder2(sup_openfolder,xfilterlist,'',true,true);
end;

function sup__tob64(xlinelen:longint;var e:string):boolean;
begin
result:=str__tob642(@sup_data,@sup_data,1,xlinelen);
if not result then e:=gectaskfailed;
end;

function sup__tob642(xlinelen:longint;var e:string):boolean;
begin
result:=str__tob642(@sup_data2,@sup_data2,1,0);
if not result then e:=gectaskfailed;
end;

function sup__compress(var e:string):boolean;
begin
result:=low__compress(@sup_data);
if not result then e:='Compression failed';
end;

function sup__decompress(var e:string):boolean;
begin
result:=low__decompress(@sup_data);
if not result then e:='Decompression failed';
end;

function sup__datacopy12:boolean;//copy data to data2
begin
sup_data2.add(sup_data);
end;

function sup__datacopy21:boolean;//copy data2 to data1
begin
sup_data.add(sup_data2);
end;

function sup__copytext(var e:string):boolean;
begin
result:=clip__copytext(sup_data);
if result then app__gui.popstatus(low__mbAUTO2(str__len(@sup_data),1,true)+' of text copied to Clipboard',1) else e:=gecTaskfailed;
end;

function sup__pastetext(var e:string):boolean;
begin
if clip__canpastetext then
   begin
   sup__dataclear;
   result:=clip__pastetext(sup_data);
   //if result then sup__undofill(dtText) else e:=gecTaskfailed;
   end
else
   begin
   result:=false;
   e:='No text in Clipboard';
   end;
end;

function sup__pastebinary(dimgformat:string;var e:string):boolean;
label
   skipend;
var
   a:trawimage;
   xcantext,xcanimage:boolean;
   etmp:string;
begin
//defaults
result:=false;
a:=nil;

try
//init
xcantext :=clip__canpastetext;
xcanimage:=clip__canpasteimage;

//check
if (not xcantext) and (not xcanimage) then
   begin
   e:='No text or image in Clipboard';
   goto skipend;
   end;

//as text
if (not result) and xcantext then
   begin
   sup__dataclear;

   if clip__pastetext(sup_data) then
      begin
      result:=true;
      //sup__undofill(dtText);
      end
   else
      begin
      e:=gecTaskfailed;
      goto skipend;
      end;
   end;

//as image
if (not result) and xcanimage then
   begin
   a:=misraw32(1,1);
   if not clip__pasteimage(a) then
      begin
      e:=gecTaskfailed;
      goto skipend;
      end;

   //sup__undoclear;
   //sup__undofill(dtImage);

   result:=mis__todata(a,@sup_data,strdefb(dimgformat,'jpg'),etmp);
   if not result then
      begin
      e:=etmp;
      goto skipend;
      end;
   end;

skipend:
except;end;
//free
freeobj(@a);
end;

function sup__copyimage(var e:string):boolean;
begin
result:=clip__copyimage(sup_image,0);
if result then app__gui.popstatus('Image copied to Clipboard',1) else e:=gecTaskfailed;
end;

function sup__copyimage2(var e:string):boolean;
begin
result:=clip__copyimage(sup_image2,0);
if result then app__gui.popstatus('Image copied to Clipboard',1) else e:=gecTaskfailed;
end;

function sup__pasteimage(var e:string):boolean;
begin
//defaults
result:=false;

try
//init
sup__imageclear;

//as image
if clip__canpasteimage then
   begin
   sup__imageclear;

   if clip__pasteimage(sup_image) then result:=true
   else
      begin
      e:=gecTaskfailed;
      sup__imageclear;
      end;

   end
else e:='No image in Clipboard';

except;end;
end;

function sup__insertspace(xspacecount:longint;var e:string):boolean;//insert X (-10..+10) spaces at beginning of each line of text - skip blank lines
label
   redo,skipend;
var
   s,sline:tstr8;
   int1,p,vsmallest,vsplen,spos:longint;
   vsp:string;
   xremove,xonce:boolean;
begin
//defaults
result      :=false;
s           :=nil;
sline       :=nil;

try
//init
xremove:=(xspacecount<0);
if xremove then xspacecount:=-xspacecount;

s        :=str__new8;
sline    :=str__new8;
str__add(@s,@sup_data);
sup__dataclear;
vsp      :=strcopy1('          ',1,frcrange32(xspacecount,0,10));
vsplen   :=low__len(vsp);
//line by line
xonce    :=true;
vsmallest:=5000;

redo:
spos:=0;
while true do
begin
if not low__nextline0(s,sline,spos) then break
else
   begin
   case xremove of
   false:begin//add
      if (str__len(@sline)>=1)           then str__sadd(@sup_data,vsp);
      if not str__add(@sup_data,@sline)  then goto skipend;
      if not str__sadd(@sup_data,rcode) then goto skipend;
      end;
   true:begin//remove
      if (vsplen=0) then
         begin
         //scan for SHORTEST space sequence at beginning of line, excluding blank lines
         if xonce then
            begin
            if (str__len(@sline)>=1) then
               begin
               int1:=0;
               for p:=1 to str__len(@sline) do if (str__bytes1(@sline,p)=ssspace) then int1:=p else break;
               if (int1<vsmallest) then vsmallest:=int1;
               end;
            end
         else
            begin
            if (vsmallest>=1)  and (str__len(@sline)>=1) then str__del3(@sline,0,vsmallest);
            if not str__add(@sup_data,@sline)            then goto skipend;
            if not str__sadd(@sup_data,rcode)           then goto skipend;
            end;
         end
      else
         begin
         if (str__str1(@sline,1,vsplen)=vsp) then str__del3(@sline,0,vsplen);
         if not str__add(@sup_data,@sline)   then goto skipend;
         if not str__sadd(@sup_data,rcode)  then goto skipend;
         end;
      end;
   end;//case
   end;
end;
//special case -> remove all spaces by auto-detection
if xonce and xremove and (vsplen=0) then
   begin
   xonce:=false;
   goto redo;
   end;

//sucessful
result:=true;
skipend:
except;end;
//free
str__free(@s);
str__free(@sline);
end;

function sup__stripwhitespace(xstripleading,xstriptrailing,xstriprcodes,xspaceforstrippedrcode:boolean;var e:string):boolean;
label
   skipend;
var
   s,sline:tstr8;
   spos:longint;
begin
//defaults
result      :=false;
s           :=nil;
sline       :=nil;

//check
if (not xstripleading) and (not xstriptrailing) and (not xstriprcodes) then
   begin
   result:=true;
   exit;
   end;

try
//init
spos     :=0;
s        :=str__new8;
sline    :=str__new8;
str__add(@s,@sup_data);
sup__dataclear;

while low__nextline0(s,sline,spos) do
begin
//get
if      xstripleading and (not xstriptrailing) then str__stripwhitespace(@sline,false)
else if (not xstripleading) and xstriptrailing then str__stripwhitespace(@sline,true)
else if xstripleading and xstriptrailing       then str__stripwhitespace_lt(@sline);

//set
str__add(@sup_data,@sline);
if xstriprcodes then
   begin
   if xspaceforstrippedrcode then str__sadd(@sup_data,#32);
   end
else str__sadd(@sup_data,rcode);
end;

//sucessful
result:=true;
skipend:
except;end;
//error
if not result then e:=gecTaskfailed;
//free
str__free(@s);
str__free(@sline);
end;

function sup__forcereturncodestyle(r10,r13,xinclude_blanklines:boolean):boolean;//force return code style
label
   redo,skipend;
var
   s,sline:tstr8;
   spos:longint;
begin
//defaults
result:=false;
s:=nil;
sline:=nil;

//check -> default to Windows return codes 13+10
if (not r10) and (not r13) then
   begin
   r10:=true;
   r13:=true;
   end;

try
//init
s     :=str__new8;
sline :=str__new8;
str__add(@s,@sup_data);
sup__dataclear;

redo:
spos:=0;
while true do
begin
if not low__nextline0(s,sline,spos) then break
else
   begin
   if xinclude_blanklines or (str__len(@sline)>=1) then
      begin
      if not str__add(@sup_data,@sline)          then goto skipend;
      if r13 and (not str__sadd(@sup_data,#13)) then goto skipend;
      if r10 and (not str__sadd(@sup_data,#10)) then goto skipend;
      end;
   end;
end;

//sucessful
result:=true;
skipend:
except;end;
//free
str__free(@s);
str__free(@sline);
end;

function sup__pre_post_lines(xincludeblanklines,xnumber:boolean;xpre,xpost,xrcode:string;var e:string):boolean;
label
   skipend;
var
   s,sline:tstr8;
   xcount,spos:longint;
begin
//defaults
result      :=false;
s           :=nil;
sline       :=nil;

try
//init
xcount   :=0;
spos     :=0;
s        :=str__new8;
sline    :=str__new8;
str__add(@s,@sup_data);
sup__dataclear;

while low__nextline0(s,sline,spos) do
begin

//only apply to non-blank lines - 20mar2025
if (sline.count>=1) then
   begin
   inc(xcount);
   str__sadd(@sup_data, insstr(k64(xcount),xnumber) +xpre +sline.text+ xpost+ xrcode);
   end
else if xincludeblanklines then str__sadd(@sup_data,xrcode);

end;

//sucessful
result:=true;
skipend:
except;end;
//error
if not result then e:=gecTaskfailed;
//free
str__free(@s);
str__free(@sline);
end;

function sup__removeleadingstr_lines(xscan1,xscan2,xscan3:string;var e:string):boolean;
var
   s,sline:tstr8;
   dlen,xlen1,xlen2,xlen3,spos:longint;
   xline:string;
begin
//defaults
result      :=false;
s           :=nil;
sline       :=nil;

try
//init
spos     :=0;
s        :=str__new8;
sline    :=str__new8;
xlen1    :=low__len(xscan1);
xlen2    :=low__len(xscan2);
xlen3    :=low__len(xscan3);
str__add(@s,@sup_data);
sup__dataclear;


while low__nextline0(s,sline,spos) do
begin
//get
xline:=sline.text;

//decide
if      (xlen1<>0) and strmatch(xscan1,strcopy1(xline,1,xlen1)) then dlen:=xlen1
else if (xlen2<>0) and strmatch(xscan2,strcopy1(xline,1,xlen2)) then dlen:=xlen2
else if (xlen3<>0) and strmatch(xscan3,strcopy1(xline,1,xlen3)) then dlen:=xlen3
else                                                                 dlen:=0;

//set
if (dlen>=1) then str__sadd(@sup_data, strcopy1(xline,dlen+1,low__len(xline)) +rcode )
else              str__sadd(@sup_data, xline +rcode );
end;

//sucessful
result:=true;
except;end;
//error
if not result then e:=gecTaskfailed;
//free
str__free(@s);
str__free(@sline);
end;


function sup__sortlines(xsortAZ:boolean;var e:string):boolean;
label
   skipend;
var
   s:tdynamicstring;
begin
//defaults
result      :=false;
s           :=nil;

try
//init
s        :=tdynamicstring.create;

//get
s.text   :=str__text(@sup_data);

//reduce memory
sup__dataclear;

//sort
s.sort(xsortAZ);

//set
str__settext(@sup_data,s.stext);

//reduce memory
s.clear;

//sucessful
result:=true;
skipend:
except;end;
//error
if not result then e:=gecTaskfailed;
//free
str__free(@s);
end;

function sup__utf8_to_ascii(var e:string):boolean;
var
   s:tstr8;
begin
//defaults
result  :=false;
s       :=nil;

try
//init
s:=str__new8;

//get
str__add(@s,@sup_data);
sup__dataclear;

//set
result:=utf8__toascii(@s,@sup_data,false);
except;end;
//error
if not result then e:=gecTaskfailed;
//free
str__free(@s);
end;

function sup__remdup(xscanpastwhitespace:boolean;var e:string):boolean;
begin
result        :=false;

try
sup_data.text :=low__remdup2(sup_data.text,false,false,xscanpastwhitespace);
result        :=true;
except;end;
//error
if not result then e:=gecTaskfailed;
end;

function sup__zip(var e:string):boolean;
begin
result:=low__compress(@sup_data);
if not result then e:=gecTaskfailed;
end;

function sup__makeuppercase(xup:boolean):boolean;
begin
if xup then sup_data.uppercase else sup_data.lowercase;
end;

function sup__makearray(xname:string;var e:string):boolean;
label
   skipend;
var
   s,dline:tstr8;
   slen,p:longint;
begin
try
//defaults
result :=false;
s      :=nil;
dline  :=nil;

//check
if (sup__datalen<=0) then goto skipend;

//init
s     :=str__new8;
dline :=str__new8;
str__add(@s,@sup_data);
sup__dataclear;
slen  :=str__len(@s);

//start
str__sadd(@sup_data, insstr(xname+rcode,xname<>'') + ':array[0..'+inttostr(slen-1)+'] of byte=('+rcode );

//content
for p:=1 to slen do
begin
str__sadd(@dline,inttostr(byte(s.bytes1[p]))+insstr(',',p<slen));
if (str__len(@dline)>=990) then//was 1015 for Win95 Delphi 3 but lowered to 990 for Win11 Notepad - 19jul2024
   begin
   str__add(@sup_data,@dline);
   str__sadd(@sup_data,rcode);
   str__clear(@dline);
   end;
end;//p

//finalise
str__add(@sup_data,@dline);
str__sadd(@sup_data,');'+rcode);

//successful
result:=true;
skipend:
except;end;
//error
if not result then e:=gecTaskfailed;

//free
str__free(@s);
str__free(@dline);
end;

function sup__makecolors(xname:string):boolean;
var
   x:string;
begin
result:=true;
x:=str__text(@sup_data);
str__settextb(@sup_data,sup__pname('cols_',strdefb(xname,'untitled'))+rcode+low__colorsarray(x,false));
end;

procedure sup__charinfo;
const
   xlimit=100000;//first 100K
var
   a:tstr8;
   v,p:longint;
   x:string;
begin
//defaults
a:=nil;

try
//init
a:=str__new8;

//get
a.sadd('POS      ASCII       CHAR'+rcode);
a.sadd('------   -----       ----'+rcode);

for p:=0 to frcmax32(sup_data.len-1,xlimit) do
begin
v:=sup_data.bytes[p];

a.sadd(
 low__lcolumn(k64(1+p),6)+#32#32#32+
 low__lcolumn(k64(v),3)+ #32#32#32+ #32#32#32+ #32#32#32+ #32#32#32+
 low__lcolumn(low__aorbstr('','('+char(v)+')',(v>=32) and (v<=126)),3)+
 rcode);
end;//p

//show
x:=a.text;
str__clear(@a);
app__gui.poptxt(x,0,'','');
except;end;
//free
str__free(@a);
end;

procedure sup__cleanunitfiles(xfolder:string;xsubfolders:boolean);
label
   skipend;
var
   s,a,aline:tstr8;
   flist:tdynamicstring;
   p,xerrorsfixed,xunitsfixed:longint;
   xresult:boolean;
   e,etmp,sf:string;

   function vbad(x:byte):boolean;
   begin
   case x of
   0..8,11..12,14..31:result:=true;
   else result:=false;
   end;//case
   end;

   function ss(x:longint):string;
   begin
   result:=insstr('s',x<>1);
   end;

   procedure vrembad(x:pobject);
   label
      skipend;
   var
      smin,smax,dmin,dmax,slen,dlen,p:longint;
      smem,dmem:pdlbyte;
      v:byte;
   begin
   try
   //init
   slen:=str__len(x);
   dlen:=0;
   if (slen<=0) then goto skipend;
   smax:=-2;
   smin:=-1;
   dmax:=-2;
   dmin:=-1;

   //get
   for p:=0 to (slen-1) do
   begin
   if (p>smax) and (not block__fastinfo(x,p,smem,smin,smax)) then goto skipend;
   v:=smem[p-smin];
   if not vbad(v) then
      begin
      if (dlen>dmax) and (not block__fastinfo(x,dlen,dmem,dmin,dmax)) then goto skipend;
      dmem[dlen-dmin]:=v;
      inc(dlen);
      end;
   end;//p

   //finalise
   if (dlen<>slen) then str__setlen(x,dlen);

   skipend:
   except;end;
   end;

   function xscan_mustsavechanges:boolean;
   var
      spos,p:longint;
   begin
   //defaults
   result:=false;

   //scan for return code errors
   for p:=0 to (a.len-2) do if vbad(a.pbytes[p]) or ((a.pbytes[p+0]=10) and (a.pbytes[p+1]=10)) or ((a.pbytes[p+0]=13) and (a.pbytes[p+1]=13)) then
      begin
      result:=true;
      inc(xerrorsfixed);
      end;

   //one or more errors need fixing
   if result then
      begin
      inc(xunitsfixed);

      //a -> s
      str__clear(@s);
      str__add(@s,@a);
      str__clear(@a);

      //fill s
      spos:=0;
      while low__nextline0(s,aline,spos) do
      begin
      vrembad(@aline);
      str__add(@a,@aline);
      str__sadd(@a,rcode);
      end;//loop

      //reset
      str__clear(@s);
      str__clear(@aline);
      end;
   end;
begin
//defaults
e              :='';
a              :=nil;
aline          :=nil;
s              :=nil;
flist          :=nil;
xerrorsfixed   :=0;
xunitsfixed    :=0;
app__gui.xstatusstart3(3,tbL100_L,true);
app__gui.xstatustext[0]:='Folder'+#9;
app__gui.xstatustext[1]:='Unit'+#9;
app__gui.xstatustext[2]:='Errors';
app__gui.xstatus(0,'Fixing units...');

try
//range
xfolder:=io__asfolderNIL(xfolder);

//check
if not io__folderexists(xfolder) then
   begin
   e:='Folder not found: '+xfolder;
   goto skipend;
   end;

//init
flist:=tdynamicstring.create;

//.filelist
if not io__filelist1(flist,false,xsubfolders,xfolder,'*.pas;*.dpr;','') then
   begin
   e:=gecOutofmemory;
   goto skipend;
   end;

//.vars
a     :=str__new8;
aline :=str__new8;
s     :=str__new8;


//scan and fix
for p:=0 to (flist.count-1) do
begin
sf:=xfolder+flist.value[p];

//get
if not io__fromfile(sf,@a,etmp) then
   begin
   e:=etmp;
   goto skipend;
   end;

//scan and fix
if xscan_mustsavechanges then
   begin
   if not io__tofile(sf,@a,etmp) then
      begin
      e:=etmp;
      goto skipend;
      end;
   end;

app__gui.xstatuspert:=low__ipercentage((p+1),flist.count);
app__gui.xstatustext[0]:='Folder'+#9+io__extractfilepath(sf);
app__gui.xstatustext[1]:='Unit'+#9+io__extractfilename(sf);
app__gui.xstatustext[2]:='Errors'+#9+k64(xerrorsfixed);

if app__gui.xstatustopped then
   begin
   e:='!';
   goto skipend;
   end;

end;//p

//sucessful
skipend:
except;end;
try
//stop status
app__gui.xstatusstop;

//free
freeobj(@a);
freeobj(@aline);
freeobj(@s);
freeobj(@flist);

//show report
if (e='!') then
   begin
   //cancelled do nothing
   end
else if (e='') then
   begin
   if (xerrorsfixed=0) then app__gui.popmsg('','No errors detected.')
   else app__gui.popmsg('',k64(xerrorsfixed)+' error'+ss(xerrorsfixed)+' in '+k64(xunitsfixed)+' unit'+ss(xunitsfixed)+' were detected and fixed.');
   end
else app__gui.poperror('',e);//errpr
except;end;
end;

function sup__packfiles(xfolder:string;xsubfolders:boolean;var e:string):boolean;
label
   skipend;
var
   xlist:tstr8;
   df:string;
begin
//defaults
result :=false;
xlist  :=nil;

try
//init
sup__dataclear;
xlist:=str__new8;

//start
if not zip__start(sup_data,xlist) then goto skipend;

case xsubfolders of
true:app__gui.popstatus('Packing "'+io__lastfoldername(xfolder,'')+'" and sub-folders...',1);
else app__gui.popstatus('Packing files for "'+io__lastfoldername(xfolder,'')+'"...',1);
end;

//get
zip__addfromfolder2(sup_data,xlist,xfolder,'*','',xsubfolders);//ignore errors

//stop
if not zip__stop(sup_data,xlist) then goto skipend;

//successful
result:=true;
skipend:
except;end;
//error
if not result then e:=gecTaskfailed;

//free
str__free(@xlist);
end;

function sup__packfiles_makeunit(xfolder,xincludemask,xexcludemask:string;xcompress,xsubfolders:boolean;var e:string):boolean;
label
   skipend;
var
   uhead,udata:tstr8;
   flist:tdynamicstring;
   p,xcount:longint;
   xresult:boolean;
   etmp:string;

   function xmemory:comp;
   begin
   result:=add64(uhead.datalen,udata.datalen);
   end;

   procedure hadd(x:string);
   begin
   uhead.sadd(x+rcode);
   end;

   procedure dadd(x:string);
   begin
   sup_data.sadd(x+rcode);
   end;

   function xpackfile(const xfolder,xpathfile:string):boolean;
   label
      skipend;
   var
      xname:string;
   begin
   //defaults
   result:=false;

   try
   xname:='file__'+intstr32(xcount);

   //load
   if not io__fromfile(xfolder+xpathfile,@sup_data,etmp) then
      begin
      e:=etmp;
      goto skipend;
      end;

   //compress
   if xcompress and (not low__compress(@sup_data)) then
      begin
      e:=gecTaskfailed;
      goto skipend;
      end;

   //convert into array
   if not sup__makearray(xname,e) then goto skipend;

   //add to body
   udata.sadd(rcode);
   udata.sadd(rcode);
   udata.sadd('//file: '+xpathfile+rcode);
   udata.add(sup_data);

   //add to head
   hadd(intstr32(xcount)+':xset('+xname+','+low__aorbstr('false','true',xcompress)+','+#39+low__remcharb(xpathfile,#39)+#39+');');

   //inc
   inc(xcount);

   //successful
   result:=true;
   skipend:
   except;e:=gecTaskfailed;end;
   sup__dataclear;
   end;
begin
//defaults
e              :='';
uhead          :=nil;
udata          :=nil;
xcount         :=0;
app__gui.xstatusstart3(3,tbL100_L,true);
app__gui.xstatustext[0]:='Folder'+#9;
app__gui.xstatustext[1]:='File'+#9;
app__gui.xstatustext[2]:='Memory'+#9;
app__gui.xstatus(0,'Packing files...');

try
//range
xfolder:=io__asfolderNIL(xfolder);

//check
if not io__folderexists(xfolder) then
   begin
   e:='Folder not found: '+xfolder;
   goto skipend;
   end;

//init
flist:=tdynamicstring.create;

//.filelist
if not io__filelist1(flist,false,xsubfolders,xfolder,xincludemask,xexcludemask) then
   begin
   e:=gecOutofmemory;
   goto skipend;
   end;

//.vars
uhead :=str__new8;
udata :=str__new8;


//get
hadd('');
hadd('function storage__findfile(xindex:longint;var xdata:pointer;var xdatalen:longint;var xcompressed:boolean;var xpathname:string):boolean;');
hadd('   procedure xset(const fdata:array of byte;fcompressed:boolean;const fpathname:string);');
hadd('   begin');
hadd('   result     :=true;');
hadd('   xdata      :=@fdata;');
hadd('   xdatalen   :=high(fdata)+1;');
hadd('   xcompressed:=fcompressed;');
hadd('   xpathname  :=fpathname;');
hadd('   end;');
hadd('begin');
hadd('//defaults');
hadd('result:=false;');
hadd('');
hadd('//find');
hadd('case xindex of');

for p:=0 to (flist.count-1) do
begin

//status
app__gui.xstatuspert:=low__ipercentage((p+1),flist.count);
app__gui.xstatustext[0]:='Folder'+#9+io__extractfilepath(xfolder+flist.value[p]);
app__gui.xstatustext[1]:='File'+#9+io__extractfilename(xfolder+flist.value[p]);
app__gui.xstatustext[2]:='Memory'+#9+low__mbauto(xmemory,true);

if app__gui.xstatustopped then
   begin
   e:='';
   goto skipend;
   end;

//pack file
if not xpackfile(xfolder,flist.value[p]) then goto skipend;

end;//p

//finalise
hadd('end;//case'+rcode);
hadd(rcode);
hadd('end;');
hadd(rcode);
hadd('end.');


//set
sup__dataclear;
//.head
dadd('');
dadd('interface');
dadd('');
dadd('function storage__findfile(xindex:longint;var xdata:pointer;var xdatalen:longint;var xcompressed:boolean;var xpathname:string):boolean;');
dadd('');
dadd('implementation');
dadd('');
dadd('const');
dadd('');
//.body
str__add(@sup_data,@udata);
str__clear(@udata);
//.head (function at bottom)
str__add(@sup_data,@uhead);
str__clear(@uhead);

//sucessful
result:=true;
skipend:
except;e:=gecTaskfailed;end;
try
//stop status
app__gui.xstatusstop;
//free
str__free(@uhead);
str__free(@udata);
freeobj(@flist);
except;end;
end;

function sup__cleanproject(xfolder:string;xsubfolders:boolean;var xcount:longint;var e:string):boolean;
label//note: copies contents of folder to a sub-folder "clean" removing unwanted files "*.dcu;*.~pa;*.ini"
   skipend;
var
   flist:tdynamicstring;
   p:longint;
   sf,df,sfolder,slastfolder,dfolder,etmp:string;

   function xpathhasCLEANinname(afolder:string):boolean;
   var
      p:longint;
   begin
   result:=false;

   if (afolder<>'') then for p:=1 to (low__len(afolder)-6) do if (afolder[p-1+stroffset]='\') and strmatch(strcopy1(afolder,p,7),'\clean\') then
      begin
      result:=true;
      break;
      end;

   end;

   function dfolderclear:boolean;
   label
      skipend;
   var
      alist:tdynamicstring;
      p:longint;
   begin
   //defaults
   result:=false;
   alist :=nil;

   //check
   if (dfolder='') then
      begin
      result:=true;
      exit;
      end;

   try
   //init
   alist:=tdynamicstring.create;

   //get
   io__filelist1(alist,false,false,dfolder,'*','');

   //clear
   for p:=0 to (alist.count-1) do if not io__remfile(dfolder+alist.value[p]) then goto skipend;

   //successful
   result:=true;
   skipend:
   except;end;
   //free
   freeobj(@alist);
   end;
begin
//defaults
result:=false;
xcount:=0;

try
//range
xfolder:=io__asfolderNIL(xfolder);

//check
if not io__folderexists(xfolder) then
   begin
   e:='Folder not found: '+xfolder;
   goto skipend;
   end;

if xpathhasCLEANinname(xfolder) then
   begin
   e:='Folder cannot be cleaned as it already contains a sub-folder "clean" in it''s name.';
   goto skipend;
   end;

//status
app__gui.popstatus('Cleaning project folder "'+io__lastfoldername(xfolder,'')+'"'+insstr(' and sub-folders',xsubfolders)+'...',1);

//init
flist:=tdynamicstring.create;

if not io__filelist1(flist,false,xsubfolders,xfolder,'*','*.dcu;*.~pa;*.ini;*bethumbs.db;.choco-package-info.txt;') then
   begin
   e:=gecOutofmemory;
   goto skipend;
   end;

//copy files to dfolder
slastfolder:='';
dfolder    :='';

for p:=0 to (flist.count-1) do
begin
sf     :=xfolder+flist.value[p];
sfolder:=io__asfolder(io__extractfilepath(sf));

//.jump over folders that are named "clean"
if not xpathhasCLEANinname(sfolder) then
   begin

   //.create new folder "clean"
   if not strmatch(slastfolder,sfolder) then
      begin
      slastfolder :=sfolder;
      dfolder     :=io__asfolder(sfolder+'clean');

      //make dfolder
      if not io__makefolder(dfolder) then
         begin
         e:='Failed to create folder:'+rcode+dfolder;
         goto skipend;
         end;

      //clean dfolder if already exists
      if not dfolderclear then
         begin
         e:='Failed to clean folder:'+rcode+dfolder;
         goto skipend;
         end;

      inc(xcount);
      end;

   //.destination filename
   df:=dfolder+strlow(io__extractfilename(sf));//and make lowercase filenames

   if not io__copyfile(sf,df,etmp) then
      begin
      e:=etmp;
      goto skipend;
      end;
   end;

end;//p

//successful
result:=true;
skipend:
except;end;
end;

function sup__inlist(x:string;const xlist:array of string;xtruewhenlistempty:boolean):boolean;
var
   p:longint;
begin
//defaults
result:=false;

//list considered empty when first list item is empty
if (xlist[0]='') then result:=xtruewhenlistempty
else
   begin

   for p:=0 to high(xlist) do if strmatch(x,xlist[p]) then
      begin
      result:=true;
      break;
      end;

   end;
end;

function sup__pname(xpre,x:string):string;
begin
result:=sup__pascallabel(xpre+io__extractfilename(x));
end;

function sup__pascallabel(x:string):string;//0..9, A..Z, a..z, "_"
var//Note: cannot start with a number, in this case use an underscore "_"
   p:longint;
   c:char;
   procedure r(x:char);
   begin
   result:=result+x;
   end;
begin
//defaults
result:='';

//get
for p:=1 to low__len(x) do
begin
c:=x[p-1+stroffset];

case byte(c) of
48..57,65..90,97..122:r(c);
else r('_');
end;//case
end;//p

if (result<>'') and ((result[stroffset]>='0') and (result[stroffset]<='9')) then result:='_'+result;
end;

function sup__extlabel(xext:string):string;
begin
result:=sup__extlabel2(xext,false);
end;

function sup__extlabel2(xext:string;xlongname:boolean):string;
var
   xmime:string;
   xtep :longint;
begin
sup__extinfo(xext,xlongname,result,xmime,xtep);
end;

function sup__extmime(xext:string):string;
var
   xlabel:string;
   xtep  :longint;
begin
sup__extinfo(xext,false,xlabel,result,xtep);
end;

function sup__extbrowsersupported(xext:string):boolean;
begin
xext:=strlow(xext);
result:=
 (xext='bmp') or (xext='jpg') or (xext='jif') or (xext='jpeg') or (xext='png') or (xext='gif') or (xext='ico') or
 (xext='txt') or (xext='htm') or (xext='html');
end;

function sup__extinfo(xext:string;xlongname:boolean;var xlabel,xmime:string;var xtep:longint):boolean;
   function m(x:string):boolean;
   begin
   result:=strmatch(x,xext);
   end;

   procedure s2(dtep:longint;dshort,dlong,dmime:string);
   begin
   if xlongname then xlabel:=strdefb(dlong,dshort) else xlabel:=strdefb(dshort,dlong);
   if (dmime='') then dmime:='application/x-'+strlow(xext);

   xtep   :=dtep;
   xmime  :=dmime;
   result :=(xlabel<>'');
   end;

   procedure s(xtep:longint;xshort,dmime:string);
   begin
   s2(xtep,xshort,xshort,dmime);
   end;

   procedure simage(dext,dmime:string);
   begin
   if (dmime='') then dmime:='image/x-'+strlow(xext);
   s(tepBMP20,strup(strdefb(dext,xext))+' Image',dmime);
   end;

   procedure sdoc(dtep:longint;dext,dmime:string);
   begin
   if (dmime='') then dmime:='application/x-'+strlow(xext);
   s(dtep,strup(strdefb(dext,xext))+' Document',dmime);
   end;
begin
//defaults
result:=true;

//get

if      m('jpg')    then simage('JPEG','image/jpeg')
else if m('jif')    then simage('JPEG','image/jpeg')
else if m('jpeg')   then simage('JPEG','image/jpeg')
else if m('png')    then simage('','image/png')
else if m('tea')    then simage('','')
else if m('ico')    then simage('','image/x-icon')
else if m('gif')    then simage('','image/gif')
else if m('tga')    then simage('','image/x-tga')
else if m('bmp')    then simage('','image/bmp')

else if m('tif')    then simage('','image/tiff')
else if m('tiff')   then simage('','image/tiff')

else if m('ppm')    then simage('','')
else if m('pgm')    then simage('','')
else if m('pbm')    then simage('','')
else if m('pnm')    then simage('','')
else if m('img32')  then simage('','')
else if m('tj32')   then simage('','')
else if m('txt')    then sdoc(tepTXT20,'','text/plain')
else if m('ini')    then sdoc(tepTXT20,'','text/plain')
else if m('log')    then sdoc(tepTXT20,'','text/plain')
else if m('css')    then sdoc(tepTXT20,'','text/css')
else if m('xml')    then sdoc(tepTXT20,'','text/xml')
else if m('eml')    then sdoc(tepTXT20,'','message/rfc822')
else if m('htm')    then sdoc(tepTXT20,'','text/html')
else if m('html')   then sdoc(tepTXT20,'','text/html')
else if m('xhtm')   then sdoc(tepTXT20,'','application/xhtml+xml')
else if m('xhtml')  then sdoc(tepTXT20,'','application/xhtml+xml')
else if m('text')   then sdoc(tepTXT20,'','text/plain')
else if m('rtf')    then sdoc(tepTXT20,'','application/rtf')

else if m('pdf')    then sdoc(tepTXT20,'','application/pdf')
else if m('pl')     then sdoc(tepTXT20,'','application/x-perl')
else if m('js')     then sdoc(tepTXT20,'','application/x-javascript')
else if m('mocha')  then sdoc(tepTXT20,'','application/x-javascript')

else if m('bwd')    then sdoc(tepBWD20,'','')
else if m('bwp')    then sdoc(tepBWP20,'','')

else if m('tar')    then sdoc(tepZIP20,'','application/x-tar')
else if m('zip')    then sdoc(tepZIP20,'','application/x-compress')
else if m('z')      then sdoc(tepZIP20,'','application/zip')
else if m('7z')     then sdoc(tepZIP20,'','application/x-7z-compressed')
else if m('gz')     then sdoc(tepZIP20,'','application/x-gzip')

else if m('wav')    then sdoc(tepWMA20,'','audio/wav')
else if m('weba')   then sdoc(tepWMA20,'','audio/webm')
else if m('webm')   then sdoc(tepXXX20,'','video/webm')
else if m('webp')   then sdoc(tepBMP20,'','image/webp')
else if m('wma')    then sdoc(tepWMA20,'','audio/x-ms-wma')

else if m('mkv')    then sdoc(tepXXX20,'','video/x-matroska')
else if m('mp3')    then sdoc(tepWMA20,'','audio/mpeg')
else if m('mp4')    then sdoc(tepXXX20,'','video/mp4')

else if m('mid')    then sdoc(tepMID20,'','audio/midi')
else if m('midi')   then sdoc(tepMID20,'','audio/midi')

else                     s(tepTXT20,'','');

end;

function sup__labelsep:string;
begin
result:=cs_capsep;
end;

function sup__label2(v1,v2:string):string;
begin
result:=v1+sup__labelsep+v2;
end;

function sup__label3(v1,v2,v3:string):string;
begin
result:=v1+sup__labelsep+v2+sup__labelsep+v3;
end;

function sup__imageext:string;
begin
result:=sup_imageext;
end;

function sup__imageextU:string;
begin
result:=strup(sup_imageext);
end;

function sup__imagetep:longint;
begin
result:=sup_imagetep;
end;

function sup__imagemime:string;
begin
result:=sup_imagemime;
end;

function sup__imagelabel:string;
begin
result:=sup_imagelabel;
end;

function sup__imagelist(xreset:boolean):boolean;//cycle through supported image list of extensions
   procedure s(dext:string);
   begin
   sup_imageext   :=strlow(dext);
   sup__extinfo(sup_imageext,false,sup_imagelabel,sup_imagemime,sup_imagetep);
   end;
begin
//reset
if xreset then
   begin
   sup_imageindex:=0;
   sup_imageext  :='';
   sup_imagemime :='';
   sup_imagelabel:='';
   end;

//next image ext in list
case sup_imageindex of
 0:s('jpg');
 1:s('png');
 2:s('tea');
 3:s('gif');
 4:s('tga');
 5:s('ico');
 6:s('bmp');
 7:s('ppm');
 8:s('pgm');
 9:s('pbm');
10:s('pnm');
11:s('img32');
12:s('tj32');
end;//case

//successful
result:=(sup_imageindex<=12);

//inc
if result and (not xreset) then inc(sup_imageindex);
end;

function sup__docext:string;
begin
result:=sup_docext;
end;

function sup__docextU:string;
begin
result:=strup(sup_docext);
end;

function sup__doctep:longint;
begin
result:=sup_doctep;
end;

function sup__docmime:string;
begin
result:=sup_docmime;
end;

function sup__doclabel:string;
begin
result:=sup_doclabel;
end;

function sup__doclist(xreset:boolean):boolean;//cycle through supported doc list of extensions
   procedure s(dext:string);
   begin
   sup_docext   :=strlow(dext);
   sup__extinfo(sup_docext,false,sup_doclabel,sup_docmime,sup_doctep);
   end;
begin
//reset
if xreset then
   begin
   sup_docindex:=0;
   sup_docext  :='';
   sup_docmime :='';
   sup_doclabel:='';
   end;

//next doc ext in list
case sup_docindex of
 0:s('txt');
 1:s('bwd');
 2:s('bwp');
end;//case

//successful
result:=(sup_docindex<=2);

//inc
if result and (not xreset) then inc(sup_docindex);
end;

procedure sup__markduplicate_procnames(sfilename:string;snamepartafterDualunderscore,xsubfolders:boolean);//19mar2025
label
   skipend;
var
   flist:tdynamicstring;
   slist,plist,phint:tlitestrings;
   int1,int2,p,scount,pcount,duptotal,pdupcount,fdupcount,xunitcount:longint;
   str1,e,f:string;

   function xs(xcount:longint):string;//insert "s"
   begin
   result:=insstr('s',xcount<>1)
   end;

   function pfind(x:string;var xhint:string):boolean;
   var
      p:longint;
   begin
   result:=false;
   xhint:='';
   if (pcount>=1) then
      begin
//      for p:=0 to (pcount-1) do if strmatch(x,plist.items[p]^) then
      for p:=0 to (pcount-1) do if strmatch(x,plist.value[p]) then
         begin
//         xhint:=phint.items[p]^;
         xhint:=phint.value[p];
         result:=true;
         break;
         end;//p
      end;
   end;

   function xisproc(xline:string;var ximplementation:boolean;xnamepartafterDualunderscore:boolean;var xval:string):boolean;
   var
      dlen,p:longint;
      v:string;
      c,lc:char;
   begin
   //defaults
   result:=false;
   xval:='';
   v:='';

   //scan for "implementation"
   if not ximplementation then
      begin
      if strmatch(xline,'implementation') or strmatch(strcopy1(xline,1,15),'implementation ') or strmatch(strcopy1(xline,1,15),'implementation'+#9) then ximplementation:=true;
      //.don't start reading proc names until AFTER we've passed Pascal's "implementation" keyword
      if not ximplementation then exit;
      end;

   //scan
   if (low__len(xline)>=10) and ( strmatch(strcopy1(xline,1,9),'function ') or strmatch(strcopy1(xline,1,10),'procedure ') ) then
      begin

      //stop at end of name "(" or ";" or ":"
      for p:=9 to low__len(xline) do
      begin
      c:=xline[p-1+stroffset];
      if (c='(') or (c=';') or (c=':') then
         begin
         v:=strcopy1(xline,1,p-1);
         break;
         end;
      end;//p


      //use name part at and after dual underscore -> e.g. "low__fromfile" and "io__fromfile" both become "__fromfile" for better duplication detection - 23jul2024
      if xnamepartafterDualunderscore and(v<>'') then
         begin
         int1:=low__len(v);
         if (int1>=2) then
            begin
            for p:=1 to (int1-1) do
            begin
            if (v[p-1+stroffset]='_') and (v[p+0+stroffset]='_') then
               begin
               v:=strcopy1(v,p,int1);
               break;
               end;
            end;//p
            end;//if
         end;//if


      //clean
      if (v<>'') then
         begin
         //init
         dlen:=0;
         xval:=v;
         lc:=#0;
         //get
         for p:=1 to low__len(v) do
         begin
         c:=v[p-1+stroffset];
         if (c=#9) then c:=#32;

         if (c<>#32) or (lc<>#32) then
            begin
            inc(dlen);
            xval[dlen-1+stroffset]:=c;
            end;

         lc:=c;
         end;//p

         //trim xval
         if (dlen<>low__len(xval)) then xval:=strcopy1(xval,1,dlen);

         //successful
         result:=(xval<>'');
         end;
      end;
   end;

   procedure paddfromfile(x:string;dlist,dlisthint:tlitestrings;var dcount,pdupcount,fdupcount:longint;xmarkcode:boolean);
   label
      skipend;
   var
      xhintname,xline,xlastline,v,vhint,e:string;
      a,aline:tstr8;
      apos:longint;
      bol1,ximplementation:boolean;
   begin
   try
   //defaults
   pdupcount:=0;
   fdupcount:=0;
   a        :=nil;
   aline    :=nil;

   //check
   if not io__fileexists(x) then exit;
   if (dlist=nil) then exit;
   if (dcount<0) then dcount:=0;
   xhintname:=strcopy1(x,1+low__len(io__asfolder(io__extractfilepath(sfilename))),low__len(x));

   //init
   a    :=str__new8;
   aline:=str__new8;
   apos:=0;
   ximplementation:=false;
   xlastline:='';

   //get
   if not io__fromfile(x,@a,e) then goto skipend;

   //scan source code (*.pas) files and add cleaned procedure and function names inside of plist
   while true do
   begin
   if not low__nextline0(a,aline,apos) then break;
   xline:=str__text(@aline);

   if xisproc(xline,ximplementation,snamepartafterDualunderscore,v) then
      begin
      if xmarkcode then
         begin
         if pfind(v,vhint) then
            begin
            bol1:=strmatch(strcopy1(v,1,9),'procedure');
            if bol1 then inc(pdupcount) else inc(fdupcount);
            dlist.value[dcount]:='//duplicate '+low__aorbstr('function','procedure',bol1)+' found in "'+vhint+'"';
            inc(dcount);
            end;
         end
      else
         begin
         dlist.value[dcount]:=v;
         if (dlisthint<>nil) then dlisthint.value[dcount]:=xhintname;
         inc(dcount);
         end;
      end;

   if xmarkcode then
      begin
      dlist.value[dcount]:=xline;
      inc(dcount);
      end;
   end;//loop
   

   skipend:
   except;end;
   //free
   str__free(@a);
   str__free(@aline);
   end;
begin
try
//sfilename:='c:\temp_code\gossgui.pas';
//defaults
e:='';
flist:=nil;
slist:=nil;
plist:=nil;
phint:=nil;
scount:=0;
pcount:=0;
xunitcount:=0;

//start status
app__gui.xstatusstart3(2,tbL100_L,true);
app__gui.xstatustext[0]:='Folder'+#9;
app__gui.xstatustext[1]:='Unit'+#9;
app__gui.xstatus(0,'Loading units...');


//check
if not io__fileexists(sfilename) then
   begin
   e:=gecFilenotfound;
   goto skipend;
   end;

//init
flist:=tdynamicstring.create;
slist:=tlitestrings.create;
plist:=tlitestrings.create;
phint:=tlitestrings.create;

//get a list of the project's "*.pas" files (same folder as sfilename)
if not io__filelist1(flist,true,xsubfolders,io__extractfilepath(sfilename),'*.pas','') then
   begin
   e:=gecTaskfailed;
   goto skipend;
   end;

//build list of project's procs and funcs for all files EXCEPT sfilename and store in "plist"
for p:=0 to (flist.count-1) do
begin
f:=flist.value[p];
if io__fileexists(f) and (not strmatch(f,sfilename)) then
   begin

   app__gui.xstatuspert:=low__ipercentage((p+1),flist.count);
   app__gui.xstatustext[0]:='Folder'+#9+io__extractfilepath(f);
   app__gui.xstatustext[1]:='Unit'+#9+io__extractfilename(f);

   if app__gui.xstatustopped then
      begin
      e:='';
      goto skipend;
      end;

   paddfromfile(f,plist,phint,pcount,int1,int2,false);
   inc(xunitcount);
   end;
end;//p


//build list of source file's procs and funcs "sfilename"
app__gui.xstatusstop;
app__gui.popstatus('Scanning for duplicates...',1);

paddfromfile(sfilename,slist,nil,scount,pdupcount,fdupcount,true);
duptotal:=pdupcount+fdupcount;

//.copy modified code to clipboard
try
if (duptotal>=1) then clip__copytext2b(slist.text);
except;
app__gui.poperror('',gecTaskfailed);
end;

//.prompt user with result
str1:=k64(xunitcount)+' pascal unit'+xs(xunitcount)+' scanned.  ';

case (duptotal>=1) of
true:begin
   app__gui.popmsg('Scan Result',
   str1+
     insstr(k64(pdupcount)+' duplicate procedure'+xs(pdupcount),pdupcount>=1)+
     insstr(' and ',(pdupcount>=1) and (fdupcount>=1))+
     insstr(k64(fdupcount)+' duplicate function'+xs(fdupcount),fdupcount>=1)+
     ' found and marked in source code.'+rcode+
   rcode+
   'Modified source code is in Clipboard.  Search the source code for comments beginning with "//duplicate" to find each marked procedure and function and it''s source of duplication.'
   );
   end;
false:app__gui.popmsg('Scan Result',str1+'No duplicate procedures or functions present.');
end;

skipend:
except;end;
try
freeobj(@flist);
freeobj(@slist);
freeobj(@plist);
freeobj(@phint);
app__gui.xstatusstop;
if (e<>'') then app__gui.popstatus(e,2);
except;end;
end;

function sup__manipulatetext(n:string;var e:string):boolean;
label
   skipend;
var
   v:string;

   function m(x:string):boolean;
   begin
   result:=strmatch(x,n);
   end;

   function mv(x:string):boolean;
   begin
   result:=strmatch(x,strcopy1(n,1,low__len(x)));
   if result then v:=strcopy1(n,low__len(x)+1,low__len(n)) else v:='';
   end;

   procedure xlines;
   label
      skipone;
   var
      xline,n:string;
      s,sline:tstr8;
      spos:longint;

      procedure xpromptval(var x:string);
      var
         str1:string;
      begin
      str1:=x;
      if app__gui.popedit(str1,'Set value to apply','') then x:=str1;
      end;
   begin
   //defaults
   s     :=nil;
   sline :=nil;

   //init
   spos  :=0;
   n     :=strlow(v);
   s     :=str__new8;
   sline :=str__new8;
   str__add(@s,@sup_data);
   sup__dataclear;

   //prompt
   if      (n='preadd')  then xpromptval(sup_preval)
   else if (n='postadd') then xpromptval(sup_postval)
   else
      begin
      //nil
      end;

   //get
   while low__nextline0(s,sline,spos) do
   begin
   xline:=stripwhitespace_lt(sline.text);

   //decide
   if      (n='filepath')   then xline:=io__asfolderNIL(io__extractfilepath(xline))//24mar2025
   else if (n='filename')   then xline:=io__extractfilename(xline)
   else if (n='nameonly')   then xline:=io__remlastext(io__extractfilename(xline))
   else if (n='preadd')     then xline:=sup_preval+xline
   else if (n='postadd')    then xline:=xline+sup_postval
   else if (n='commalist')  then
      begin
      low__remchar(xline,',');
      sup_data.sadd( insstr(',',sup_data.len>=1) + xline );
      goto skipone;
      end
   else if (n='commalists') then//single quotes
      begin
      low__remchar(xline,',');
      low__remchar(xline,#39);
      sup_data.sadd( insstr(',',sup_data.len>=1) + #39 + xline + #39 );
      goto skipone;
      end
   else if (n='commalistd') then//double quotes
      begin
      low__remchar(xline,',');
      low__remchar(xline,#34);
      sup_data.sadd( insstr(',',sup_data.len>=1) + #34 + xline + #34 );
      goto skipone;
      end
   else
      begin
      //nil
      end;

   //add
   sup_data.sadd(xline+rcode);
   skipone:
   end;//loop

   end;
begin
//defaults
result:=false;

try
//get
if      m('up')      then sup__data.uppercase
else if m('low')     then sup__data.lowercase
else if mv('lines.') then xlines
else
   begin
   e:='Text manipulation command "'+n+'" not supported';
   goto skipend;
   end;

//successful
result:=true;
skipend:
except;e:=gecTaskfailed;end;
end;

function sup__listofsizes(var xpos,xsize:longint):boolean;
begin
//defaults
result :=true;
xsize  :=128;

//range
if (xpos<0) then xpos:=0;

//get
case xpos of
0:xsize:=2560;
1:xsize:=1024;
2:xsize:=512;
3:xsize:=430;
4:xsize:=400;
5:xsize:=256;
6:xsize:=208;
7:xsize:=157;
8:xsize:=128;
else result:=false;
end;//case

inc(xpos);
end;


//Delphi to Lazarus project conversion procs -----------------------------------
procedure d2laz__makeproject(xall:boolean);//this app
var
   e:string;
   int1:longint;

   procedure se(xok:boolean);
   begin
   if xok then showbasic('Delphi conversion successful')
   else        showerror('Delphi to Lazarus project conversion failed: '+e);
   end;
begin
case xall of
true:se(d2laz__makeproject3(app__rootfolder,false,int1,e));
else se(d2laz__makeproject2(io__remlastext(io__exename)+'.dpr',e));
end;//case
end;

function d2laz__makeproject2(xfilename:string;var e:string):boolean;//a specific app -> expects a ".dpr" filename - 30mar2025, 21mar2025
label
   skipend;
var
   a:tstr8;
   b:tdynamicstring;
   xprojectbody,xconditionals,xext,xfolder,xname,xtitle,xdes:string;
   xguimode,xmainpas,xgossroot:boolean;

   function xclean(x:string):string;
   begin
   result:=x;
   swapchars(result,'"',#39);
   end;

   function xpullval(var xdata:string;var xpos:longint;var xval:string):boolean;
   label
      redo;
   var
      xlen,lp:longint;
   begin
   //defaults
   result:=false;

   //range
   if (xpos<1) then xpos:=1;

   //init
   xlen:=low__len(xdata);
   lp  :=xpos;

   //get
   redo:

   if (xpos<=xlen) then
      begin
      if (xdata[xpos-1+stroffset]=';') or (xdata[xpos-1+stroffset]=#32) then
         begin
         xval:=strcopy1(xdata,lp,xpos-lp);
         inc(xpos);
         result:=true;
         end
      else
         begin
         inc(xpos);
         goto redo;
         end;
      end;

   end;

   function lfind2(var xdata:string;x:string;var v1,v2:string):boolean;
   var
      xdatalen,xlen,p:longint;
   begin
   //defaults
   result   :=false;
   xdatalen :=low__len(xdata);
   xlen     :=low__len(x);
   v1       :='';
   v2       :='';

   //get
   if (xdatalen>=1) then for p:=1 to xdatalen do if (xdata[p-1+stroffset]=x[stroffset]) and (strcopy1(xdata,p,xlen)=x) then
      begin
      result :=true;
      v1     :=stripwhitespace_lt(strcopy1(xdata,1,p-1));
      v2     :=stripwhitespace_lt(strcopy1(xdata,p+xlen,xlen));
      break;
      end;//p
   end;

   function lfind(var xdata:string;x:string):boolean;
   var
      v1,v2:string;
   begin
   result:=lfind2(xdata,x,v1,v2);
   end;

   function acls:boolean;
   begin
   result:=true;str__clear(@a);
   end;

   procedure bcls;
   begin
   b.clear;
   end;

   procedure al(x:string);
   begin
   a.sadd(x+rcode);
   end;

   function badd(x:string):boolean;
   begin
   result:=true;b.value[b.count]:=x;
   end;

   function aload(dfilename:string;var e:string):boolean;
   begin
   result:=acls and io__fromfile(dfilename,@a,e);
   end;

   function asave(dfilename:string;var e:string):boolean;
   begin
   result:=io__tofile(dfilename,@a,e);
   end;

   function afindvars(var e:string):boolean;//searchs the D3 ".dof" project file for important Delphi settings
   label
      skipend;
   var
      dv,n,v,x,xline:string;
      xlen,xpos,xpos2:longint;
   begin
   //defaults
   result:=false;

   //load
   if not aload(xfolder+xname+'.dof',e) then goto skipend;

   //init
   x     :=a.text;
   xlen  :=low__len(x);
   xpos  :=0;

   //get
   while low__nextline1(x,xline,xlen,xpos) do
   begin
   xline :=stripwhitespace_lt(xline);
   low__splitstr(xline,ssEqual,n,v);
   n     :=strlow(n);
   v     :=stripwhitespace_lt(v);

   //decide
   //.app compiler condition vars
   if (n='conditionals') then
      begin
      xpos2:=0;
      v:=v+';';//force trailing semi-colon

      while xpullval(v,xpos2,dv) do
      begin
      dv:=stripwhitespace_lt(dv);
      if (dv<>'') then xconditionals:=xconditionals+insstr(#32,xconditionals<>'')+'-d'+dv;
      end;//loop

      end
   //.app description
   else if (n='exedescription') then xdes:=xclean(v)
   //.console or gui app -> this is inversed, e.g. gui: "ConsoleApp=1" and console.app: "ConsoleApp=0"
   else if (n='consoleapp') then xguimode:=(strint32(v)<>0);
   end;//loop

   //filter
   xdes:=xclean(strdefb(xdes,xname));

   //successful
   result:=true;
   skipend:
   end;

   function bfindunits:boolean;
   var
      v1,v2,x,xline,xline0:string;
      xlen,xpos:longint;
      xok,xdoneunits:boolean;
   begin
   //defaults
   result:=false;

   //init
   bcls;
   x          :=a.text;
   xlen       :=low__len(x);
   xpos       :=0;
   xok        :=false;
   xdoneunits :=false;

   //get
   while low__nextline1(x,xline0,xlen,xpos) do
   begin
   xline :=strlow(stripwhitespace_lt(xline0));

   //decide
   if xdoneunits then
      begin
      xprojectbody:=xprojectbody+xline0+rcode;
      end
   else
      begin
      if not xok then
         begin
         if lfind(xline,'uses') then xok:=true;
         end
      else if lfind2(xline,' in ',v1,v2) then
         begin
         if (v1<>'') then
            begin
            if      strmatch(v1,'main')     then xmainpas:=true
            else if strmatch(v1,'gossroot') then xgossroot:=true;//21mar2025
            result:=badd(v1+'.pas');//mark with ".pas" to indicate these are project specific units
            end;
         end
      else if lfind2(xline,',',v1,v2) then
         begin
         if (v1<>'') then
            begin
            //system unit (no .pas extention)
            result:=badd(v1);
            end;
         end;

      //finish scaning for unit names
      if xok and lfind(xline,';') then xdoneunits:=true;
      end;
   end;//loop
   end;

   function save__lpr(var e:string):boolean;
   label
      skipend;
   var
      p:longint;
   begin
   //defaults
   result:=false;
   e:=gecTaskfailed;

   //load
   if not aload(xfilename,e) then goto skipend;

   //extract list of unit names from code
   if not bfindunits then
      begin
      e:='Not units found in Delpi project file';
      goto skipend;
      end;

   //clear
   acls;

   //get
   al('program '+xname+';');
   al('');
   al('{$mode delphi}{$H+}');
   al('');
   al('uses');
   al('  {$IFDEF UNIX}');
   al('  cthreads,');
   al('  {$ENDIF}');
   al('  {$IFDEF HASAMIGA}');
   al('  athreads,');
   al('  {$ENDIF}');
   al('  Interfaces,// this includes the LCL widgetset');

   //.unit list
   for p:=0 to (b.count-1) do al('  '+io__remlastext(b.value[p])+low__aorbstr(',',';',p>=(b.count-1)));

   al('  { you can add units after this }');
   al('');

   //.body
   a.sadd(xprojectbody);

   //save
   if not asave(xfolder+xname+'.lpr',e) then goto skipend;

   //successful
   result:=true;
   skipend:
   end;

   function save__lpi(var e:string):boolean;
   label
      skipend;
   var
      p:longint;
   begin
   //defaults
   result:=false;
   e:=gecTaskfailed;

   //check
   if (b.count<=0) then
      begin
      e:='No units found, can''t save project .lpi file';
      goto skipend;
      end;

   //cls
   acls;

   //get
   al('<?xml version="1.0" encoding="UTF-8"?>');
   al('<CONFIG>');
   al('<ProjectOptions>');
   al(' <Version Value="12"/>');
   al(' <PathDelim Value="\"/>');
   al(' <General>');
   al('  <SessionStorage Value="InProjectDir"/>');
   al('  <Title Value="'+xtitle+'"/>');
   al('  <Scaled Value="True"/>');
   al('  <ResourceType Value="res"/>');
   al('  <UseXPManifest Value="True"/>');
   al('  <XPManifest>');
   al('   <DpiAware Value="True/PM_V2"/>');
   al('   <TextName Value="'+xname+'"/>');
   al('   <TextDesc Value="'+xdes+'"/>');
   al('  </XPManifest>');
   al(' </General>');
   al(' <BuildModes>');
   al('  <Item Name="Default" Default="True"/>');
   al(' </BuildModes>');
   al(' <PublishOptions>');
   al('  <Version Value="2"/>');
   al('  <UseFileFilters Value="True"/>');
   al(' </PublishOptions>');
   al(' <RunParams>');
   al('  <FormatVersion Value="2"/>');
   al(' </RunParams>');
   al(' <RequiredPackages>');
   al('  <Item>');
   al('  <PackageName Value="LCL"/>');
   al('  </Item>');
   al(' </RequiredPackages>');
   al(' <Units>');
   al('  <Unit>');
   al('  <Filename Value="'+xname+'.lpr"/>');
   al('  <IsPartOfProject Value="True"/>');
   al('  </Unit>');
   //main.pas
   if xmainpas then
      begin
      al('  <Unit>');
      al('  <Filename Value="main.pas"/>');
      al('  <IsPartOfProject Value="True"/>');
      al('  <ComponentName Value="Form1"/>');
      al('  <HasResources Value="True"/>');
      al('  <ResourceBaseClass Value="Form"/>');
      al('  </Unit>');
      end;
   al(' </Units>');
   al('</ProjectOptions>');

   al('<CompilerOptions>');
   al(' <Version Value="11"/>');
   al(' <PathDelim Value="\"/>');
   al(' <Target>');
   al('  <Filename Value="'+xname+'"/>');
   al(' </Target>');
   al(' <SearchPaths>');
   al('  <IncludeFiles Value="$(ProjOutDir)"/>');
   al('  <UnitOutputDirectory Value="lib\$(TargetCPU)-$(TargetOS)"/>');
   al(' </SearchPaths>');
   al(' <Parsing>');
   al('  <SyntaxOptions>');
   al('   <SyntaxMode Value="Delphi"/>');
   al('  </SyntaxOptions>');
   al(' </Parsing>');
   al(' <Linking>');
   al('  <Debugging>');
   al('   <GenerateDebugInfo Value="False"/>');
   al('   <DebugInfoType Value="dsDwarf3"/>');
   al('   <UseExternalDbgSyms Value="False"/>');//**
   al('  </Debugging>');
   al('  <Options>');
   al('   <Win32>');
   al('    <GraphicApplication Value="'+low__aorbstr('False','True',xguimode)+'"/>');
   al('   </Win32>');
   al('  </Options>');
   al(' </Linking>');
   al(' <Other>');
   al('  <WriteFPCLogo Value="False"/>');
   al('  <CustomOptions Value="'+xconditionals+'"/>');//include app specific "app<name>"
   al(' </Other>');
   al('</CompilerOptions>');
   al('<Debugging>');
   al(' <Exceptions>');
   al('  <Item>');
   al('   <Name Value="EAbort"/>');
   al('  </Item>');
   al('  <Item>');
   al('   <Name Value="ECodetoolError"/>');
   al('  </Item>');
   al('  <Item>');
   al('   <Name Value="EFOpenError"/>');
   al('  </Item>');
   al(' </Exceptions>');
   al('</Debugging>');
   al('</CONFIG>');

   //save
   if not asave(xfolder+xname+'.lpi',e) then goto skipend;

   //successful
   result:=true;
   skipend:
   end;

   function save__lps(var e:string):boolean;
   label
      skipend;
   var
      xcount,p:longint;
      procedure u_lpr;
      begin
      inc(xcount);

      al(' <Unit>');
      al('  <Filename Value="'+xname+'.lpr"/>');
      al('  <IsPartOfProject Value="True"/>');
      al('  <IsVisibleTab Value="True"/>');
      al('  <EditorIndex Value="'+intstr32(xcount)+'"/>');
      al('  <UsageCount Value="1"/>');
      al('  <Loaded Value="True"/>');
      al('  <DefaultSyntaxHighlighter Value="Delphi"/>');
      al(' </Unit>');
      end;

      procedure u_pas(n:string;xform1:boolean);
      begin
      if (n='') then exit;

      n:=io__remlastext(n);
      inc(xcount);

      al(' <Unit>');
      al('  <Filename Value="'+n+'.pas"/>');
      if xform1 then
         begin
         al('  <IsPartOfProject Value="True"/>');
         al('  <ComponentName Value="Form1"/>');
         al('  <HasResources Value="True"/>');
         al('  <ResourceBaseClass Value="Form"/>');
         end;
      al('  <EditorIndex Value="'+intstr32(xcount)+'"/>');
      al('  <UsageCount Value="1"/>');
      al('  <Loaded Value="True"/>');
      al('  <DefaultSyntaxHighlighter Value="Delphi"/>');
      al(' </Unit>');
      end;
   begin
   //defaults
   result:=false;
   e:=gecTaskfailed;

   //check
   if (b.count<=0) then
      begin
      e:='No units found, can''t save project .lpi file';
      goto skipend;
      end;

   //cls
   acls;

   //get
   al('<?xml version="1.0" encoding="UTF-8"?>');
   al('<CONFIG>');
   al('<ProjectSession>');
   al(' <PathDelim Value="\"/>');
   al(' <Version Value="12"/>');
   al(' <BuildModes Active="Default"/>');
   al(' <Units>');

   u_lpr;
   for p:=0 to (b.count-1) do if (strmatch(io__lastext(b.value[p]),'pas')) then u_pas(b.value[p],strmatch(b.value[p],'main.pas'));

   if xguimode and xmainpas then
      begin
      al(' <Unit>');
      al('  <Filename Value="main.lfm"/>');
      al('  <HasResources Value="True"/>');
      al('  <EditorIndex Value="-1"/>');
      al('  <UsageCount Value="1"/>');
      al('  <DefaultSyntaxHighlighter Value="LFM"/>');
      al(' </Unit>');
      end;
   al(' </Units>');
   al(' <RunParams>');
   al('  <FormatVersion Value="2"/>');
   al('  <Modes ActiveMode=""/>');
   al(' </RunParams>');
   al('</ProjectSession>');
   al('</CONFIG>');

   //save
   if not asave(xfolder+xname+'.lps',e) then goto skipend;

   //successful
   result:=true;
   skipend:
   end;

begin
//defaults
result:=false;
e:=gecTaskfailed;
a:=nil;
b:=nil;

try
//init
xext           :=strlow(io__lastext(xfilename));
xfolder        :=io__asfolder(io__extractfilepath(xfilename));
xname          :=io__remlastext(io__extractfilename(xfilename));
xguimode       :=false;//false=console app, true=gui app -> value set via bfindunits
xmainpas       :=false;
xgossroot      :=false;
xconditionals  :='';//e.g. "gui3" or "con3" etc -> set by "afindvars"
a              :=str__new8;
b              :=tdynamicstring.create;
xtitle         :=swapcharsb(xname,'"',#39);
xdes           :='';//set by "afindvars"

//check
if (xext<>'dpr') then
   begin
   e:='Not a Delphi project filename (.dpr)';
   goto skipend;
   end;
if not io__fileexists(xfilename) then
   begin
   e:=gecFilenotfound;
   goto skipend;
   end;

//vars
if not afindvars(e) then goto skipend;

//lpr
if not save__lpr(e) then goto skipend;

//lpi
if not save__lpi(e) then goto skipend;

//lps
if not save__lps(e) then goto skipend;

//successful
result:=true;
skipend:
except;end;
//free
str__free(@a);
freeobj(@b);
end;

function d2laz__makeproject3(xfolder:string;xsubfolders:boolean;var xmakecount:longint;var e:string):boolean;//all apps in folder optional subfolders
label
   skipend;
var
   a:tdynamicstring;
   p,ecount:longint;
begin
//defaults
result     :=false;
e          :=gecTaskfailed;
a          :=nil;
ecount     :=0;
xmakecount :=0;

try
//filter
xfolder:=io__asfolderNIL(xfolder);

//check
if not io__folderexists(xfolder) then
   begin
   e:=gecPathnotfound;
   goto skipend;
   end;

//init
a:=tdynamicstring.create;

//filelist
if not io__filelist1(a,true,xsubfolders,xfolder,'*.dpr','') then goto skipend;

//get
for p:=0 to (a.count-1) do if d2laz__makeproject2(a.value[p],e) then inc(xmakecount) else inc(ecount);

//check
if (ecount>=1) then goto skipend;

//successful
result:=true;
skipend:
except;end;
//free
freeobj(@a);
end;



//Chocolatey procs -------------------------------------------------------------
//xxxxxxxxxxxxxxxxxxxxx//1111111111111111111
function choco__appnameOK(var x:string):boolean;
var
   s:string;
   v,p:longint;
begin
//defaults
result:=false;
s     :=x;
x     :='';

//get
for p:=1 to low__len(s) do
begin
v:=byte(s[p-1+stroffset]);

case v of
nn0..nn9,llA..llZ,uuA..uuZ,ssDash,ssDot:x:=x+char(v);//only use a dot if it's in the original app's name
ssSpace,ssComma                        :x:=x+'-';
end;//case

end;//p

result:=(x<>'');
end;

function choco__appverOK(var x:string):boolean;
var
   s:string;
   v,lp,p:longint;
begin
//defaults
result:=false;

//check
if (x='') then exit;

//init
s     :=x+'.';
x     :='';
lp    :=1;

//get
for p:=1 to low__len(s) do if (s[p-1+stroffset]='.') then
   begin
   v:=frcmin32(strint32(strcopy1(s,lp,p-lp)),0);
   lp:=p+1;
   x:=x+insstr('.',x<>'')+intstr32(v);
   end;//p

//successful
result:=(x<>'');
end;

function choco__appdesOK(var x:string):boolean;//18apr2025
begin
result:=choco__appdesOK2(x,false);
end;

function choco__appdesOK2(var x:string;xallow_morethan:boolean):boolean;//20apr2025
var
   s:string;
   v,p:longint;
begin
//defaults
result:=false;
s     :=x;
x     :='';

//get
for p:=1 to low__len(s) do
begin
v:=byte(s[p-1+stroffset]);

case v of
32..59,61,63..126:x:=x+char(v);//exclude less.than (60) and greater.than (62)
ssLessthan:x:=x+'(';
ssMorethan:if xallow_morethan then x:=x+char(v) else x:=x+')';
else x:=x+#32;
end;//case

end;//p

result:=(x<>'');
end;

function choco__urlOK(var x:string):boolean;
var
   s:string;
   v,p:longint;

   function m(const s:string):boolean;
   begin
   result:=strmatch(strcopy1(x,1,low__len(s)),s);
   end;

   function xcharcount(xchar:char;xmincount:longint):boolean;
   var
      p,xcount:longint;
   begin
   result:=false;
   xcount:=0;

   for p:=0 to low__len(x) do if (x[p-1+stroffset]=xchar) then
      begin
      inc(xcount);
      if (xcount>=xmincount) then
         begin
         result:=true;
         break;
         end;
      end;//p
   end;
begin
//defaults
result:=false;
s     :=x;
x     :='';

//get
for p:=1 to low__len(s) do
begin
v:=byte(s[p-1+stroffset]);

case v of
ssLessthan,ssMorethan:;
else                  x:=x+char(v);
end;//case

end;//p

result:=(m('https://') or m('http://')) and xcharcount('.',1);
end;

function choco__apptagsOK(var x:string):boolean;//keywords
begin
choco__appdesOK(x);
swapchars(x,#9,#10);
swapchars(x,#13,#10);
swapchars(x,#32,#10);
swapchars(x,';',#10);
swapchars(x,'.',#10);
swapchars(x,',',#10);
x:=low__remdup2(x,true,false,true);
swapchars(x,#10,#32);
low__remchar(x,#13);
x:=stripwhitespace_lt(x);
result:=(x<>'');
end;

function choco__multi_to_singleline(const x:string):string;
begin
result:=x;
low__remchar(result,#13);
swapstrs(result,#10,'>');
end;

function choco__single_to_multiline(const x:string):string;
begin
result:=x;
swapstrs(result,'>',rcode);
end;

function choco__default_license:string;
begin
result:=
'MIT License (example license only)'+rcode+
''+rcode+
'Copyright (year) (your name/company name)'+rcode+
''+rcode+
'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, '+'merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:'+rcode+
''+rcode+
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.'+rcode+
''+rcode+
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS '+'BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'+rcode+
'';
end;

function choco__default_verification:string;
begin
result:=
'VERIFICATION'+rcode+
''+rcode+
'Verification is intended to assist the Chocolatey moderators and community'+rcode+
'in verifying that this package''s contents are trustworthy.'+rcode+
''+rcode+
'Package can be verified like this:'+rcode+
''+rcode+
'1. Download the app from:'+rcode+
'   url: (url or page to download your app)'+rcode+
''+rcode+
'2. Get the sha256 checksum using one of the following methods:'+rcode+
'   - Use powershell function ''Get-FileHash'''+rcode+
'   - Use Chocolatey utility ''checksum.exe'''+rcode+
''+rcode+
'3. The checksum should match the following:'+rcode+
'   checksum type: sha256'+rcode+
'   checksum: (your app''s checksum)'+rcode+
'';
end;

function choco__form(var xdata:string;var xsavechanges,xduplicatetofolder:boolean;xexelist:tchocolist;sfilelist:tdynamicstring;xduplicatefiles:tfastvars):boolean;
const
   xscale=1.0;
var
   v:tfastvars;
   a:tbasicscroll;
   g:tbasicsystem;
   xtemp:tstr8;
   da:trect;
   xfirst:boolean;
   vsp,xcount,p,xpreviousfocus,dw,dh:longint;
   xpreviouscontrol:tbasiccontrol;
   xcolumn,xpage:tbasicscroll;
   xlist,xfilelist:tbasicmenu;

   xid,xtitle,xver,xauthor,xowner,xcopyright,xprojectUrl,xiconUrl,xscreenshotUrl,xlicenseUrl,xprojectSourceURL,xpackageSourceUrl,xdocsUrl,xmailingListUrl,xbugTrackerUrl:tbasicedit;
   xkeywords,xshortdes,xdes,xlicense,xverification,xreleasenotes:tbasicbwp;

   function xmultiline(xname:string):boolean;
   begin
   xname:=strlow(xname);
   result:=(xname='app.des') or (xname='app.license') or (xname='app.verification') or (xname='app.releasenotes');
   end;

   procedure xnewpage(xtep:longint;xpagelabel,xhelp,xpagename:string);
   begin
   a.xhead.add(xpagelabel,xtep,0,scpage+xpagename,xhelp);
   xpage :=a.xpage(xpagename,true);
   xcount:=0;
   end;

   procedure xnewcol(xremcount:longint);
   begin
   //check
   if (xcount>5) then exit;

   //get
   if (xpage=nil) then xnewpage(tepOptions20,'App Details','','appdetails');
   xpage.xcols.makeautoheight;
   xpage.xcols.style:=bcLefttoright;
   xpage.xcols.remcount[xcount]:=frcmin32(xremcount,1);//share GUI area amongst all columns evenly -> "remainder count"
   xcolumn:=xpage.xcols.cols2[xcount,1,true];
   xcolumn.help:=a.xhead.help;
   xfirst :=true;
   //inc
   inc(xcount);
   end;

   procedure xnewcol2(xremcount:longint;xvertical:boolean);//no scroll
   begin
   //check
   if (xcount>5) then exit;

   //get
   if (xpage=nil) then xnewpage(tepOptions20,'App Details','','appdetails');
   xpage.xcols.style:=low__aorb(bcLeftToRight,bcTopToBottom,xvertical);
   xpage.xcols.remcount[xcount]:=frcmin32(xremcount,1);//share GUI area amongst all columns evenly -> "remainder count"
   xcolumn:=xpage.xcols.cols2[xcount,1,false];
   xfirst :=true;
   //inc
   inc(xcount);
   end;

   function nedit(const xtext,xlabel,xhelp:string;xminlen:longint):tbasicedit;
   begin
   if (xcolumn=nil) then xnewcol(100);
   if (xlabel<>'') then
      begin
      xcolumn.nlabel(xlabel,xhelp).osepv:=insint(vsp,not xfirst);
      end;
   result:=xcolumn.nedit('',xhelp);

   with result.oinputcolorise do
   begin
   use:=(xminlen>=1);
   minlen   :=xminlen;
   backTRUE :=cllime;
   backFALSE:=clred;
   end;

   result.value:=xtext;
   xfirst:=false;
   end;

   function nurl2(const xtext,xlabel,xhelp:string;xminlen:longint):tbasicedit;
   begin
   result:=nedit(xtext,xlabel,xhelp,xminlen);
   result.tep2:=tepGo20;
   result.ocmd2:='edit.visit';
   end;

   function nurl(const xtext,xlabel,xhelp:string):tbasicedit;
   begin
   result:=nurl2(xtext,xlabel,xhelp,4);
   end;

   function ntext2(const xtext,xlabel,xhelp:string;xminlen:longint;xwrap:boolean):tbasicbwp;
   begin
   if (xcolumn=nil) then xnewcol(100);
   if (xlabel<>'') then
      begin
      xcolumn.nlabel(xlabel,xhelp).osepv:=insint(vsp,not xfirst);
      end;
   result:=xcolumn.nbwp5(xhelp,str__new8b(xtext),insint(1,xwrap),false,true,true,false,false,true,true,0,2);//plain text using secondary font (usually Courier New)
   result.oautoheight:=false;
   result.bordersize:=1;
   result.oborderdiff:=20;
   result.clientheight:=100*vizoom;

   with result.oinputcolorise do
   begin
   use:=(xminlen>=1);
   minlen   :=xminlen;
   backTRUE :=cllime;
   backFALSE:=clred;
   end;


   xfirst:=false;
   end;

   function ntext(const xtext,xlabel,xhelp:string;xminlen:longint):tbasicbwp;
   begin
   result:=ntext2(xtext,xlabel,xhelp,xminlen,true);
   end;

   function nlist(const xtext,xlabel,xhelp:string):tbasicmenu;
   begin
   if (xcolumn=nil) then xnewcol(100);
   if (xlabel<>'') then
      begin
      xcolumn.nlabel(xlabel,xhelp).osepv:=insint(vsp,not xfirst);
      end;
   result:=xcolumn.nlistx('',xhelp,0,0,nil);
   xfirst:=false;
   end;

   function nlist2(xlist:tdynamicstring;const xlabel,xhelp:string):tbasicmenu;
   var
      a:tstr8;
      p:longint;
   begin
   a:=nil;
   try
   if (xcolumn=nil) then xnewcol(100);
   if (xlabel<>'') then
      begin
      xcolumn.nlabel(xlabel,xhelp).osepv:=insint(vsp,not xfirst);
      end;

   a:=str__new8;
   low__menuinit(a);
   for p:=0 to (xlist.count-1) do low__menuadd(a,tepFNew20,clnone,xlist.value[p],'',xlist.value[p],p,aknone,0,false,true,false,false);
   low__menuend(a);

   result:=xcolumn.nlist('',xhelp,a,0);
   xfirst:=false;
   except;end;
   //free
   str__free(@a);
   end;

   function s(xname:string):string;//get value
   begin
   //init
   xname:=strlow(xname);

   //get
   result:=v.s[xname];

   //defaults
   if      (xname='app.verification') and (low__len(result)<=4) then result:=choco__default_verification
   else if (xname='app.license')      and (low__len(result)<=4) then result:=choco__default_license;

   //filter
   if xmultiline(xname) then result:=choco__single_to_multiline(result);
   result:=stripwhitespace_lt(result);
   end;

   procedure s2(const xname:string;x:tbasiccontrol);//set value
   var
      z:string;
   begin
   //get
   if      (x is tbasicedit) then z:=(x as tbasicedit).value
   else if (x is tbasictick) then z:=bolstr((x as tbasictick).value)
   else if (x is tbasicbwp)  then
      begin
      str__clear(@xtemp);
      (x as tbasicbwp).iogettxt(xtemp);
      z:=str__text(@xtemp);
      str__clear(@xtemp);
      end
   else z:='';

   //filter
   if xmultiline(xname) then z:=choco__multi_to_singleline(z);

   if      (xname='app.verification') and (low__len(z)<=4) then z:=choco__multi_to_singleline(choco__default_verification)
   else if (xname='app.license')      and (low__len(z)<=4) then z:=choco__multi_to_singleline(choco__default_license);

   //set
   v.s[xname]:=z;
   end;
begin
//defaults
result             :=false;
xsavechanges       :=false;
xduplicatetofolder :=false;
xcount             :=0;
xpage              :=nil;
xcolumn            :=nil;
xfirst             :=false;
vsp                :=3*vizoom;
v                  :=nil;
xtemp              :=nil;

//check
if (app__gui=nil) then exit else g:=app__gui;

try
//init
xpreviousfocus   :=g.winfocus;
xpreviouscontrol :=g.focuscontrol;
a                :=nil;
dw               :=round(700*xscale);
dh               :=round(550*xscale);
low__winzoom(dw,dh);//17mar2021
da.left          :=(g.width-dw) div 2;
da.top           :=(g.height-dh) div 2;
da.right         :=da.left+dw-1;
da.bottom        :=da.top+dh-1;
v                :=tfastvars.create;
v.text           :=xdata;
xtemp            :=str__new8;

//get
a:=g.ndlg(da,false);
a.oborderstyle:=bsSystem50;
a.mkreturn:=false;
a.static:=true;
a.oautoheight:=false;
a.xhead.caption:='Chocolatey Package Information';
a.xhead.help:='Data Entry | The values entered into this form are stored and maintained in the local file ".choco-package-info.txt" within the '+'folder selected for packing.  This file will not be included in the Chocolatey package. | | Required fields are marked in RED when empty and GREEN when filled out.  Entered urls must begin with https:// or http:// and point to a website';
//.tep
a.xhead.tep:=tepIcon32;
a.xhelp;

//-- page 1 --------------------------------------------------------------------
xnewpage(tepOptions20,'App Details','App Details | Important app details required to create a Chocolatey package','appdetails');

//.1st column
xnewcol(100);

xid:=nedit(s('app.name'),'ID','App ID | A short lowercase name that identifies your app, e.g. myapp | May include a dash',2);
xid.caption:='lowercase app name/id to identify your app';

xtitle:=nedit(s('app.title'),'Title','Title | Title of your app',2);
xtitle.caption:='app title';

xver:=nedit(s('app.ver'),'Version','Version | Version number of your app',2);
xver.caption:='e.g. 1.0.3000';

xauthor:=nedit(s('app.author'),'Author','Author | Type the name of the author of the app',2);

xowner:=nedit(s('app.owner'),'Owner(s)','Owner | Type a comma separated list of owners',2);

xcopyright:=nedit(s('app.copyright'),'Copyright','Copyright | Copyright for your app, e.g. 2025 My Company',2);
xcopyright.caption:='year and software vendor';

xiconUrl:=nurl(s('app.iconurl'),'Icon Url (CDN)','Icon Url | A url to your app''s icon on a CDN (content delivery network, e.g. https://raw.githack.com) which caches the icon for a long period of time and can handle high traffic loads');
xiconUrl.caption:='CDN url to app icon';

xprojectUrl:=nurl(s('app.projecturl'),'Project Url','Project Url | A url to your app''s project');
xprojectUrl.caption:='url to app project';

xprojectSourceURL:=nurl(s('app.projectsourceurl'),'Project Source Url','Project Source Url | A url to your app''s source code');
xprojectSourceURL.caption:='url to app source code';

xpackageSourceUrl:=nurl(s('app.packagesourceurl'),'Chocolatey Package Source Files Url','Chocolatey Package Source Files Url | A url to a folder that contains the contents of the built Chocolatey package, e.g. at GitHub.  This would contain the root folder of the package with your app''s nuspec file '+'e.g. "/myapp.nuspec" and the tools folder with the files "/tools/LICENSE.txt" and "/tools/VERIFICATION.txt" in it, and optionally your "/tools/myapp.exe" etc as an example.  | '+'Click the "Save, build and duplicate" button below (bottom right) to create a sub-folder with these files in addition to your Chocolatey package');
xpackageSourceUrl.caption:='url to this Chocolatey package';

xdocsUrl:=nurl(s('app.docurl'),'Documentation Url','Documentation Url | A url to your app''s online documentation');
xdocsUrl.caption:='url to your app''s online documentation';

xmailingListUrl:=nurl2(s('app.mailurl'),'Mailing List Url','Mailing List Url (Optional) | A url to your mailing list',4);
xmailingListUrl.caption:='url to your app''s mailing list';
xmailingListUrl.oinputcolorise.backFALSE:=clnone;//disable the red


//.2nd column
xnewcol(100);
xbugTrackerUrl:=nurl2(s('app.bugurl'),'Bug Tracker Url','Bug Tracker Url (Optional) | A url to your app''s bug tracker',4);
xbugTrackerUrl.caption:='url to your app''s bug tracker';
xbugTrackerUrl.oinputcolorise.backFALSE:=clnone;//disable the red

xkeywords:=ntext2(s('app.tags'),'Keywords','Keywords | A set of keywords (tags) that represent your app',4,false);

xshortdes:=ntext(s('app.shortdes'),'Short Description','Short Description | A short description (summary) of your app',4);

xdes:=ntext(s('app.des'),'Description','Description | A complete description of your app.  Markdown code accepted.',4);
xdes.ominheight:=200*vizoom;

xscreenshotUrl:=nurl2(s('app.screenshoturl'),'Description Screenshot Url (CDN)','Description Screenshot Url (Optional) | A url to your app''s screenshot on a CDN (content delivery network, e.g. https://raw.githack.com) which caches the screenshot for a long period of time and can handle high traffic loads.  '+'Use the tag "($$)" (exclude double quotes) to insert the screenshot into your description text above, or, '+'omit the tag and have the screenshot automatically appended to your description during the package build process.  Leave blank for no screenshot, in this case the ($$) tag will insert nothing.',4);
xscreenshotUrl.caption:='CDN url to app screenshot';
xscreenshotUrl.oinputcolorise.backFALSE:=clnone;//disable the red

//-- page 2 --------------------------------------------------------------------
xnewpage(tepTXT20,'License','License | App license text, verification text and app release notes ','license');
xnewcol2(120,true);
xlicenseUrl:=nurl(s('app.licenseurl'),'License Url','License Url | '+'A url to a license for your app.  This url will be automatically inserted at the top of the App License below in the format "From: <license url>" during the package build process.  '+'It''s a duplication of sorts, but the purpose is to help Chocolatey moderators with the verification process of your app.  '+'An example url for the MIT license would be: https://opensource.org/license/mit');
xlicenseUrl.caption:='url to app license file';

xlicense:=ntext(s('app.license'),'App License','App License | License text that covers the usage of your app.  This text will be stored as a file named "tools\LICENSE.txt" in the built Chocolatey package.  The required "From: <license url>" '+'text line will be automatically inserted at the beginning of the text during the package build process.',4);
xlicense.oautoheight:=true;

xnewcol2(100,true);
xverification:=ntext(s('app.verification'),'Verification','Verification | Verification instructions for the Chocolatey moderators so they can examine your app''s EXE(s) and verify it''s integrity.  This text will be stored as a file named "tools\VERIFICATION.txt" in the built Chocolatey package',4);
xverification.oautoheight:=true;

xnewcol2(70,true);
xreleasenotes:=ntext(s('app.releasenotes'),'App Release Notes','App Release Notes | Detail any changes made to the app',0);
xreleasenotes.oautoheight:=true;


//-- page 3 --------------------------------------------------------------------
xnewpage(tepFolder20,'Files','Files | Mark known GUI apps and view list of files to be included within the Chocolatey package','guiexes');
xnewcol2(100,false);
xlist:=nlist('','Tick the EXEs that are GUI apps, and are not to be shimmed','EXEs | Ticked EXEs will not be shimmed by Chocolatey, and will not be included on the path for command line work');

if (xexelist<>nil) then xexelist.listConnect(xlist);//connect

xnewcol2(100,false);
xfilelist:=nlist2(sfilelist,'Included files for Chocolatey package','Included Files | A list of files to be included in the Chocolatey package');

//default page
a.pageindex:=0;

with a.xtoolbar2 do
begin
cadd(ntranslate('Cancel'),tepClose20,0,scdlg,rthtranslate('Don''t save changes or build the package'),0);
cadd(ntranslate('Save and cancel'),tepSave20,-1,scdlg,rthtranslate('Save changes and don''t build the package'),0);
cadd(ntranslate('Save and build'),tepSave20,1,scdlg,rthtranslate('Save changes and build the package'),600);
if (xduplicatefiles<>nil) then cadd(ntranslate('Save, build and duplicate'),tepSave20,2,scdlg,rthtranslate('Save changes, build the package, and duplicate package files to sub-folder "<package filename>_packagefiles"'),0);
end;


//set
//a.makeautohigh;
g.focuscontrol:=xid;
result              :=g.xshowwait(a,xpreviouscontrol,xpreviousfocus);
xsavechanges        :=result or (a.ocode<0);
xduplicatetofolder  :=result and (a.ocode>=2) and (xduplicatefiles<>nil);

if xsavechanges then
   begin
   s2('app.name',xid);
   s2('app.title',xtitle);
   s2('app.ver',xver);
   s2('app.author',xauthor);
   s2('app.owner',xowner);
   s2('app.copyright',xcopyright);
   s2('app.iconurl',xiconurl);
   s2('app.projecturl',xprojecturl);
   s2('app.projectsourceurl',xprojectSourceURL);
   s2('app.packagesourceurl',xpackageSourceUrl);
   s2('app.licenseurl',xlicenseUrl);
   s2('app.docurl',xdocsUrl);
   s2('app.mailurl',xmailingListUrl);
   s2('app.bugurl',xbugTrackerUrl);
   s2('app.tags',xkeywords);
   s2('app.shortdes',xshortdes);
   s2('app.des',xdes);
   s2('app.screenshoturl',xscreenshoturl);
   s2('app.license',xlicense);
   s2('app.verification',xverification);
   s2('app.releasenotes',xreleasenotes);
   xdata:=v.text;
   end;
except;end;
try
if (xexelist<>nil) then xexelist.listDisconnect(xlist);//disconnect
freeobj(@a);
str__free(@xtemp);
str__free(@v);
except;end;
end;

function choco__makeportablepackage(xdata:pobject;xfolder:string;xallfiles,xsubfolders:boolean;xduplicatefiles:tfastvars;var xpromptagain:boolean;var xoutname,e:string):boolean;//18apr2025, 11apr2025
label//xallfiles=true=all files within "xfolder" are included, else only "EXEs" and "license.txt/verification.txt" are included
     //               all files within a sub-folder(s) are always included for "xsubfolders=true"
   redo,skipone,skipend;
const
   xscaleW=1.3;
   xbom   =#239 + #187 + #191;//unicode byte order mark (BOM)
var
   bol1,xsavechanges,xmustduplicatefiles,xhasrootexe,xhasrootmsi,xhasrootmsu,xonce,xcancel:boolean;
   flist:tdynamicstring;
   cvars,elist:tfastvars;
   zlist,zdata,fdata:tstr8;
   xexelist,xexelist2:tchocolist;
   xidcount,p,xcount:longint;
   xresult:boolean;
   dn,str1,xappprojecturl,xappprojectsourceurl,xappiconurl,xappscreenshoturl,xappname,xapptitle,xappcopyright,xappver,xapptags,xappshortdes,xappdes,xappauthor,xappowner,xpsmdcp_ID,sext,sf,etmp:string;
   xemptyfieldlist,xapppackagesourceurl,xapplicenseurl,xappdocurl,xappmailurl,xappbugurl,xapplicense,xappverification,xappreleasenotes:string;

   function xzip__add(xdata,xlist:tstr8;sname:string;sdata:tstr8):boolean;
   begin
   //keep a duplicate
   try;if xmustduplicatefiles and (xduplicatefiles<>nil) then xduplicatefiles.s[sname]:=sdata.text;except;end;

   //add file to package
   result:=zip__add(xdata,xlist,sname,sdata);
   end;

   procedure xempty2(const x,xname:string);
   begin
   if (low__len(x)<2)then xemptyfieldlist:=xemptyfieldlist+xname+rcode;
   end;

   procedure xempty4(const x,xname:string);
   begin
   if (low__len(x)<4) then xemptyfieldlist:=xemptyfieldlist+xname+rcode;
   end;

   function xmultiline(const x:string):string;
   begin
   result:=stripwhitespace_lt(choco__single_to_multiline(x));
   end;

   function xmakeid(x:string):string;
   begin
   inc(xidcount);
   result:=strlow(low__tob64bstr(k64(xidcount)+x+ms64str,0));
   if (strcopy1(result,low__len(result),1)='=') then strdel1(result,low__len(result),1);
   end;

   function xapperr:boolean;
   begin
   result:=(not xcancel) and (app__gui<>nil);
   if result then app__gui.poperror('',etmp);
   end;

   function ub(xurl,xurllabel:string):boolean;//url is bad
   begin
   result:=false;
   if (not xcancel) and (not choco__urlok(xurl)) then
      begin
      result:=true;
      etmp:=xurllabel+#32+low__aorbstr('must start with https:// or http:// and point to a website','is empty',xurl='');
      xapperr;
      end;
   end;

   procedure cfilter;
   var
      a:tfastvars;
   begin
   //defaults
   a:=nil;

   try
   //init
   a:=tfastvars.create;
   a.text:=cvars.text;
   cvars.clear;

   //get
   xappname:=strlow(stripwhitespace_lt(a.s['app.name']));//force lowercase -> used for app id
   choco__appnameOK(xappname);
   cvars.s['app.name']:=xappname;

   xapptitle:=stripwhitespace_lt(a.s['app.title']);
   choco__appdesOK(xapptitle);
   cvars.s['app.title']:=xapptitle;

   xappver:=stripwhitespace_lt(a.s['app.ver']);
   choco__appverOK(xappver);
   cvars.s['app.ver']:=xappver;

   xappprojecturl:=stripwhitespace_lt(a.s['app.projecturl']);
   choco__urlOK(xappprojecturl);
   cvars.s['app.projecturl']:=xappprojecturl;

   xappprojectsourceurl:=stripwhitespace_lt(a.s['app.projectsourceurl']);
   choco__urlOK(xappprojectsourceurl);
   cvars.s['app.projectsourceurl']:=xappprojectsourceurl;

   xapppackagesourceurl:=stripwhitespace_lt(a.s['app.packagesourceurl']);
   choco__urlOK(xapppackagesourceurl);
   cvars.s['app.packagesourceurl']:=xapppackagesourceurl;

   xapplicenseurl:=stripwhitespace_lt(a.s['app.licenseurl']);
   choco__urlOK(xapplicenseurl);
   cvars.s['app.licenseurl']:=xapplicenseurl;

   xappdocurl:=stripwhitespace_lt(a.s['app.docurl']);
   choco__urlOK(xappdocurl);
   cvars.s['app.docurl']:=xappdocurl;

   xappmailurl:=stripwhitespace_lt(a.s['app.mailurl']);
   choco__urlOK(xappmailurl);
   cvars.s['app.mailurl']:=xappmailurl;

   xappbugurl:=stripwhitespace_lt(a.s['app.bugurl']);
   choco__urlOK(xappbugurl);
   cvars.s['app.bugurl']:=xappbugurl;

   xappiconurl:=stripwhitespace_lt(a.s['app.iconurl']);
   choco__urlOK(xappiconurl);
   cvars.s['app.iconurl']:=xappiconurl;

   xappscreenshoturl:=stripwhitespace_lt(a.s['app.screenshoturl']);
   choco__urlOK(xappscreenshoturl);
   cvars.s['app.screenshoturl']:=xappscreenshoturl;

   xappauthor:=stripwhitespace_lt(a.s['app.author']);
   choco__appdesOK(xappauthor);
   cvars.s['app.author']:=xappauthor;

   xappowner:=stripwhitespace_lt(a.s['app.owner']);
   choco__appdesOK(xappowner);
   cvars.s['app.owner']:=xappowner;

   xappcopyright:=stripwhitespace_lt(a.s['app.copyright']);
   choco__appdesOK(xappcopyright);
   cvars.s['app.copyright']:=xappcopyright;

   xapptags:=stripwhitespace_lt(a.s['app.tags']);
   choco__apptagsOK(xapptags);
   cvars.s['app.tags']:=xapptags;

   xappshortdes:=stripwhitespace_lt(a.s['app.shortdes']);
   choco__appdesOK(xappshortdes);
   cvars.s['app.shortdes']:=xappshortdes;

   xappdes:=stripwhitespace_lt(a.s['app.des']);
   choco__appdesOK2(xappdes,true);
   cvars.s['app.des']:=xappdes;

   xapplicense:=stripwhitespace_lt(a.s['app.license']);
   choco__appdesOK2(xapplicense,true);
   cvars.s['app.license']:=xapplicense;

   xappverification:=stripwhitespace_lt(a.s['app.verification']);
   choco__appdesOK2(xappverification,true);
   cvars.s['app.verification']:=xappverification;

   xappreleasenotes:=stripwhitespace_lt(a.s['app.releasenotes']);
   choco__appdesOK2(xappreleasenotes,true);
   cvars.s['app.releasenotes']:=xappreleasenotes;

   cvars.s['app.exelist']:=a.s['app.exelist'];//normal
   cvars.s['app.exelist.s']:=a.s['app.exelist.s'];//subfolders
   except;end;
   //free
   freeobj(@a);
   end;

   function xmakedes:string;
   label
      redo;
   var
      xscreenshot:string;
      xlen,p,lp:longint;
      xfoundtag:boolean;

      function xlabel:string;
      begin
      result:=xapptitle+' v'+xappver+' Screenshot';
      swapchars(result,'[','(');
      swapchars(result,']',')');
      end;
   begin
   //defaults
   result:=xmultiline(xappdes);//decode one line into multiple lines ready for use

   //screenshot url
   if (xappscreenshoturl<>'') then xscreenshot:='!['+xlabel+']('+xappscreenshoturl+')' else xscreenshot:='';

   //init
   xfoundtag:=false;
   xlen     :=low__len(result);
   p        :=1;
   lp       :=p;

   redo:
   if (p<=xlen) and (result[p-1+stroffset]='(') and strmatch(strcopy1(result,p,4),'($$)') then
      begin
      result    :=strcopy1(result,1,p-1)+xscreenshot+strcopy1(result,p+4,xlen);
      xlen      :=low__len(result);
      lp        :=p;
      xfoundtag :=true;
      end;

   //.inc
   inc(p);
   if (p<=xlen) then goto redo;

   //tag not found -> append to end
   if not xfoundtag then result:=result+rcode+xscreenshot;
   end;

   procedure fclear;
   begin
   str__clear(@fdata);
   end;

   procedure fal(const x:string);//add line of text to fdata
   begin
   str__sadd(@fdata,x+rcode);
   end;

   procedure fal00(const x:string);//no indent, no return code
   begin
   str__sadd(@fdata,x);
   end;

   procedure fal2(const x:string);//indent 2 spaces
   begin
   fal(#32#32+x);
   end;

   procedure fal4(const x:string);//indent 4 spaces
   begin
   fal(#32#32#32#32+x);
   end;

   function xadd__content_types_xml:boolean;
   var
      p:longint;
      de:string;
   begin
   //defaults
   result:=false;

   try
   //clear
   fclear;

   //get - 18apr2025: BOM is NOT used
   fal('<?xml version="1.0" encoding="utf-8"?>');
   fal('<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">');
   fal2('<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />');
   fal2('<Default Extension="psmdcp" ContentType="application/vnd.openxmlformats-package.core-properties+xml" />');
   fal2('<Default Extension="nuspec" ContentType="application/octet" />');

   //.add all file extensions that have been used when packing files
   for p:=0 to (elist.count-1) do
   begin
   de:=strlow(elist.n[p]);
   swapchars(de,'"',#39);
   if (de<>'rels') and (de<>'psmdcp') and (de<>'nuspec') then fal2('<Default Extension="'+de+'" ContentType="application/octet" />');
   end;//p

   //.finish
   fal00('</Types>');//no return codes

   //set
   result:=zip__add(zdata,zlist,'[Content_Types].xml',fdata);//don't duplicate
   except;end;
   end;

   function xadd__nuspec:boolean;//18apr2025, 11apr2025
   var
      str1:string;

   begin
   //defaults
   result:=false;

   try
   //clear
   fclear;

   //get
   str__sadd(@fdata,xbom);//18apr2025: BOM is used

   fal('<?xml version="1.0" encoding="utf-8"?>');
   fal('<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">');
   fal2('<metadata>');
   fal4('<id>'+xappname+'</id>');
   fal4('<version>'+xappver+'</version>');
   fal4('<title>'+xapptitle+'</title>');
   fal4('<authors>'+xappauthor+'</authors>');
   fal4('<owners>'+xappowner+'</owners>');
   fal4('<requireLicenseAcceptance>false</requireLicenseAcceptance>');
   fal4('<licenseUrl>'+xappLicenseUrl+'</licenseUrl>');
   fal4('<projectUrl>'+xappProjecturl+'</projectUrl>');//11apr2025
   fal4('<iconUrl>'+xappiconurl+'</iconUrl>');
   fal4('<description>'+xmakedes+'</description>');//note: the "![CDATA[...]]>" allows for html to be included
   fal4('<summary>'+xappshortdes+'</summary>');
   fal4('<copyright>'+xappcopyright+'</copyright>');
   fal4('<tags>'+xapptags+'</tags>');
   fal4('<projectSourceUrl>'+xappProjectSourceUrl+'</projectSourceUrl>');
   fal4('<packageSourceUrl>'+xappPackageSourceUrl+'</packageSourceUrl>');
   fal4('<docsUrl>'+xappDocUrl+'</docsUrl>');

   if (xappMailUrl<>'') then fal4('<mailingListUrl>'+xappMailUrl+'</mailingListUrl>');//not allowed to be empty
   if (xappBugUrl<>'')  then fal4('<bugTrackerUrl>'+xappBugUrl+'</bugTrackerUrl>');//not allowed to be empty

   str1:=xmultiline(xappreleasenotes);
   if (str1<>'') then fal4('<releaseNotes>'+str1+'</releaseNotes>');

   fal2('</metadata>');
   fal00('</package>');//no trailing return code

   //set
   result:=xzip__add(zdata,zlist,xappname+'.nuspec',fdata);
   except;end;
   end;

   function xadd__psmdcp:boolean;
   begin
   //defaults
   result:=false;

   try
   //clear
   fclear;

   //get - 18apr2025: BOM is NOT used
   fal('<?xml version="1.0" encoding="utf-8"?>');
   fal('<coreProperties xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.openxmlformats.org/package/2006/metadata/core-properties">');
   fal2('<dc:creator>'+xappauthor+'</dc:creator>');
   fal2('<dc:description>'+xmakedes+'</dc:description>');
   fal2('<dc:identifier>'+xappname+'</dc:identifier>');
   fal2('<version>'+xappver+'</version>');
   fal2('<keywords>'+xapptags+'</keywords>');//11apr2025
   fal2('<lastModifiedBy>choco, Version=2.4.3.0, Culture=neutral, PublicKeyToken=79d02ea9cad655eb;Microsoft Windows NT 10.0.22000.0;.NET Framework 4.8</lastModifiedBy>');
   fal00('</coreProperties>');//no return code

   //set
   result:=zip__add(zdata,zlist,'package\services\metadata\core-properties\'+xpsmdcp_ID+'.psmdcp',fdata);//don't duplicate
   except;end;
   end;

   function xadd__rels:boolean;
   begin//Note: XML IDs for "Relationship/nuspec" and "Relationship/psmdcp" not included - 31mar2025
   //defaults
   result:=false;

   try
   //clear
   fclear;

   //get - 18apr2025: BOM is NOT used
   fal('<?xml version="1.0" encoding="utf-8"?>');
   fal('<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">');
   fal2('<Relationship Type="http://schemas.microsoft.com/packaging/2010/07/manifest" Target="/'+xappname+'.nuspec" Id="R'+strcopy1(strup(guid__make('nuspec.'+xappname,true)),1,16)+'" />');//11apr2025: fixed
   fal2('<Relationship Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="/package/services/metadata/core-properties/'+xpsmdcp_ID+'.psmdcp" Id="R'+strcopy1(strup(guid__make('psmdcp.'+xappname,true)),1,16)+'" />');
   fal00('</Relationships>');//no return code

   //set
   result:=zip__add(zdata,zlist,'_rels\.rels',fdata);//don't duplicate
   except;end;
   end;
begin
//defaults
result        :=false;
etmp          :=gecTaskfailed;
xidcount      :=0;
flist         :=nil;
fdata         :=nil;
zlist         :=nil;
zdata         :=nil;
cvars         :=nil;
elist         :=nil;
xoutname      :='';
xpsmdcp_ID    :=strlow(guid__make('',true));
xexelist      :=nil;
xexelist2     :=nil;
xpromptagain  :=false;

try
//xduplicatefiles
if (xduplicatefiles<>nil) then xduplicatefiles.clear;

//check
if not str__lock(xdata) then goto skipend;

//clear
str__clear(xdata);

//range
xfolder:=io__asfolderNIL(xfolder);

//init
flist       :=tdynamicstring.create;
fdata       :=str__new8;
cvars       :=tfastvars.create;
elist       :=tfastvars.create;
zlist       :=str__new8;
zdata       :=str__new8;
xexelist    :=tchocolist.create;
xexelist2   :=tchocolist.create;
xhasrootexe :=false;
xhasrootmsi :=false;
xhasrootmsu :=false;

//filelist
if not io__filelist1(flist,false,xsubfolders,xfolder,low__aorbstr('*.exe;','*',xallfiles),'') then
   begin
   etmp:=gecOutofmemory;
   goto skipend;
   end;

//.scan list
for p:=(flist.count-1) downto 0 do
begin
//.filter out specific files in root folder only -> we automatically create "license.txt" and "verification.txt" and ".choco-package-info.txt" does not form part of the package -> it's our information record
if strmatch(flist.value[p],'verification.txt') or strmatch(flist.value[p],'license.txt') or strmatch(flist.value[p],'.choco-package-info.txt') then flist.del(p);

//.ensure at least one ROOT exe is present
if (not xhasrootexe) and strmatch(io__lastext(flist.value[p]),'exe') and (not low__havechar(flist.value[p],'/')) and (not low__havechar(flist.value[p],'\')) then xhasrootexe:=true;
if (not xhasrootmsi) and strmatch(io__lastext(flist.value[p]),'msi') and (not low__havechar(flist.value[p],'/')) and (not low__havechar(flist.value[p],'\')) then xhasrootmsi:=true;
if (not xhasrootmsu) and strmatch(io__lastext(flist.value[p]),'msu') and (not low__havechar(flist.value[p],'/')) and (not low__havechar(flist.value[p],'\')) then xhasrootmsu:=true;
end;

if (not xallfiles) and (not xhasrootexe) then
   begin
   xpromptagain:=true;
   etmp        :='No app EXE found in base folder';
   goto skipend;
   end;

if xallfiles and (not xhasrootexe) and (not xhasrootmsi) and (not xhasrootmsu) then
   begin
   xpromptagain:=true;
   etmp        :='No EXE, MSI or MSU file found in base folder';
   goto skipend;
   end;

if (flist.count<=0) then
   begin
   xpromptagain:=true;
   etmp        :='No files found to pack';
   goto skipend;
   end;

//load ".choco-package-info.txt" values
io__fromfile(xfolder+'.choco-package-info.txt',@fdata,etmp);
cvars.text:=fdata.text;
xexelist.textline:=cvars.s['app.exelist'+insstr('.s',xsubfolders)];
cfilter;
fclear;

//build list of EXEs that are to be packed and filter out any dead items
xexelist2.clear;
for p:=0 to (flist.count-1) do if strmatch(io__lastext(flist.value[p]),'exe') then xexelist2.marked[flist.value[p]]:=xexelist.marked[flist.value[p]];
xexelist.textline:=xexelist2.textline;
xexelist2.clear;

//prompt user
redo:
xcancel:=false;

if (app__gui<>nil) then
   begin
   str1:=cvars.text;
   bol1:=choco__form(str1,xsavechanges,xmustduplicatefiles,xexelist,flist,xduplicatefiles);

   if xsavechanges then
      begin
      cvars.text:=str1;
      cfilter;

      cvars.s['app.exelist'+insstr('.s',xsubfolders)]:=xexelist.textline;

      fclear;
      str__sadd(@fdata,cvars.text);
      io__tofile(xfolder+'.choco-package-info.txt',@fdata,etmp);
      fclear;
      end;

   if not bol1 then
      begin
      etmp:=gecTaskCancelled;
      goto skipend;
      end;
   end;

//check ".choco-package-info.txt" values
xemptyfieldlist:='';

xempty2(xappname,'ID');
xempty2(xapptitle,'Title');
xempty2(xappver,'Version');
xempty2(xapptags,'Keywords');
xempty4(xappdes,'Description');
xempty4(xappshortdes,'Short Description');
xempty2(xappauthor,'Author');
xempty2(xappowner,'Owner');
xempty4(xappiconurl,'Icon Url');
xempty4(xappprojecturl,'Project Url');
xempty2(xappcopyright,'Copyright');
xempty4(xapppackagesourceurl,'Chocolatey Package Source Url');
xempty4(xapplicenseurl,'License Url');
xempty4(xappdocurl,'Documentation Url');
xempty4(xapplicense,'App License');
xempty4(xappverification,'Verification');

if (xemptyfieldlist<>'') then
   begin
   etmp:='One or more required fields are empty and marked in red.  They must be filled out prior to building the Chocolatey package.'+rcode+rcode+'Empty fields are:'+rcode+xemptyfieldlist;
   if xapperr then goto redo else goto skipend;
   end;

if (choco__multi_to_singleline(choco__default_license)=xapplicense) then
   begin
   etmp:='The default license text must be personalised to your app.';
   if xapperr then goto redo else goto skipend;
   end;

if (choco__multi_to_singleline(choco__default_verification)=xappverification) then
   begin
   etmp:='The default verification text must be personalised to your app.';
   if xapperr then goto redo else goto skipend;
   end;

if ub(xappiconurl,'Icon Url')                               then goto redo;
if ub(xappprojecturl,'Project Url')                         then goto redo;
if ub(xapppackagesourceurl,'Chocolatey Package Source Url') then goto redo;
if ub(xapplicenseurl,'License Url')                         then goto redo;
if ub(xappdocurl,'Documentation Url')                       then goto redo;

//.optional urls
if (xappscreenshoturl<>'') and ub(xappscreenshoturl,'Screen Url') then goto redo;
if (xappmailurl<>'') and ub(xappmailurl,'Mailing list Url')       then goto redo;
if (xappbugurl<>'') and ub(xappbugurl,'Bug tracking Url')         then goto redo;

if xcancel                                                        then goto skipend;


//start
if not zip__start(zdata,zlist) then goto skipend;

//status
if      (not xallfiles) and (not xsubfolders) then str1:='Packing folder EXEs...'
else if xallfiles and (not xsubfolders)       then str1:='Packing files for "'+io__lastfoldername(xfolder,'')+'"...'
else                                               str1:='Packing "'+io__lastfoldername(xfolder,'')+'" and sub-folders...';
app__gui.popstatus(str1,1);

//get --------------------------------------------------------------------------
xonce:=true;


//.1st file
if not xadd__rels   then goto skipend;

//.2nd file
if not xadd__nuspec then goto skipend;

//.3rd file - license.txt
fdata.text:='From: '+xapplicenseurl+rcode+rcode+'LICENSE'+rcode+rcode+xmultiline(xapplicense);
if not xzip__add(zdata,zlist,'tools\LICENSE.txt',fdata) then goto skipend;
elist.b['txt']:=true;

//.4th file - verification.txt
fdata.text:=xmultiline(xappverification);
if not xzip__add(zdata,zlist,'tools\VERIFICATION.txt',fdata) then goto skipend;
elist.b['txt']:=true;


//.folder files
for p:=0 to (flist.count-1) do
begin
sf   :=xfolder+flist.value[p];
sext :=strlow(io__lastext(flist.value[p]));

if xonce and strmatch(sf,xfolder+'.choco-package-info.txt') then
   begin
   xonce:=false;
   goto skipone;
   end;

//.track file extensions used
elist.b[sext]:=true;

//.load file data
if not io__fromfile(sf,@fdata,etmp) then goto skipend;


//.name modifers
dn:=flist.value[p];
if      strmatch(dn,'verification.txt') then dn:='VERIFICATION.txt'
else if strmatch(dn,'license.txt')      then dn:='LICENSE.txt';

//.add file to zip archive
if not xzip__add(zdata,zlist,'tools\'+dn,fdata) then goto skipend;

//.mark GUI apps with an empty file ending in ".gui"
if (sext='exe') and xexelist.marked[flist.value[p]] then
   begin
   fdata.clear;
   if not xzip__add(zdata,zlist,'tools\'+dn+'.gui',fdata) then goto skipend;
   elist.b['gui']:=true;
   end;

skipone:
end;//p


//.2nd to last file
if not xadd__content_types_xml then goto skipend;

//.last file
if not xadd__psmdcp            then goto skipend;


//stop and finalise
if not zip__stop(zdata,zlist) then goto skipend;

if not str__add(xdata,@zdata) then
   begin
   etmp:=gecOutofmemory;
   goto skipend;
   end;


//outname
xoutname:=xappname+'.'+xappver+'.'+fenupkg;

//sucessful
result:=true;
skipend:
except;end;
//free
freeobj(@xexelist);
freeobj(@xexelist2);
freeobj(@flist);
freeobj(@cvars);
freeobj(@elist);

str__free(@fdata);
str__free(@zlist);
str__free(@zdata);

str__uaf(xdata);

//error
if not result then e:=etmp;
end;

function choco__saveduplicates(dfilename:string;xduplicatefiles:tfastvars;var e:string):boolean;//20apr2025
label
   skipend;
var
   xrootfolder,df,etmp:string;
   p:longint;

   function xcleanfolder:boolean;
   label
      skipend;
   var
      flist:tdynamicstring;
      p:longint;
      ln,n:string;
   begin
   //defaults
   result:=false;
   flist :=nil;

   try
   //init
   flist:=tdynamicstring.create;

   //get
   io__filelist1(flist,false,true,xrootfolder,'*','');

   //.remove files first
   for p:=0 to (flist.count-1) do
   begin
   n:=xrootfolder+flist.value[p];

   if not io__remfile(n) then
      begin
      etmp:='Unable to clean sub-folder: '+gecFileinuse;
      goto skipend;
      end;

   end;//p

   //.remove folders second
   ln:='';
   for p:=0 to (flist.count-1) do
   begin
   n:=io__extractfilepath(xrootfolder+flist.value[p]);

   if (not strmatch(n,ln)) and (not strmatch(n,xrootfolder)) and (not io__deletefolder(n)) then
      begin
      etmp:='Unable to clean sub-folder: '+gecFolderInUse;
      goto skipend;
      end;

   ln:=n;
   end;//p

   //successful
   result:=true;
   skipend:
   except;end;

   //free
   freeobj(@flist);
   end;
begin
//defaults
result:=false;
etmp  :=gecTaskfailed;

try
//check
if (xduplicatefiles=nil) or (xduplicatefiles.count<=0) or (not io__fileexists(dfilename)) then
   begin
   result:=true;
   exit;
   end;

//make folder
xrootfolder:=io__asfolder(dfilename+'_packagefiles');
if not io__makefolder(xrootfolder) then
   begin
   etmp:=gecFolderinuse;
   goto skipend;
   end;

//clean folder
if not xcleanfolder then goto skipend;

//get
for p:=0 to (xduplicatefiles.count-1) do
begin
df:=xrootfolder+swapstrsb(xduplicatefiles.n[p],'/','\');

if not io__tofilestr(df,xduplicatefiles.s[ xduplicatefiles.n[p] ],etmp) then goto skipend;
end;//p

//successful
result:=true;
skipend:
except;end;
//error
if not result then e:=etmp;
end;

//## tchocolist ################################################################
constructor tchocolist.create;
begin
//track
if classnameis('tchocolist') then track__inc(satOther,1);

//self
inherited create;

//controls
icore:=tfastvars.create;

//var
ilist:=nil;
end;

destructor tchocolist.destroy;
begin
try
//self
inherited destroy;

//track
if classnameis('tchocolist') then track__inc(satOther,-1);
except;end;
end;

function tchocolist.getmarked(x:string):boolean;
begin
result:=(x<>'') and icore.b[x];
end;

procedure tchocolist.setmarked(x:string;v:boolean);
begin
if (x<>'') then icore.b[x]:=v;
end;

procedure tchocolist.list__onclick(sender:tobject);
var
   n:string;
begin
if (ilist<>nil) then
   begin
   n:=ilist.xgetval2(ilist.itemindex);
   marked[n]:=not marked[n];
   ilist.paintnow;
   end;
end;

function tchocolist.list__onitem(sender:tobject;xindex:longint;var xtab,xtep,xtepcolor:longint;var xcaption,xcaplabel,xhelp,xcode2:string;var xcode,xshortcut,xindent:longint;var xflash,xenabled,xtitle,xsep,xbold:boolean):boolean;
var
   n:string;
begin
if (xindex>=0) and (xindex<icore.count) then n:=icore.n[xindex] else n:='';

xtep:=tep__yes(marked[n]);

xcaption :=n;
xcaplabel:=n;
end;

procedure tchocolist.clear;
begin
icore.clear;
end;

procedure tchocolist.listConnect(x:tbasicmenu);
begin
if (x<>nil) then
   begin
   ilist:=x;
   x.ongetitem:=list__onitem;
   x.onclick:=list__onclick;
   x.countx:=icore.count;
   end;
end;

procedure tchocolist.listDisconnect(x:tbasicmenu);
begin
if (x<>nil) then
   begin
   ilist:=nil;
   x.ongetitem:=nil;
   x.onclick:=nil;
   x.countx:=0;
   end;
end;

function tchocolist.gettext:string;
var
   a:tstr8;
   p:longint;
begin
//defaults
result:='';
a     :=nil;

try
//init
a:=str__new8;

//get
for p:=0 to (icore.count-1) do if (icore.n[p]<>'') then a.sadd(low__aorbstr('0','1',marked[icore.n[p]]) + icore.n[p] +'>');

//set
result:=a.text;
except;end;
//free
str__free(@a);
end;

procedure tchocolist.settext(x:string);
var
   lp,p:longint;
   n:string;
   b:boolean;
begin
//clear
icore.clear;

//get
lp:=1;
for p:=1 to low__len(x) do if (x[p-1+stroffset]='>') then
   begin
   b:=(strint32(strcopy1(x,lp,1))<>0);
   n:=strcopy1(x,lp+1,p-lp-1);
   if (n<>'') then icore.b[n]:=b;
   lp:=p+1;
   end;

//set
if (ilist<>nil) then ilist.countx:=icore.count;
end;

//## tworkpanel ################################################################
function workpanel__new(xrootwin:tbasicscroll;xtep:longint;xname,xpagename,xhelp:string):tworkpanel;
begin
if (xrootwin<>nil) then
   begin
   result           :=tworkpanel.create(xrootwin.client);
   result.help      :=xhelp;
   result.opagename :=strlow(strdefb(xpagename,xname));
   xrootwin.xhead.add(xname,xtep,0,scpage+result.opagename,result.help);
   end
else
   begin
   showerror('Invalid rootwin');
   result:=nil;
   end;
end;



constructor tworkpanel.create(xparent:tobject);
begin
//self
inherited create(xparent);

//track
if classnameis('tworkpanel') then track__inc(satOther,1);

//vars
oautoheight   :=true;
bordersize    :=0;
icurrentbar   :=nil;
ibuttoncount  :=0;

//controls


end;

destructor tworkpanel.destroy;
begin
try
//controls

//self
inherited destroy;

//untrack
if classnameis('tworkpanel') then track__inc(satOther,-1);
except;end;
end;

function tworkpanel.getbar(xindex:longint):tbasictoolbar;
begin
if (icount>=1) then result:=ibar[frcrange32(xindex,0,icount-1)] else result:=nil;
end;

function tworkpanel.xnewbar:tbasictoolbar;
begin
result:=xnewbar2(100);
end;

function tworkpanel.xnewbar2(xremcount:longint):tbasictoolbar;
begin
//check
if (icount>high(ibar)) then
   begin
   result:=bar[icount];
   exit;
   end;

//get
style:=bcLefttoright;
remcount[icount]:=frcmin32(xremcount,1);//share GUI area amongst all columns evenly -> "remainder count"

with cols2[icount,1,true] do
begin
result:=client.ntoolbar('');
result.ounderline :=false;
result.oflatback  :=true;
result.onclick    :=__onclick;
result.opartline  :=0.3;
result.oscaleh    :=1.1;
end;

//inc
icurrentbar:=result;
if (icount>=0) and (icount<=high(ibar)) then ibar[icount]:=result;
inc(icount);
end;

procedure tworkpanel.xenhance(xval:string;var x:string);
var
   v:string;
begin
v:=k64(low__findv(xval));
swapstrs(x,'%copy','and copy to Clipboard');
swapstrs(x,'%to',' >> ');
swapstrs(x,'%linelen','and '+v+'c lines');
swapstrs(x,'%v',v);
end;

procedure tworkpanel.al;//new line
begin
if (icurrentbar<>nil) then
   begin

   with icurrentbar do
   begin
   newpartline;
   end;

   end;
end;

procedure tworkpanel.at(xname,xhelp:string);//add title
begin
if (icurrentbar<>nil) then
   begin

   with icurrentbar do
   begin
   btitle[add(xname,tepNone,0,'',xhelp)]:=true;
   newline;
   end;

   end;
end;

procedure tworkpanel.ab(xtep:longint;xcmd,xname,xhelp:string);//add button
begin
if (icurrentbar<>nil) then
   begin
   //init
   inc(ibuttoncount);
   xenhance(xcmd,xname);
   xenhance(xcmd,xhelp);
//   xname:=k64(ibuttoncount)+'. '+xname;

   //add
   with icurrentbar do
   begin
   add(xname,xtep,0,xcmd,xhelp);
   newline;
   end;

   end;
end;

procedure tworkpanel.ab1(xtep:longint;xcmd,xcmd2,v1,xhelp:string);
begin
ab(xtep,xcmd+insstr(cs_sep+xcmd2,xcmd2<>''),v1,xhelp);
end;

procedure tworkpanel.ab2(xtep:longint;xcmd,xcmd2,v1,v2,xhelp:string);
begin
ab(xtep,xcmd+insstr(cs_sep+xcmd2,xcmd2<>''),sup__label2(v1,v2),xhelp);
end;

procedure tworkpanel.ab20(xtep:longint;xcmd,xcmd2,v1,v2,xhelp:string);
begin
ab(xtep,xcmd+insstr(cs_sep+xcmd2,xcmd2<>''),v2,xhelp);
end;

procedure tworkpanel.ab3(xtep:longint;xcmd,xcmd2,v1,v2,v3,xhelp:string);
begin
ab(xtep,xcmd+insstr(cs_sep+xcmd2,xcmd2<>''),sup__label3(v1,v2,v3),xhelp);
end;

procedure tworkpanel.addbyname(n:string);
var
   v,p:longint;
   str1:string;
   xconcise:boolean;

   function m(x:string):boolean;//full match
   begin
   result:=strmatch(x,n);
   end;

   procedure xblankimages(dwhite:boolean);
      procedure bi(xsize:longint);//blank image
         function xfilter:boolean;
         begin
         result:=(not xconcise) or ((xsize=2560) or (xsize=512) or (xsize=430)  or (xsize=256));
         end;
      begin
      if xfilter then ab1(tepBMP20,cs_blankimages,intstr32(xsize)+'.'+intstr32(insint(clwhite,dwhite)),k64(xsize)+'px','Image | Copy a '+k64(xsize)+'w x '+k64(xsize)+'h '+low__aorbstr('black','white',dwhite)+' image to Clipboard');
      end;
   begin
   at('Blank ('+low__aorbstr('B','W',dwhite)+')','Image | Copy a '+low__aorbstr('black','white',dwhite)+' image to Clipboard');
   bi(2560);
   bi(1024);
   bi(512);
   bi(430);
   bi(400);
   bi(256);
   bi(208);
   bi(128);
   bi(96);
   bi(72);
   bi(64);
   bi(48);
   bi(32);
   bi(20);
   bi(16);
   bi(8);
   bi(4);
   bi(2);
   bi(1);
   end;

   procedure xtemplate(dstyle:string;dwhite:boolean);
   var
      xpos,xsize:longint;
      xshort,xlabel:string;

      function xfilter:boolean;
      begin
      result:=(not xconcise) or ((xsize=2560) or (xsize=512) or (xsize=430)  or (xsize=256));
      end;
   begin
   //range
   dstyle:=strlow(dstyle);
   if (dstyle<>'squircle') and (dstyle<>'circle') and (dstyle<>'square') then dstyle:='squircle';

   //init
   xlabel:=low__aorbstr('black','white',dwhite);
   xshort:=low__aorbstr('B','W',dwhite);
   xpos  :=0;

   if (dstyle='circle') then
      begin
      at('Circle ('+xshort+')','Circle | Resize and stamp Clipboard image as a circle with '+strlow(xlabel)+' space');
      while sup__listofsizes(xpos,xsize) do if xfilter then ab1(tepBMP20,cs_imagetemplate,'circle.'+intstr32(xsize)+'.'+low__aorbstr('0','1',dwhite),k64(xsize)+'px','Circle | Resize Clipboard image to '+k64(xsize)+'w x '+k64(xsize)+'h and stamp as a circle with '+strlow(xlabel)+' background');
      end
   else if (dstyle='squircle') then
      begin
      at('Squircle ('+xshort+')','Squircle | Resize and stamp Clipboard image as a squircle with '+strlow(xlabel)+' space');
      while sup__listofsizes(xpos,xsize) do if xfilter then ab1(tepBMP20,cs_imagetemplate,'squircle.'+intstr32(xsize)+'.'+low__aorbstr('0','1',dwhite),k64(xsize)+'px','Squircle | Resize Clipboard image to '+k64(xsize)+'w x '+k64(xsize)+'h and stamp as a squircle with '+strlow(xlabel)+' background');
      end
   else
      begin
      at('Square','Square | Resize and stamp Clipboard image as a square');
      while sup__listofsizes(xpos,xsize) do if xfilter then ab1(tepBMP20,cs_imagetemplate,'square.'+intstr32(xsize)+'.0',k64(xsize)+'px','Square | Resize Clipboard image to '+k64(xsize)+'w x '+k64(xsize)+'h');
      end;

   end;
begin
//init
n         :=strlow(n);
xconcise  :=m(cs_concise_part1) or m(cs_concise_part2) or m(cs_concise_part3) or m(cs_concise_part4);


if m(cs_text_part1) then
   begin
   at('Mime/Type Base64','');
   ab1(tepOpen20,cs_fromfile_makebase64_xxc,'0','File','Mime/Type Base64 | Encode a file as mime/type base64');
   ab1(tepTXT20,cs_pastetext_makebase64,'','Text','Mime/Type Base64 | Encode Clipboard text as mime/type base64');


   al;
   at('Pascal Array','');
   ab1(tepTXT20,cs_pastetext_makearray,cs_nil,'Text','Plain Text | Pack Clipboard text into a Pascal array');
   ab1(tepTXT20,cs_pastetext_makearray,cs_zip,'Text (C)','Plain Text | Zip and pack Clipboard text into a Pascal array');

   al;
   at('Insert/Remove','Text | Filter and modify text');
   for p:=1 to 5 do
   begin
   ab1(tepTXT20,cs_pastetext_manipulate_spacetabs,intstr32(p),'+'+k64(p)+' Space'+insstr('s',p<>1),'Insert Space | Insert '+k64(p)+' leading space(s) to each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_spacetabs,'-'+intstr32(p),'-'+k64(p)+' Space'+insstr('s',p<>1),'Remove Space | Remove '+k64(p)+' leading space(s) from each line of Clipboard text');
   end;//p
   end

else if m(cs_text_part2) then
   begin
   at('Base64','');
   ab1(tepOpen20,cs_fromfile_makebase64_xxc,'0','Base64 1 line','Base64 | Encode a file to base64');
   ab1(tepOpen20,cs_fromfile_makebase64_xxc,'72','Base64 72c/l','Base64 | Encode a file to base64 with 72 character lines');
   ab1(tepOpen20,cs_fromfile_makebase64_xxc,'990','Base64 990c/l','Base64 | Encode a file to base64 with 990 character lines');
   ab1(tepTXT20,cs_pastetext_makebase64_xxc,'0','Base64 1 line','Base64 | Encode Clipboard text as base64');
   ab1(tepTXT20,cs_pastetext_makebase64_xxc,'72','Base64 72c/l','Base64 | Encode Clipboard text as base64 with 72 character lines');
   ab1(tepTXT20,cs_pastetext_makebase64_xxc,'990','Base64 990c/l','Base64 | Encode Clipboard text as base64 with 990 character lines');

   al;
   at('Text Manipulation','Text Manipulation | Filter and modify text');
   ab1(tepTXT20,cs_pastetext_manipulate,'up','Uppercase','Text Manipulation | Make Clipboard text uppercase');
   ab1(tepTXT20,cs_pastetext_manipulate,'low','Lowercase','Text Manipulation | Make Clipboard text lowercase');
   ab1(tepTXT20,cs_pastetext_manipulate_spacetabs,'0','Trim Spaces','Text Manipulation | Remove common leading space from each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_strip,'l','Remove Leading Whitespace','Text Manipulation | Remove leading whitespace from each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_strip,'t','Remove Trailing Whitespace','Text Manipulation | Remove trailing whitespace from each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_strip,'lt','Remove Lead/Trail Whitespace','Text Manipulation | Remove leading and trailing whitespace from each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_strip,'rs','Space for Return Codes','Text Manipulation | Replace Clipboard text return codes with spaces');
   ab1(tepTXT20,cs_pastetext_manipulate_remchar,'9','Remove Tabs','Text Manipulation | Remove tabs (#9) from Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_remchar,'10','Remove #10','Text Manipulation | Remove return codes (#10) from Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_remchar,'13','Remove #13','Text Manipulation | Remove return codes (#13) from Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_remchar,'32','Remove Spaces','Text Manipulation | Remove spaces (#32) from Clipboard text');
   end

else if m(cs_text_part3) then
   begin
   at('Text Manipulation','Text Manipulation | Filter and modify text');
   ab1(tepTXT20,cs_pastetext_forcereturncodes,'10','Linux Return Codes','Text Manipulation | Force Linux return codes (#10) for Clipboard text');
   ab1(tepTXT20,cs_pastetext_forcereturncodes,'13','Apple Return Codes','Text Manipulation | Force Apple return codes (#13) for Clipboard text');
   ab1(tepTXT20,cs_pastetext_forcereturncodes,'1310','Windows Return Codes','Text Manipulation | Force Windows return codes (#13#10) for Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.filepath','Filepath','Text Manipulation | Filter each line of text in Clipboard as a filepath (path only, no filename)');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.filename','Filename','Text Manipulation | Filter each line of text in Clipboard as a filename (no path)');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.nameonly','Name only','Text Manipulation | Filter each line of text in Clipboard as a filename leaving only the name portion (no path or ext)');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.preadd','Insert','Text Manipulation | Insert text at the beginning of each line of text in Clipboard');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.postadd','Append','Text Manipulation | Append text at the end of each line of text in Clipboard');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.commalist','Comma List','Text Manipulation | Rewrite lines of text in Clipboard into a comma separated list');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.commalists','Comma List ( '' )','Text Manipulation | Rewrite lines of text in Clipboard into a comma separated list with each value bounded by single quotes');
   ab1(tepTXT20,cs_pastetext_manipulate,'lines.commalistd','Comma List ( " )','Text Manipulation | Rewrite lines of text in Clipboard into a comma separated list with each value bounded by double quotes');
   ab1(tepTXT20,cs_pre_post_lines,'bullet0','Insert Bullet','Text Manipulation | Insert a leading bullet "* " into each line of text in Clipboard');
   ab1(tepTXT20,cs_pre_post_lines,'bullet1','Insert Bullet 2','Text Manipulation | Insert a leading bullet " * " into each line of text in Clipboard');
   ab1(tepTXT20,cs_remleadingstr_lines,'','Remove Bullets','Text Manipulation | Remove leading bullet "* ", " * " or " *" from each line of text in Clipboard');
   ab1(tepTXT20,cs_pre_post_lines,'number','Number Lines','Text Manipulation | Number each line of text in Clipboard');
   ab1(tepTXT20,cs_pre_post_lines,'remblank','Remove Blank Lines','Text Manipulation | Remove blank lines from Clipboard text');
   ab1(tepTXT20,cs_remdup,'0','Remove Diuplicates','Text Manipulation | Remove duplicate lines from Clipboard text');
   ab1(tepTXT20,cs_remdup,'1','Remove Diuplicates 2','Text Manipulation | Scan past whitespace and remove duplicate lines from Clipboard text');
   ab1(tepTXT20,cs_charinfo,'','Report Bytes','Text | Scan first 100K of Clipboard text and display position, ASCII code and character for each character of text');
   end

else if m(cs_text_part4) then
   begin
   at('Sort Lines','');
   ab1(tepTXT20,cs_sortlines,'az','Sort A-Z','Sort Lines | Sort lines of text in Clipboard into ascending "A to Z" order');
   ab1(tepTXT20,cs_sortlines,'za','Sort Z-A','Sort Lines | Sort lines of text in Clipboard into descending "Z to A" order');

   al;
   at('Convert','');
   ab1(tepTXT20,cs_utf8_to_ascii,'','UTF-8 to ASCII','Convert | Convert Clipboard text from UTF-8 to ASCII');
   end

else if m(cs_image_part1) then
   begin
   at('Convert','Convert | Convert image');
   ab1(tepOpen20,cs_convertimage,'','Image','Convert | Convert an image file');
   ab1(tepOpen20,cs_convertimage_web,'','Web Image','Convert | Convert a web image file');
   al;
   at('Pascal Array','Pascal Array | Pack an image into a Pascal array and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makearray,cs_nil,'Image','Pascal Array | Pack an image file into a Pascal array and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makearray,cs_zip,'Image (C)','Pascal Array | Zip and pack an image file into a Pascal array and copy to Clipboard');
   sup__imagelist(true);
   while sup__imagelist(false) do ab1(sup__imagetep,cs_pasteimage_makearray,sup__imageext,sup__imageextU,'Pascal Array | Pack Clipboard image into a Pascal array in '+sup__imageextU+' format');
   end

else if m(cs_image_part2) then
   begin
   xtemplate('square',false);
   al;
   at('Mime/Type Base64','Mime/Type Base64 | Encode an image to mime/type base64 and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makebase64,cs_nil,'Image','Mime/Type Base64 | Encode an image file as mime/type base64 and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makebase64,cs_browsersupportedimages,'Web Image','Mime/Type Base64 | Encode a web image as mime/type base64 and copy to Clipboard');
   sup__imagelist(true);
   while sup__imagelist(false) do if sup__extbrowsersupported(sup__imageext) and sup__inlist(sup__imageext,[''],true) then
      begin
      ab1(sup__imagetep,cs_pasteimage_makebase64,sup__imageext,sup__imageextU,'Mime/Type Base64 | Encode Clipboard image as mime/type base64 in '+sup__imageextU+' format');
      end;
   end

else if m(cs_image_part3) then
   begin
   xtemplate('squircle',true);
   al;
   xtemplate('squircle',false);
   end

else if m(cs_image_part4) then
   begin
   xtemplate('circle',true);
   al;
   xtemplate('circle',false);
   end

else if m(cs_image_part5) then
   begin
   xblankimages(true);
   end

else if m(cs_image_part6) then
   begin
   xblankimages(false);
   end

else if m(cs_code_part1) then
   begin
   at('Clone','Clone | Clone project');
   ab1(tepDPR20,cs_make_lazarusproject_fromdelphi,'file','Gossamer Project','Clone | Clone a Gossamer project (Delphi .dpr + .dof) to a Lazarus project (.lpr + .lps + .lpi)');
   ab1(tepDPR20,cs_make_lazarusproject_fromdelphi,'folder','All Gossamer Projects','Clone | Clone all Gossamer projects (Delphi .dpr + .dof) to Lazarus projects (.lpr + .lps + .lpi) in a folder');
   ab1(tepDPR20,cs_make_lazarusproject_fromdelphi,'folder.subfolders','All Gossamer Projects (S)','Clone | Clone all Gossamer projects (Delphi .dpr + .dof) to Lazarus projects (.lpr + .lps + .lpi) in a folder and all sub-folders');

   al;
   at('Clean','Clean | Clean project');
   ab1(tepDPR20,cs_cleanproject,'folder','All Gossamer Projects','Clean | Copy a clean set of project folder files to sub-folder "clean", excluding files "*.dcu", "*.~pa" and "*.ini" and force lowercase filenames');
   ab1(tepDPR20,cs_cleanproject,'folder.subfolders','All Gossamer Projects (S)','Clean | Copy a clean set of project folder files to sub-folder "clean" and repeat for all sub-folders, excluding files "*.dcu", "*.~pa" and "*.ini" and force lowercase filenames');

   al;
   at('Pack','Pack | Pack files');
   ab1(tepOpen20,cs_packfiles_makeunit,'-' ,'Pack files into a unit','Pack | Pack folder files into a Pascal unit');
   ab1(tepOpen20,cs_packfiles_makeunit,'C' ,'Pack files into a unit (C)','Pack | Compress and pack folder files into a Pascal unit');
   ab1(tepOpen20,cs_packfiles_makeunit,'S' ,'Pack files into a unit (S)','Pack | Pack folder and sub-folder files into a Pascal unit');
   ab1(tepOpen20,cs_packfiles_makeunit,'CS','Pack files into a unit (CS)','Pack | Compress and pack folder and sub-folder files into a Pascal unit');

   al;
   at('Mark','Mark | Mark Pascal source code');
   ab1(tepPAS20,cs_markduplicates_code,'0','Duplicates in a unit','Mark | Mark all procedure and function names which are duplicated in other Pascal units (*.pas) in the same folder and copy to Clipboard');
   ab1(tepPAS20,cs_markduplicates_code,'1','Duplicates in a unit (S)','Mark | Mark all procedure and function names which are duplicated in other Pascal units (*.pas) in the same folder or sub-folders and copy to Clipboard');
   ab1(tepPAS20,cs_markduplicates_code,'2','Duplicates in a unit (__)','Mark | Mark all procedure and function names which are duplicated in other Pascal units (*.pas) in the same folder and copy to Clipboard | '+'A double underscore in a name truncates the comparison to the trailing part of the name | For example a procedure with the name "abc__load()" becomes "load()" for comparison purposes');
   ab1(tepPAS20,cs_markduplicates_code,'3','Duplicates in a unit (S__)','Mark | Mark all procedure and function names which are duplicated in other Pascal units (*.pas) in the same folder or sub-folders and copy to Clipboard | '+'A double underscore in a name truncates the comparison to the trailing part of the name | For example a procedure with the name "abc__load()" becomes "load()" for comparison purposes');
   end

else if m(cs_code_part2) then
   begin
   at('Make','Make | Make Chocolatey package');
   ab1(tepnupkg20,cs_choco,'-' ,'Chocolatey package','Make | Pack folder EXEs into a portable Chocolatey package (*.nupkg) | Use this option only if your app is portable - only the EXEs are included');
   ab1(tepnupkg20,cs_choco,'F' ,'Chocolatey package (F)','Make | Pack folder files and EXEs into a portable Chocolatey package (*.nupkg) | Use this option only if your app is portable or has scripts for the installer');
   ab1(tepnupkg20,cs_choco,'FS' ,'Chocolatey package (FS)','Make | Pack folder and sub-folder files and EXEs into a portable Chocolatey package (*.nupkg) | Use this option only if your app is portable or has scripts for the installer');

   al;
   at('Fix','Code | Fix Pascal source code');
   ab1(tepOpen20,cs_cleanunitfiles,'0','Units in a folder','Fix | Fix corrupted return codes and bad characters in all Pascal units (*.pas) and project files (*.dpr) in a folder which can lead to fatal compiler errors');
   ab1(tepOpen20,cs_cleanunitfiles,'1','Units in a folder (S)','Fix | Fix corrupted return codes and bad characters in all Pascal units (*.pas) and project files (*.dpr) in a folder and sub-folders which can lead to fatal compiler errors');

   al;
   at('Compress','');
   ab1(tepZip20,cs_packfiles,cs_nil,'Folder','Compress | Compress folder files into a ZIP archive');
   ab1(tepZip20,cs_packfiles,cs_subfolders,'Folder (S)','Compress | Compress folder files and sub-folders into a ZIP archive');
   end

else if m(cs_code_part3) then
   begin
   at('Pascal Array','Pascal Array | Pack conent into a Pascal array');
   ab1(tepOpen20,cs_fromfile_makearray,cs_nil,'File','Pascal Array | Pack a file into a Pascal array');
   ab1(tepOpen20,cs_fromfile_makearray,cs_zip,'File (C)','Pascal Array | Zip and pack a file into a Pascal array');
   ab1(tepOpen20,cs_openimage_makearray,cs_nil,'Image','Pascal Array | Pack an image into a Pascal array');
   ab1(tepOpen20,cs_openimage_makearray,cs_zip,'Image (C)','Pascal Array | Zip and pack an image file into a Pascal array');
   ab1(tepOpen20,cs_opencolorscheme_makearray,'','Color Scheme','Color Scheme | Pack a color scheme file into a Pascal array');
   ab1(tepBCS20,cs_pastecolorscheme_makearray,'','Color Scheme','Color Scheme | Pack Clipboard color scheme into a Pascal array');
   ab1(tepTXT20,cs_pastetext_makearray,cs_nil,'Text','Plain Text | Pack Clipboard text into a Pascal array');
   ab1(tepTXT20,cs_pastetext_makearray,cs_zip,'Text (C)','Plain Text | Zip and pack Clipboard text into a Pascal array');
   ab1(tepZip20,cs_packfiles_makearray,cs_nil,'Folder','Pack | Compress folder files into a ZIP archive and pack into a Pascal array');
   ab1(tepZip20,cs_packfiles_makearray,cs_subfolders,'Folder (S)','Pack | Compress folder files and sub-folders into a ZIP archive and pack into a Pascal array');
   end

else if m(cs_concise_part1) then
   begin
   at('Compress','');
   ab1(tepZip20,cs_packfiles,cs_nil,'Folder','Compress | Compress folder files into a ZIP archive');
   ab1(tepZip20,cs_packfiles,cs_subfolders,'Folder (S)','Compress | Compress folder files and sub-folders into a ZIP archive');

   al;
   at('Convert','Convert | Convert image');
   ab1(tepOpen20,cs_convertimage,'','Image','Convert | Convert an image file');
   ab1(tepOpen20,cs_convertimage_web,'','Web Image','Convert | Convert a web image file');

   al;
   at('Pascal Array','Pascal Array | Pack an image into a Pascal array and copy to Clipboard');
   ab1(tepOpen20,cs_fromfile_makearray,cs_nil,'File','Pascal Array | Pack a file into a Pascal array');
   ab1(tepOpen20,cs_fromfile_makearray,cs_zip,'File (C)','Pascal Array | Zip and pack a file into a Pascal array');
   ab1(tepOpen20,cs_openimage_makearray,cs_nil,'Image','Pascal Array | Pack an image into a Pascal array');
   ab1(tepOpen20,cs_openimage_makearray,cs_zip,'Image (C)','Pascal Array | Zip and pack an image file into a Pascal array and copy to Clipboard');

   sup__imagelist(true);
   while sup__imagelist(false) do if sup__inlist(sup__imageext,['png','jpg','tea'],true) then ab1(sup__imagetep,cs_pasteimage_makearray,sup__imageext,sup__imageextU,'Pascal Array | Pack Clipboard image into a Pascal array in '+sup__imageextU+' format');

   ab1(tepBCS20,cs_pastecolorscheme_makearray,'','Color Scheme','Color Scheme | Pack Clipboard color scheme into a Pascal array');
   ab1(tepTXT20,cs_pastetext_makearray,cs_nil,'Text','Plain Text | Pack Clipboard text into a Pascal array');
   ab1(tepTXT20,cs_pastetext_makearray,cs_zip,'Text (C)','Plain Text | Zip and pack Clipboard text into a Pascal array');
   end

else if m(cs_concise_part2) then
   begin
   xtemplate('square',true);
   al;
   xtemplate('squircle',true);
   al;
   xtemplate('circle',true);
   al;
   xblankimages(true);
   end

else if m(cs_concise_part3) then
   begin
   at('Mime/Type Base64','Mime/Type Base64 | Encode an image to mime/type base64 and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makebase64,cs_nil,'Image','Mime/Type Base64 | Encode an image file as mime/type base64 and copy to Clipboard');
   ab1(tepOpen20,cs_openimage_makebase64,cs_browsersupportedimages,'Web Image','Mime/Type Base64 | Encode a web image as mime/type base64 and copy to Clipboard');
   sup__imagelist(true);
   while sup__imagelist(false) do if sup__extbrowsersupported(sup__imageext) and sup__inlist(sup__imageext,['jpg','png','gif'],true) then
      begin
      ab1(sup__imagetep,cs_pasteimage_makebase64,sup__imageext,sup__imageextU,'Mime/Type Base64 | Encode Clipboard image as mime/type base64 in '+sup__imageextU+' format');
      end;

   at('Base64','');
   ab1(tepOpen20,cs_fromfile_makebase64_xxc,'72','Base64 72c/l','Base64 | Encode a file to base64 with 72 character lines');
   ab1(tepTXT20,cs_pastetext_makebase64_xxc,'72','Base64 72c/l','Base64 | Encode Clipboard text as base64 with 72 character lines');

   al;
   at('Insert/Remove','Text | Filter and modify text');
   for p:=3 to 5 do if (p<>4) then
   begin
   ab1(tepTXT20,cs_pastetext_manipulate_spacetabs,intstr32(p),'+'+k64(p)+' Space'+insstr('s',p<>1),'Insert Space | Insert '+k64(p)+' leading space(s) to each line of Clipboard text');
   ab1(tepTXT20,cs_pastetext_manipulate_spacetabs,'-'+intstr32(p),'-'+k64(p)+' Space'+insstr('s',p<>1),'Remove Space | Remove '+k64(p)+' leading space(s) from each line of Clipboard text');
   end;//p

   at('Sort Lines','');
   ab1(tepTXT20,cs_sortlines,'az','Sort A-Z','Sort Lines | Sort lines of text in Clipboard into ascending "A to Z" order');
   ab1(tepTXT20,cs_sortlines,'za','Sort Z-A','Sort Lines | Sort lines of text in Clipboard into descending "Z to A" order');

   al;
   at('Convert','');
   ab1(tepTXT20,cs_utf8_to_ascii,'','UTF-8 to ASCII','Convert | Convert Clipboard text from UTF-8 to ASCII');
   end

else if m(cs_concise_part4) then
   begin
   at('Clone','Code | Clone project');
   ab1(tepDPR20,cs_make_lazarusproject_fromdelphi,'file','Gossamer Project','Clone | Clone a Gossamer project (Delphi .dpr + .dof) to a Lazarus project (.lpr + .lps + .lpi)');

   al;
   at('Make','Make | Make Chocolatey package');
   ab1(tepnupkg20,cs_choco,'-' ,'Chocolatey package','Make | Pack folder EXEs into a portable Chocolatey package (*.nupkg) | Use this option only if your app is portable - only the EXEs are included');
   ab1(tepnupkg20,cs_choco,'F' ,'Chocolatey package (F)','Make | Pack folder files and EXEs into a portable Chocolatey package (*.nupkg) | Use this option only if your app is portable or has scripts for the installer');

   al;
   at('Pack','Pack | Pack files');
   ab1(tepOpen20,cs_packfiles_makeunit,'-','Pack files into a unit','Pack | Pack folder files into a Pascal unit');
   ab1(tepOpen20,cs_packfiles_makeunit,'C' ,'Pack files into a unit (C)','Pack | Compress and pack folder files into a Pascal unit');

   al;
   at('Mark','Code | Mark Pascal source code');
   ab1(tepPAS20,cs_markduplicates_code,'0','Duplicates in a unit','Mark | Mark all procedure and function names which are duplicated in other Pascal units (*.pas) in the same folder and copy to Clipboard');

   al;
   at('Fix','Code | Fix Pascal source code');
   ab1(tepOpen20,cs_cleanunitfiles,'0','Units in a folder','Fix | Fix corrupted return codes and bad characters in all Pascal units (*.pas) and project files (*.dpr) in a folder which can lead to fatal compiler errors');
   end

else
   begin
   showerror('Command option "'+n+'" not supported');
   end;

end;

procedure tworkpanel.makeconcise;
begin
xnewbar;
addbyname(cs_concise_part1);

xnewbar.oscaleh:=1.04;
addbyname(cs_concise_part2);

xnewbar;
addbyname(cs_concise_part3);

xnewbar;
addbyname(cs_concise_part4);
end;

procedure tworkpanel.maketext;
begin
xnewbar;
addbyname(cs_text_part1);

xnewbar;
addbyname(cs_text_part2);

xnewbar;
addbyname(cs_text_part3);

xnewbar;
addbyname(cs_text_part4);
end;

procedure tworkpanel.makeimage;
begin
xnewbar;
addbyname(cs_image_part1);

xnewbar;
addbyname(cs_image_part2);

xnewbar;
addbyname(cs_image_part3);

xnewbar;
addbyname(cs_image_part4);

xnewbar;
addbyname(cs_image_part5);

xnewbar;
addbyname(cs_image_part6);
end;

procedure tworkpanel.makecode;
begin
xnewbar;
addbyname(cs_code_part1);

xnewbar;
addbyname(cs_code_part2);

xnewbar;
addbyname(cs_code_part3);
end;

procedure tworkpanel.__onclick(sender:tobject);
begin
xcmd(sender,0,'');
end;

procedure tworkpanel.xcmd(sender:tobject;xcode:longint;xcode2:string);
label
   redo_cs_choco,choco,skipend;
var
   xpromptagain,xresult:boolean;
   str1,e,lv,v,v2,v3:string;
   xcount,vint,vint2,vint3:longint;
   xvars:tfastvars;

   function m(x:string):boolean;//full match
   begin
   result:=strmatch(x,xcode2);
   end;

   function m2(x:string):boolean;//partial match
   var
      xlen:longint;
   begin
   xlen  :=low__len(x)+1;
   result:=strmatch(x+'.',strcopy1(xcode2,1,xlen));
   if result then
      begin
      v   :=strcopy1(xcode2,xlen+1,low__len(xcode2));
      lv  :=strlow(v);
      vint:=strint32(v);
      end;
   end;

   function m22(x:string):boolean;//partial match and split "v" into 2 parts
   var
      str1:string;
   begin
   //get
   result:=m2(x);
   str1  :=v;
   low__splitstr(str1,ssDot,v,v2);

   //set
   lv   :=strlow(v);
   vint :=strint32(v);
   vint2:=strint32(v2);
   end;

   function m23(x:string):boolean;//partial match and split "v" into 2 parts
   var
      str1:string;
   begin
   //get
   result:=m2(x);
   str1  :=v;
   low__splitstr(str1,ssDot,v,v2);

   str1:=v2;
   low__splitstr(str1,ssDot,v2,v3);

   //set
   lv   :=strlow(v);
   vint :=strint32(v);
   vint2:=strint32(v2);
   vint3:=strint32(v3);
   end;

   function mv(x:string):boolean;
   begin
   result:=strmatch(x,v);
   end;

   function eTaskfailed:boolean;
   begin
   result:=true;
   e:=gecTaskfailed;
   end;

   function xlaz_makecount(xcount:longint):string;
   begin
   case xcount of
   0      :result:='No Gossamer projects were found.';
   1      :result:='1 Gossamer project was cloned.';
   else    result:=k64(xcount)+' Gossamer projects were cloned.';
   end;//case
   end;

   function xclean_makecount(xcount:longint):string;
   begin
   case xcount of
   0      :result:='No project folders were clean.';
   1      :result:='1 project folder was cleaned.';
   else    result:=k64(xcount)+' project folders were cleaned.';
   end;//case
   end;
begin
try
//defaults
xresult :=false;
e       :=gecTaskfailed;
xvars   :=nil;

//init
if (sender<>nil) and (sender is tbasictoolbar) then
   begin
   xcode :=(sender as tbasictoolbar).ocode;
   xcode2:=(sender as tbasictoolbar).ocode2;
   end;
v     :='';
lv    :='';
v2    :='';
v3    :='';
vint  :=0;
vint2 :=0;
vint3 :=0;


//array ------------------------------------------------------------------------
if m2(cs_pastetext_makearray) then
   begin
   if not sup__pastetext(e)                   then goto skipend;
   if mv(cs_zip) and (not sup__compress(e))   then goto skipend;
   if not sup__makearray(sup__pname('text.','txt'),e) then goto skipend;
   if not sup__copytext(e)                    then goto skipend;
   end
else if m(cs_opencolorscheme_makearray) then
   begin
   if not sup__openprompt(febcs,e)  then goto skipend;
   sup__makecolors(io__remlastext(sup_openfile));
   if not sup__copytext(e)          then goto skipend;
   end
else if m(cs_pastecolorscheme_makearray) then
   begin
   if not sup__pastetext(e)   then goto skipend;
   sup__makecolors('untitled');
   if not sup__copytext(e)    then goto skipend;
   end
else if m2(cs_fromfile_makearray) then
   begin
   if not sup__openprompt(feany,e)                            then goto skipend;
   if mv(cs_zip) and (not sup__compress(e))                   then goto skipend;
   if not sup__makearray(sup__pname('file__',sup_openfile),e) then goto skipend;
   if not sup__copytext(e)                                    then goto skipend;
   end
else if m2(cs_openimage_makearray) then
   begin
   if not sup__openimageprompt(e)                                  then goto skipend;
   if mv(cs_zip) and (not sup__compress(e))                        then goto skipend;
   if not sup__makearray(sup__pname('file__',sup_openimagefile),e) then goto skipend;
   if not sup__copytext(e)                                         then goto skipend;
   end
else if m2(cs_pasteimage_makearray) then
   begin
   if not sup__pasteimage(e)                    then goto skipend;
   if not sup__imagetodata(v,ia_goodquality,e)  then goto skipend;
   if not sup__makearray('image_'+strlow(v),e)             then goto skipend;
   if not sup__copytext(e)                      then goto skipend;
   end
else if m2(cs_packfiles_makearray) then
   begin
   if sup__openfolder('') then
      begin
      sup__dataclear;
      if not sup__packfiles(sup_openfolder,mv(cs_subfolders),e)                                               then goto skipend;
      if not sup__makearray(sup__pname('ziparchive__',io__lastfoldername(sup_openfolder,'untitled')),e)  then goto skipend;
      if not sup__copytext(e)                                                                                 then goto skipend;
      end;
   end
else if m2(cs_packfiles_makeunit) then
   begin
   if sup__openfolder('') then
      begin
      if not sup__packfiles_makeunit(sup_openfolder,'*','',mv('CS') or mv('C'),mv('CS') or mv('S'),e) then goto skipend;
      if not sup__saveprompt2(fepas,true,e)                                                             then goto skipend;
      //reduce memory
      sup__dataclear;
      end;
   end

//base64 -----------------------------------------------------------------------
else if m2(cs_fromfile_makebase64) then
   begin
   if not sup__openprompt(peany,e)                        then goto skipend;
   if not sup__datatobase64(io__lastext(sup_openfile),e)  then goto skipend;
   if not sup__copytext(e)                                then goto skipend;
   end
else if m2(cs_fromfile_makebase64_xxc) then
   begin
   if not sup__openprompt(peany,e)                        then goto skipend;
   if not sup__tob64(vint,e)                              then goto skipend;
   if not sup__copytext(e)                                then goto skipend;
   end
else if m2(cs_openimage_makebase64) then
   begin
   if mv(cs_browsersupportedimages) then
      begin
      if not sup__openimageprompt_browsersupported(e)             then goto skipend;
      if not sup__datatobase64(io__lastext(sup_openimagefile0),e) then goto skipend;
      end
   else
      begin
      if not sup__openimageprompt(e)                              then goto skipend;
      if not sup__datatobase64(io__lastext(sup_openimagefile),e)  then goto skipend;
      end;

   if not sup__copytext(e)                                        then goto skipend;
   end
else if m2(cs_pasteimage_makebase64) then
   begin
   if not sup__pasteimage(e)                    then goto skipend;
   if not sup__imagetodata(v,ia_goodquality,e)  then goto skipend;
   if not sup__datatobase64(v,e)                then goto skipend;
   if not sup__copytext(e)                      then goto skipend;
   end
else if m(cs_pastetext_makebase64) then
   begin
   if not sup__pastetext(e)                    then goto skipend;
   if not sup__datatobase64('txt',e)           then goto skipend;
   if not sup__copytext(e)                     then goto skipend;
   end
else if m2(cs_pastetext_makebase64_xxc) then
   begin
   if not sup__pastetext(e)                    then goto skipend;
   if not sup__tob64(vint,e)                   then goto skipend;
   if not sup__copytext(e)                     then goto skipend;
   end


//file -------------------------------------------------------------------------
else if m2(cs_packfiles) then
   begin
   if sup__openfolder('') then
      begin
      sup__dataclear;
      if not sup__packfiles(sup_openfolder,mv(cs_subfolders),e)  then goto skipend;
      if not sup__uniquename(sup_openfolder,feZIP,sup_savefile)  then goto skipend;
      if not sup__saveprompt(feZIP,e)                            then goto skipend;
      end;
   end
else if m(cs_convertimage_web) then
   begin
   if not sup__openimageprompt_browsersupported(e) then goto skipend;
   if not sup__datatoimage(e)                      then goto skipend;
   if not sup__saveimageprompt(e)                  then goto skipend;
   end
else if m(cs_convertimage) then
   begin
   if not sup__openimageprompt(e) then goto skipend;
   if not sup__datatoimage(e)     then goto skipend;
   if not sup__saveimageprompt(e) then goto skipend;
   end


//text manipulation ------------------------------------------------------------
else if m2(cs_pastetext_manipulate) then
   begin
   if not sup__pastetext(e)                    then goto skipend;
   if not sup__manipulatetext(v,e)             then goto skipend;
   if not sup__copytext(e)                     then goto skipend;
   end
else if m2(cs_pastetext_manipulate_spacetabs) then
   begin
   if not sup__pastetext(e)                    then goto skipend;
   if not sup__insertspace(vint,e)             then goto skipend;
   if not sup__copytext(e)                     then goto skipend;
   end
else if m2(cs_pastetext_manipulate_strip) then
   begin
   if not sup__pastetext(e)                                                                            then goto skipend;
   if not sup__stripwhitespace(mv('l') or mv('lt'),mv('t') or mv('lt'),mv('r') or mv('rs'),mv('rs'),e) then goto skipend;
   if not sup__copytext(e)                                                                             then goto skipend;
   end
else if m2(cs_pastetext_manipulate_remchar) then
   begin
   if not sup__pastetext(e)                                                                            then goto skipend;
   if (not str__remchar(@sup_data,frcrange32(vint,0,255))) and eTaskfailed                             then goto skipend;
   if not sup__copytext(e)                                                                             then goto skipend;
   end
else if m2(cs_pastetext_forcereturncodes) then
   begin
   if mv('10') or mv('13') or mv('1310') then
      begin
      if not sup__pastetext(e)                                                                                then goto skipend;
      if not sup__forcereturncodestyle( mv('10') or mv('1310'), mv('13') or mv('1310'), true) and eTaskfailed then goto skipend;
      if not sup__copytext(e)                                                                                 then goto skipend;
      end;
   end
else if m2(cs_pre_post_lines) then
   begin
   if not sup__pastetext(e)                                                         then goto skipend;

   if      mv('bullet0') and (not sup__pre_post_lines(true,false,'* ','',rcode,e))  then goto skipend
   else if mv('bullet1') and (not sup__pre_post_lines(true,false,' * ','',rcode,e)) then goto skipend
   else if mv('number')  and (not sup__pre_post_lines(true,true,'. ','',rcode,e))   then goto skipend
   else if mv('remblank')  and (not sup__pre_post_lines(false,false,'','',rcode,e)) then goto skipend;

   if not sup__copytext(e)                                                          then goto skipend;
   end
else if m(cs_remleadingstr_lines) then
   begin
   if not sup__pastetext(e)                              then goto skipend;
   if not sup__removeleadingstr_lines('* ',' * ',' *',e) then goto skipend;
   if not sup__copytext(e)                               then goto skipend;
   end
else if m2(cs_sortlines) then
   begin
   if not sup__pastetext(e)          then goto skipend;
   if not sup__sortlines(mv('az'),e) then goto skipend;
   if not sup__copytext(e)           then goto skipend;
   end
else if m(cs_utf8_to_ascii) then
   begin
   if not sup__pastetext(e)          then goto skipend;
   if not sup__utf8_to_ascii(e)      then goto skipend;
   if not sup__copytext(e)           then goto skipend;
   end
else if m2(cs_remdup) then
   begin
   if not sup__pastetext(e)          then goto skipend;
   if not sup__remdup(vint<>0,e)     then goto skipend;
   if not sup__copytext(e)           then goto skipend;
   end
else if m(cs_charinfo) then
   begin
   if not sup__pastetext(e)          then goto skipend;
   sup__charinfo;
   end


//code -------------------------------------------------------------------------
else if m2(cs_markduplicates_code) then
   begin
   if not sup__openprompt2(fepas,false,e) then goto skipend;

   if      mv('0') then sup__markduplicate_procnames(sup_openfile,false,false)
   else if mv('1') then sup__markduplicate_procnames(sup_openfile,false,true)
   else if mv('2') then sup__markduplicate_procnames(sup_openfile,true,false)
   else if mv('3') then sup__markduplicate_procnames(sup_openfile,true,true)
   else                 sup__markduplicate_procnames(sup_openfile,false,false);
   end
else if m2(cs_cleanproject) then
   begin
   if mv('folder') or mv('folder.subfolders') then
      begin
      if sup__openfolder('*.dpr') then
         begin
         if not sup__cleanproject(sup_openfolder,mv('folder.subfolders'),xcount,e) then goto skipend;
         app__gui.popmsg('',xclean_makecount(xcount));
         end;
      end
   end
else if m2(cs_make_lazarusproject_fromdelphi) then
   begin
   if mv('folder') or mv('folder.subfolders') then
      begin
      if sup__openfolder('*.dpr') then
         begin
         if not d2laz__makeproject3(sup_openfolder,mv('folder.subfolders'),xcount,e) then goto skipend;
         app__gui.popmsg('',xlaz_makecount(xcount));
         end;
      end
   else//file
      begin
      if not sup__openprompt2(fedpr,false,e)     then goto skipend;
      if not d2laz__makeproject2(sup_openfile,e) then goto skipend;
      app__gui.popmsg('',xlaz_makecount(1));
      end;
   end
else if m2(cs_cleanunitfiles) then
   begin
   if sup__openfolder('*.pas') then sup__cleanunitfiles(sup_openfolder,vint<>0);
   end
else if m2(cs_choco) then
   begin
redo_cs_choco:
   if sup__openfolder( low__aorbstr('*.exe;','*',mv('F') or mv('FS')) ) then
      begin
      xvars:=tfastvars.create;//for duplicates

      //.build Chocolatey package
      if not choco__makeportablepackage(@sup_data,sup_openfolder,mv('F') or mv('FS'),mv('FS'),xvars,xpromptagain,str1,e) then
         begin
         if xpromptagain then
            begin
            gui.poperror('',e);
            goto redo_cs_choco;
            end
         else if (e=gecTaskCancelled) then xresult:=true;//suppress error

         goto skipend;
         end;
      sup_savefile:=io__extractfilepath(sup_savefile)+str1;

      //.save package to file
      choco:
      if not sup__saveprompt(fenupkg,e) then
         begin
         if (e<>'') then
            begin
            app__gui.poperror('',e);
            goto choco;//try again to save
            end
         else
            begin
            sup__dataclear;
            goto skipend;
            end;
         end;

      //clear
      sup__dataclear;

      //save optional duplicates to sub-folder
      if (xvars.count>=1) and (not choco__saveduplicates(sup_savefile,xvars,e)) then goto skipend;
      end;
   end

//image ------------------------------------------------------------------------
else if m22(cs_blankimages) then
   begin
   if (not missize(sup_image,vint,vint)) and eTaskfailed then goto skipend;
   if (not miscls(sup_image,vint2)) and eTaskfailed      then goto skipend;
   if not sup__copyimage(e)                              then goto skipend;
   end

else if m23(cs_imagetemplate) then
   begin
   if not sup__imagetemplate(v,vint2,vint2,vint3<>0,e)   then goto skipend;
   if not sup__copyimage(e)                              then goto skipend;
   end

//error ------------------------------------------------------------------------
else
   begin
   e:='Command not found';
   goto skipend;
   end;


//successful
xresult:=true;
skipend:
except;end;
//free
freeobj(@xvars);
//error
if (not xresult) and (e<>'') then gui.poperror('',e);
end;


//## tapp ######################################################################
constructor tapp.create;
begin
if system_debug then dbstatus(38,'Debug 010 - 21may2021_528am');//yyyy


//check source code for know problems ------------------------------------------
//io__sourecode_checkall(['']);


//self
inherited create(strint32(app__info('width')),strint32(app__info('height')),true);
ibuildingcontrol:=true;
iloaded:=false;

//start support procs
sup__start;

//need checkers
need_jpeg;
need_gif;
need_ico;

//init
itimer500:=ms64;
//vars
iloaded:=false;


//controls
with rootwin do
begin
scroll:=false;
xhead;
xgrad;
xgrad2;
xstatus2.celltext[0]:='Tools for packing files, converting images, manipulating text, checking source code and working with the Gossamer codebase by Blaiz Enterprises';
xstatus2.cellalign[0]:=0;
end;


//window.header.toolbar links - 22mar2021
workpanel__new(rootwin,tepHome20,'Overview','','Tools | Concise set of tools for general tasks and working with Gossamer source code and packaged data').makeconcise;
workpanel__new(rootwin,tepBMP20,'Image','','Image | Image tools').makeimage;
workpanel__new(rootwin,tepTXT20,'Text','','Text | Clipboard text manipulation tools').maketext;
workpanel__new(rootwin,tepDPR20,'Code','','Code | Code tools').makecode;


with rootwin do
begin
xhead.addsep;
xhead.xaddoptions;
xhead.xaddhelp;
end;


//default page to show
rootwin.xhead.parentpage:='overview';

//events
rootwin.xhead.onclick:=__onclick;
rootwin.xhead.showmenuFill1:=xshowmenuFill1;
rootwin.xhead.showmenuClick1:=xshowmenuClick1;
rootwin.xhead.ocanshowmenu:=true;//use toolbar for special menu display - 18dec2021

//start timer event
ibuildingcontrol:=false;
xloadsettings;

//finish
createfinish;
end;

destructor tapp.destroy;
begin
try
//settings
xautosavesettings;

//self
inherited destroy;

//stop support procs
sup__stop;
except;end;
end;


procedure tapp.xcmd(sender:tobject;xcode:longint;xcode2:string);
label
   skipend;
var
   str1,e:string;
begin//use for testing purposes only - 15mar2020
try
//defaults
e:='';

//init
if zzok(sender,7455) and (sender is tbasictoolbar) then
   begin
   //ours next
   xcode:=(sender as tbasictoolbar).ocode;
   xcode2:=strlow((sender as tbasictoolbar).ocode2);
   end;

//successful
skipend:
except;end;
if (e<>'') then gui.popstatus(e,2);
end;


procedure tapp.xshowmenuFill1(sender:tobject;xstyle:string;xmenudata:tstr8;var ximagealign:longint;var xmenuname:string);
begin
try
//check
if zznil(xmenudata,5000) then exit;

except;end;
end;

function tapp.xshowmenuClick1(sender:tbasiccontrol;xstyle:string;xcode:longint;xcode2:string;xtepcolor:longint):boolean;
begin
result:=true;xcmd(nil,0,xcode2);
end;

procedure tapp.xloadsettings;
var
   a:tvars8;
begin
try
//defaults
a:=nil;
//check
if zznil(prgsettings,5001) then exit;

//init
a:=vnew2(950);
//filter
//a.s['openfolder']    :=prgsettings.sdef('openfolder','');
//a.s['openfilename']  :=prgsettings.sdef('openfilename','');
//a.s['savefilename']  :=prgsettings.sdef('savefilename','');

//a.b['omaxscreen_entirescreen']   :=prgsettings.bdef('omaxscreen_entirescreen',false);

//io__makeportablefilename(ilastopenfolder);


//a.i['tool']    :=prgsettings.idef('tool',longint(tpen));
//.tools
//gui.omaxscreen_entirescreen:=a.b['omaxscreen_entirescreen'];

//sync
prgsettings.data:=a.data;

//set
//ilastopenfolder      :=io__asfolderNIL(io__readportablefilename(a.s['openfolder']));
//ilastopenfilename    :=io__readportablefilename(a.s['openfilename']);
//ilastsavefilename    :=io__readportablefilename(a.s['savefilename']);
except;end;
//free
freeobj(@a);
iloaded:=true;
end;

procedure tapp.xsavesettings;
var
   a:tvars8;
begin
try
//check
if not iloaded then exit;

//defaults
a:=nil;
a:=vnew2(951);

//get
//a.s['openfolder']:=io__makeportablefilename(ilastopenfolder);
//a.s['openfilename']:=io__makeportablefilename(io__asfolderNIL(io__extractfilepath(ilastopenfilename)));//don't store filenames in case it refers to a LARGE file or something that may prevent program from starting from a previous error
//a.s['savefilename']:=io__makeportablefilename(io__asfolderNIL(io__extractfilepath(ilastsavefilename)));

//set
prgsettings.data:=a.data;
siSaveprgsettings;
except;end;
//free
freeobj(@a);
end;

procedure tapp.xautosavesettings;
var
   bol1:boolean;
begin
try
//check
if not iloaded then exit;
//get
bol1:=false;
//if low__setstr(isettingsref,ilastopenfolder+#1+ilastopenfilename+#1+ilastsavefilename+#1) then bol1:=true;
//set
if bol1 then xsavesettings;
except;end;
end;

procedure tapp.__onclick(sender:tobject);
begin
try;xcmd(sender,0,'');except;end;
end;

procedure tapp.__ontimer(sender:tobject);//._ontimer
begin
try
//init


//timer500
if (ms64>=itimer500) then
   begin
   //savesettings
   xautosavesettings;

   //reset
   itimer500:=ms64+500;
   end;

//debug tests
if system_debug then debug_tests;
except;end;
end;

end.
