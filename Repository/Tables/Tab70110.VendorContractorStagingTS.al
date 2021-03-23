table 70110 "Vendor Contractor TS"
{
    Caption = 'Vendor Contractor Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; ID; text[50])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;

        }
        field(3; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(4; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(5; Type; Enum "Vendor Type TS")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(8; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(9; "TS Sync Status"; Enum "TS Sync Status TS")
        {
            DataClassification = CustomerContent;
            Caption = 'TS Sync Status';
            //Editable = false;
        }
        field(10; "TS Synced By"; Code[50])
        {
            Caption = 'TS Synced By';
            DataClassification = CustomerContent;
        }
        field(11; "TS Synced On"; DateTime)
        {
            Caption = 'TS Synced On';
            DataClassification = CustomerContent;
        }
        field(12; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}