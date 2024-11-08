pageextension 51016 "SalesOrderListPageExt" extends "Sales Order List"
{
    // Modifie la présentation de la page "Sales Order List" afin d'ajouter nos champs et cacher les champs non utiles.
    layout
    {
        addbefore("No.")
        {
            // Add changes to page content here
            field("Bloqué"; Rec."Bloqué")
            {
                ApplicationArea = All;
                Caption = 'Bloqué';
                ToolTip = 'Indique si la commande est bloquée';
            }
        }
        moveafter("Sell-to Customer No."; "Ship-to Code")
        modify("Ship-to Code")
        {
            ApplicationArea = All;
            Visible = true;
            Editable = false;
            Caption = 'Code destinataire';
        }
        addafter("Ship-to Code")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                Caption = 'Date commande';
                ToolTip = 'Date de la commande';
                Visible = true;
                Editable = false;
            }
        }
        moveafter("Order Date"; "Shipment Date")
        modify("Shipment Date")
        {
            Visible = true;
            Caption = 'Date de préparation';
        }
        addafter("Sell-to Customer Name")
        {
            field("Validée"; Rec."Validée")
            {
                ApplicationArea = All;
                Caption = 'Validée';
                ToolTip = 'Indique si la commande est validée';
                Visible = true;
                Editable = false;
            }
            field(Reliquat; Rec.Reliquat)
            {
                ApplicationArea = All;
                Caption = 'Reliquat';
                ToolTip = 'Reliquat de la commande';
                Visible = true;
                Editable = false;
            }
            field("Total Outstanding Quantity"; Rec."Total Outstanding Quantity")
            {
                ApplicationArea = All;
                Caption = 'Quantité ouverte totale';
                ToolTip = 'Quantité ouverte totale';
                Visible = true;
                Editable = false;
            }
        }
        moveafter("Total Outstanding Quantity"; "Amount Including VAT")
        addafter("Amount Including VAT")
        {
            field("Préparation"; Rec."Préparation")
            {
                ApplicationArea = All;
                Caption = 'Préparation';
                ToolTip = 'Préparation de la commande';
                Visible = true;
                Editable = true;
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = All;
                Caption = 'Utilisateur';
                ToolTip = 'Utilisateur de l''enregistrement';
                Visible = false;
                Editable = false;
                Enabled = true;
            }
            field(Origine; Rec.Origine)
            {
                ApplicationArea = All;
                Caption = 'Origine';
                ToolTip = 'Code d''origine';
                Visible = false;
                Editable = false;
                Enabled = true;
            }
            field("BP édité"; Rec."BP édité")
            {
                ApplicationArea = All;
                Caption = 'BP édité';
                ToolTip = 'Bon de préparation édité';
                Visible = false;
                Editable = false;
                Enabled = true;
            }
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Completely Shipped")
        {
            Visible = false;
        }
        modify("Amt. Ship. Not Inv. (LCY)")
        {
            Visible = false;
        }
        modify("Amt. Ship. Not Inv. (LCY) Base")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }


    }

    actions
    {
        // Add changes to page actions here
    }
}