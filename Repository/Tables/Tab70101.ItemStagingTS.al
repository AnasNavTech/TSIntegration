table 70101 "Item Staging TS"
{
    Caption = 'Item Staging - TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(5; Type; Enum "Item Type TS")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
        }
        field(7; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(8; "Purchase Unit of Measure"; Code[10])
        {
            Caption = 'Purchase Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(9; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(10; "Base to Purchase UOM Relation"; Decimal)
        {
            Caption = 'Base to Purchase UOM Relation';
            DataClassification = CustomerContent;
        }
        field(11; "Base to Sales UOM Relation"; Decimal)
        {
            Caption = 'Base to Sales UOM Relation';
            DataClassification = CustomerContent;
        }
        field(12; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(14; OD1; Text[100])
        {
            Caption = 'OD1';
            DataClassification = CustomerContent;
        }
        field(15; OD2; Text[100])
        {
            Caption = 'OD2';
            DataClassification = CustomerContent;
        }
        field(16; WT1; Text[100])
        {
            Caption = 'WT1';
            DataClassification = CustomerContent;
        }
        field(17; WT2; Text[100])
        {
            Caption = 'WT2';
            DataClassification = CustomerContent;
        }
        field(18; "Grade Type"; Text[100])
        {
            Caption = 'Grade Type';
            DataClassification = CustomerContent;
        }
        field(19; Grade; Text[100])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(20; "Product Type"; Text[100])
        {
            Caption = 'Product Type';
            DataClassification = CustomerContent;
        }
        field(21; "Attribute 8"; Text[100])
        {
            Caption = 'Attribute 8';
            DataClassification = CustomerContent;
        }
        field(22; "Attribute 9"; Text[100])
        {
            Caption = 'Attribute 9';
            DataClassification = CustomerContent;
        }
        field(23; "Attribute 10"; Text[100])
        {
            Caption = 'Attribute 10';
            DataClassification = CustomerContent;
        }
        field(24; "Attribute 11"; Text[100])
        {
            Caption = 'Attribute 11';
            DataClassification = CustomerContent;
        }
        field(25; "Attribute 12"; Text[100])
        {
            Caption = 'Attribute 12';
            DataClassification = CustomerContent;
        }
        field(26; "Attribute 13"; Text[100])
        {
            Caption = 'Attribute 13';
            DataClassification = CustomerContent;
        }
        field(27; "Attribute 14"; Text[100])
        {
            Caption = 'Attribute 14';
            DataClassification = CustomerContent;
        }
        field(28; "Attribute 15"; Text[100])
        {
            Caption = 'Attribute 15';
            DataClassification = CustomerContent;
        }
        field(29; "Attribute 16"; Text[100])
        {
            Caption = 'Attribute 16';
            DataClassification = CustomerContent;
        }
        field(30; "Attribute 17"; Text[100])
        {
            Caption = 'Attribute 17';
            DataClassification = CustomerContent;
        }
        field(31; "Attribute 18"; Text[100])
        {
            Caption = 'Attribute 18';
            DataClassification = CustomerContent;
        }
        field(32; "Attribute 19"; Text[100])
        {
            Caption = 'Attribute 19';
            DataClassification = CustomerContent;
        }
        field(33; "Attribute 20"; Text[100])
        {
            Caption = 'Attribute 20';
            DataClassification = CustomerContent;
        }
        field(34; "Entry Date and Time"; DateTime)
        {
            Caption = 'Entry Date and Time';
            DataClassification = CustomerContent;
        }
        field(35; "Processing Date and Time"; DateTime)
        {
            Caption = 'Processing Date and Time';
            DataClassification = CustomerContent;
        }
        field(36; "Integration Status"; enum "Integration Status TS")
        {
            Caption = 'Integration Status';
            DataClassification = CustomerContent;
        }
        field(37; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
        }
        field(38; "Processing Remarks"; Text[100])
        {
            Caption = 'Processing Remarks';
            DataClassification = CustomerContent;
        }
        field(39; "Error Remarks"; Text[100])
        {
            Caption = 'Error Remarks';
            DataClassification = CustomerContent;
        }
        field(40; ID; Guid)
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