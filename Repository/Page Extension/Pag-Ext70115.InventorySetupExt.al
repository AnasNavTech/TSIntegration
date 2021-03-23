pageextension 70115 "Inventory Setup Ext" extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field(Good; Rec.Good)
            {
                Caption = 'Good';
                ApplicationArea = All;
            }
            field(Rejected; Rec.Rejected)
            {
                Caption = 'Rejected';
                ApplicationArea = All;
            }
            field(Damaged; Rec.Damaged)
            {
                Caption = 'Damaged';
                ApplicationArea = All;
            }
            field(JournalTemplateName; Rec."TS Journal Template Name")
            {
                Caption = 'TS Journal Template Name';
                ApplicationArea = All;
            }
            field(JournalBatchName; Rec."TS Journal Batch Name")
            {
                Caption = 'TS Journal Batch Name';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}