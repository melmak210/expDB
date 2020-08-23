INSERT INTO expType (Category, Description)
VALUES ('Grnd Transport', 'Expenses related to transport that exludes flight'), 
('Grocery', 'Basic essentials excluding entertainment'), ('entertainment', 'Includes Eatout, leisure expenses'), ('Phone', NULL), ('Internet', NULL), ('Apparel', 'clothing items'), ('Insurance', NULL), ('Tax', 'Tax related'), ('Utilities', 'Water, council rates or electricty');

INSERT INTO location (Description, DomOrInt)
VALUES ('Sydney', 'Dom'), ('Melbourne', 'Dom');

INSERT INTO Ven (ven_name)
VALUES ('Woolworths'), ('Coles'), ('Target'), ('Bunnings'), ('Iconic'), ('ForeverNew'), ('NRMA'), ('Service NSW'), ('Aust Tax Office'), ('Caltex'), ('Parra Council'), ('Energy Aust'), ('Sydney Water'), ('Telstra');

INSERT INTO expenses (month, typeexpense, exgstamount, gst, vendor, place)
VALUES ('0820', 6, 35.50,3.55, 5, 1), ('0820', 2, 50,5, 1, 1), ('0820', 2, 20.10,2.01, 1, 2), ('0920', 2, 50,5, 1, 1), ('1020', 2, 50,5, 1, 1);