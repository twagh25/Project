use loan_db ;
select * from financial_loan;

select count(id) as Total_application from financial_loan;

select count(id) as PMTD_Total_application from financial_loan
where month(issue_date) = 11 and year(issue_date)= 2021;

select count(id) as MTD_Total_application from financial_loan
where month(issue_date) = 12 and year(issue_date)= 2021;


select sum(loan_amount) as Total_Funded_Amount from financial_loan ;

select sum(loan_amount) as MTD_Total_Funded_Amount from financial_loan
where  month(issue_date) = 12 and year(issue_date)= 2021 ;

select sum(loan_amount) as PMTD_Total_Funded_Amount from financial_loan
where  month(issue_date) = 11 and year(issue_date)= 2021 ;

select sum(total_payment) as total_amount_received from financial_loan;

select sum(total_payment) as MTD_total_amount_received from financial_loan
where month(issue_date) = 12 and year(issue_date)=2021;

select sum(total_payment) as PMTD_total_amount_received from financial_loan
where month(issue_date) = 11 and year(issue_date)=2021;

select round(avg(int_rate)*100,2) as avg_intrest from financial_loan;

select round(avg(int_rate)*100,2) as MTD_avg_intrest from financial_loan
where month(issue_date) = 12 and year(issue_date)=2021;

select round(avg(int_rate)*100,2) as PMTD_avg_intrest from financial_loan
where month(issue_date) = 11 and year(issue_date)=2021;

select round(avg(dti)*100,2) as Average_Debt_to_Income from financial_loan; 

select round(avg(dti)*100,2) as MTD_Average_Debt_to_Income from financial_loan 
where month(issue_date) = 12 and year(issue_date)=2021;

select round(avg(dti)*100,2) as PMTD_Average_Debt_to_Income from financial_loan 
where month(issue_date) = 11 and year(issue_date)=2021;


select (count(case when loan_status ="Fully Paid" or loan_status ="Current" then id end )*100)/ count(id) as Good_Loan_Percentage
from financial_loan;

select count(id) as GOOD_LOAN_APPLICATION from financial_loan
where loan_status = "Fully Paid" or loan_status ="Current" ;

select sum(loan_amount) as GOOD_LOAN_funded_amount from financial_loan
where loan_status = "Fully Paid" or loan_status ="Current" ;

select sum(total_payment) as GOOD_LOAN_Total_Recived_amount from financial_loan
where loan_status = "Fully Paid" or loan_status ="Current" ;

select (count(case when loan_status = "Charged Off" then id end)*100)/ count(id) as Bad_Loan_Applicvation_Persentage
from financial_loan;

select count(id) as Bad_Loan_Apllication from financial_loan
where loan_status = "Charged Off" ;

select sum(loan_amount) as Bad_Loan_funded_amount from financial_loan
where loan_status = "Charged Off" ;

select sum(total_payment) as Bad_Loan_Amount_Recived from financial_loan
where loan_status = "Charged Off" ;

select loan_status,
       count(id) as Good_Loan_Application,
       sum(loan_amount) as Total_Funded_Amount,
       sum(total_payment) as Total_Recived_Amount,
       avg(int_rate*100) as Interest_Rate,
       avg(dti*100) as DTI
from financial_loan
group by loan_status;

select loan_status,
       sum(loan_amount) as MTD_Total_Funded_Amount,
       sum(total_payment) as MTD_Total_Recived_Amount
from financial_loan
where month(issue_date)  = 12
group by loan_status;

select month(issue_date) as Month_number ,
      monthname(issue_date) as Month_Name,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by month(issue_date), monthname(issue_date)
order by month(issue_date) ; 


select address_state,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by address_state
order by address_state ; 

select term,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by term
order by term ; 

select emp_length,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by emp_length
order by emp_length ; 

select purpose,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by purpose
order by count(id) desc ; 

select home_ownership,
      count(id) as Total_Loan_Application,
      sum(loan_amount) as Total_Funded_Amount,
      sum(total_payment) as Total_recived_Amount
from financial_loan
group by  home_ownership
order by count(id) desc ;

 
