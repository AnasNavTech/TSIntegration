tableextension 70116 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(70100; Good; Code[10])
        {
            Caption = 'Good';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(70101; Rejected; Code[10])
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(70102; Damaged; Code[10])
        {
            Caption = 'Damaged';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(70103; "TS Journal Template Name"; Code[10])
        {
            Caption = 'TS Journal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template";
        }
        field(70104; "TS Journal Batch Name"; Code[10])
        {
            Caption = 'TS Journal Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name;
        }
    }

    var
        myInt: Integer;
}