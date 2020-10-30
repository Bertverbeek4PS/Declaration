page 60002 DeclarationsAPI
{
    PageType = API;
    Caption = 'Declaration API';
    APIPublisher = '4PS';
    APIGroup = 'W1';
    APIVersion = 'v2.0';
    EntityName = 'declaration';
    EntitySetName = 'declarations';
    SourceTable = Declaration;
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No"; rec."No.")
                {
                    caption = 'No';
                }
                field("EmployeeNo"; rec."Employee No.")
                {
                    caption = 'Employee No';
                }
                field("EmployeeEmail"; rec."Employee E-mail")
                {
                    caption = 'Employee Email';
                }
                field("Description"; rec."Description")
                {
                    caption = 'Description';
                }
                field("Amount"; rec."Amount")
                {
                    caption = 'Amount';
                }
                field("AccountNo"; rec."Account No.")
                {
                    caption = 'Account No.';
                }
                field("Manager"; rec."Manager No.")
                {
                    caption = 'Manager No';
                }
                field("ManagerEmail"; rec."Manager E-mail")
                {
                    caption = 'Manager Email';
                }
                field("Approved"; rec."Approved")
                {
                    caption = 'Approved';
                }
                field("Approvedby"; rec."Approved by")
                {
                    caption = 'Approved by';
                }
                field("ApprovedDate"; rec."Approved Date")
                {
                    caption = 'Approved Date';
                }
                field(SystemId; rec.SystemId)
                {
                    Editable = false;
                    caption = 'Id';
                }
            }
        }
    }
}