pageextension 70104 "Purch. Quote SubPage Ext" extends "Purchase Quote Subform"
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