Unit About;

Interface

Uses
  Classes, Forms, Graphics, ExtCtrls, StdCtrls, Buttons;

Type
  TAbout_DLG = Class (TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Procedure Button1OnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  About_DLG: TAbout_DLG;

Implementation

USES dos,PMWIN;

Procedure TAbout_DLG.Button1OnClick (Sender: TObject);
Begin
  close;
End;

Initialization
  RegisterClasses ([TAbout_DLG, TImage, TLabel, TButton, TEdit]);
End.
