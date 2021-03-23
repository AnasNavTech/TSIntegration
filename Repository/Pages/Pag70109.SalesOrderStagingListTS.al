page 70109 "Sales Order Staging List TS"
{
    Caption = 'Sales Order Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Sales Order Staging TS";
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
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

                field("Entry Date and Time"; Rec."Entry Date and Time")
                {
                    Caption = 'Entry Date and Time';
                    ApplicationArea = All;
                }
                field("Processing Date and Time"; Rec."Processing Date and Time")
                {
                    Caption = 'Processing Date and Time';
                    ApplicationArea = All;
                }
                field("Integration Status"; Rec."Integration Status")
                {
                    Caption = 'Integration Status';
                    ApplicationArea = All;
                }
                field("Retry Count"; Rec."Retry Count")
                {
                    Caption = 'Retry Count';
                    ApplicationArea = All;
                }
                field("Processing Remarks"; Rec."Processing Remarks")
                {
                    Caption = 'Processing Remarks';
                    ApplicationArea = All;
                }
                field("Error Remarks"; Rec."Error Remarks")
                {
                    Caption = 'Error Remarks';
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Sales Order")
            {
                Caption = 'Create Sales Order';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertSalesOrder();
                end;
            }
        }
    }
}