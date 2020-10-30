page 60006 GLAccountAPI
{
    PageType = API;
    Caption = 'GL Account API';
    APIPublisher = '4PS';
    APIGroup = 'W1';
    APIVersion = 'v2.0';
    EntityName = 'glaccount';
    EntitySetName = 'glaccounts';
    SourceTable = "G/L Account";
    SourceTableView = WHERE("Declaration" = CONST(true));
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
                field(Name; rec.Name)
                {
                    caption = 'Name';
                }
                field(Declaration; rec.Declaration)
                {
                    caption = 'Declaration';
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