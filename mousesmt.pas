Program MouseSmt;

Uses
  Forms, Graphics, Main, About, Tips;

{$r MouseSmt.scu}

Begin
  Application.Create;
  Application.CreateForm (TMain_DLG, Main_DLG);
  Application.Run;
  Application.Destroy;
End.
