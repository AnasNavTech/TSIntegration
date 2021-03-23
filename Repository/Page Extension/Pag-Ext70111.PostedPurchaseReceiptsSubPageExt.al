pageextension 70111 "Posted Purch.Rcpt SubPage Ext" extends "Posted Purchase Rcpt. Subform"
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