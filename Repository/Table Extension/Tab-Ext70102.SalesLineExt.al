tableextension 70102 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(70100; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(70101; "Material Req No."; Text[50])
        {
            Caption = 'Material Req No.';
            DataClassification = CustomerContent;
        }
        field(70102; "Customer Item Code"; Text[50])
        {
            Caption = 'Customer Item Code';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}