page 60001 "Declarations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Declaration;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee E-mail"; rec."Employee E-mail")
                {
                    ApplicationArea = All;
                }
                field(Description; rec."Description")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec."Amount")
                {
                    ApplicationArea = All;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Manager No."; rec."Manager No.")
                {
                    ApplicationArea = All;
                }
                field("Manager E-mail"; rec."Manager E-mail")
                {
                    ApplicationArea = All;
                }
                field(Approved; rec."Approved")
                {
                    ApplicationArea = All;
                }
                field("Approved by"; rec."Approved by")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; rec."Approved Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

        area(processing)
        {
            action(Post)
            {
                caption = 'Post';
                ApplicationArea = All;
                Visible = true;
                Image = Post;
                ToolTip = 'Post declaration entries.';

                trigger OnAction()
                begin
                    rec.ProcessDeclarationEntries;
                end;
            }
            action(CDSSynchronizeNow)
            {
                Caption = 'Synchronize';
                ApplicationArea = All;
                Visible = true;
                Image = Refresh;
                Enabled = CDSIsCoupledToRecord;
                ToolTip = 'Send or get updated data to or from Common Data Service.';

                trigger OnAction()
                var
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CRMIntegrationManagement.UpdateOneNow(rec.RecordId);
                end;
            }
            action(ShowLog)
            {
                Caption = 'Synchronization Log';
                ApplicationArea = All;
                Visible = true;
                Image = Log;
                ToolTip = 'View integration synchronization jobs for the customer table.';

                trigger OnAction()
                var
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CRMIntegrationManagement.ShowLog(rec.RecordId);
                end;
            }
            group(Coupling)
            {
                Caption = 'Coupling';
                Image = LinkAccount;
                ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Common Data Service record.';

                action(ManageCDSCoupling)
                {
                    Caption = 'Set Up Coupling';
                    ApplicationArea = All;
                    Visible = true;
                    Image = LinkAccount;
                    ToolTip = 'Create or modify the coupling to a Common Data Service Worker.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.DefineCoupling(rec.RecordId);
                    end;
                }
                action(DeleteCDSCoupling)
                {
                    Caption = 'Delete Coupling';
                    ApplicationArea = All;
                    Visible = true;
                    Image = UnLinkAccount;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Delete the coupling to a Common Data Service Worker.';

                    trigger OnAction()
                    var
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                    begin
                        CRMCouplingManagement.RemoveCoupling(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(rec.RecordId);
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;
}