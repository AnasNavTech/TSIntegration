codeunit 70100 "Insert Data From TS"
{
    //Permissions = TableData "Sales Invoice Header" = m;
    TableNo = "Job Queue Entry";
    trigger OnRun()
    begin
        case Rec."Parameter String" of
            'Insert Customer':
                InsertCustomerStaging();
            'Insert Item':
                InsertItemStaging();
            'Insert Location':
                InsertLocationStaging();
            'Update Purchase Receipts':
                UpdatePurchaseReceiptsStaging();
            'Create Sales Order':
                InsertSalesOrder();
            'Update Sales Shipments':
                UpdateSalesShipment();
            'Create Transfer Orders':
                CreateTransferOrders();
            'Insert Production Issue and Receipt':
                InsertProductionIssueandReceipt();
            'Insert Inventory Adjustments':
                AdjustInventory();
            'Insert Mill Master':
                InsertMillMasterStaging();
            'Create Sales Return Order':
                CreateSalesReturnOrder();
        end;

    end;

    procedure InsertCustomerStaging()
    var
        CustomerStaging: Record "Customer Staging TS";
        CustomerRec: Record Customer;
        CustomerExistLabel: Label 'Customer Already Exist';
        CustomerNoLabel: Label 'Customer No. Should be Blank.';
        IsError: Boolean;
    begin
        CustomerStaging.SetRange("Integration Status", CustomerStaging."Integration Status"::Pending);
        if CustomerStaging.FindSet() then begin
            repeat
                IsError := false;
                if CustomerStaging."No." = '' then begin
                    CustomerStaging."Integration Status" := CustomerStaging."Integration Status"::Error;
                    CustomerStaging."Error Remarks" := CustomerNoLabel;
                    CustomerStaging.Modify(false);
                    IsError := true;
                end;

                if not IsError then begin
                    CustomerRec.Init();
                    CustomerRec."No." := CustomerStaging."No.";
                    CustomerRec.Name := CustomerStaging.Name;
                    CustomerRec."Name 2" := CustomerStaging."Name 2";
                    CustomerRec.Address := CustomerStaging.Address;
                    CustomerRec."Address 2" := CustomerStaging."Address 2";
                    CustomerRec.City := CustomerStaging.City;
                    CustomerRec."Country/Region Code" := CustomerStaging.Country;
                    CustomerRec."Phone No." := CustomerStaging."Phone No.";
                    CustomerRec."E-Mail" := CustomerStaging.Email;
                    CustomerRec."VAT Registration No." := CustomerStaging."VAT Registration No.";
                    CustomerRec."Credit Limit (LCY)" := CustomerStaging."Credit Limit";
                    if not CustomerRec.Insert(false) then
                        CustomerRec.Modify(false);

                    CustomerStaging."Integration Status" := CustomerStaging."Integration Status"::Processed;
                    CustomerStaging.Modify(false);
                end;
                Commit();
            UNTIL CustomerStaging.Next() = 0;
        end;
    end;

    procedure InsertItemStaging()
    var
        ItemStaging: Record "Item Staging TS";
        ItemRec: Record Item;
        InventorySetup: Record "Inventory Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        UnitOfMeasure: Record "Unit of Measure";
        TSItemNoExistLabel: Label 'TS Item No. Already Exist';
        TSItemBlankLabel: Label 'TS Item No. Should not be Blank';
        BaseUnitOfMeasLabel: Label 'Base Unit of Measure Should not be Blank';
        IsError: Boolean;
        NewRecord: Boolean;
    begin
        ItemStaging.SetRange("Integration Status", ItemStaging."Integration Status"::Pending);
        if ItemStaging.FindSet() then begin
            repeat
                IsError := false;
                NewRecord := false;
                if ItemStaging."Base Unit of Measure" = '' then begin
                    ItemStaging."Integration Status" := ItemStaging."Integration Status"::Error;
                    ItemStaging."Error Remarks" := BaseUnitOfMeasLabel;
                    ItemStaging.Modify(false);
                    IsError := true;
                end;
                if ItemStaging."TS Item No." = '' then begin
                    ItemStaging."Integration Status" := ItemStaging."Integration Status"::Error;
                    ItemStaging."Error Remarks" := TSItemBlankLabel;
                    ItemStaging.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    ItemRec.Reset();
                    ItemRec.SetCurrentKey("TS Item No.");
                    ItemRec.SetRange("TS Item No.", ItemStaging."TS Item No.");
                    if not ItemRec.FindFirst() then
                        NewRecord := true;

                    if NewRecord then begin
                        ItemRec.Init();
                        ItemRec."No." := '';
                    end;
                    ItemRec."TS Item No." := ItemStaging."TS Item No.";
                    ItemRec.Description := ItemStaging.Description;
                    ItemRec."Description 2" := ItemStaging."Description 2";
                    ItemRec.Type := ItemStaging.Type;
                    ItemRec."Item Category Code" := ItemStaging."Item Category Code";
                    if not UnitOfMeasure.Get(ItemStaging."Base Unit of Measure") then begin
                        UnitOfMeasure.Init();
                        UnitOfMeasure.Code := ItemStaging."Base Unit of Measure";
                        UnitOfMeasure.Insert();
                    end;
                    ItemRec.Validate("Base Unit of Measure", ItemStaging."Base Unit of Measure");
                    if ItemStaging."Purchase Unit of Measure" <> '' then begin
                        if not ItemUnitOfMeasure.Get(ItemRec."No.", ItemStaging."Purchase Unit of Measure") then begin
                            ItemUnitOfMeasure.Init();
                            ItemUnitOfMeasure."Item No." := ItemRec."No.";
                            ItemUnitOfMeasure.Code := ItemStaging."Purchase Unit of Measure";
                            ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                            ItemUnitOfMeasure.Insert();
                        end;
                        ItemRec.Validate("Purch. Unit of Measure", ItemStaging."Purchase Unit of Measure");
                    end;
                    if ItemStaging."Sales Unit of Measure" <> '' then begin
                        if not ItemUnitOfMeasure.Get(ItemRec."No.", ItemStaging."Sales Unit of Measure") then begin
                            ItemUnitOfMeasure.Init();
                            ItemUnitOfMeasure."Item No." := ItemRec."No.";
                            ItemUnitOfMeasure.Code := ItemStaging."Sales Unit of Measure";
                            ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                            ItemUnitOfMeasure.Insert();
                        end;
                        ItemRec.Validate("Sales Unit of Measure", ItemStaging."Sales Unit of Measure");
                    end;
                    ItemRec."Unit Price" := ItemStaging."Unit Price";
                    ItemRec.Blocked := ItemStaging.Blocked;
                    ItemRec.OD1 := ItemStaging.OD1;
                    ItemRec.OD2 := ItemStaging.OD2;
                    ItemRec.WT1 := ItemStaging.WT1;
                    ItemRec.WT2 := ItemStaging.WT2;
                    ItemRec."Grade Type" := ItemStaging."Grade Type";
                    ItemRec.Grade := ItemStaging.Grade;
                    ItemRec."Product Type" := ItemStaging."Product Type";
                    ItemRec."Attribute 8" := ItemStaging."Attribute 8";
                    ItemRec."Attribute 9" := ItemStaging."Attribute 9";
                    ItemRec."Attribute 10" := ItemStaging."Attribute 10";
                    ItemRec."Attribute 11" := ItemStaging."Attribute 11";
                    ItemRec."Attribute 12" := ItemStaging."Attribute 12";
                    ItemRec."Attribute 13" := ItemStaging."Attribute 13";
                    ItemRec."Attribute 14" := ItemStaging."Attribute 14";
                    ItemRec."Attribute 15" := ItemStaging."Attribute 15";
                    ItemRec."Attribute 16" := ItemStaging."Attribute 16";
                    ItemRec."Attribute 17" := ItemStaging."Attribute 17";
                    ItemRec."Attribute 18" := ItemStaging."Attribute 18";
                    ItemRec."Attribute 19" := ItemStaging."Attribute 19";
                    ItemRec."Attribute 20" := ItemStaging."Attribute 20";
                    if NewRecord then
                        ItemRec.Insert(true)
                    else
                        ItemRec.Modify(false);

                    ItemStaging."Integration Status" := ItemStaging."Integration Status"::Processed;
                    ItemStaging.Modify(false);
                end;
                Commit();
            Until ItemStaging.Next() = 0;
        end;
    end;

    procedure InsertLocationStaging()
    var
        LocationStaging: Record "Locations Staging TS";
        LocationRec: Record Location;
        IsError: Boolean;
        LocationExistLabel: Label 'Location Already Exist';
        LocationBlankLabel: Label 'Location Should not be Blank';
    begin
        LocationStaging.SetRange("Integration Status", LocationStaging."Integration Status"::Pending);
        if LocationStaging.FindSet() then begin
            repeat
                IsError := false;
                if LocationStaging.Code = '' then begin
                    LocationStaging."Integration Status" := LocationStaging."Integration Status"::Error;
                    LocationStaging."Error Remarks" := LocationBlankLabel;
                    LocationStaging.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    LocationRec.Init();
                    LocationRec.Code := LocationStaging.Code;
                    LocationRec.Name := LocationStaging.Name;
                    LocationRec.Address := LocationStaging.Address;
                    LocationRec."Address 2" := LocationStaging."Address 2";
                    LocationRec.City := LocationStaging.City;
                    LocationRec."Country/Region Code" := LocationStaging."Country Code";
                    LocationRec.Contact := LocationStaging.Contact;
                    LocationRec."Phone No." := LocationStaging."Phone No.";
                    LocationRec."E-Mail" := LocationStaging.Email;
                    LocationRec."Trust Limit" := LocationStaging."Trust Limit";
                    if not LocationRec.Insert(false) then
                        LocationRec.Modify(false);

                    LocationStaging."Integration Status" := LocationStaging."Integration Status"::Processed;
                    LocationStaging.Modify(false);
                end;
                Commit();
            Until LocationStaging.Next() = 0;
        end;
    end;

    procedure InsertMillMasterStaging()
    var
        MillMasterStaging: Record "Mill Master Staging TS";
        MillMasterRec: Record "Mill Master";
        IsError: Boolean;
        MillMasterExistLabel: Label 'Mill Master Already Exist';
        MillMasterBlankLabel: Label 'Mill Master Should not be Blank';
    begin
        MillMasterStaging.SetRange("Integration Status", MillMasterStaging."Integration Status"::Pending);
        if MillMasterStaging.FindSet() then begin
            repeat
                IsError := false;
                if MillMasterStaging.Code = '' then begin
                    MillMasterStaging."Integration Status" := MillMasterStaging."Integration Status"::Error;
                    MillMasterStaging."Error Remarks" := MillMasterBlankLabel;
                    MillMasterStaging.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    MillMasterRec.Init();
                    MillMasterRec.Code := MillMasterStaging.Code;
                    MillMasterRec.Description := MillMasterStaging.Description;
                    MillMasterRec.Address := MillMasterStaging.Address;
                    MillMasterRec.City := MillMasterStaging.City;
                    MillMasterRec.State := MillMasterStaging.State;
                    MillMasterRec.Country := MillMasterStaging.Country;
                    if not MillMasterRec.Insert(false) then
                        MillMasterRec.Modify(false);

                    MillMasterStaging."Integration Status" := MillMasterStaging."Integration Status"::Processed;
                    MillMasterStaging.Modify(false);
                end;
                Commit();
            Until MillMasterStaging.Next() = 0;
        end;
    end;

    procedure InsertDatatoStaging()
    var
        PurchRcptStaging: Record "Purchase Receipts TS";
        TransferOrderStaging: Record "Transfer Order Staging TS";
        InventAdjStaging: Record "Inventory Adjust. Staging TS";
        SalesOrderStaging: Record "Sales Order Staging TS";
        RecSalesOrderStaging: Record "Sales Order Staging TS";
        PurchaseLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        SalesOrderStaging.Reset();
        if SalesOrderStaging.FindSet() then begin
            repeat
                SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Pending;
                SalesOrderStaging.Modify();
            Until SalesOrderStaging.Next() = 0;
        end;
        exit;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", '106006');
        if PurchaseLine.FindFirst() then begin
            PurchRcptStaging.Reset();
            if PurchRcptStaging.FindLast() then
                EntryNo := PurchRcptStaging."Entry No." + 1;
            PurchRcptStaging.Reset();
            PurchRcptStaging.Init();
            PurchRcptStaging."Entry No." := EntryNo;
            PurchRcptStaging."Purchase Order No." := PurchaseLine."Document No.";
            PurchRcptStaging."Purchase Receipt No." := PurchaseLine."Document No.";
            PurchRcptStaging."TS Item No." := PurchaseLine."TS Item No.";
            PurchRcptStaging."Quantity Received" := PurchaseLine.Quantity;
            PurchRcptStaging."Quantity Good" := 5;
            PurchRcptStaging."Quantity Damaged" := 3;
            PurchRcptStaging."Quantity Rejected" := 2;
            PurchRcptStaging."Lot No." := 'LOT-PO01';
            PurchRcptStaging.Insert(true);
            //Until PurchaseLine.Next() = 0;
        end;
        exit;
        InventAdjStaging.Reset();
        if InventAdjStaging.FindSet() then
            repeat
                InventAdjStaging."Integration Status" := InventAdjStaging."Integration Status"::Pending;
                InventAdjStaging.Modify();
            Until InventAdjStaging.Next() = 0;
        exit;
        if TransferOrderStaging.FindSet() then
            repeat
                TransferOrderStaging."From Location Code" := 'DUBAI-1';
                TransferOrderStaging."To Location Code" := 'DUBAI-2';
                TransferOrderStaging.Modify();
            Until TransferOrderStaging.Next() = 0;
        exit;
    end;

    procedure UpdatePurchaseReceiptsStaging()
    var
        PurchaseReceiptsStaging: Record "Purchase Receipts TS";
        ReOpenPurchaseDoc: Codeunit "Release Purchase Document";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        InventorySetup: Record "Inventory Setup";
        PurchaseLineExistLabel: Label 'Purchase Line does not Exist';
        TSItemExistLabel: Label 'TS Item No Should Not be Blank';
        PurchaseOrderBlankLabel: Label 'Purchase Order No Should Not be Blank';
        PurchaseReceiptBlankLabel: Label 'Purchase Receipt No Should Not be Blank';
        QuantityReceivedBlankLable: Label 'Quantity Received Should Not be Blank';
        InventorySetupBlankLabel: Label 'Good/Damaged/Rejected Location Should Not be Blank in Inventory Setup';
        IsError: Boolean;
    begin
        PurchaseReceiptsStaging.SetRange("Integration Status", PurchaseReceiptsStaging."Integration Status"::Pending);
        if PurchaseReceiptsStaging.FindSet() then begin
            repeat
                IsError := false;
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", PurchaseReceiptsStaging."Purchase Order No.");
                PurchaseLine.SetRange("TS Item No.", PurchaseReceiptsStaging."TS Item No.");
                if not PurchaseLine.FindFirst() then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := PurchaseLineExistLabel;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                if PurchaseReceiptsStaging."TS Item No." = '' then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := TSItemExistLabel;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                if PurchaseReceiptsStaging."Purchase Order No." = '' then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := PurchaseOrderBlankLabel;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                if PurchaseReceiptsStaging."Purchase Receipt No." = '' then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := PurchaseReceiptBlankLabel;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                if PurchaseReceiptsStaging."Quantity Received" = 0 then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := QuantityReceivedBlankLable;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                InventorySetup.Get();
                if (InventorySetup.Good = '') or (InventorySetup.Damaged = '') or (InventorySetup.Rejected = '') then begin
                    PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Error;
                    PurchaseReceiptsStaging."Error Remarks" := InventorySetupBlankLabel;
                    PurchaseReceiptsStaging.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.SetRange("No.", PurchaseReceiptsStaging."Purchase Order No.");
                    if PurchaseHeader.FindFirst() then begin
                        if PurchaseHeader.Status = PurchaseHeader.Status::Released then
                            ReOpenPurchaseDoc.Reopen(PurchaseHeader);
                        PurchaseHeader."Receiving No." := PurchaseReceiptsStaging."Purchase Receipt No.";
                        PurchaseHeader.Modify();
                    end;

                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", PurchaseReceiptsStaging."Purchase Order No.");
                    PurchaseLine.SetRange("TS Item No.", PurchaseReceiptsStaging."TS Item No.");
                    if PurchaseLine.FindFirst() then begin
                        PurchaseLine.Validate("Qty. to Receive", PurchaseReceiptsStaging."Quantity Received");
                        CreateTransferOrderForPurchaseReceipts(PurchaseLine, PurchaseReceiptsStaging);
                        PurchaseLine.Modify();

                        PurchaseReceiptsStaging."Integration Status" := PurchaseReceiptsStaging."Integration Status"::Processed;
                        PurchaseReceiptsStaging.Modify(false);
                    end;
                end;
                Commit();
            Until PurchaseReceiptsStaging.Next() = 0;
        end;
    end;

    procedure CreateTransferOrders()
    var
        TransferOrderStaging: Record "Transfer Order Staging TS";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferLineLastNo: Record "Transfer Line";
        ItemRec: Record Item;
        ReOpenTransferDoc: Codeunit "Release Transfer Document";
        LotCreation: Record "Purchase Line";
        Location: Record Location;
        LineNo: Integer;
        TransferLineExistLabel: Label 'Transfer Line Already Exist';
        TransferCodeBlankLabel: Label 'Transfer From/To Code Should Not be Blank';
        TSItemNoBlankLabel: Label 'TS Item No Should Not be Blank';
        TSQuantityBlanklabel: Label 'Quantity/Quantity Received/Quantity Shipped Should Not be Blank';
        ItemExistError: Label 'TS Item Does not Exist';
        LocationExistLabel: Label 'Location Code Does not Exist';
        IsError: Boolean;
    begin
        TransferOrderStaging.SetRange("Integration Status", TransferOrderStaging."Integration Status"::Pending);
        if TransferOrderStaging.FindSet() then begin
            repeat
                IsError := false;
                if (TransferOrderStaging."To Location Code" = '') or (TransferOrderStaging."From Location Code" = '') then begin
                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Error;
                    TransferOrderStaging."Error Remarks" := TransferCodeBlankLabel;
                    TransferOrderStaging.Modify(false);
                    IsError := true;
                end;
                if TransferOrderStaging."TS Item No." = '' then begin
                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Error;
                    TransferOrderStaging."Error Remarks" := TSItemNoBlankLabel;
                    TransferOrderStaging.Modify(false);
                    IsError := true;
                end;
                ItemRec.Reset();
                ItemRec.SetRange("TS Item No.", TransferOrderStaging."TS Item No.");
                if not ItemRec.FindFirst() then begin
                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Error;
                    TransferOrderStaging."Error Remarks" := ItemExistError;
                    TransferOrderStaging.Modify(false);
                    IsError := true;
                end;
                if (TransferOrderStaging.Quantity = 0) or (TransferOrderStaging."Quantity Shipped" = 0) or (TransferOrderStaging."Quantity Received" = 0) then begin
                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Error;
                    TransferOrderStaging."Error Remarks" := TSQuantityBlanklabel;
                    TransferOrderStaging.Modify(false);
                    IsError := true;
                end;
                if (not Location.Get(TransferOrderStaging."From Location Code")) or (not Location.Get(TransferOrderStaging."To Location Code")) then begin
                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Error;
                    TransferOrderStaging."Error Remarks" := LocationExistLabel;
                    TransferOrderStaging.Modify(false);
                    IsError := true;
                end;

                if not IsError then begin
                    TransferHeader.Reset();
                    TransferHeader.SetRange("No.", TransferOrderStaging."Transfer Order No.");
                    if not TransferHeader.FindFirst() then begin
                        TransferHeader.Init();
                        TransferHeader."No." := TransferOrderStaging."Transfer Order No.";
                        TransferHeader.Validate("Transfer-from Code", TransferOrderStaging."From Location Code");
                        TransferHeader.Validate("Transfer-to Code", TransferOrderStaging."To Location Code");
                        Location.Reset();
                        Location.SetRange("Use As In-Transit", true);
                        Location.FindFirst();
                        TransferHeader."In-Transit Code" := Location.code;
                        TransferHeader.Validate("Posting Date", TransferOrderStaging."Transfer Date");
                        TransferHeader.Insert(true);
                    end else
                        if TransferHeader.Status = TransferHeader.Status::Released then
                            ReOpenTransferDoc.Reopen(TransferHeader);

                    TransferLineLastNo.Reset();
                    TransferLineLastNo.SetRange("Document No.", TransferOrderStaging."Transfer Order No.");
                    if TransferLineLastNo.FindLast() then
                        LineNo := TransferLineLastNo."Line No." + 10000
                    else
                        LineNo := 10000;

                    ItemRec.Reset();
                    ItemRec.SetRange("TS Item No.", TransferOrderStaging."TS Item No.");
                    if ItemRec.FindFirst() then;

                    TransferLine.Init();
                    TransferLine."Document No." := TransferOrderStaging."Transfer Order No.";
                    TransferLine."Line No." := LineNo;
                    TransferLine.Validate("Item No.", ItemRec."No.");
                    TransferLine."TS Item No." := TransferOrderStaging."TS Item No.";
                    TransferLine.Validate(Quantity, TransferOrderStaging.Quantity);
                    TransferLine.Insert(true);
                    if TransferOrderStaging."Item Lot No." <> '' then begin
                        LotCreation.CreateReservationEntry(TransferLine."Item No.", TransferLine."Transfer-from Code", -TransferLine."Qty. to Ship", 5741, 0, TransferLine.Description,
                                    TransferLine."Document No.", TransferLine."Line No.", TransferLine."Qty. per Unit of Measure", -TransferLine."Qty. to Ship (Base)", TransferOrderStaging."Item Lot No.", false, '', 2, TransferHeader."Posting Date");
                        LotCreation.CreateReservationEntry(TransferLine."Item No.", TransferLine."Transfer-To Code", TransferLine."Qty. to Ship", 5741, 1, TransferLine.Description,
                                    TransferLine."Document No.", TransferLine."Line No.", TransferLine."Qty. per Unit of Measure", TransferLine."Qty. to Ship (Base)", TransferOrderStaging."Item Lot No.", true, '', 2, 0D);
                    end;

                    TransferOrderStaging."Integration Status" := TransferOrderStaging."Integration Status"::Processed;
                    TransferOrderStaging.Modify(false);
                end;
                Commit();
            Until TransferOrderStaging.Next() = 0;
        end;
    end;

    procedure AdjustInventory()
    var
        InventoryAdj: Record "Inventory Adjust. Staging TS";
        ItemJournal: Record "Item Journal Line";
        ItemJournalLineNo: Record "Item Journal Line";
        ItemRec: Record Item;
        LocationRec: Record Location;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        LineNo: Integer;
        ReservationEntry: Record "Reservation Entry";
        LotCreation: Record "Purchase Line";
        IsError: Boolean;
        TSItemExistlabel: Label 'TS Item No Does not Exist';
        TSItemBlankLabel: Label 'TS Item Should Not be Blank';
        DocumentNoBlankLabel: Label 'Document No Should Not be Blank';
        LocationNoBlankLabel: Label 'Location No Should Not be Blank';
        LocationNoExistLable: Label 'Location Does Not Exist';
        QuantityBlankLabel: Label 'Quantity Should Not be Blank';
        TemplateBankLabel: Label 'TS Template/Batch Should not be Blank in Inventory Setup';
    begin
        InventoryAdj.SetRange("Integration Status", InventoryAdj."Integration Status"::Pending);
        if InventoryAdj.FindSet() then begin
            repeat
                IsError := false;
                if InventoryAdj."Document No." = '' then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := DocumentNoBlankLabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                if InventoryAdj."TS Item No." = '' then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := TSItemBlankLabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                ItemRec.Reset();
                ItemRec.SetRange("TS Item No.", InventoryAdj."TS Item No.");
                if not ItemRec.FindFirst() then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := TSItemExistlabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                if InventoryAdj."Location Code" = '' then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := LocationNoBlankLabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                if Not LocationRec.Get(InventoryAdj."Location Code") then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := LocationNoExistLable;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                if InventoryAdj.Quantity = 0 then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := QuantityBlankLabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                InventorySetup.Get();
                if (InventorySetup."TS Journal Batch Name" = '') or (InventorySetup."TS Journal Template Name" = '') then begin
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Error;
                    InventoryAdj."Error Remarks" := TemplateBankLabel;
                    InventoryAdj.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    ItemJournalLineNo.Reset();
                    ItemJournalLineNo.SetRange("Journal Batch Name", InventorySetup."TS Journal Batch Name");
                    ItemJournalLineNo.SetRange("Journal Template Name", InventorySetup."TS Journal Template Name");
                    if ItemJournalLineNo.FindLast() then
                        LineNo := ItemJournalLineNo."Line No." + 10000
                    else
                        LineNo := 10000;
                    InventorySetup.Get();
                    ItemJournal.Init();
                    ItemJournal."Journal Batch Name" := InventorySetup."TS Journal Batch Name";
                    ItemJournal."Journal Template Name" := InventorySetup."TS Journal Template Name";
                    ItemJournal."Line No." := LineNo;
                    ItemJournal."Document No." := InventoryAdj."Document No.";
                    ItemJournal.validate("Posting Date", Today);
                    ItemJournal.validate("Document Date", Today);
                    ItemJournal.Insert();

                    if InventoryAdj."Entry Type" = InventoryAdj."Entry Type"::"Positive Adjmt." then
                        ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
                    if InventoryAdj."Entry Type" = InventoryAdj."Entry Type"::"Negative Adjmt." then
                        ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
                    ItemRec.Reset();
                    ItemRec.SetRange("TS Item No.", InventoryAdj."TS Item No.");
                    if ItemRec.FindFirst() then;
                    if not ItemUnitOfMeasure.Get(ItemRec."No.", InventoryAdj."Unit of Measure Code") then begin
                        ItemUnitOfMeasure.Init();
                        ItemUnitOfMeasure."Item No." := ItemRec."No.";
                        ItemUnitOfMeasure.Code := InventoryAdj."Unit of Measure Code";
                        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                        ItemUnitOfMeasure.Insert();
                    end;
                    ItemJournal.Validate("Item No.", ItemRec."No.");
                    ItemJournal."TS Item No." := InventoryAdj."TS Item No.";
                    ItemJournal.Validate(Quantity, InventoryAdj.Quantity);
                    if InventoryAdj."Item Lot No." <> '' then
                        ItemJournal.Validate("Lot No.", InventoryAdj."Item Lot No.");
                    ItemJournal.validate("Location Code", InventoryAdj."Location Code");
                    ItemJournal.Validate("Unit of Measure Code", InventoryAdj."Unit of Measure Code");
                    ItemJournal."Reason Code" := InventoryAdj."Reason Code";
                    ItemJournal.Modify();
                    if ItemJournal."Entry Type" = ItemJournal."Entry Type"::"Positive Adjmt." then
                        LotCreation.CreateReservationEntry(ItemJournal."Item No.", ItemJournal."Location Code", ItemJournal."Quantity (Base)", 83, 2, ItemJournal.Description,
                                ItemJournal."Journal Template Name", ItemJournal."Line No.", ItemJournal."Qty. per Unit of Measure", ItemJournal.Quantity, InventoryAdj."Item Lot No.", true, ItemJournal."Journal Batch Name", 3, 0D);
                    if ItemJournal."Entry Type" = ItemJournal."Entry Type"::"Negative Adjmt." then
                        LotCreation.CreateReservationEntry(ItemJournal."Item No.", ItemJournal."Location Code", -ItemJournal."Quantity (Base)", 83, 3, ItemJournal.Description,
                                ItemJournal."Journal Template Name", ItemJournal."Line No.", ItemJournal."Qty. per Unit of Measure", -ItemJournal.Quantity, InventoryAdj."Item Lot No.", false, ItemJournal."Journal Batch Name", 3, 0D);
                    InventoryAdj."Integration Status" := InventoryAdj."Integration Status"::Processed;
                    InventoryAdj.Modify(false);
                end;
                Commit();
            Until InventoryAdj.Next() = 0;
        end;
    end;

    procedure InsertProductionIssueandReceipt()
    var
        ProdIssueRcpt: Record "Prod. Issue - Rcpt Staging TS";
        ItemJournal: Record "Item Journal Line";
        ItemJournalLineNo: Record "Item Journal Line";
        LineNo: Integer;
        ItemRec: Record Item;
        LocationRec: Record Location;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        LotCreation: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        InventorySetup: Record "Inventory Setup";
        LotNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsError: Boolean;
        TSItemExistlabel: Label 'TS Item No Does not Exist';
        TSItemBlankLabel: Label 'TS Item Should Not be Blank';
        DocumentNoBlankLabel: Label 'Document No Should Not be Blank';
        LocationNoBlankLabel: Label 'Location No Should Not be Blank';
        LocationNoExistLable: Label 'Location Does Not Exist';
        QuantityBlankLabel: Label 'Quantity Should Not be Blank';
        TemplateBankLabel: Label 'TS Template/Batch Should not be Blank in Inventory Setup';
    begin
        ProdIssueRcpt.SetRange("Integration Status", ProdIssueRcpt."Integration Status"::Pending);
        if ProdIssueRcpt.FindSet() then begin
            repeat
                IsError := false;
                if ProdIssueRcpt."Document No." = '' then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := DocumentNoBlankLabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                if ProdIssueRcpt."TS Item No." = '' then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := TSItemBlankLabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                ItemRec.Reset();
                ItemRec.SetRange("TS Item No.", ProdIssueRcpt."TS Item No.");
                if not ItemRec.FindFirst() then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := TSItemExistlabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                if ProdIssueRcpt."Location Code" = '' then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := LocationNoBlankLabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                if Not LocationRec.Get(ProdIssueRcpt."Location Code") then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := LocationNoExistLable;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                if ProdIssueRcpt.Quantity = 0 then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := QuantityBlankLabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                InventorySetup.Get();
                if (InventorySetup."TS Journal Batch Name" = '') or (InventorySetup."TS Journal Template Name" = '') then begin
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Error;
                    ProdIssueRcpt."Error Remarks" := TemplateBankLabel;
                    ProdIssueRcpt.Modify(false);
                    IsError := true;
                end;
                IF NOT IsError THEN BEGIN
                    ItemJournalLineNo.Reset();
                    ItemJournalLineNo.SetRange("Journal Batch Name", InventorySetup."TS Journal Batch Name");
                    ItemJournalLineNo.SetRange("Journal Template Name", InventorySetup."TS Journal Template Name");
                    if ItemJournalLineNo.FindLast() then
                        LineNo := ItemJournalLineNo."Line No." + 10000
                    else
                        LineNo := 10000;
                    ItemJournal.Init();
                    ItemJournal."Journal Batch Name" := InventorySetup."TS Journal Batch Name";
                    ItemJournal."Journal Template Name" := InventorySetup."TS Journal Template Name";
                    ItemJournal."Line No." := LineNo;
                    ItemJournal."Document No." := ProdIssueRcpt."Document No.";
                    ItemJournal.validate("Posting Date", Today);
                    ItemJournal.validate("Document Date", Today);
                    ItemJournal.Insert();

                    if ProdIssueRcpt."Entry Type" = ProdIssueRcpt."Entry Type"::Receipt then
                        ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
                    if ProdIssueRcpt."Entry Type" = ProdIssueRcpt."Entry Type"::Issue then
                        ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
                    ItemRec.Reset();
                    ItemRec.SetRange("TS Item No.", ProdIssueRcpt."TS Item No.");
                    if ItemRec.FindFirst() then;
                    if not ItemUnitOfMeasure.Get(ItemRec."No.", ProdIssueRcpt."Unit of Measure Code") then begin
                        ItemUnitOfMeasure.Init();
                        ItemUnitOfMeasure."Item No." := ItemRec."No.";
                        ItemUnitOfMeasure.Code := ProdIssueRcpt."Unit of Measure Code";
                        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                        ItemUnitOfMeasure.Insert();
                    end;
                    ItemJournal.Validate("Item No.", ItemRec."No.");
                    ItemJournal."TS Item No." := ProdIssueRcpt."TS Item No.";
                    ItemJournal.Validate(Quantity, ProdIssueRcpt.Quantity);
                    if ProdIssueRcpt."Item Lot No." <> '' then
                        ItemJournal.Validate("Lot No.", ProdIssueRcpt."Item Lot No.");
                    ItemJournal.validate("Location Code", ProdIssueRcpt."Location Code");
                    ItemJournal.Validate("Unit of Measure Code", ProdIssueRcpt."Unit of Measure Code");
                    ItemJournal."Reason Code" := ProdIssueRcpt."Reason Code";
                    ItemJournal.Modify(false);

                    if ItemJournal."Entry Type" = ItemJournal."Entry Type"::"Positive Adjmt." then
                        LotCreation.CreateReservationEntry(ItemJournal."Item No.", ItemJournal."Location Code", ItemJournal."Quantity (Base)", 83, 2, ItemJournal.Description,
                                ItemJournal."Journal Template Name", ItemJournal."Line No.", ItemJournal."Qty. per Unit of Measure", ItemJournal.Quantity, ProdIssueRcpt."Item Lot No.", true, ItemJournal."Journal Batch Name", 3, 0D);
                    if ItemJournal."Entry Type" = ItemJournal."Entry Type"::"Negative Adjmt." then
                        LotCreation.CreateReservationEntry(ItemJournal."Item No.", ItemJournal."Location Code", -ItemJournal."Quantity (Base)", 83, 3, ItemJournal.Description,
                                ItemJournal."Journal Template Name", ItemJournal."Line No.", ItemJournal."Qty. per Unit of Measure", -ItemJournal.Quantity, ProdIssueRcpt."Item Lot No.", false, ItemJournal."Journal Batch Name", 3, 0D);
                    ProdIssueRcpt."Integration Status" := ProdIssueRcpt."Integration Status"::Processed;
                    ProdIssueRcpt.Modify(false);
                END;
                Commit();
            Until ProdIssueRcpt.Next() = 0;
        end;
    end;

    procedure InsertSalesOrder()
    var
        SalesOrderStaging: Record "Sales Order Staging TS";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLineRec: Record "Sales Line";
        ItemRec: Record Item;
        LocationRec: Record Location;
        CustomerRec: Record Customer;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ReOpenSalesOrder: Codeunit "Release Sales Document";
        LineNo: Integer;
        LotCreation: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        IsError: Boolean;
        TSItemExistlabel: Label 'TS Item No Does not Exist';
        TSItemBlankLabel: Label 'TS Item Should Not be Blank';
        DocumentNoBlankLabel: Label 'Document No Should Not be Blank';
        LocationNoBlankLabel: Label 'Location No Should Not be Blank';
        LocationNoExistLable: Label 'Location Does Not Exist';
        QuantityBlankLabel: Label 'Quantity Should Not be Blank';
        CustomerNoBlankLabel: Label 'Customer Should Not be Blank';
        CustomerExistLabel: Label 'Customer No. does not Exist';
    begin
        SalesOrderStaging.SetRange("Integration Status", SalesOrderStaging."Integration Status"::Pending);
        if SalesOrderStaging.FindSet() then begin
            repeat
                IsError := false;
                if SalesOrderStaging."Document No." = '' then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := DocumentNoBlankLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if SalesOrderStaging."TS Item No." = '' then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := TSItemBlankLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                ItemRec.Reset();
                ItemRec.SetRange("TS Item No.", SalesOrderStaging."TS Item No.");
                if not ItemRec.FindFirst() then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := TSItemExistlabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if SalesOrderStaging."Location Code" = '' then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := LocationNoBlankLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if Not LocationRec.Get(SalesOrderStaging."Location Code") then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := LocationNoExistLable;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if SalesOrderStaging.Quantity = 0 then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := QuantityBlankLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if SalesOrderStaging."Customer No." = '' then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := CustomerNoBlankLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if not CustomerRec.Get(SalesOrderStaging."Customer No.") then begin
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Error;
                    SalesOrderStaging."Error Remarks" := CustomerExistLabel;
                    SalesOrderStaging.Modify(false);
                    IsError := true;
                end;
                if not IsError then begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange("No.", SalesOrderStaging."Document No.");
                    if not SalesHeader.FindFirst() then begin
                        SalesHeader.Init();
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                        SalesHeader."No." := SalesOrderStaging."Document No.";
                        SalesHeader.Validate("Sell-to Customer No.", SalesOrderStaging."Customer No.");
                        SalesHeader.Validate("Posting Date", SalesOrderStaging."Order Date");
                        SalesHeader.Validate("Payment Terms Code", SalesOrderStaging."Payment Terms Code");
                        SalesHeader."External Document No." := SalesOrderStaging."Customer PO No.";
                        SalesHeader.Validate("Salesperson Code", SalesOrderStaging."Salesperson Code");
                        SalesHeader.Validate("Location Code", SalesOrderStaging."Location Code");
                        SalesHeader.Validate("Currency Code", SalesOrderStaging."Currency Code");
                        SalesHeader."MR No." := SalesOrderStaging."Material Req No.";
                        SalesHeader.Insert(true);
                    end else
                        if SalesHeader.Status <> SalesHeader.Status::Open then
                            ReOpenSalesOrder.Reopen(SalesHeader);

                    SalesLineRec.Reset();
                    SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Order);
                    SalesLineRec.SetRange("Document No.", SalesOrderStaging."Document No.");
                    if SalesLineRec.FindLast() then
                        LineNo := SalesLineRec."Line No." + 10000
                    else
                        LineNo := 10000;

                    SalesLine.Init();
                    SalesLine."Document Type" := SalesLine."Document Type"::Order;
                    SalesLine."Document No." := SalesOrderStaging."Document No.";
                    SalesLine."Line No." := LineNo;
                    SalesLine.Type := SalesLine.Type::Item;
                    ItemRec.Reset();
                    ItemRec.SetRange("TS Item No.", SalesOrderStaging."TS Item No.");
                    if ItemRec.FindFirst() then;
                    SalesLine.Validate("No.", ItemRec."No.");
                    SalesLine."TS Item No." := SalesOrderStaging."TS Item No.";
                    SalesLine.Validate(Quantity, SalesOrderStaging.Quantity);
                    SalesLine.Validate("Location Code", SalesOrderStaging."Location Code");
                    if not ItemUnitOfMeasure.Get(ItemRec."No.", SalesOrderStaging."Unit of Measure") then begin
                        ItemUnitOfMeasure.Init();
                        ItemUnitOfMeasure."Item No." := ItemRec."No.";
                        ItemUnitOfMeasure.Code := SalesOrderStaging."Unit of Measure";
                        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                        ItemUnitOfMeasure.Insert();
                    end;
                    SalesLine."Unit of Measure Code" := SalesOrderStaging."Unit of Measure";
                    SalesLine.Validate("Unit Price", SalesOrderStaging."Unit Price Excl. VAT");
                    SalesLine."Material Req No." := SalesOrderStaging."Material Req No.";
                    SalesLine."Customer Item Code" := SalesOrderStaging."Customer Item Code";
                    SalesLine."Promised Delivery Date" := SalesOrderStaging."Delivery Date";
                    LotCreation.CreateReservationEntry(SalesLine."No.", SalesLine."Location Code", -SalesLine."Quantity (Base)", 37, 1, SalesLine.Description,
                            SalesLine."Document No.", SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", -SalesLine.Quantity, SalesOrderStaging."Item Lot No.", false, '', 2, SalesLine."Shipment Date");
                    SalesLine.Insert(true);
                    SalesOrderStaging."Integration Status" := SalesOrderStaging."Integration Status"::Processed;
                    SalesOrderStaging.Modify();
                end;
                Commit();
            Until SalesOrderStaging.Next() = 0;
        end;
    end;

    procedure UpdateSalesShipment()
    var
        SalesShipmentStaging: Record "Sales Shipments Staging TS";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ReopenSalesDoc: Codeunit "Release Sales Document";
        IsError: Boolean;
        SalesLineExistLabel: Label 'Sales Line Does not Exist';
        QuantityBlankLabel: Label 'Quantity Should Not be Blank';
        ShipmentNoBlankLabel: Label 'Shipment No Should Not be Blank';
        QuantityErrLabel: Label 'Quantity Should not be greater than ';
    begin
        SalesShipmentStaging.SetRange("Integration Status", SalesShipmentStaging."Integration Status"::Pending);
        if SalesShipmentStaging.FindSet() then begin
            repeat
                IsError := false;
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesShipmentStaging."Sales Order No.");
                SalesLine.SetRange("TS Item No.", SalesShipmentStaging."TS Item No.");
                if not SalesLine.FindFirst() then begin
                    SalesShipmentStaging."Integration Status" := SalesShipmentStaging."Integration Status"::Error;
                    SalesShipmentStaging."Error Remarks" := SalesLineExistLabel;
                    SalesShipmentStaging.Modify(false);
                    IsError := true;
                end;
                if SalesShipmentStaging.Quantity = 0 then begin
                    SalesShipmentStaging."Integration Status" := SalesShipmentStaging."Integration Status"::Error;
                    SalesShipmentStaging."Error Remarks" := QuantityBlankLabel;
                    SalesShipmentStaging.Modify(false);
                    IsError := true;
                end;
                if SalesShipmentStaging."Shipment No." = '' then begin
                    SalesShipmentStaging."Integration Status" := SalesShipmentStaging."Integration Status"::Error;
                    SalesShipmentStaging."Error Remarks" := ShipmentNoBlankLabel;
                    SalesShipmentStaging.Modify(false);
                    IsError := true;
                end;
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesShipmentStaging."Sales Order No.");
                SalesLine.SetRange("TS Item No.", SalesShipmentStaging."TS Item No.");
                if SalesLine.FindFirst() then begin
                    if SalesLine.Quantity < SalesShipmentStaging.Quantity then begin
                        SalesShipmentStaging."Integration Status" := SalesShipmentStaging."Integration Status"::Error;
                        SalesShipmentStaging."Error Remarks" := QuantityErrLabel + 'Sales Line Quantity - ' + Format(SalesLine.Quantity);
                        SalesShipmentStaging.Modify(false);
                        IsError := true;
                    end;
                end;
                if not IsError then begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange("No.", SalesShipmentStaging."Sales Order No.");
                    if SalesHeader.FindFirst() then begin
                        ReopenSalesDoc.Reopen(SalesHeader);
                        SalesHeader."Shipping No." := SalesShipmentStaging."Shipment No.";
                        SalesHeader."Shipment Date" := SalesShipmentStaging."Shipment Date";
                        SalesHeader.Modify();
                    end;

                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.", SalesShipmentStaging."Sales Order No.");
                    SalesLine.SetRange("TS Item No.", SalesShipmentStaging."TS Item No.");
                    if SalesLine.FindFirst() then begin
                        SalesLine.Validate("Qty. to Ship", SalesShipmentStaging.Quantity);
                        SalesLine.Modify();

                        SalesShipmentStaging."Integration Status" := SalesShipmentStaging."Integration Status"::Processed;
                        SalesShipmentStaging.Modify();
                    end;
                end;
                Commit();
            Until SalesShipmentStaging.Next() = 0;
        end;

    end;

    procedure CreateTransferOrderForPurchaseReceipts(PurchLine: Record "Purchase Line"; PurchaseRcptStaging: Record "Purchase Receipts TS")
    begin
        if PurchaseRcptStaging."Quantity Good" <> 0 then
            CreateTransferOrderForPO(PurchLine, PurchaseRcptStaging, true, false, false, PurchaseRcptStaging."Quantity Good");
        if PurchaseRcptStaging."Quantity Damaged" <> 0 then
            CreateTransferOrderForPO(PurchLine, PurchaseRcptStaging, false, true, false, PurchaseRcptStaging."Quantity Damaged");
        if PurchaseRcptStaging."Quantity Rejected" <> 0 then
            CreateTransferOrderForPO(PurchLine, PurchaseRcptStaging, false, false, true, PurchaseRcptStaging."Quantity Rejected");
    end;

    procedure CreateTransferOrderForPO(PurchLine: Record "Purchase Line"; PurchaseRcptStaging: Record "Purchase Receipts TS"; Good: Boolean; Damaged: Boolean; Rejected: Boolean; Qty: Decimal)
    var
        PurchaseHeader: Record "Purchase Header";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        InventorySetup: Record "Inventory Setup";
        TransferLineLastNo: Record "Transfer Line";
        ItemRec: Record Item;
        LotCreation: Record "Purchase Line";
        Location: Record Location;
        LocationCode: Code[10];
    begin
        PurchaseHeader.Get(PurchLine."Document Type", PurchLine."Document No.");
        InventorySetup.Get();
        If Good then
            LocationCode := InventorySetup.Good;
        if Damaged then
            LocationCode := InventorySetup.Damaged;
        if Rejected then
            LocationCode := InventorySetup.Rejected;

        TransferHeader.Init();
        TransferHeader."No." := '';
        TransferHeader."Transfer-from Code" := PurchLine."Location Code";
        TransferHeader."Transfer-to Code" := LocationCode;
        Location.Reset();
        Location.SetRange("Use As In-Transit", true);
        Location.FindFirst();
        TransferHeader."In-Transit Code" := Location.code;
        TransferHeader.Validate("Posting Date", PurchaseHeader."Posting Date");
        TransferHeader."External Document No." := PurchaseHeader."No.";
        TransferHeader.Insert(true);

        ItemRec.Reset();
        ItemRec.SetRange("TS Item No.", PurchLine."TS Item No.");
        if ItemRec.FindFirst() then;

        TransferLine.Init();
        TransferLine."Document No." := TransferHeader."No.";
        TransferLine."Line No." := 10000;
        TransferLine.Validate("Item No.", ItemRec."No.");
        TransferLine."TS Item No." := PurchLine."TS Item No.";
        TransferLine.Validate(Quantity, Qty);
        TransferLine.Insert(true);
        if PurchaseRcptStaging."Lot No." <> '' then begin
            LotCreation.CreateReservationEntry(TransferLine."Item No.", TransferLine."Transfer-from Code", -TransferLine."Qty. to Ship", 5741, 0, TransferLine.Description,
                        TransferLine."Document No.", TransferLine."Line No.", TransferLine."Qty. per Unit of Measure", -TransferLine."Qty. to Ship (Base)", PurchaseRcptStaging."Lot No.", false, '', 2, PurchaseHeader."Posting Date");
            LotCreation.CreateReservationEntry(TransferLine."Item No.", TransferLine."Transfer-To Code", TransferLine."Qty. to Ship", 5741, 1, TransferLine.Description,
                        TransferLine."Document No.", TransferLine."Line No.", TransferLine."Qty. per Unit of Measure", TransferLine."Qty. to Ship (Base)", PurchaseRcptStaging."Lot No.", true, '', 2, 0D);
        end;
    end;

    procedure CreateSalesReturnOrder()
    var
        SalesReturnStaging: Record "Sales Ret. Order Staging TS";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        InventorySetup: Record "Inventory Setup";
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        Customer: Record Customer;
        LineNo: Integer;
        IsError: Boolean;
        CustomerErr: Label 'Customer does not Exist;';
        ItemErr: Label 'Item does not Exist.';
        QtyErr: Label 'Quantity Good/Quantity Damaged Should not be zero.';
        InventorySetupErr: Label 'Location Code Should not be Blank in Inventory Setup.';
    begin
        SalesReturnStaging.SetRange("Integration Status", SalesReturnStaging."Integration Status"::Pending);
        if SalesReturnStaging.FindSet() then begin
            repeat
                IsError := false;
                LineNo := 0;
                InventorySetup.Get();
                if (InventorySetup.Good = '') or (InventorySetup.Damaged = '') then begin
                    SalesReturnStaging."Error Remarks" := InventorySetupErr;
                    SalesReturnStaging."Integration Status" := SalesReturnStaging."Integration Status"::Error;
                    SalesReturnStaging.Modify();
                    IsError := true;
                end;
                Item.Reset();
                Item.SetRange("TS Item No.", SalesReturnStaging."Item Numbers");
                if (not Item.FindFirst()) or (SalesReturnStaging."Item Numbers" = '') then begin
                    SalesReturnStaging."Error Remarks" := ItemErr;
                    SalesReturnStaging."Integration Status" := SalesReturnStaging."Integration Status"::Error;
                    SalesReturnStaging.Modify();
                    IsError := true;
                end;
                if (SalesReturnStaging."Quantity Damaged" = 0) and (SalesReturnStaging."Quantity Good" = 0) then begin
                    SalesReturnStaging."Error Remarks" := QtyErr;
                    SalesReturnStaging."Integration Status" := SalesReturnStaging."Integration Status"::Error;
                    SalesReturnStaging.Modify();
                    IsError := true;
                end;
                Customer.Reset();
                Customer.SetRange("No.", SalesReturnStaging."Customer Code");
                if (not Customer.FindFirst()) or (SalesReturnStaging."Customer Code" = '') then begin
                    SalesReturnStaging."Error Remarks" := CustomerErr;
                    SalesReturnStaging."Integration Status" := SalesReturnStaging."Integration Status"::Error;
                    SalesReturnStaging.Modify();
                    IsError := true;
                end;
                if not IsError then begin
                    SalesHeader.Reset();
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
                    SalesHeader."No." := '';
                    SalesHeader.Insert(true);
                    SalesHeader.Validate("Sell-to Customer No.", SalesReturnStaging."Customer Code");
                    SalesHeader."Call Off Number" := SalesReturnStaging."Call Off Number";
                    SalesHeader."Well Number" := SalesReturnStaging."Well Number";
                    SalesHeader."Rig Number" := SalesReturnStaging."Rig Number";
                    SalesHeader."Order Date" := SalesReturnStaging."Return Date";
                    SalesHeader."External Document No." := SalesReturnStaging."No.";
                    SalesHeader.Modify();

                    LineNo := 10000;
                    SalesLine.Reset();
                    if SalesReturnStaging."Quantity Good" <> 0 then begin
                        SalesLine.Init();
                        SalesLine."Document Type" := SalesLine."Document Type"::"Return Order";
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := LineNo;
                        Item.Reset();
                        Item.SetRange("TS Item No.", SalesReturnStaging."Item Numbers");
                        Item.FindFirst();
                        SalesLine.Type := SalesLine.Type::Item;
                        SalesLine.Validate("No.", Item."No.");
                        SalesLine.Validate("Location Code", InventorySetup.Good);
                        SalesLine.Validate(Quantity, SalesReturnStaging."Quantity Good");
                        SalesLine.Validate("Return Qty. to Receive", SalesReturnStaging."Quantity Good");
                        SalesLine.Validate("Qty. to Invoice", SalesReturnStaging."Quantity Good");
                        SalesLine.Insert();
                        if SalesReturnStaging."Lot No." <> '' then
                            PurchaseLine.CreateReservationEntry(SalesLine."No.", SalesLine."Location Code", SalesLine."Quantity (Base)", 37, 5, SalesLine.Description,
                                    SalesLine."Document No.", SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", SalesLine.Quantity, SalesReturnStaging."Lot No.", true, '', 2, 0D);
                        LineNo += 10000;
                    end;
                    SalesLine.Reset();
                    if SalesReturnStaging."Quantity Damaged" <> 0 then begin
                        SalesLine.Init();
                        SalesLine."Document Type" := SalesLine."Document Type"::"Return Order";
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := LineNo;
                        Item.Reset();
                        Item.SetRange("TS Item No.", SalesReturnStaging."Item Numbers");
                        Item.FindFirst();
                        SalesLine.Type := SalesLine.Type::Item;
                        SalesLine.Validate("No.", Item."No.");
                        SalesLine.Validate("Location Code", InventorySetup.Damaged);
                        SalesLine.Validate(Quantity, SalesReturnStaging."Quantity Damaged");
                        SalesLine.Validate("Return Qty. to Receive", SalesReturnStaging."Quantity Damaged");
                        SalesLine.Validate("Qty. to Invoice", SalesReturnStaging."Quantity Damaged");
                        SalesLine.Insert();
                        if SalesReturnStaging."Lot No." <> '' then
                            PurchaseLine.CreateReservationEntry(SalesLine."No.", SalesLine."Location Code", SalesLine."Quantity (Base)", 37, 5, SalesLine.Description,
                                    SalesLine."Document No.", SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", SalesLine.Quantity, SalesReturnStaging."Lot No.", true, '', 2, 0D);
                    end;

                    SalesReturnStaging."Integration Status" := SalesReturnStaging."Integration Status"::Processed;
                    SalesReturnStaging.Modify();
                end;
                Commit();
            until SalesReturnStaging.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
}