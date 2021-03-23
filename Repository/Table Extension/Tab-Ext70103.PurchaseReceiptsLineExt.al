tableextension 70103 "Purchase Receipts Line Ext" extends "Purch. Rcpt. Line"
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