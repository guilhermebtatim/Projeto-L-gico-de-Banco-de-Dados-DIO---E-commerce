-- criação do banco de dados para o cenário de E-commerce

drop database ecommerce;

show databases;
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key not null,
    Fname varchar(15),
    Minit varchar(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(255),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;

-- criar tabela produto

create table product(
	idProduct int auto_increment primary key not null,
    Pname varchar(255) not null,
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Rating float default 0,
    Price float not null
);
alter table product auto_increment=1;

-- criar tabela Formas de pagamento

create table payments(
	idPaymentClient int not null,
    idPayment int not null unique auto_increment,
    CardNumber varchar(20) not null,
    CardAgency varchar(15) not null,
    CardValDate varchar(6) not null,
    CardName varchar(30) not null,
    primary key (idPaymentClient, idPayment),
    constraint fk_payments_clients foreign key (idPaymentClient) references clients(idClient)
);
alter table payments auto_increment=1;

-- criar tabela pedido

create table orders(
	idOrder int auto_increment primary key not null,
    idOrderClient int,
    OrderStatus ENUM('Em adamento', 'Em processamento', 'Enviado', 'Entregue') default 'Em processamento' not null,
    OrderDescription varchar(255),
    ShippingPrice float default 0,
    PaymentType enum('Boleto','Cartão') not null default 'Boleto',
    idOrderPayment int,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient),
    constraint fk_orders_payment foreign key (idOrderPayment) references payments(idPayment)
		on update cascade
);
alter table orders auto_increment=1;

-- criar tabela estoque

create table stock(
	idProdStock int auto_increment primary key not null,
    StockLocation varchar(255) not null,
    StockQuantity int not null default 0
);
alter table stock auto_increment=1;

-- criar tabela fornecedor

create table supplier(
	idSupplier int auto_increment primary key not null,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

-- criar tabela vendedor

create table seller(
	idSeller int auto_increment primary key not null,
    SocialName varchar(255) not null,
    Location varchar(255),
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    Contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF),
    constraint unique_socialname_seller unique (SocialName)
);
alter table seller auto_increment=1;

create table productSeller(
	idPSseller int,
    idPSproduct int,
    PSQuantity int not null,
    primary key (idPSseller, idPSproduct),
    constraint fk_productseller_seller foreign key (idPSseller) references seller(idSeller),
    constraint fk_productseller_product foreign key (idPSproduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    POQuantity int not null,
    POStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);

create table productStock(
	idPSproduct int,
    idPSstock int,
    PSLocation varchar(255) not null,
    primary key (idPSproduct, idPSstock),
    constraint fk_productstock_product foreign key (idPSproduct) references product(idProduct),
    constraint fk_productstock_stock foreign key (idPSstock) references stock(idProdStock)
);

create table productSupplier(
	idPSupSupplier int,
    idPSupProduct int,
    PSupQuantity int not null,
    primary key (idPSupSupplier, idPSupProduct),
    constraint fk_productsupplier_supplier foreign key (idPSupSupplier) references supplier(idSupplier),
    constraint fk_productsupplier_product foreign key (idPSupProduct) references product(idProduct)
);

show databases;
use ecommerce;
show tables;
use information_schema;
select * from referential_constraints where constraint_schema = 'ecommerce';
