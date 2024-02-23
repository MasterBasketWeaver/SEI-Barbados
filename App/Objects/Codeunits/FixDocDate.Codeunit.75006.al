codeunit 75006 "BA Fix Doc. Date"
{
    Permissions = tabledata "Sales Invoice Header" = m;

    trigger OnRun()
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        NameBuffer: Record "Name/Value Buffer" temporary;
        SalesInvHeader: Record "Sales Invoice Header";
        IStream: InStream;
        OStream: OutStream;
        Window: Dialog;

        FromFile: Text;
        i: Integer;
    begin
        if not UploadIntoStream('', '', '', FromFile, IStream) or not ExcelBuffer.GetSheetsNameListFromStream(IStream, NameBuffer) or not NameBuffer.FindFirst() then
            exit;

        ExcelBuffer.OpenBookStream(IStream, NameBuffer.Value);
        ExcelBuffer.ReadSheet();

        ExcelBuffer.SetFilter("Row No.", '>%1', 1);
        ExcelBuffer.SetRange("Column No.", 1);
        if ExcelBuffer.FindSet() then
            repeat
                if SalesInvHeader.Get(ExcelBuffer."Cell Value as Text") then begin
                    SalesInvHeader."Document Date" := SalesInvHeader."Posting Date";
                    SalesInvHeader.Modify(false);
                    i += 1;
                end;
            until ExcelBuffer.Next() = 0;
        ExcelBuffer.CloseBook();

        if not Confirm(StrSubstNo('Updated: %1.', i)) then
            Error('');
    end;
}