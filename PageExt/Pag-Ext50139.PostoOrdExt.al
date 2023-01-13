pageextension 50139 PostoOrdExt extends "Posted Purchase Invoice"
{


    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Material Req No"; Rec."Material Req No")
            {
                ApplicationArea = all;
                // ShowMandatory = true;
                Editable = false;
            }
        }


    }
}
