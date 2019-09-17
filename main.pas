Unit Main;

Interface

Uses
  Classes, Forms, Graphics, Buttons, StdCtrls, ComCtrls, ExtCtrls;

Type

  DATA_REC=RECORD
   LENGTH,LEVEL1,LEV1MULT,LEVEL2,LEV2MULT:WORD
  END;


  TMain_DLG = Class (TForm)
    Button3: TButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TrackBar1: TTrackBar;
    MenuItem5: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem4: TMenuItem;
    MainMenu1: TMainMenu;
    MenuItem2: TMenuItem;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    MenuItem11: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem10: TMenuItem;
    Shape1: TShape;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    Procedure MenuItem65OnClick (Sender: TObject);
    Procedure MenuItem7OnClick (Sender: TObject);
    Procedure MenuItem8OnClick (Sender: TObject);
    Procedure MenuItem6OnClick (Sender: TObject);
    Procedure MenuItem3OnClick (Sender: TObject);
    Procedure MenuItem9OnClick (Sender: TObject);
    Procedure Button2OnClick (Sender: TObject);
    Procedure MenuItem1OnClick (Sender: TObject);
    Procedure Edit1OnChange (Sender: TObject);
    Procedure TrackBar1OnChange (Sender: TObject);
    Procedure Form1OnCreate (Sender: TObject);
    Procedure Button3OnClick (Sender: TObject);
    Procedure Button1OnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

  FUNCTION SETMOUSEACCEL(NEW:DATA_REC):INTEGER;
  FUNCTION GETMOUSEACCEL:DATA_REC;


Var
  Main_DLG: TMain_DLG;

Implementation

uses sysutils,bsedos,BSEDEV,OS2DEF,about,PMWP,tips;

Procedure TMain_DLG.MenuItem65OnClick (Sender: TObject);
var GUNKLWRD1:LONGWORD;
Begin
  menuitem65.checked:=true;  menuitem7.checked:=false;
  GUNKLWRD1:=WINQUERYOBJECT('<MouseSmart_Startup>');
  WINDESTROYOBJECT(GUNKLWRD1);

End;

Procedure TMain_DLG.MenuItem7OnClick (Sender: TObject);
VAR RC:INTEGER;
    SETUPSTRING,CURDIR:STRING;
Begin
  menuitem7.checked:=true;  menuitem65.checked:=false;
  GETDIR(0,CURDIR);
  SETUPSTRING:='OBJECTID=<MouseSmart_Startup>;EXENAME='+CURDIR+'\MOUSESMT.EXE;PARAMETERS='+INTTOSTR(TRACKBAR1.POSITION)+' '+INTTOSTR(TRACKBAR2.POSITION)+' '+INTTOSTR(TRACKBAR3.POSITION)+' '+INTTOSTR(TRACKBAR4.POSITION);
  RC:=WINCREATEOBJECT('WPProgram','MouseSmart Startup',SETUPSTRING,'<WP_START>',1);
  //MessageBox2('Object creation completed with a return code of : '+INTTOSTR(RC),mtInformation,[MBOK]);
End;

Procedure TMain_DLG.MenuItem8OnClick (Sender: TObject);
Begin
  Tips_dlg.show;
End;

Procedure TMain_DLG.MenuItem9OnClick (Sender: TObject);
Begin
  about_dlg.show;
End;


Procedure TMain_DLG.MenuItem6OnClick (Sender: TObject);
var SETUPSTRING,CURDIR:STRING;
Begin
  GETDIR(0,CURDIR);
  SETUPSTRING:='PARAMETERS= ;EXENAME='+CURDIR+'\MOUSESMT.EXE;OBJECTID=<MouseSmart>';
  WINCREATEOBJECT('WPProgram','MouseSmart',SETUPSTRING,'<WP_CONFIG>',1);
End;

Procedure TMain_DLG.MenuItem3OnClick (Sender: TObject);
Begin
  close;
End;

Procedure TMain_DLG.Button2OnClick (Sender: TObject);
Begin
  TRACKBAR1.POSITION:=3;
  TRACKBAR2.POSITION:=2;
  TRACKBAR3.POSITION:=20;
  TRACKBAR4.POSITION:=4;
  BUTTON3.ENABLED:=TRUE;
End;

Procedure TMain_DLG.MenuItem1OnClick (Sender: TObject);
Begin
  button3.click;
End;

Procedure TMain_DLG.Edit1OnChange (Sender: TObject);
Begin
  TRACKBAR1.POSITION:=STRTOINT(EDIT1.CAPTION);
  TRACKBAR2.POSITION:=STRTOINT(EDIT2.CAPTION);
  TRACKBAR3.POSITION:=STRTOINT(EDIT3.CAPTION);
  TRACKBAR4.POSITION:=STRTOINT(EDIT4.CAPTION);
  BUTTON3.ENABLED:=TRUE;
