pageextension 50137 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{

    layout
    {
        addafter("Order No.")
        {
            field("Material Req No"; Rec."Material Req No")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = false;
                ToolTip = 'Specifies the value of Material Request No';
            }
        }


    }
}
