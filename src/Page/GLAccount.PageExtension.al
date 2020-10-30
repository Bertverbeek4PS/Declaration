pageextension 60005 GLAccountCardExtension extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field(Declaration; rec.Declaration)
            {
                Caption = 'Declaration';
                ApplicationArea = All;
            }
        }
    }
}