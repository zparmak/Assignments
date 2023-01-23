--1--
--You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.
--1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)
select customer_id
from sale.customer
where customer_id IN(
		select a.customer_id
		from sale.customer a
		inner join sale.orders b on a.customer_id = b.customer_id
		inner join sale.order_item c on b.order_id = c.order_id
		inner join product.product d on c.product_id = d.product_id
		where d.product_name =  '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
		EXCEPT 
		select a.customer_id
		from sale.customer a
		inner join sale.orders b on a.customer_id = b.customer_id
		inner join sale.order_item c on b.order_id = c.order_id
		inner join product.product d on c.product_id = d.product_id
		where d.product_name =  'Polk Audio - 50 W Woofer - Black'
		)
order by customer_id

-- buraya kadar istenen çýktýyý verdi, ancak other_product olmayan haliyle---


with t1 as 
(
select customer_id
from sale.customer
where customer_id IN(
		select a.customer_id
		from sale.customer a
		inner join sale.orders b on a.customer_id = b.customer_id
		inner join sale.order_item c on b.order_id = c.order_id
		inner join product.product d on c.product_id = d.product_id
		where d.product_name =  '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
		EXCEPT 
		select a.customer_id
		from sale.customer a
		inner join sale.orders b on a.customer_id = b.customer_id
		inner join sale.order_item c on b.order_id = c.order_id
		inner join product.product d on c.product_id = d.product_id
		where d.product_name =  'Polk Audio - 50 W Woofer - Black'
		)
)
	
select customer_id case customer_id = t1.customer_id  then 'Yes' else 'No' 
		end as 'other_product',
		first_name, last_name
from sale.customer, t1;



	



--2.Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. 
--Write a query to return the conversion rate for each Advertisement type.

CREATE TABLE ECommerce (Visitor_ID 
	INT IDENTITY (1, 1) PRIMARY KEY,	
	Adv_Type VARCHAR (255) NOT NULL, Action1 VARCHAR (255) NOT NULL);

INSERT INTO ECommerce (Adv_Type, Action1)VALUES 
	('A', 'Left'),
	('A', 'Order'),
	('B', 'Left'),
	('A', 'Order'),
	('A', 'Review'),
	('A', 'Left'),
	('B', 'Left'),
	('B', 'Order'),
	('B', 'Review'),
	('A', 'Review');


select * from ECommerce

with t1 as
(
select Adv_Type, count(Adv_Type) as total_adv
from ECommerce
group by Adv_Type
)

with t2 as
(
select Adv_Type, count(Action1) as total_order_by_action
from ECommerce
where Action1 = 'Order'
group by Adv_Type
)

select (t1.Adv_type, t2.total_order_by_action / t1.total_adv) as Conversation_Rate
from t1, t2
where t1.Adv_Type = t2.Adv_Type

