page 60004 "Declaration Setup"
{

    PageType = Card;
    SourceTable = "Declaration Setup";
    Caption = 'Declaration Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Declaration Journal Template"; rec."Declaration Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Declaration Journal Batch"; rec."Declaration Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Declaration Nos."; rec."Declaration Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.Reset;
        if not rec.Get then begin
            rec.Init;
            rec.Insert;
        end;
    end;

}
