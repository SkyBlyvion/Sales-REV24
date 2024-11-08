pageextension 51017 "SalesOrderDocPageExt" extends "Sales Order"
{
    layout
    {
        moveafter("Sell-to Contact"; "Location Code")
        moveafter("Location Code"; "Your Reference")
        moveafter("Your Reference"; Status)
        addafter(Status)
        {
            field("Préparation"; Rec."Préparation")
            {
                ApplicationArea = All;
                Caption = 'Préparation';
                ToolTip = 'Préparation de la commande';
                Visible = true;
                Editable = true;
            }
        }
        moveafter("Préparation"; "Posting Date")
        moveafter("Posting Date"; "Order Date")
        moveafter("Order Date"; "Document Date")
        moveafter("Document Date"; "Shipment Date")
        addafter("Salesperson Code")
        {
            field(Origine; Rec.Origine)
            {
                ApplicationArea = All;
                Caption = 'Origine';
                ToolTip = 'Code d''origine';
                Visible = true;
                Editable = true;
            }
            field("No. Cde PalmWare"; Rec."No. Cde PalmWare")
            {
                ApplicationArea = All;
                Caption = 'No. Cde PalmWare';
                ToolTip = 'Numéro de commande PalmWare';
                Visible = true;
                Editable = true;
            }
            grid(MyGrid)
            {
                field("Bloqué"; Rec."Bloqué")
                {
                    ApplicationArea = All;
                    Caption = 'Bloqué';
                    ToolTip = 'Indique si la commande est bloquée';
                    Visible = true;
                    Editable = true;
                }
                field("AR édité"; Rec."AR édité")
                {
                    ApplicationArea = All;
                    Caption = 'AR édité';
                    ToolTip = 'Accusé de réception édité';
                    Visible = true;
                    Editable = false;
                }
            }
            grid(MyGrid2)
            {
                field("BP édité"; Rec."BP édité")
                {
                    ApplicationArea = All;
                    Caption = 'BP édité';
                    ToolTip = 'Bon de préparation édité';
                    Visible = true;
                    Editable = false;
                }
                field("Cde triée"; Rec."Cde triée")
                {
                    ApplicationArea = All;
                    Caption = 'Cde triée';
                    ToolTip = 'Commande triée';
                    Visible = true;
                    Editable = false;
                }
            }
            grid(MyGrid3)
            {
                field(Reliquat; Rec.Reliquat)
                {
                    ApplicationArea = All;
                    Caption = 'Reliquat';
                    ToolTip = 'Reliquat de la commande';
                    Visible = true;
                    Editable = false;
                }
                field(Proforma; Rec.Proforma)
                {
                    ApplicationArea = All;
                    Caption = 'Proforma';
                    ToolTip = 'Indicateur de commande Proforma';
                    Visible = true;
                    Editable = true;
                }

            }
            field("Validée"; Rec."Validée")
            {
                ApplicationArea = All;
                Caption = 'Validée';
                ToolTip = 'Indique si la commande est validée';
                Visible = true;
                Editable = true;
            }
            field("Obs validée"; Rec."Obs validée")
            {
                ApplicationArea = All;
                Caption = 'Obs validée';
                ToolTip = 'Observation validée';
                Visible = true;
                Editable = true;
            }
        }
        //TODO: Détails Facture et Expedition - Facturation
        // Les adresses et facturation sont sur OptionsMembers (Destinatiare & Facturation ) Now instead of rewrite entire list.
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}