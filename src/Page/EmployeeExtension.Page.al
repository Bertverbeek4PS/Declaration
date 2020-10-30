pageextension 60000 EmployeeExtension extends "Employee Card"
{
    layout
    {

        addlast(General)
        {
            field("Manager No."; rec."Manager No.")
            {
                Caption = 'Manager No.';
                ApplicationArea = All;
            }
        }
    }
}