LOAD DATA INFILE 'C:/Users/Piya/Desktop/New folder/Uploads/Policy Data SHEET1.csv'
INTO TABLE customer_information
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


alter table Claims
modify column ClaimAmount varchar(50);

select * from Policies;

ALTER TABLE Policies
MODIFY COLUMN PolicyStartDate VARCHAR(20),
MODIFY COLUMN PolicyEndDate VARCHAR(20);


use policydb;
select * from policy_data;

CREATE TABLE customers_info_1 (
    Customer_ID VARCHAR(255),
    customer_name VARCHAR(255),
    Gender VARCHAR(255),
    Age INT(20),
    Occupation VARCHAR(255),
    Marital_Status VARCHAR(255),
    Address VARCHAR(255),
    State VARCHAR(100),
    ZIP_code int(50)
);
SHOW VARIABLES LIKE 'secure_file_priv';

CREATE TABLE Policies (
    PolicyID VARCHAR(100),
    PolicyType VARCHAR(100),
    CoverageAmount int(15) ,
    PremiumAmount DECIMAL(15, 2),
    PolicyStartDate DATE,
    PolicyEndDate DATE,
    PaymentFrequency VARCHAR(20),
    Status_p VARCHAR(20),
    CustomerID VARCHAR(100)
);

describe policies;


CREATE TABLE Claims (
    ClaimID VARCHAR(50),
    DateOfClaim varchar(50),
    ClaimAmount int(50),
    ClaimStatus VARCHAR(20),
    ReasonForClaim VARCHAR(255),
    SettlementDate varchar(50),
    PolicyID VARCHAR(10)
);
ALTER TABLE Claims MODIFY PolicyID VARCHAR(50);
select * from Claims;

alter table Claims
modify column ClaimAmount varchar(50);

select * from Policies;
SELECT COUNT(*) AS TotalPolicies
FROM Policies; 

SELECT COUNT(*) AS TotalPolicies
FROM Policies;
describe Claims;

drop table Claims;

CREATE TABLE payment_history (
    payment_id varchar(100),
    date_of_payment varchar(50),
    amount_paid DECIMAL(15, 2),
    payment_method VARCHAR(50) ,
    payment_status VARCHAR(50),
    policy_id varchar(50)
);

select * from payment_history;

CREATE TABLE additional_fields (
    agent_id varchar(50),
    renewal_status VARCHAR(20),
    policy_discounts int(20),
    risk_score int(50),
    policy_id varchar(50)
);

select* from additional_fields;

CREATE TABLE brokerage (
    client_name VARCHAR(100),
    policy_number VARCHAR(100),
    policy_status VARCHAR(20),
    policy_start_date  VARCHAR(50),
    policy_end_date  VARCHAR(50),
    product_group VARCHAR(50),
    account_exe_id INT(20),
    exe_name VARCHAR(100),
    branch_name VARCHAR(100),
    solution_group VARCHAR(100),
    income_class VARCHAR(100),
    amount DECIMAL(15, 2),
    income_due_date varchar(50),
    revenue_transaction_type VARCHAR(100),
    renewal_status VARCHAR(50),
    lapse_reason VARCHAR(100),
    last_updated_date  VARCHAR(50)
);

select * from brokerage;

CREATE TABLE invoices (
    invoice_number int(50),
    invoice_date VARCHAR(100),
    revenue_transaction_type VARCHAR(100),
    branch_name VARCHAR(50),
    solution_group VARCHAR(50),
    account_exe_id INT(20),
    account_executive VARCHAR(100),
    income_class VARCHAR(50),
    client_name VARCHAR(100),
    policy_number VARCHAR(50),
    amount int(50),
    income_due_date VARCHAR(100)
);

select*from invoices;

CREATE TABLE individual_budget (
    branch VARCHAR(50),
    account_exe_id INT(20),
    employee_name VARCHAR(100),
    new_role2 VARCHAR(50),
    new_budget int(50),
    cross_sell_budget int(50),
    renewal_budget int(50)
);
select*from individual_budget;

CREATE TABLE meeting_details (
    account_exe_id INT(20),
    account_executive VARCHAR(100),
    branch_name VARCHAR(50),
    global_attendees VARCHAR(100),
    meeting_date VARCHAR(50)
);

select * from meeting_details;

CREATE TABLE opportunity (
    opportunity_name VARCHAR(100),
    opportunity_id VARCHAR(50),
    account_exe_id INT(20),
    account_executive VARCHAR(100),
    premium_amount int (100),
    revenue_amount int(100),
    closing_date varchar(50),
    stage VARCHAR(50),
    branch VARCHAR(50),
    specialty VARCHAR(100),
    product_group VARCHAR(50),
    product_sub_group VARCHAR(50),
    risk_details VARCHAR(50)
);




use policydb;
CREATE TABLE customer_information (
    Customer_ID varchar(255),
    customer_name VARCHAR(100),
    Gender varchar(50),
    Age INT ,
    Occupation VARCHAR(100),
    Marital_Status VARCHAR(20),
    Address VARCHAR(255),
    State VARCHAR(50),
    ZIP_code int
);

-- Branch Dataset 

select * from opportunity;
SELECT COUNT(*) AS total_opportunities  -- (1)
FROM opportunity;

SELECT  COUNT(*) AS open_opportunities_count  -- (2)
FROM opportunity
WHERE stage IN ('Propose Solution', 'Qualify Opportunity');

select * from invoices;  -- (3)
select account_executive, count(invoice_number) as "Number_of_invoices"
from invoices group by account_executive order by Number_of_invoices desc;

select * from meeting_details;
describe meeting_details;

select account_executive, count(*) as "meeting_count" from meeting_details  -- (4)
group by account_executive order by meeting_count desc;


SELECT YEAR(STR_TO_DATE(meeting_date, '%d-%m-%Y')) AS year, -- (5)
COUNT(*) AS meeting_count
FROM meeting_details
WHERE YEAR(STR_TO_DATE(meeting_date, '%d-%m-%Y')) IN (2019, 2020)
GROUP BY YEAR(STR_TO_DATE(meeting_date, '%d-%m-%Y'))
ORDER BY year;



select * from opportunity;
select stage, sum(revenue_amount) as "total_revenue" from opportunity -- (6)
group by stage order by total_revenue desc;

-- Policy dataset

select * from policies;

SELECT COUNT(*) AS total_policies  -- (1)
FROM  policies;

select * from customer_information;

SELECT COUNT(*) AS total_customers -- (2)
FROM  customer_information;

select * from claims;
describe claims;

SELECT  SUM(claimAmount) AS total_claim_amount -- (3)
FROM  claims;

SELECT COUNT(*) AS policies_expiring_this_year  -- (4)
FROM policies
WHERE YEAR(STR_TO_DATE(policyEndDate, '%d-%m-%Y')) = YEAR(CURDATE());

select * from payment_history;

SELECT payment_status, -- (5)
COUNT(*) AS policy_count_by_payment_status
FROM payment_history
GROUP BY payment_status;

SELECT claimStatus, COUNT(*) AS policy_count  -- (6)
FROM claims
WHERE claimStatus IN ('approved', 'denied', 'pending')
GROUP BY claimStatus;






