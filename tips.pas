Unit Tips;

Interface

Uses
  Classes, Forms, Graphics, Buttons, StdCtrls;

Type
  TTips_DLG = Class (TForm)
    Button1: TButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Procedure Button1OnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  Tips_DLG: TTips_DLG;

Implementation

Procedure TTips_DLG.Button1OnClick (Sender: TObject);
Begin
  Close;
End;

Initialization
  RegisterClasses ([TTips_DLG, TButton, TLabel]);
End.
