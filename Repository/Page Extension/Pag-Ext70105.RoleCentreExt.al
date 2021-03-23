pageextension 70105 "Role Center Ext" extends "Business Manager Role Center"
{

    actions
    {
        addafter(SetupAndExtensions)
        {
            group(TubeStream)
            {
                Caption = 'Tubestream';
                Image = List;
                ToolTip = 'TubeStream Screens.';
                action(CustomerStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Staging List';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Staging List TS";
                }
                action(ItemStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Item Staging List';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Staging List TS";
                }
                action(LocationStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Location Staging List';
                    Image = ItemAvailbyLoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Locations Staging List TS";
                }
                action(PurchaseReceiptStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Receipt Staging List';
                    Image = Purchase;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Rcpts Staging List TS";
                }
                action(SalesOrderStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Staging List';
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order Staging List TS";
                }
                action(SalesShipmentStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Shipment Staging List';
                    Image = SalesShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Ship Staging List TS";
                }
                action(TransferOrderStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Order Staging List';
                    Image = TransferOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Trans. Order Staging List TS";
                }
                action(ProductionIssueRcptStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Production Issue&Receipt Staging List';
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Prod. Issue & Rcpt List TS";
                }
                action(InventoryAdjustmentStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Adjustment Staging List';
                    Image = Inventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inventory Adjust. List TS";
                }
                action(TSSetup)
                {
                    ApplicationArea = All;
                    Caption = 'TubeStream Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "TS Setup";
                }
                action(TestTubeStreamAPI)
                {
                    ApplicationArea = All;
                    Caption = 'Test TubeStream API''s';
                    Image = TestFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Test API Staging TS";
                }
                action(VendorContractorStaging)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Contractor Staging List';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Contractor Staging TS";
                }
                action(PurchaseOrderStagingList)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order Staging List';
                    Image = Purchase;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Order Staging TS";
                }
                action(SalesInvoiceStagingList)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice Staging List';
                    Image = SalesInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Invoice Staging TS";
                }
                action(InvoiceClosureStagingList)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Closure Staging List';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Invoice Closure Staging TS";
                }
                action(MillMasterList)
                {
                    ApplicationArea = All;
                    Caption = 'Mill Master List';
                    Image = MachineCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Mill Master List";
                }
                action(QuoteComparision)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Quote Comparision';
                    Image = CompareCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Quote Comparision TS";
                }
                action(MillMasterStagingList)
                {
                    ApplicationArea = All;
                    Caption = 'Mill Master Staging List';
                    Image = MachineCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Mill Master Staging List TS";
                }
                action(SalesReturnOrderList)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Return Order Staging List';
                    Image = MachineCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "SR Order Staging List TS";
                }
            }
        }
    }

    var
        myInt: Integer;
}