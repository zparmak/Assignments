select *  from sale.order_item

--Discount Effects
--Generate a report including product IDs and discount effects on whether the increase 
--in the discount rate positively impacts the number of orders for the products.
--In this assignment, you are expected to generate a solution using SQL with a logical approach. 

--First way-- Ürün bazýnda satýþ adedi ortalamalarý üzerinden indirim oranýnýn etkisi ayrý ayrý gözlemlendi.

with t1 as
(
select  product_id, discount, 
sum(quantity) as total_quantity from sale.order_item
group by  product_id, discount
),

t2 as
(

select *, AVG(total_quantity) OVER (PARTITION BY product_id) as avg_quantity from t1
)


select *, 
case when avg_quantity < total_quantity then 'Positive' else 'Negative' END Discount_Effect 
from t2



---Second way--- indirim oraný 0.05 ve 0.20 arasýndaki satýþ adetlerinin üzerinden karþýlaþtýrýlma yapýldý.

 with cte as
 (
select  product_id, discount, 
sum(quantity) as total_quantity from sale.order_item
group by  product_id, discount 
),
 T1 as
 (
select *, total_quantity as first_quantity from cte where discount= 0.05 
),
T2 as
(
select *, total_quantity as last_quantity from cte where discount= 0.20
)

select t1.product_id, first_quantity, last_quantity, case when first_quantity < last_quantity then 'Positive' else 'Negative' END Discount_Effect from
t1 left join t2 on t1.product_id = t2.product_id