codeunit 60001 "CDS Lookup"
{
    trigger OnRun()
    begin

    end;

    procedure LookupDeclaration(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDSDeclaration: Record "CDS new_Declaration";
        OriginalCDSDeclaration: Record "CDS new_Declaration";
        DeclarationCDS: Page "Declaration CDS";
    begin
        if not IsNullGuid(CRMId) then begin
            if CDSDeclaration.Get(CRMId) then
                DeclarationCDS.SetRecord(CDSDeclaration);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDSDeclaration.Get(SavedCRMId) then
                    DeclarationCDS.SetCurrentlyCoupled(OriginalCDSDeclaration);
        end;
        CDSDeclaration.SetView(IntTableFilter);
        DeclarationCDS.SetTableView(CDSDeclaration);
        DeclarationCDS.LookupMode(true);
        Commit();
        if DeclarationCDS.RunModal = ACTION::LookupOK then begin
            DeclarationCDS.GetRecord(CDSDeclaration);
            CRMId := CDSDeclaration.new_declarationid;
            exit(true);
        end;
        exit(false);
    end;
}