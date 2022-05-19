-- Query 1
select distinct c.*, v.* from phoenix_claim cl 
inner join phoenix_insurance_policy ip on cl.phoenix_claim_insurance_policy_id=ip.phoenix_insurance_policy_id
inner join phoenix_vehicle v on v.phoenix_vehicle_id=ip.phoenix_insurance_policy_vehicle_id
inner join phoenix_customer c on c.phoenix_customer_id=v.phoenix_vehicle_customer_id
inner join phoenix_incident i on i.phoenix_incident_vehicle_id=v.phoenix_vehicle_id
where phoenix_claim_status='pending';

-- Query 2
select distinct c.* from phoenix_customer c  
inner join phoenix_vehicle v on c.phoenix_customer_id=v.phoenix_vehicle_customer_id
inner join phoenix_insurance_policy ip on v.phoenix_vehicle_id=ip.phoenix_insurance_policy_vehicle_id
inner join phoenix_premium_payment pp on pp.phoenix_premium_payment_insurance_policy_id=ip.phoenix_insurance_policy_id
where phoenix_premium_payment_amount > (select sum(phoenix_customer_id) from phoenix_customer);

-- Query 3
select c.* from phoenix_company c 
inner join phoenix_department d on c.phoenix_company_id=d.phoenix_department_company_id
inner join phoenix_product p on c.phoenix_company_id=p.phoenix_product_company_id
group by phoenix_company_id
having count( distinct phoenix_department_id) < count( distinct phoenix_product_id) and count( distinct phoenix_department_location) >1;  

-- Query 4
select * from phoenix_customer 
where phoenix_customer_id in
	(select phoenix_vehicle_customer_id from phoenix_vehicle 
	group by phoenix_vehicle_customer_id
	having count(*)>1)
and phoenix_customer_id in	
	(select v.phoenix_vehicle_customer_id from phoenix_premium_payment pp 
    inner join phoenix_insurance_policy ip on pp.phoenix_premium_payment_insurance_policy_id=ip.phoenix_insurance_policy_id 
	inner join phoenix_vehicle v on v.phoenix_vehicle_id=ip.phoenix_insurance_policy_vehicle_id
	inner join phoenix_customer c on c.phoenix_customer_id=v.phoenix_vehicle_customer_id
	inner join phoenix_incident i on i.phoenix_incident_vehicle_id=v.phoenix_vehicle_id 
	where phoenix_premium_payment_status='pending');

-- Query 5
Select distinct v.* from phoenix_vehicle as v 
inner join  phoenix_insurance_policy as ip on v.phoenix_vehicle_id=ip.phoenix_insurance_policy_vehicle_id 
inner join phoenix_premium_payment as pp on pp.phoenix_premium_payment_insurance_policy_id=ip.phoenix_insurance_policy_id
where (phoenix_vehicle_registration_number < phoenix_premium_payment_amount);
 
-- Query 6
select distinct c.* from phoenix_customer c 
inner join phoenix_vehicle v on v.phoenix_vehicle_customer_id=c.phoenix_customer_id
inner join phoenix_insurance_policy ip on ip.phoenix_insurance_policy_vehicle_id=v.phoenix_vehicle_id
inner join phoenix_claim cl on cl.phoenix_claim_insurance_policy_id=ip.phoenix_insurance_policy_id
inner join phoenix_claim_payment cp on cp.phoenix_claim_payment_claim_id=cl.phoenix_claim_id
inner join phoenix_product p on ip.phoenix_insurance_policy_product_id=p.phoenix_product_id
inner join phoenix_coverage co on co.phoenix_coverage_product_id=p.phoenix_product_id
where phoenix_claim_amount < phoenix_coverage_amount and phoenix_claim_amount > (phoenix_customer_id+phoenix_vehicle_id+phoenix_claim_id+phoenix_claim_payment_id);
