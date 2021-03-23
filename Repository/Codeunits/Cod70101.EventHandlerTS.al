codeunit 70101 "Event Handler TS"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidatePurchaseItemNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        ItemRec: Record Item;
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            ItemRec.Get(Rec."No.");
            Rec."TS Item No." := ItemRec."TS Item No.";
        end;

        if (Rec.Type = Rec.Type::Item) and (Rec."No." = '') then
            Rec."TS Item No." := '';

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateSalesItemNo(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        ItemRec: Record Item;
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            ItemRec.Get(Rec."No.");
            Rec."TS Item No." := ItemRec."TS Item No.";
        end;

        if (Rec.Type = Rec.Type::Item) and (Rec."No." = '') then
            Rec."TS Item No." := '';

    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterValidateEvent', 'Item No.', false, false)]
    local procedure OnAfterValidateItemJournalItemNo(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        ItemRec: Record Item;
    begin
        if Rec."Item No." <> '' then begin
            ItemRec.Get(Rec."Item No.");
            Rec."TS Item No." := ItemRec."TS Item No.";
        end;

        if Rec."Item No." = '' then
            Rec."TS Item No." := '';

    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    procedure OnAfterCopyItemJnlLineFromPurchLine(VAR ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine."TS Item No." := PurchLine."TS Item No.";
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    procedure OnAfterCopyItemJnlLineFromSalesLine(VAR ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."TS Item No." := SalesLine."TS Item No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    procedure OnAfterInsertItemLedgEntry(VAR ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry."TS Item No." := ItemJournalLine."TS Item No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure OnBeforeInsertValueEntry(VAR ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgerEntry: Record "Item Ledger Entry"; VAR ValueEntryNo: Integer; VAR InventoryPostingToGL: Codeunit "Inventory Posting To G/L")
    begin
        ValueEntry."TS Item No." := ItemLedgerEntry."TS Item No.";
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInitHeaderDefaults', '', false, false)]
    local procedure OnAfterInitHeaderDefaults(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    begin

        PurchLine."Expected Receipt Date" := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        SalesInvoiceStaging: Record "Sales Invoice TS";
        EntryNo: Integer;
    begin
        if SalesInvoiceStaging.FindLast() then
            EntryNo := SalesInvoiceStaging."Entry No." + 1
        else
            EntryNo := 1;

        SalesInvoiceStaging.Reset();
        SalesInvoiceStaging.Init();
        SalesInvoiceStaging."Entry No." := EntryNo;
        SalesInvoiceStaging."Customer No." := SalesInvHeader."Bill-to Customer No.";
        SalesHeader.CalcFields("Amount Including VAT");
        SalesInvoiceStaging."Amount Including VAT" := SalesHeader."Amount Including VAT";
        SalesInvoiceStaging."Invoice Closure Date" := SalesInvHeader."Posting Date";
        SalesInvoiceStaging."Currency Code" := SalesInvHeader."Currency Code";
        SalesInvoiceStaging."Invoice Date" := SalesInvHeader."Posting Date";
        SalesInvoiceStaging."Due Date" := SalesInvHeader."Due Date";
        SalesInvoiceStaging."Sales Order No." := SalesInvHeader."Order No.";
        SalesInvoiceStaging."Sales Invoice No." := SalesInvHeader."No.";
        SalesInvoiceStaging."MR No." := SalesInvHeader."MR No.";
        SalesInvoiceStaging."Customer PO No." := SalesInvHeader."External Document No.";
        SalesInvoiceStaging."TS Sync Status" := SalesInvoiceStaging."TS Sync Status"::"Waiting for Sync";
        SalesInvoiceStaging.Insert();
    end;

    var
        myInt: Integer;
}