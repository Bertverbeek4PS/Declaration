table 60002 "Declaration Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Declaration Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Declaration Journal Template"; Code[10])
        {
            Caption = 'Declaration Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(3; "Declaration Journal Batch"; Code[10])
        {
            Caption = 'Declaration Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Declaration Journal Template"));
        }
        field(4; "Declaration Nos."; Code[20])
        {
            Caption = 'Declaration Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}