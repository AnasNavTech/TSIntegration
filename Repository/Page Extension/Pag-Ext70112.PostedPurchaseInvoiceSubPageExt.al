pageextension 70112 "Posted Purch.Inv SubPage Ext" extends "Posted Purch. Invoice Subform"
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