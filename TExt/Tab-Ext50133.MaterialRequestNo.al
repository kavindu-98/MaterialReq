tableextension 50133 "Material Request No" extends "Purchase Header"
{
    fields
    {
        field(50100; "Material Req No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
    }


    procedure InsertCreatePurchaseOdrRec(MaterialReq: Record "Material Request Header"; VenderID: Code[10])
    var

        PurchaseOdrLine: Record "Purchase Line";
        MaterialReqline: Record "Material Request Line";

    begin
        // MaterialReq.Reset();
        // MaterialReq.SetRange("No.", MaterialReqNo);
        // MaterialReq.FindFirst();
        Rec.Init();
        Rec."Document Type" := Rec."Document Type"::Order;
        Rec."Material Req No" := MaterialReq."No.";
        Rec.Validate("Buy-from Vendor No.", VenderID);
        Rec.Insert(true);
        Rec.Invoice := true;
        Rec.Receive := true;
        GetVendorInvoiceNo();
        Rec."Vendor Invoice No." := VendorInvoiceNo;

        MaterialReq.Status := MaterialReq.Status::Processed;
        MaterialReq."Used for PO" := true;
        MaterialReq.Modify();

        //Rec.SetRange("Material Req No", MaterialReqNo);
        MaterialReqline.Reset();
        MaterialReqline.SetRange("Request Number", MaterialReq."No.");
        if MaterialReqline.FindFirst() then
            repeat
                PurchaseOdrLine.Init();
                PurchaseOdrLine."Document No." := Rec."No.";
                PurchaseOdrLine."Document Type" := Rec."Document Type";
                PurchaseOdrLine."Line No." := MaterialReqline."Line Number";
                PurchaseOdrLine.Validate(Type, PurchaseOdrLine.Type::Item);
                PurchaseOdrLine.Validate("No.", MaterialReqLine."Part Number");
                PurchaseOdrLine.Validate(Quantity, MaterialReqLine.Quantity);
                PurchaseOdrLine.Validate("Location Code", MaterialReqLine."Location Code");

                PurchaseOdrLine.Insert(true);
            until MaterialReqline.Next() = 0;


        // Message('Purchase Order Successfully Created');

        if Rec.SendToPosting(90) then
            Message('Purchase Order Successfully Posted');

    end;

    var
        VendorPurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VendorInvoiceNo: Code[20];

    procedure GetVendorInvoiceNo(): Code[20]
    var
        NoSeriesCode: Code[20];
        NoSeriesDate: Date;
    begin
        VendorInvPurchaseSetup();
        VendorPurchaseSetup.TestField("Vendor Invoice Nos");
        NoSeriesCode := VendorPurchaseSetup."Vendor Invoice Nos";
        VendorInvoiceNo := NoSeriesMgt.GetNextNo(NoSeriesCode, Today, true);
        exit(VendorInvoiceNo);
    end;

    local procedure VendorInvPurchaseSetup()
    begin
        VendorPurchaseSetup.Get();
    end;




}
