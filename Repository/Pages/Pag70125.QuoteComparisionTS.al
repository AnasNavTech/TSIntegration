page 70125 "Quote Comparision TS"
{
    Caption = 'Purchase Quote Comparision - TS';
    ApplicationArea = All;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = "Purchase Quote Lines TS";
    UsageCategory = Tasks;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Internal Request No.")
            {
                ShowCaption = false;
                field(InternalReqNo; InternalReqNo)
                {
                    Caption = 'Internal Request No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
                    begin
                        if InternalReqNo <> '' then begin
                            PurchaseQuoteLines.SetRange("Inserted By", UserId());
                            if PurchaseQuoteLines.FindSet() then
                                PurchaseQuoteLines.DeleteAll();
                            Rec.InsertData(InternalReqNo);
                        end;

                        if InternalReqNo = '' then begin
                            PurchaseQuoteLines.SetRange("Inserted By", UserId());
                            if PurchaseQuoteLines.FindSet() then
                                PurchaseQuoteLines.DeleteAll();
                        end;

                        CurrPage.Update(false);
                    end;
                }
            }
            repeater("Purchase Quote Lines")
            {
                field(ReadyForPO; Rec."Ready For PO")
                {
                    Caption = 'Ready For PO';
                    ApplicationArea = All;
                    Editable = ReadyForPOEditable;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Ready For PO" then
                            ReadyForPOValidation();
                        CurrPage.Update(true);
                    end;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(VendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(VendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ItemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UnitCost; Rec."Unit Cost")
                {
                    BlankZero = true;
                    Caption = 'Unit Cost';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    BlankZero = true;
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    BlankZero = true;
                    Caption = 'Amount';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(LocationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(InternalRequestNo; Rec."Internal Request No.")
                {
                    Caption = 'Internal Request No.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(UserID; Rec."Inserted By")
                {
                    Caption = 'Inserted By';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(QuoteComparision)
            {
                ApplicationArea = All;
                Caption = 'Quote Comparision';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = CompareCOA;

                trigger OnAction()
                var
                    PurchaseQuoteLines: Record "Purchase Quote Lines TS";
                begin
                    if InternalReqNo = '' then
                        Error(InternalReqNoBlankErr);

                    PurchaseQuoteLines.SetRange("Internal Request No.", InternalReqNo);
                    PurchaseQuoteLines.SetRange("Ready For PO", true);
                    if PurchaseQuoteLines.IsEmpty then
                        Error(NothngToProcessErr);

                    CreatePurchaseOrder(InternalReqNo);
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        InternalReqNo: Code[20];
        InternalReqNoBlankErr: Label 'Internal Request No Should not be Blank';
        NothngToProcessErr: Label 'Nothing to Process';
        ReadyForPOEditable: Boolean;

    trigger OnOpenPage()
    var
        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
    begin
        PurchaseQuoteLines.SetRange("Inserted By", UserId());
        if PurchaseQuoteLines.FindSet() then
            PurchaseQuoteLines.DeleteAll();

        if InternalReqNo <> '' then begin
            PurchaseQuoteLines.SetRange("Inserted By", UserId());
            if PurchaseQuoteLines.FindSet() then
                PurchaseQuoteLines.DeleteAll();
            Rec.InsertData(InternalReqNo);
        end;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        ReadyForPOEditable := true;

        if Rec."Document No." = '' then
            ReadyForPOEditable := false;
    end;

    procedure CreatePurchaseOrder(InternalRequestNo: Code[20])
    var
        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        POHeader: Record "Purchase Header";
        POLine: Record "Purchase Line";
        HeaderCreated: Boolean;
        POCreationMsg: Label 'Purchase Order %1 has been created.';
        POCreationConfirm: Label 'Do you want to Create Purchase Order?';
    begin
        if not Confirm(POCreationConfirm) then
            Exit;

        HeaderCreated := false;
        PurchaseQuoteLines.Reset();
        PurchaseQuoteLines.SetRange("Internal Request No.", InternalReqNo);
        PurchaseQuoteLines.SetRange("Ready For PO", true);
        if PurchaseQuoteLines.FindSet() then begin
            repeat
                if not HeaderCreated then begin
                    PurchaseHeader.Get(PurchaseHeader."Document Type"::Quote, PurchaseQuoteLines."Document No.");

                    POHeader.Init();
                    POHeader.TransferFields(PurchaseHeader);
                    POHeader."Document Type" := POHeader."Document Type"::Order;
                    POHeader."No." := '';
                    POHeader.Validate("Posting Date", Today);
                    POHeader.Insert(true);
                    HeaderCreated := true;
                end;

                PurchaseLines.Get(PurchaseLines."Document Type"::Quote, PurchaseQuoteLines."Document No.", PurchaseQuoteLines."Purchase Quote Line No.");

                POLine.Init();
                POLine.TransferFields(PurchaseLines);
                POLine."Document Type" := POHeader."Document Type";
                POLine."Document No." := POHeader."No.";
                POLine."Line No." := FindLastPurchaseLineNo(POHeader);
                POLine."Expected Receipt Date" := 0D;
                POLine.Insert();

            Until PurchaseQuoteLines.Next() = 0;

            if POHeader."No." <> '' then
                Message(POCreationMsg, POHeader."No.");

            DeletePurchaseQuote(InternalRequestNo);

            PurchaseQuoteLines.Reset();
            PurchaseQuoteLines.SetRange("Internal Request No.", InternalReqNo);
            if PurchaseQuoteLines.FindSet() then
                PurchaseQuoteLines.DeleteAll();

            InternalReqNo := '';
        end;

    end;

    procedure DeletePurchaseQuote(InternalRequestNo: Code[20])
    var
        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseQuoteLines.SetRange("Internal Request No.", InternalRequestNo);
        if PurchaseQuoteLines.FindSet() then begin
            repeat
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Quote);
                PurchaseHeader.SetRange("No.", PurchaseQuoteLines."Document No.");
                if PurchaseHeader.FindFirst() then
                    PurchaseHeader.Delete(true);
            Until PurchaseQuoteLines.Next() = 0;
        end;
    end;

    procedure FindLastPurchaseLineNo(PurchHeader: Record "Purchase Header"): Integer
    var
        PurchaseLineRec: Record "Purchase Line";
    begin
        PurchaseLineRec.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLineRec.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLineRec.FindLast() then
            Exit(PurchaseLineRec."Line No." + 10000);

        Exit(10000);

    end;

    procedure SetInternalRequestNo(RequestNo: Code[20])
    var
        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
    begin
        InternalReqNo := RequestNo;
    end;

    procedure ReadyForPOValidation()
    var
        PurchaseQuoteComp: Record "Purchase Quote Lines TS";
        AlreadyExistLabel: Label 'You have already selected one Quote for order';
    begin
        PurchaseQuoteComp.SetRange("Inserted By", UserId());
        PurchaseQuoteComp.SetRange("Internal Request No.", Rec."Internal Request No.");
        PurchaseQuoteComp.SetFilter("Document No.", '<>%1', Rec."Document No.");
        PurchaseQuoteComp.SetRange("Ready For PO", true);
        if PurchaseQuoteComp.FindFirst() then
            Error(AlreadyExistLabel);
    end;
}