pageextension 70114 "Posted Sales.Inv SubPage Ext" extends "Posted Sales Invoice Subform"
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