table 70106 "Transfer Order Staging TS"
{
    Caption = 'Transfer Order Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            DataClassification = CustomerContent;
        }
        field(3; "From Location Code"; Code[10])
        {
            Caption = 'From Location Code';
            DataClassification = CustomerContent;
        }
        field(4; "To Location Code"; Code[10])
        {
            Caption = 'To Location Code';
            DataClassification = CustomerContent;
        }
        field(5; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
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
        field(9; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DataClassification = CustomerContent;
        }
        field(10; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
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