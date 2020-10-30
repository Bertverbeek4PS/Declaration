page 60003 "Declaration CDS"
{
    PageType = List;
    SourceTable = "CDS new_declaration";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Declaration - Common Data Service';

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; rec.new_No)
                {
                    ApplicationArea = Suite;
                    StyleExpr = FirstColumnStyle;
                }
                field("Description"; rec.new_Description)
                {
                    ApplicationArea = Suite;
                }
                field("Blocked"; rec.new_Amount)
                {
                    ApplicationArea = Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateFromCDS)
            {
                ApplicationArea = All;
                Caption = 'Create in Business Central';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate the entity from the coupled Common Data Service worker.';

                trigger OnAction()
                var
                    CDSIntTable: Record "CDS new_declaration";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(CDSIntTable);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(CDSIntTable);
                end;
            }

        }

    }

    var
        CurrentlyCoupledTable: Record "CDS new_declaration";
        Coupled: Text;
        FirstColumnStyle: Text;

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    trigger OnOpenPage()
    var
        LookupCRMTables: Codeunit "Lookup CRM Tables";
    begin
        rec.FilterGroup(4);
        rec.SetView(LookupCRMTables.GetIntegrationTableMappingView(DATABASE::"CDS new_declaration"));
        rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
        RecordID: RecordID;
        EmptyRecordID: RecordID;
    begin
        if CRMIntegrationRecord.FindRecordIDFromID(rec.new_declarationid, DATABASE::Employee, RecordID) then
            if CurrentlyCoupledTable.new_declarationid = rec.new_declarationid then begin
                Coupled := 'Current';
                FirstColumnStyle := 'Strong';
            end else begin
                Coupled := 'Yes';
                FirstColumnStyle := 'Subordinate';
            end;

        if RecordID = EmptyRecordID then begin
            Coupled := 'No';
            FirstColumnStyle := 'None';
        end;
    end;

    procedure SetCurrentlyCoupled(CDSIntTable: Record "CDS new_declaration")
    begin
        CurrentlyCoupledTable := CDSIntTable;
    end;
}