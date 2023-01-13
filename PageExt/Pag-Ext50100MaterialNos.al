pageextension 50142 "Material Request Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {

            field("Material Request Nos"; Rec."Material Request Nos")
            {
                ApplicationArea = all;
            }
            field("Vendor Invoice Nos"; Rec."Vendor Invoice Nos")
            {
                ApplicationArea = all;
            }


        }
    }


}
