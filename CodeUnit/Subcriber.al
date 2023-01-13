// codeunit 50130 "Get Vendor Invoice no"
// {


//     var
//         MaterialRequestExt: Record "Purchases & Payables Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;



//     trigger OnInsert()
//     begin
//         InitInsert();
//         "Created Date" := Today; //auto fill date
//     end;

//     procedure InitInsert()
//     begin
//         if "No." = '' then begin
//             TestNoSeries;
//             // CheckFullyPaid;
//             NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", Today, "No.", "No. Series");
//         end;
//     end;

//     procedure TestNoSeries()
//     begin
//         MaterialRequestExtSetup();
//         MaterialRequestExt.TestField("Material Request Nos");


//     end;



//     procedure GetNoSeriesCode(): Code[20]
//     var
//         NoSeriesCode: Code[20];
//     begin
//         MaterialRequestExtSetup();
//         NoSeriesCode := MaterialRequestExt."Material Request Nos";
//         exit(NoSeriesCode);
//     end;

//     local procedure MaterialRequestExtSetup()
//     begin
//         MaterialRequestExt.Get();
//     end;




// }
