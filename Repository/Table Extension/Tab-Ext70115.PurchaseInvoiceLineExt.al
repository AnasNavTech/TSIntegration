tableextension 70115 "Purchase Invoice Line Ext" extends "Purch. Inv. Line"
{
    fields
    {
        field(70101; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}