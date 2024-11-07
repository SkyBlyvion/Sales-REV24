
tableextension 51006 "SalesLineTableExt" extends "Sales Line"
{
    fields
    {
        field(50000; Bloqué; Boolean)
        {
            Caption = 'Bloqué';
            ToolTip = 'Indique si la ligne est bloquée';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = false;
            BlankNumbers = DontBlank;

            trigger OnValidate()
            begin
                //BLOCAGE PC 01/10/99 NSC1.11 Gestion du blocage et du déblocage
                IF Bloqué = FALSE THEN BEGIN
                    EnTeteVente4.GET("Document Type", "Document No.");
                    EnTeteVente4.DeblocageEntete("Line No.");
                END;
                //BLOCAGE PC 01/10/99 NSC1.11 Gestion du blocage et du déblocage
            end;
        }
        field(50001; Promotion; Boolean)
        {
            Caption = 'Promotion';
            ToolTip = 'Indique si la ligne est une promotion';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50002; Déprécié; Boolean)
        {
            Caption = 'Déprécié';
            ToolTip = 'Indique si la ligne est dépréciée';
            Description = 'LIGNE_VENTE 06/11/24 LN REV24';
            Editable = true;
        }
        field(50003; "Prix Net (Pièce)"; Decimal)
        {
            Caption = 'Prix Net (Pièce)';
            ToolTip = 'Prix net par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50004; Origine; Code[20])
        {
            Caption = 'Origine';
            ToolTip = 'Code d''origine';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50005; "Prix Unitaire Remisé (Pièce)"; Decimal)
        {
            Caption = 'Prix Unitaire Remisé (Pièce)';
            ToolTip = 'Prix unitaire remisé par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50006; "% Commission"; Decimal)
        {
            Caption = '% Commission';
            ToolTip = 'Commission en pourcentage';
            Description = 'COMMISSION LN 06/11/24 REV24';
            Editable = true;
        }
        field(50007; "Date de livraison Client"; Date)
        {
            Caption = 'Date de livraison Client';
            ToolTip = 'Date de livraison client';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50008; "No. commande PalmWare"; Code[14])
        {
            Caption = 'No. commande PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50009; "Quantité/Conditionnement"; Integer)
        {
            Caption = 'Quantité/Conditionnement';
            ToolTip = 'Quantité par conditionnement';
            Description = 'QUANTITE_CONDITIONNEMENT LN 06/11/24 REV24';
            Editable = true;
        }
        field(50013; "Prix Unitaire (Pièce)"; Decimal)
        {
            Caption = 'Prix Unitaire (Pièce)';
            ToolTip = 'Prix unitaire par pièce';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50014; "Volume (unitaire)"; Decimal)
        {
            Caption = 'Volume (unitaire)';
            ToolTip = 'Volume unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50015; Volume; Decimal)
        {
            Caption = 'Volume';
            ToolTip = 'Volume total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50016; "Poids (unitaire)"; Decimal)
        {
            Caption = 'Poids (unitaire)';
            ToolTip = 'Poids unitaire';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50017; Poids; Decimal)
        {
            Caption = 'Poids';
            ToolTip = 'Poids total';
            Description = 'VOLUME_POIDS LN 06/11/24 REV24';
            Editable = true;
        }
        field(50018; "% remise REVIMPORT"; Decimal)
        {
            Caption = '% remise REVIMPORT';
            ToolTip = 'Pourcentage de remise REVIMPORT';
            Description = 'REMISE_REVIMPORT LN 06/11/24 REV24';
            Editable = true;
        }
        field(50019; "Stock physique (qté)"; Decimal)
        {
            Caption = 'Stock physique (qté)';
            ToolTip = 'Stock physique en quantité';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50020; Renouvelable; Boolean)
        {
            Caption = 'Renouvelable';
            ToolTip = 'Indique si renouvelable';
            Description = 'RENOUVELABLE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50021; "Nbre de colis"; Decimal)
        {
            Caption = 'Nbre de colis';
            ToolTip = 'Nombre de colis';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50022; "Ancienne Date d'expédition"; Date)
        {
            Caption = 'Ancienne Date d''expédition';
            ToolTip = 'Ancienne date d''expédition';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50023; "Date d'expédition retardée"; Boolean)
        {
            Caption = 'Date d''expédition retardée';
            ToolTip = 'Indique si la date d''expédition est retardée';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50024; SélectionReRéservationT; Boolean)
        {
            Caption = 'SélectionReRéservationT';
            ToolTip = 'Sélection pour la ré-réservation T';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50025; SélectionReRéservationU; Boolean)
        {
            Caption = 'SélectionReRéservationU';
            ToolTip = 'Sélection pour la ré-réservation U';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50026; NouveauNLigne; Integer)
        {
            Caption = 'NouveauNLigne';
            ToolTip = 'Nouveau numéro de ligne';
            Description = 'LIGNE_VENTE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50027; "Prix négocié"; Boolean)
        {
            Caption = 'Prix négocié';
            ToolTip = 'Indique si le prix est négocié';
            Description = 'BLOCAGE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50038; "No. Cde PalmWare"; Text[14])
        {
            Caption = 'No. Cde PalmWare';
            ToolTip = 'Numéro de commande PalmWare';
            Description = 'PALMWARE LN 06/11/24 REV24';
            Editable = true;
        }
        field(50043; "No. client Revimex"; Code[20])
        {
            Caption = 'No. client Revimex';
            ToolTip = 'Numéro de client Revimex';
            Description = 'REVIMEX LN 06/11/24 REV24';
            Editable = true;
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        PrixUnitaire: Decimal;
        ComRepresentant: Record "Commission représentant";
        Client: Record Customer;
        ParamStock: Record "Inventory Setup";
        LigVente3: Record "Sales Line";
        CondProduit: Record "Item Variant";
        EcrituresReservations: Record "Reservation Entry";
        entier: Integer;
        EnTeteVente4: Record "Sales Header";
        DateTemp: Date;
        EnTeteVente2: Record "Sales Header";
        EcrReserv2: Record "Reservation Entry";
        EcrReserv3: Record "Reservation Entry";
        entier2: Integer;
        ArticleRemplacement: Record "Récépissé transport";
        MajPUOk: Boolean;
        UpPriceForCopyDoc: Boolean;

        TextLIGNE_VENTE01: Label 'Une réservation est en train d''être effectuée pour cet article\', Comment = 'FRF';
        TextLIGNE_VENTE02: Label 'Veuillez ressaisir la quantité ultérieurement pour mettre à ', Comment = 'FRF';
        TextLIGNE_VENTE03: Label ' jour', Comment = 'FRF';
        TextLIGNE_VENTE04: Label 'ESP', Comment = 'ESP';
        TextLIGNE_VENTE05: Label 'AM', Comment = 'AM';
        TextLIGNE_VENTE06: Label 'MCR', Comment = 'MCR';
        TextLIGNE_VENTE07: Label 'CC', Comment = 'CC';
        TextLIGNE_VENTE08: Label 'Le prix unitaire de l''article %1 est inférieur au prix net remisé ou au TG qui est de %2.', Comment = 'FRF';
        TextLIGNE_VENTE09: Label 'Le prix unitaire de l''article %1 est supérieur au prix TG qui est de %2 ', Comment = 'FRF';
        TextLIGNE_VENTE10: Label 'Le prix unitaire de l''article %1 est inférieur au prix net qui est de %2.', Comment = 'FRF';
        TextLIGNE_VENTE11: Label 'Le document n° %1 n''existe pas. La réservation dans les ventes ne pas pas être effectuée', Comment = 'FRF';
        TextLIGNE_VENTE12: Label 'Une réservation a été générée pour la commande de vente %1, article n° %2', Comment = 'FRF';
        TextLIGNE_VENTE13: Label 'Il n''y a pas assez de quantité en stock\', Comment = 'FRF';
        TextLIGNE_VENTE14: Label 'pour pouvoir livrer voulez vous modifier les réservations', Comment = 'FRF';
        TextLIGNE_VENTE15: Label 'PR', Comment = 'PR';
        TextLIGNE_VENTE16: Label 'ARCASOFT', Comment = 'ARCASOFT';
        TextLIGNE_VENTE17: Label 'HD', Comment = 'HD';



}
