pageextension 70113 "Posted Sales.Ship SubPage Ext" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field(TSItemNo; Rec."TS Item No.")
            {
                Caption = 'TS Item No.';
                ApplicationArea = All;
            }
        }
    }

    var
        myInt: Integer;
}