SET search_path = sample;

CREATE USER cashflow_admin WITH PASSWORD :'cashflow_admin_password';
GRANT CONNECT ON DATABASE personify TO cashflow_admin;
GRANT ALL PRIVILEGES ON DATABASE personify TO cashflow_admin;