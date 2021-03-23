table 70113 "Invoice Closure TS"
{
    Caption = 'Invoice Closure Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Invoice Closure Date"; Date)
        {
            Caption = 'Invoice Closure Date';
            DataClassification = CustomerContent;

        }
        field(3; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(4; ID; text[50])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(6; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(7; "TS Sync Status"; Enum "TS Sync Status TS")
        {
            DataClassification = CustomerContent;
            Caption = 'TS Sync Status';
            //Editable = false;
        }
        field(8; "TS Synced By"; Code[50])
        {
            Caption = 'TS Synced By';
            DataClassification = CustomerContent;
        }
        field(9; "TS Synced On"; DateTime)
        {
            Caption = 'TS Synced On';
            DataClassification = CustomerContent;
        }
        field(10; "TS Error Message"; Text[250])
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