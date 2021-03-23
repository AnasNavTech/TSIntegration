tableextension 70104 "Sales Shipment Line Ext" extends "Sales Shipment Line"
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