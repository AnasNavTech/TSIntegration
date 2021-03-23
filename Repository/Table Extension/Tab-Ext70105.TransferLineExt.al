tableextension 70105 "Transfer Line Ext" extends "Transfer Line"
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