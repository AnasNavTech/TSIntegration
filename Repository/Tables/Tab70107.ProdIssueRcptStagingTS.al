table 70107 "Prod. Issue - Rcpt Staging TS"
{
    Caption = 'Production Issue and Receipt Staging -TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(4; "Entry Type"; Enum "Entry Type TS")
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(7; "Item Lot No."; Code[20])
        {
            Caption = 'Item Lot No.';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(9; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(10; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(11; "Entry Date and Time"; DateTime)
        {
            Caption = 'Entry Date and Time';
            DataClassification = CustomerContent;
        }
        field(12; "Processing Date and Time"; DateTime)
        {
            Caption = 'Processing Date and Time';
            DataClassification = CustomerContent;
        }
        field(13; "Integration Status"; Enum "Integration Status TS")
        {
            Caption = 'Integration Status';
            DataClassification = CustomerContent;
        }
        field(14; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
        }
        field(15; "Processing Remarks"; Text[100])
        {
            Caption = 'Processing Remarks';
            DataClassification = CustomerContent;
        }
        field(16; "Error Remarks"; Text[100])
        {
            Caption = 'Error Remarks';
            DataClassification = CustomerContent;
        }
        field(17; ID; Guid)
        {
            Caption = 'ID';
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
        ID := CreateGuid();
        "Entry Date and Time" := CurrentDateTime;
        "Integration Status" := "Integration Status"::Pending;
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