End;

Procedure TMain_DLG.TrackBar1OnChange (Sender: TObject);
Begin
  edit1.caption:=INTTOSTR(TRACKBAR1.POSITION);
  edit2.caption:=INTTOSTR(TRACKBAR2.POSITION);
  edit3.caption:=INTTOSTR(TRACKBAR3.POSITION);
  edit4.caption:=INTTOSTR(TRACKBAR4.POSITION);
  BUTTON3.ENABLED:=TRUE;
End;

Procedure TMain_DLG.Form1OnCreate (Sender: TObject);
VAR DATA:DATA_REC;
    GUNKLWRD1:LONGWORD;
Begin
  if PARAMCOUNT=4 THEN BEGIN
    DATA.LEVEL1:=STRTOINT(ParamStr(1));
    DATA.LEV1MULT:=STRTOINT(ParamStr(2));
    DATA.LEVEL2:=STRTOINT(ParamStr(3));
    DATA.LEV2MULT:=STRTOINT(ParamStr(4));
    SETMOUSEACCEL(DATA);
    HALT;
  END
  ELSE BEGIN
    DATA:=GETMOUSEACCEL;
    TRACKBAR1.POSITION:=DATA.LEVEL1;
    TRACKBAR2.POSITION:=DATA.LEV1MULT;
    TRACKBAR3.POSITION:=DATA.LEVEL2;
    TRACKBAR4.POSITION:=DATA.LEV2MULT;
    BUTTON3.ENABLED:=FALSE;
  END;

  GUNKLWRD1:=WINQUERYOBJECT('<MouseSmart_Startup>');
  if GUNKLWRD1<>0 then begin menuitem65.checked:=false; menuitem7.checked:=true; end
  else begin menuitem7.checked:=false; menuitem65.checked:=true; end;
End;

Procedure TMain_DLG.Button1OnClick (Sender: TObject);
BEGIN
  CLOSE;
END;

Procedure TMain_DLG.Button3OnClick (Sender: TObject);
VAR DATA:DATA_REC;
Begin
  DATA.LEVEL1:=TRACKBAR1.POSITION;
  DATA.LEV1MULT:=TRACKBAR2.POSITION;
  DATA.LEVEL2:=TRACKBAR3.POSITION;
  DATA.LEV2MULT:=TRACKBAR4.POSITION;
  SETMOUSEACCEL(DATA);
  BUTTON3.ENABLED:=FALSE;
End;

FUNCTION SETMOUSEACCEL(NEW:DATA_REC):INTEGER;
var handle:longword;
    ParmLengthMax,ParmLengthInOut,DataLengthMax,DataLengthInOut:ULONG;
    RC,GUNK:LONGWORD;
BEGIN
  rc:=dosopen('/dev/mouse$',handle,gunk,0,0,OPEN_ACTION_OPEN_IF_EXISTS,$42,nil);
  ParmLengthMax:=SIZEOF(NEW);ParmLengthInOut:=SIZEOF(NEW);DataLengthMax:=SIZEOF(NEW);NEW.LENGTH:=SIZEOF(NEW);
  RC:=DOSDEVIOCTL(HANDLE,IOCTL_POINTINGDEVICE,MOU_SETHOTKEYBUTTON,NEW,ParmLengthMax,ParmLengthInOut,NIL,0,DataLengthMax);
  DOSCLOSE(HANDLE);
  RESULT:=RC;
END;


FUNCTION GETMOUSEACCEL:DATA_REC;
var handle:longword;
    ParmLengthMax,ParmLengthInOut,DataLengthMax,DataLengthInOut:ULONG;
    RC,GUNK:LONGWORD;
    BUF:DATA_REC;
BEGIN
  rc:=dosopen('/dev/mouse$',handle,gunk,0,0,OPEN_ACTION_OPEN_IF_EXISTS,$42,nil);
  ParmLengthMax:=0;ParmLengthInOut:=0;DataLengthInOut:=SIZEOF(BUF);DataLengthMax:=SIZEOF(BUF);BUF.LENGTH:=SIZEOF(BUF);
  RC:=DOSDEVIOCTL(HANDLE,IOCTL_POINTINGDEVICE,MOU_GETHOTKEYBUTTON,NIL,ParmLengthMax,ParmLengthInOut,BUF,DataLengthInOut,DataLengthMax);
  DOSCLOSE(HANDLE);
  RESULT:=BUF;
END;


Initialization
  RegisterClasses ([TMain_DLG, TButton, TLabel,
    TTrackBar, TEdit, TPopupMenu, TMenuItem, TMainMenu, TShape, TImage]);
End.
