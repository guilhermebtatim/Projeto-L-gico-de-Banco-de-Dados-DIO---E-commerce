-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');

select * from clients;

-- idProduct, Pname, Category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), Rating, Price
insert into product (Pname, Category, Rating, Price) values
							  ('Fone de ouvido','Eletrônico','4','89.90'),
                              ('Barbie Elsa','Brinquedos','3','37.90'),
                              ('Body Carters','Vestimenta','5','59.90'),
                              ('Microfone Vedo - Youtuber','Eletrônico','4','44.90'),
                              ('Sofá retrátil','Móveis','3','799.90'),
                              ('Farinha de arroz','Alimentos','2','8.99'),
                              ('Fire Stick Amazon','Eletrônico','3','29.90');

select * from product;

-- idPaymentClient, idPayment, CardNumber, CardAgency, CardValDate, CardName
insert into payments (idPaymentClient, CardNumber, CardAgency, CardValDate, CardName) values
							(1, '1234567891234567', '123456789', '112023', 'Maria M Silva'),
                            (3, '2165020654620225', '159528512', '022024', 'Ricardo F Silva'),
                            (3, '6519851202551625', '519651220', '052026', 'Ricardo F Silva'),
                            (5, '1891022909512094', '015189065', '072023', 'Roberta G Assis');
                            
select * from payments;

-- idOrder, idOrderClient, OrderStatus, OrderDescription, ShippingPrice, PaymentType, idOrderPayment
-- delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, OrderStatus, OrderDescription, ShippingPrice, PaymentType, idOrderPayment) values 
							 (1,'Em adamento','compra via aplicativo',default,default,null),
                             (2,default,'compra via aplicativo',50,default,null),
                             (3,default,null,default,'Cartão',2),
                             (4,'Entregue','compra via web site',150,default,null);

select * from orders;

-- idPOproduct, idPOorder, POQuantity, POStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,default),
                         (2,1,1,default),
                         (3,2,1,default);

select * from productOrder;

-- idProdStock, StockLocation, StockQuantity
insert into stock (StockLocation, StockQuantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
select * from stock;

-- idLproduct, idLstorage, location
insert into productStock (idPSproduct, idPSstock, PSLocation) values
						 (1,2,'RJ'),
                         (2,6,'GO');

select * from productStock;

-- idSupplier, SocialName, CNPJ, Contact
insert into supplier (SocialName, CNPJ, Contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
                            
-- idPSupSupplier, idPSupProduct, PSupQuantity
insert into productSupplier (idPSupSupplier, idPSupProduct, PSupQuantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, Location, AbsName, CNPJ, CPF, Contact
insert into seller (SocialName, Location, AbsName, CNPJ, CPF, Contact) values 
						('Tech eletronics','Rio de Janeiro', null, 123456789456321, null, 219946287),
					    ('Botique Durgas','Rio de Janeiro', null, null,123456783, 219567895),
						('Kids World','São Paulo', null, 456789123654485, null, 1198657484);

select * from seller;

-- idPSseller, idPSproduct, PSQuantity
insert into productSeller (idPSseller, idPSproduct, PSQuantity) values 
						 (1,6,80),
                         (2,7,10);

select * from productSeller;

--
--
--


select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) CompleteName, idOrder, OrderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, OrderStatus, OrderDescription, ShippingPrice, PaymentType, idOrderPayment) values 
							 (2,'Enviado','compra via aplicativo',default,default,null);

                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

-- Cartões cadastrados em cada cliente
select * from clients, payments where idClient = id;

-- recuperação de pedido com produto associado
select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 
        
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient
        having count(*) > 1; 
        
-- Algum vendedor também é fornecedor?
select * from seller sell join supplier supp on sell.CNPJ = supp.CNPJ;

-- Relação de produtos, fornecedores e estoques
select * from product;
select * from supplier;
select * from stock;
select * from productStock;
select * from productSupplier;

select * from product p join productStock pst on p.idProduct = pst.idPSproduct
	join productSupplier psu on p.idProduct = psu.idPSupProduct;

-- Relação de nomes dos fornecedores e nomes dos produtos
select Pname, Category, idPSupSupplier, PSupQuantity from product p join productSupplier psu on p.idProduct = psu.idPSupProduct;