tableextension 70120 "Purchase Receipt Header Ext" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(70103; "Mill Code"; Code[15])
        {
            Caption = 'Mill Code';
            DataClassification = CustomerContent;
        }
        field(70104; "Mill Name"; Text[250])
        {
            Caption = 'Mill Name';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}