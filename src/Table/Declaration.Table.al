table 60000 Declaration
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    DeclarationSetup.Get();
                    NoSeriesMgt.TestManual(DeclarationSetup."Declaration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(20; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee";
            Caption = 'Employee No.';
        }
        field(21; "Employee E-mail"; text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."E-Mail" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee E-mail';
            Editable = false;
        }
        field(25; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(30; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(40; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(50; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account No.';
            TableRelation = "G/L Account";
        }
        field(60; "Manager No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Manager No." WHERE("No." = FIELD("Employee No.")));
            Caption = 'Manager';
            Editable = false;
        }
        field(61; "Manager E-mail"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."E-Mail" WHERE("No." = FIELD("Manager No.")));
            Caption = 'Manager E-mail';
            Editable = false;
        }
        field(65; "Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved';
        }
        field(70; "Approved by"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved By';
        }
        field(80; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Date';
        }
        field(90; "Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed';
        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        DeclarationSetup: Record "Declaration Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        DeclarationSetup.Get;

        if "No. Series" = '' then
            "No. Series" := DeclarationSetup."Declaration Nos.";

        if "No." = '' then begin
            DeclarationSetup.Get();
            DeclarationSetup.TestField("Declaration Nos.");
            NoSeriesMgt.InitSeries(DeclarationSetup."Declaration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure ProcessDeclarationEntries()
    var
        Declaration: record Declaration;
        GenJournalLine: record "Gen. Journal Line";
    begin
        DeclarationSetup.Get;

        Declaration.reset;
        Declaration.SetRange(Approved, true);
        Declaration.SetRange(Processed, false);
        if Declaration.FindSet() then
            repeat
                GenJournalLine."Journal Template Name" := DeclarationSetup."Declaration Journal Template";
                GenJournalLine."Journal Batch Name" := DeclarationSetup."Declaration Journal Batch";
                GenJournalLine."Line No." := GenJournalLine.GetNewLineNo(DeclarationSetup."Declaration Journal Template", DeclarationSetup."Declaration Journal Batch");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Document Date" := "Approved Date";
                GenJournalLine.Insert();

                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                GenJournalLine.validate("Account No.", Declaration."Employee No.");
                GenJournalLine.Description := Declaration.Description;
                GenJournalLine.Amount := Declaration.Amount;
                GenJournalLine."Account No." := Declaration."Account No.";
                GenJournalLine.Modify();

                Declaration.Processed := true;
                Declaration.Modify();

            until Declaration.Next() = 0;

        //Post journal FIXME

    end;


}