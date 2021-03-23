tableextension 70101 "Locations Ext" extends Location
{
    fields
    {
        field(70100; "Trust Limit"; Decimal)
        {
            Caption = 'Trust Limit';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}