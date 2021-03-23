table 70105 "Sales Shipments Staging TS"
{
    Caption = 'Sales Shipments Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
        }
        field(3; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(4; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(5; "Item Lot No."; Code[20])
        {
            Caption = 'Item Lot No.';
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(7; "Quantity (Length)"; Decimal)
        {
            Caption = 'Quantity (Length)';
            DataClassification = CustomerContent;
        }
        field(8; "Entry Date and Time"; DateTime)
        {
            Caption = 'Entry Date and Time';
            DataClassification = CustomerContent;
        }
        field(9; "Processing Date and Time"; DateTime)
        {
            Caption = 'Processing Date and Time';
            DataClassification = CustomerContent;
        }
        field(10; "Integration Status"; Enum "Integration Status TS")
        {
            Caption = 'Integration Status';
            DataClassification = CustomerContent;
        }
        field(11; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
        }
        field(12; "Processing Remarks"; Text[100])
        {
            Caption = 'Processing Remarks';
            DataClassification = CustomerContent;
        }
        field(13; "Error Remarks"; Text[100])
        {
            Caption = 'Error Remarks';
            DataClassification = CustomerContent;
        }
        field(14; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(15; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
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