tableextension 70110 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(70100; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}