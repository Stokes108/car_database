create table supplier(
	supplier_id SERIAL primary key,
	supplier_name VARCHAR(100),
	supplier_phone VARCHAR(15),
	supplier_address VARCHAR(150)
);

create table part(
	part_id SERIAL primary key,
	part_name VARCHAR(150),
	part_price numeric(4,2)
);


create table part_supplier(
	part_supplier_id SERIAL primary key,
	part_id INTEGER not null,
	supplier_id INTEGER not null,
	foreign key (part_id) references part(part_id),
	foreign key (supplier_id) references supplier(supplier_id)
);

create table total_parts(
	total_parts_id SERIAL primary key,
	part_id_1 INTEGER not null,
	part_id_2 INTEGER default null,
	part_id_3 INTEGER default null,
	part_id_4 INTEGER default null,
	part_id_5 INTEGER default null,
	part_id_6 INTEGER default null,
	part_id_7 INTEGER default null,
	
	foreign key (part_id_1) references part(part_id),
	foreign key (part_id_2) references part(part_id),
	foreign key (part_id_3) references part(part_id),
	foreign key (part_id_4) references part(part_id),
	foreign key (part_id_5) references part(part_id),
	foreign key (part_id_6) references part(part_id),
	foreign key (part_id_7) references part(part_id)
);



create table salesperson(
	salesperson_id SERIAL primary key, 
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(150),
	address VARCHAR(150),
	contact_num VARCHAR(15)
);

create table customer(
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(150),
	contact_num VARCHAR(15),
	email VARCHAR(150),
	billing_info VARCHAR(150)
);

create table car(
	car_id SERIAL primary key,
	serial_num INTEGER not null,
	make VARCHAR(50),
	model VARCHAR(50),
	used INTEGER default 0,
	sold_here INTEGER default 0,
	customer_id INTEGER not null,
	foreign key (customer_id) references customer(customer_id)
);	

create table invoice(
	invoice_id SERIAL primary key,
	salesperson_id INTEGER not null,
	car_id INTEGER not null,
	customer_id INTEGER not null,
	price numeric(7,2),
	foreign key (salesperson_id) references salesperson(salesperson_id),
	foreign key (car_id) references car(car_id),
	foreign key (customer_id) references customer(customer_id)
);


create table mechanic(
	mechanic_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(150),
	contact_num VARCHAR(15)
);

create table service_ticket(
	service_id SERIAL primary key,
	service_date DATE default current_date,
	total numeric(5,2),
	car_id INTEGER not null,
	total_part_id INTEGER default null,
	foreign key (car_id) references car(car_id),
	foreign key (total_part_id) references total_parts(total_parts_id)
);

create table car_mechanic(
	car_mechanic_id SERIAL primary key,
	mechanic_id INTEGER not null,
	service_id INTEGER not null
);


