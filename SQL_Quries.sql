----------------------------------------DASHBOARD-1--------------------------
--- TOTAL LOAN APPLICATIONS ---
use [Bank Loan DB];
select * from Bank_loan_data;
-- Total Loan Application  --
select count(id) as Total_loan_application from Bank_loan_data;

-- MTD Loan Application--
select count(id) as MTD_loan_application from Bank_loan_data
where month(issue_date) = 12 AND YEAR(issue_date) = 2021;

--MoM loan Application--
select count(id) as PMTD_loan_application from Bank_loan_data
where month(issue_date) = 11 AND YEAR(issue_date) = 2021;

--(MTD-PMTD)/PMTD--

--- TOTAL FUNDED AMMOUNT ---
-- MTD totoal funded amount --
select sum(loan_amount) as MTD_Total_Funded_amount from Bank_loan_data
where MONTH(issue_date)= 12 and YEAR(issue_date) = 2021;
-- PMTD total funded amount
select sum(loan_amount) as PMTD_Total_Funded_amount from Bank_loan_data
where MONTH(issue_date)= 11 and YEAR(issue_date) = 2021;
--- TOTAL AMOUNT RECEIVED FROM CUSTOMERS ---
select sum(total_payment) as toal_amount_received from Bank_loan_data ;
select sum(total_payment) as toal_amount_received from Bank_loan_data
where MONTH(issue_date)=11;

select sum(total_payment) as MTD_total_amount_received from Bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

select SUM(total_payment) as PMTD_total_amount_received from Bank_loan_data
where MONTH (issue_date) = 11 AND YEAR(issue_date)= 2021;

----------------------------------------------------------------------------------

--- AVERAGE INTREST RATE ---
select ROUND(AVG(int_rate)*100,3) as Avg_Intrest_rate from Bank_loan_data;

select ROUND(AVG(int_rate)*100,3) as Avg_Intrest_rate from Bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date)=2021;

select ROUND(AVG(int_rate)*100,3) as Avg_Intrest_rate from Bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date)=2021;
---------------------------------------------------------------------------------
select AVG(dti)*100 as Avg_DTI from Bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date) = 2021;

select AVG(dti)*100 as Avg_DTI from Bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date) = 2021;

------------------------------------------------------------------------------------
--- Good loan and bad loan ---

---- GOOD_LOAN_PERCENTAGE------
Select loan_status from Bank_loan_data;
select
    (count(case when loan_status ='Fully Paid' or loan_status ='Current'THEN id END)*100)
    /
    count(id) as Good_loan_Percentage 
from Bank_loan_data;

------GOOD_LOAN_APPLICATIONS--------
select COUNT(id) as Good_Loan_Applications from Bank_loan_data where loan_status='Fully paid' or loan_status='loan_status';
----FUNDED_AMOUNT/LOAN_AMOUNT-------
select sum(loan_amount) as Good_Loan_Funded_Amount from Bank_loan_data where loan_status='Fully paid' or loan_status='loan_status';
-----GOOD_LOAN_TOTAL_RECIEVED_AMOUNT----
select sum(total_payment) as Good_Loan_Recieved_Amount from Bank_loan_data where loan_status='Fully paid' or loan_status='loan_status';
----BAD_LOANS-----
select 
     (COUNT(Case when loan_status = 'Charged Off' then id end)*100)/
      COUNT(id) as Bad_load_percentage
from Bank_loan_data;
-----Toal_application_bad_loan------
select count(id) as Bad_loan_applications from Bank_loan_data	
where loan_status = 'Charged Off';
-----Bad-Loan-funded-amount-----
select sum(loan_amount) as Bad_Loan_funded_amount from Bank_loan_data
where loan_status='Charged Off';
-----Bad_loan_Recieved_Amount-----
select sum(total_payment) as Bad_Loan_funded_amount from Bank_loan_data
where loan_status='Charged Off';


---LOAN_STATUS_GRID_VIEW------
select
     loan_status,
	 COUNT(id) as Total_loan_applications,
	 SUM(total_payment) as Total_Amount_Received,
	 SUM(loan_amount) as Total_Funded_Amount,
	 AVG(int_rate * 100) as Interest_Rate,
	 AVG(dti * 100) as DTI
  from
     Bank_loan_data
	 group by
	 loan_status;

----MTD_Amount_Received_Funded-----
select 
      loan_status,
	  SUM(total_payment) as MTD_Total_Amount_Received,
	  SUM(loan_amount) as MTD_Total_Amount_Funded
FROM Bank_loan_data
where MONTH(issue_date) = 12
Group by loan_status;

--------------------------------OVER_VIER_DASHBOARD---------------------------------------------------

---Monthly_Trends-----
select 
    MONTH(issue_date) as Month_Number,
    DATENAME(MONTH, issue_date) as Month_Name,
    count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by MONTH(issue_date),DATENAME(MONTH, issue_date)
order by MONTH(issue_date);

---Reginal_Analysis_By_State---
select 
     address_state,
	 count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by address_state
order by count(id) desc;

---Loan_Term_Analysis----
select 
     term,
	 count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by term
order by term desc;

---Employee_Length_Analysis---
select 
     emp_length,
	 count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by emp_length
order by count(id) desc;

---Loan_Purpose_Breakdown---
select 
     purpose,
	 count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by purpose
order by count(id) desc;

---Home_Ownership_Analysis---
select 
     home_ownership,
	 count(id) as Total_Loan_Application,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from Bank_loan_data
group by home_ownership
order by count(id) desc;