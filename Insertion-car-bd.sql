
--create function to add customers
create or replace function add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _address VARCHAR, _contact_num VARCHAR, _email VARCHAR, _billing_info VARCHAR)
returns void 
as $MAIN$
begin 
	insert into customer(customer_id, first_name, last_name, address, contact_num, email, billing_info)
	values (_customer_id, _first_name, _last_name, _address, _contact_num, _email, _billing_info);
end;

$MAIN$
language plpgsql;


select add_customer(1, 'Kevin', 'Hart', '52 Main St', '444-444-4444', 'khart@gmail.com', '5342-4233-3423-2433 432 82432');
select add_customer(2, 'Bobby', 'Flay', '434 E Callie Ave', '534-532-5342', 'bflay@gmail.com', '4234-2453-2425-3532 432 54231'  );

insert into customer(customer_id, first_name, last_name, address)
values (3, 'Regina', 'Williams', '108 Magical Ave');

select * from customer;


insert into salesperson(salesperson_id, first_name, last_name, email, contact_num, address)
values (1, 'Brad', 'Thomas', 'btommy@email.com', '533-245-2455', '43 W Main St'),
(2, 'Timmy', 'Tony', 'ttony@emails.com', '433-435-2422', '452 E MLK Blvd.');

insert into supplier(supplier_id, supplier_name, supplier_phone, supplier_address)
values(1, 'Iron Work LLC', '423-532-2453', '432 W Main St Loisville KY 53424'),
(2, 'Super Car LLC', '848-3523-5356', '535 E George Ave');

alter table part drop part_price;
alter table part_supplier add part_price numeric(5,2) not null;


create or replace function add_part(_part_id INTEGER, _part_name VARCHAR)
returns void 
as $MAIN$
begin 
	insert into part(part_id, part_name)
	values (_part_id, _part_name);
end;

$MAIN$
language plpgsql;

select add_part(1, 'Boiler plate');
select add_part(2, 'exhaust tube');
select add_part(3, 'carberator cap');
select add_part(4, 'muffler tip');



create or replace function add_part_supplier(_part_supplier_id INTEGER, _part_id INTEGER, _supplier_id INTEGER, _part_price numeric(5,2))
returns void 
as $MAIN$
begin 
	insert into part_supplier(part_supplier_id, part_id, supplier_id, part_price)
	values (_part_supplier_id, _part_id, _supplier_id, _part_price);
end;

$MAIN$
language plpgsql;


select add_part_supplier(1, 1, 1, 5.99);
select add_part_supplier(2, 1, 2, 6.99);
select add_part_supplier(3, 2, 1, 10.99);
select add_part_supplier(4, 3, 1, 45.99);
select add_part_supplier(5, 3, 2, 50.99);
select add_part_supplier(6, 4, 2, 100.99);

select * from part_supplier 
full join part on part_supplier.part_id = part.part_id
full join supplier on supplier.supplier_id = part_supplier.supplier_id
where part.part_id = 3;

insert into total_parts(total_parts_id, part_id_1, part_id_2, part_id_3, part_id_4)
values(1, 2, null, null, null),(2,2, 4,3,1), (3,4,2, null, null), (4, 1, 4, null, null), (5, 1,2,3,4);

-- tried to put a default statment into insert statment doesn't work
insert into total_parts(total_parts_id, part_id_1, part_id_2 default null, part_id_3 default null, part_id_4 default null)
values (6, 1, 3), (7, 3, 4,2);


select * from total_parts;



insert into mechanic(mechanic_id, first_name, last_name, contact_num, address)
values(1, 'Butch', 'Cassidy', '666-666-2324', '432 W Utah Ave'),
(2, 'Tony', 'Two-tails', '542-242-4254', '943 E Oregeon Blvd');

alter table car add column _year integer;


create or replace function add_car(_car_id INTEGER, _make VARCHAR, _model VARCHAR, _year_ integer, _serial_num INTEGER,_customer_id INTEGER, _used INTEGER default 0, _sold_here INTEGER default 0)
returns void 
as $MAIN$
begin 
	insert into car(car_id, make, model, _year, serial_num, customer_id, used, sold_here)
	values (_car_id, _make, _model, _year_, _serial_num, _customer_id, _used, _sold_here);
end;

$MAIN$
language plpgsql;




select add_car(1, 'Honda', 'Accord', 1998, 435564346 , 1, 1, 1);
select add_car(2, 'Ferrari', 'FastXL', 2012, 245642465, 1);

select add_car(3, 'Honda', 'Fit', 2016, 35556434, 1, 1);

select add_car(4, 'Toyota', 'Prius', 2022, 534645467, 2, 0, 1);
select add_car(5, 'Ford', 'F-150',2009,  534364623 , 2, 1, 0);
select add_car(6, 'Honda', 'Accord',2018, 424665464, 2, 0, 1);

select * from car;

-- need to do more research to restrict data entry into the invoice table. A car should only be inputed if it is sold here
--ie) if it has a 1 on sold here. It should also only have the customer_id of the person who has bought the car 
-- a solution to this would be to drop the customer_id from the table and then to access the customer_id through the car_id 
-- another work around is to drop the sold_here data from table and to just access the sold cars with invoice table 
-- both sold and worked on cars would be in the invoice table


insert into invoice(invoice_id, car_id, customer_id, salesperson_id, price)
values(1, 1, 1, 1, 23403.99), (2,4, 2, 2, 4234.99), (3,6,2,1, 98299.09);

-- trying to do after data is inserted into table
alter table invoice drop customer_id;
alter table car drop sold_here;


--testing to see if I can alter a function. other option is to drop it and write it again  - doesn't work 
alter function add_car modify _sold_here;

drop function add_car;


create or replace function add_car(_car_id INTEGER, _make VARCHAR, _model VARCHAR, _year_ integer, _serial_num INTEGER,_customer_id INTEGER, _used INTEGER default 0)
returns void 
as $MAIN$
begin 
	insert into car(car_id, make, model, _year, serial_num, customer_id, used)
	values (_car_id, _make, _model, _year_, _serial_num, _customer_id, _used);
end;

$MAIN$
language plpgsql;

select add_car(7, 'Honda', 'Accord',2018, 424665464, 2, 0);

select * from car;

--may be able to modify function- error calling it again once I dropped the column sold_here

insert into service_ticket(service_id, total, car_id, total_part_id)
values(1, 400.99, 1, 2), (2, 542.99, 2, null), (3, 150.99, 5, null), (4, 109.99, 3, 2);

insert into car_mechanic(car_mechanic_id, service_id, mechanic_id)
values (1, 1, 1), (2, 1, 2), (3, 2, 2), (4, 3, 1), (5, 3, 2), (6, 4, 1);

select * from car_mechanic
full join service_ticket on service_ticket.service_id = car_mechanic.service_id
full join mechanic on mechanic.mechanic_id = car_mechanic.mechanic_id;



select * from mechanic m
select * from car c 
select * from customer c2 
select * from salesperson s 
select * from part p 
select * from part_supplier ps 
select * from supplier s2 
select * from total_parts tp 
select * from invoice i 

select invoice.price , customer.first_name, customer.last_name, car.used 
from invoice 
inner join car 
on car.car_id = invoice.car_id
inner join customer 
on customer.customer_id = car.customer_id;
