tableextension 70100 "Item Ext" extends Item
{
    fields
    {
        field(70100; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(70101; OD1; Text[100])
        {
            Caption = 'OD1';
            DataClassification = CustomerContent;
        }
        field(70102; OD2; Text[100])
        {
            Caption = 'OD2';
            DataClassification = CustomerContent;
        }
        field(70103; WT1; Text[100])
        {
            Caption = 'WT1';
            DataClassification = CustomerContent;
        }
        field(70104; WT2; Text[100])
        {
            Caption = 'WT2';
            DataClassification = CustomerContent;
        }
        field(70105; "Grade Type"; Text[100])
        {
            Caption = 'Grade Type';
            DataClassification = CustomerContent;
        }
        field(70106; Grade; Text[100])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(70107; "Product Type"; Text[100])
        {
            Caption = 'Product Type';
            DataClassification = CustomerContent;
        }
        field(70108; "Attribute 8"; Text[100])
        {
            Caption = 'Attribute 8';
            DataClassification = CustomerContent;
        }
        field(70109; "Attribute 9"; Text[100])
        {
            Caption = 'Attribute 9';
            DataClassification = CustomerContent;
        }
        field(70110; "Attribute 10"; Text[100])
        {
            Caption = 'Attribute 10';
            DataClassification = CustomerContent;
        }
        field(70111; "Attribute 11"; Text[100])
        {
            Caption = 'Attribute 11';
            DataClassification = CustomerContent;
        }
        field(70112; "Attribute 12"; Text[100])
        {
            Caption = 'Attribute 12';
            DataClassification = CustomerContent;
        }
        field(70113; "Attribute 13"; Text[100])
        {
            Caption = 'Attribute 13';
            DataClassification = CustomerContent;
        }
        field(70114; "Attribute 14"; Text[100])
        {
            Caption = 'Attribute 14';
            DataClassification = CustomerContent;
        }
        field(70115; "Attribute 15"; Text[100])
        {
            Caption = 'Attribute 15';
            DataClassification = CustomerContent;
        }
        field(70116; "Attribute 16"; Text[100])
        {
            Caption = 'Attribute 16';
            DataClassification = CustomerContent;
        }
        field(70117; "Attribute 17"; Text[100])
        {
            Caption = 'Attribute 17';
            DataClassification = CustomerContent;
        }
        field(70118; "Attribute 18"; Text[100])
        {
            Caption = 'Attribute 18';
            DataClassification = CustomerContent;
        }
        field(70119; "Attribute 19"; Text[100])
        {
            Caption = 'Attribute 19';
            DataClassification = CustomerContent;
        }
        field(70120; "Attribute 20"; Text[100])
        {
            Caption = 'Attribute 20';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}