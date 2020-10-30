codeunit 60000 "CDS Integration"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        //For Declation Table
        if BCTableNo = DATABASE::Declaration then begin
            CDSTableNo := DATABASE::"CDS new_Declaration";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Management", 'OnIsIntegrationRecord', '', true, true)]
    local procedure HandleOnIsIntegrationRecord(TableID: Integer; var isIntegrationRecord: Boolean)
    begin
        //for Declarations table
        if TableID = DATABASE::Declaration then
            isIntegrationRecord := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Management", 'OnAfterAddToIntegrationPageList', '', true, true)]
    local procedure HandleOnAfterAddToIntegrationPageList(var TempNameValueBuffer: Record "Name/Value Buffer"; var NextId: Integer)
    begin
        AddToIntegrationPageList(PAGE::"Declarations", DATABASE::Declaration, TempNameValueBuffer, NextId);
    end;

    local procedure AddToIntegrationPageList(PageId: Integer; TableId: Integer; var TempNameValueBuffer: Record "Name/Value Buffer" temporary; var NextId: Integer)
    begin
        with TempNameValueBuffer do begin
            Init;
            ID := NextId;
            NextId := NextId + 1;
            Name := Format(PageId);
            Value := Format(TableId);
            Insert;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', true, true)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    var
        CDSRecRef: RecordRef;
        CDSLookUp: Codeunit "CDS Lookup";
    begin
        if CRMTableID = Database::"CDS new_Declaration" then begin
            CDSRecRef.Open(Database::"CDS new_Declaration");
            Handled := CDSLookUp.LookupDeclaration(SavedCRMId, CRMId, IntTableFilter);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', true, true)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        RecRefTable: RecordRef;
        RecRefCDS: RecordRef;
        test: Page "CDS Connection Setup";
    begin
        //Declarations
        RecRefTable.Open(DATABASE::Declaration);
        RecRefCDS.OPEN(DATABASE::"CDS new_Declaration");
        InsertIntegrationTableMapping(
            IntegrationTableMapping, 'DECLARATIONS',
            RecRefTable.Number, RecRefCDS.Number,
            GetFieldNo(RecRefCDS.Number, 'new_DeclarationId'), GetFieldNo(RecRefCDS.Number, 'ModifiedOn'),
            '', '', true);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'No.'), GetFieldNo(RecRefCDS.Number, 'new_No'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Employee No.'), GetFieldNo(RecRefCDS.Number, 'new_EmployeeNo'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Employee E-mail'), GetFieldNo(RecRefCDS.Number, 'new_EmployeeEmail'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Date'), GetFieldNo(RecRefCDS.Number, 'new_Date'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Description'), GetFieldNo(RecRefCDS.Number, 'new_Description'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Account No.'), GetFieldNo(RecRefCDS.Number, 'new_AccountNo'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Manager No.'), GetFieldNo(RecRefCDS.Number, 'new_ManagerNo'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Manager E-mail'), GetFieldNo(RecRefCDS.Number, 'new_ManagerEmail'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Amount'), GetFieldNo(RecRefCDS.Number, 'new_Amount'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Approved'), GetFieldNo(RecRefCDS.Number, 'new_Approved'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Approved by'), GetFieldNo(RecRefCDS.Number, 'new_ApprovedBy'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('DECLARATIONS', GetFieldNo(RecRefTable.Number, 'Approved Date'), GetFieldNo(RecRefCDS.Number, 'new_ApprovedDate'), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        RecRefTable.Close;
        RecRefCDS.Close;
    end;

    local procedure GetFieldNo(TableNo: Integer; FieldName: Text[30]): Integer
    var
        "Field": Record "Field";
    begin
        Field.Reset;
        Field.SetRange(TableNo, TableNo);
        Field.SetRange(FieldName, FieldName);
        If Field.FindFirst() then
            exit(Field."No.");
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'CDS');
    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnBeforeGetNameFieldNo', '', true, true)]
    local procedure OnBeforeGetNameFieldNo(TableId: Integer; var FieldNo: Integer)
    var
        CDSDeclarations: Record "CDS new_Declaration";
        Item: record Item;
        Employee: record "Employee";
        Declarations: record Declaration;
        GLAccount: Record "G/L Account";
    begin
        case TableID of
            DATABASE::"CDS new_Declaration":
                FieldNo := CDSDeclarations.FieldNo(new_Description);
            DATABASE::Declaration:
                FieldNo := Declarations.FieldNo(Description);
        end;
    end;

}