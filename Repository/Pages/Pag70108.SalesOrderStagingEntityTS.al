page 70108 "Sales Order Staging Entity TS"
{
    Caption = 'SalesOrder Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Sales Order Staging TS";
    EntityName = 'salesOrders';
    EntitySetName = 'salesOrdersTS';
    ODataKeyFields = ID;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                    ApplicationArea = All;
                }
                field(CustomerPONo; Rec."Customer PO No.")
                {
                    Caption = 'Customer PO No.';
                    ApplicationArea = All;
                }
                field(OrderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                    ApplicationArea = All;
                }
                field(SalespersonCode; Rec."SalesPerson Code")
                {
                    Caption = 'Salesperson Code';
                    ApplicationArea = All;
                }
                field(LocationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = All;
                }
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                }
                field(ItemLotNo; Rec."Item Lot No.")
                {
                    Caption = 'Item Lot No.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                }
                field(UnitPriceExclVAT; Rec."Unit Price Excl. VAT")
                {
                    Caption = 'Unit Price Excl. VAT';
                    ApplicationArea = All;
                }
                field(LineAmountExclVAT; Rec."Line Amount Excl. VAT")
                {
                    Caption = 'Line Amount Excl. VAT';
                    ApplicationArea = All;
                }
                field(MaterialReqNo; Rec."Material Req No.")
                {
                    Caption = 'Material Req No.';
                    ApplicationArea = All;
                }
                field(CustomerItemCode; Rec."Customer Item Code")
                {
                    Caption = 'Customer Item Code';
                    ApplicationArea = All;
                }
                field(DeliveryDate; Rec."Delivery Date")
                {
                    Caption = 'Delivery Date';
                    ApplicationArea = All;
                }
                field(CustomerDimension; Rec."Customer Dimension")
                {
                    Caption = 'Customer Dimension';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        myInt: Integer;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Insert(true);
        exit(false);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.Delete(true);
    end;
}