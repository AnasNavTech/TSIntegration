pageextension 70103 "Purchase Quote Ext" extends "Purchase Quote"
{
    layout
    {
        addlast(General)
        {
            field(InternalReqNo; Rec."Internal Request No.")
            {
                Caption = 'Internal Request No.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Make Order")
        {
            action(PurchaseQuotation)
            {
                ApplicationArea = All;
                Caption = 'Quote comparision';
                Image = Quote;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    QuoteComparision: Page "Quote Comparision TS";
                begin
                    clear(QuoteComparision);
                    QuoteComparision.SetInternalRequestNo(Rec."Internal Request No.");
                    QuoteComparision.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}