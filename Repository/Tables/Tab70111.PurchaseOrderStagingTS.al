table 70111 "Purchase Order TS"
{
    Caption = 'Purchase Order Staging - TS';
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
        field(3; Allowance; Decimal)
        {
            Caption = 'Allowance';
            DataClassification = CustomerContent;
        }
        field(4; "Book Value"; Decimal)
        {
            Caption = 'Book Value';
            DataClassification = CustomerContent;
        }
        field(5; "Book Value Mt"; Decimal)
        {
            Caption = 'Book Value Mt';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Account No."; Code[20])
        {
            Caption = 'Customer Account No.';
            DataClassification = CustomerContent;
        }
        field(7; Destination; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
        }
        field(8; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;
        }
        field(9; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(10; "Mill Name"; Text[250])
        {
            Caption = 'Mill Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mill Code"; Code[15])
        {
            Caption = 'Mill Code';
            DataClassification = CustomerContent;
        }
        field(12; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = CustomerContent;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(14; Unit; Code[10])
        {
            Caption = 'Unit';
            DataClassification = CustomerContent;
        }
        field(15; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
        }
        field(16; "Customer PO No."; Code[20])
        {
            Caption = 'Customer PO No.';
            DataClassification = CustomerContent;
        }
        field(17; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(18; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(19; "TS Sync Status"; Enum "TS Sync Status TS")
        {
            DataClassification = CustomerContent;
            Caption = 'TS Sync Status';
            //Editable = false;
        }
        field(20; "TS Synced By"; Code[50])
        {
            Caption = 'TS Synced By';
            DataClassification = CustomerContent;
        }
        field(21; "TS Synced On"; DateTime)
        {
            Caption = 'TS Synced On';
            DataClassification = CustomerContent;
        }
        field(22; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(23; "Purchase Line No."; Integer)
        {
            Caption = 'Purchase Line No.';
            DataClassification = CustomerContent;
        }
        field(24; "Vessel Name"; Text[25])
        {
            Caption = 'Vessel Name';
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