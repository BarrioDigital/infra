CREATE DATABASE IF NOT EXISTS db_barriodigital_requests;
CREATE DATABASE IF NOT EXISTS db_barriodigital_catalog;
CREATE DATABASE IF NOT EXISTS db_barriodigital_audit;
CREATE DATABASE IF NOT EXISTS db_barriodigital_report;

GRANT ALL PRIVILEGES ON db_barriodigital_requests.* TO 'barriouser'@'%';
GRANT ALL PRIVILEGES ON db_barriodigital_catalog.* TO 'barriouser'@'%';
GRANT ALL PRIVILEGES ON db_barriodigital_audit.* TO 'barriouser'@'%';
GRANT ALL PRIVILEGES ON db_barriodigital_report.* TO 'barriouser'@'%';

FLUSH PRIVILEGES;