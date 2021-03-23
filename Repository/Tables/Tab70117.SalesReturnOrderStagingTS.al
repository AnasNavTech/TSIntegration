table 70117 "Sales Ret. Order Staging TS"
{
    Caption = 'Sales Return Order Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Call Off Number"; Text[20])
        {
            Caption = 'Call Off Number';
            DataClassification = CustomerContent;
        }
        field(4; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
            DataClassification = CustomerContent;
        }
        field(5; "Return Date"; Date)
        {
            Caption = 'Return Date';
            DataClassification = CustomerContent;
        }
        field(6; "Item Numbers"; Code[50])
        {
            Caption = 'Item Numbers';
            DataClassification = CustomerContent;
        }
        field(7; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(8; "Quantity Good"; Decimal)
        {
            Caption = 'Quantity Good';
            DataClassification = CustomerContent;
        }
        field(9; "Quantity Damaged"; Decimal)
        {
            Caption = 'Quantity Damaged';
            DataClassification = CustomerContent;
        }
        field(10; "Rig Number"; Text[10])
        {
            Caption = 'Rig Number';
            DataClassification = CustomerContent;
        }
        field(11; "Well Number"; Text[10])
        {
            Caption = 'Well Number';
            DataClassification = CustomerContent;
        }
        field(12; "Entry Date and Time"; DateTime)
        {
            Caption = 'Entry Date and Time';
            DataClassification = CustomerContent;
        }
        field(13; "Processing Date and Time"; DateTime)
        {
            Caption = 'Processing Date and Time';
            DataClassification = CustomerContent;
        }
        field(14; "Integration Status"; Enum "Integration Status TS")
        {
            Caption = 'Integration Status';
            DataClassification = CustomerContent;
        }
        field(15; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
        }
        field(16; "Processing Remarks"; Text[100])
        {
            Caption = 'Processing Remarks';
            DataClassification = CustomerContent;
        }
        field(17; "Error Remarks"; Text[100])
        {
            Caption = 'Error Remarks';
            DataClassification = CustomerContent;
        }
        field(18; ID; Guid)
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