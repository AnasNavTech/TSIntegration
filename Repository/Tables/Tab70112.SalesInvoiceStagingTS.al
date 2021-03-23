table 70112 "Sales Invoice TS"
{
    Caption = 'Sales Invoice Staging - TS';
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
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(4; "Amount Including VAT"; Decimal)
        {
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
        }
        field(5; "Invoice Closure Date"; Date)
        {
            Caption = 'Invoice Closure Date';
            DataClassification = CustomerContent;
        }
        field(6; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(7; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = CustomerContent;
        }
        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(9; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
        }
        field(10; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(11; "MR No."; Code[20])
        {
            Caption = 'MR No.';
            DataClassification = CustomerContent;
        }
        field(12; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(13; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(14; "TS Sync Status"; Enum "TS Sync Status TS")
        {
            DataClassification = CustomerContent;
            Caption = 'TS Sync Status';
            //Editable = false;
        }
        field(15; "TS Synced By"; Code[50])
        {
            Caption = 'TS Synced By';
            DataClassification = CustomerContent;
        }
        field(16; "TS Synced On"; DateTime)
        {
            Caption = 'TS Synced On';
            DataClassification = CustomerContent;
        }
        field(17; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Customer PO No."; Code[35])
        {
            Caption = 'Cust PO No.';
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