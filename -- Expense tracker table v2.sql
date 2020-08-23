-- Expense tracker table

CREATE TABLE expType(
exp_id serial primary key,
Category varchar(25) not null,
Description varchar(50)
);

CREATE TABLE location (
loc_id serial primary key,
description varchar(20),
DomOrInt varchar(20) 
);

CREATE TABLE Ven (
ven_id serial primary key,
ven_name varchar(20) NOT NULL
);

CREATE TABLE Expenses (
Month char(4) NOT NULL,
TypeExpense integer NOT NULL,
ExGstAmount decimal(4,2) NOT NULL,
GST decimal (4,2),
Vendor integer NOT NULL,
Place integer NOT NULL,
FOREIGN KEY (TypeExpense) references expType (exp_id),
FOREIGN KEY (Place) references location(loc_id),
FOREIGN KEY (Vendor) references Ven(ven_id)
);

create type ExpenseSummary as (
	period char(4), -- e.g. 0120 equiv to Jan 2020
	type   char(20),     
	vendor char(20),
	amount numeric,
        GST numeric
);

CREATE OR REPLACE FUNCTION Summary(p char)
 RETURNS SETOF ExpenseSummary
 LANGUAGE plpgsql
AS $function$
declare
        rec ExpenseSummary;
        ExpTotal numeric := 0;
        GSTa numeric := 0;
        GrndTotal numeric := 0;
        Total ExpenseSummary;
        sum ExpenseSummary;
        E_line ExpenseSummary;
        addAmt numeric;
        addGst numeric;


begin
        select e.month into p
        FROM Expenses as e
        where e.month = p;

        if (not found) then
                raise EXCEPTION 'No such period';
        end if;
        for rec in
                select e.month, et.Category, v.ven_name, e.ExGstAmount, e.GST 
                        FROM Expenses e
                        join expType et on (et.exp_id = e.TypeExpense)
                        join ven v on (v.ven_id = e.vendor)
                where  e.month = p
        loop

                
                ExpTotal := ExpTotal + ROUND(rec.amount,2);
                GSTa := GSTa + ROUND(rec.GST,2);
                addAmt := sum(ExpTotal);
                addGst := sum(GSTa);
                GrndTotal := ExpTotal + GSTa;
                return next rec;
        end loop;

        if (ExpTotal = 0) then
                rec := (null,null,null,'No Expense',null, null);
        else
                
                rec := (rec.period,rec.type,rec.vendor, ExpTotal, GSTa);
                sum := (null, null, 'Total Amount', addAmt, addGst);
                E_line := (null, null, null, null, null);
                Total := (null, null, 'Grand Total GST Incl', null, GrndTotal);
        end if;

        return next E_line;
        return next sum;
        return next Total;
        return;
end;
$function$;

