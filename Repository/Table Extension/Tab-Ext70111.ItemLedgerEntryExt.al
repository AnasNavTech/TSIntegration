tableextension 70111 "Item Ledger Entry Ext" extends "Item Ledger Entry"
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