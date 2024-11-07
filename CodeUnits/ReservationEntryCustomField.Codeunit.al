codeunit 51015 "ReservationEntryCustomField"
{
    // OnAfterModifyEvent for Reservation Entry
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterModifyEvent', '', true, true)] // Passer en OnAfterValidate si erreur
    local procedure OnAfterModifyReservationEntry(var Rec: Record "Reservation Entry"; xRec: Record "Reservation Entry"; RunTrigger: Boolean)
    var
        LigneVente: Record "Sales Line";
        EcrReserv: Record "Reservation Entry";
        MaxDate: Date;
    begin
        if Rec."Expected Receipt Date" <> xRec."Expected Receipt Date" then begin
            // RESERVATION PC 05/04/06 NSC4.00 Modification MAJ des lignes ventes associées à la réservation
            MaxDate := 0D;
            LigneVente.RESET();

            if (Rec."Source Type" = 37) then begin
                LigneVente.SETRANGE("Document Type", Rec."Source Subtype");
                LigneVente.SETRANGE("Document No.", Rec."Source ID");
                LigneVente.SETRANGE("Line No.", Rec."Source Ref. No.");

                if LigneVente.FIND() then begin
                    Rec.MODIFY();
                    COMMIT();
                    EcrReserv.RESET();
                    EcrReserv.SETCURRENTKEY("Reservation Status", "Source Type", "Source Subtype", "Source ID", "Source Ref. No.");
                    EcrReserv.SETRANGE("Reservation Status", EcrReserv."Reservation Status"::Reservation);
                    EcrReserv.SETRANGE("Source Type", Rec."Source Type");
                    EcrReserv.SETRANGE("Source Subtype", Rec."Source Subtype");
                    EcrReserv.SETRANGE("Source ID", Rec."Source ID");
                    EcrReserv.SETRANGE("Source Ref. No.", Rec."Source Ref. No.");
                    LigneVente.CALCFIELDS("Reserved Qty. (Base)");

                    if EcrReserv.FIND('-') and (LigneVente."Outstanding Qty. (Base)" = LigneVente."Reserved Qty. (Base)") then begin
                        repeat
                            if EcrReserv."Expected Receipt Date" > MaxDate then
                                MaxDate := EcrReserv."Expected Receipt Date";
                        until EcrReserv.NEXT() = 0;

                        LigneVente."Ancienne Date d'expédition" := LigneVente."Shipment Date";
                        LigneVente."Date d'expédition retardée" := true;
                        LigneVente."Shipment Date" := MaxDate;
                        LigneVente.MODIFY();
                    end;
                end;
            end;
            // Fin RESERVATION PC 05/04/06 NSC4.00 Modification MAJ des lignes ventes associées à la réservation
        end;
    end;
}
