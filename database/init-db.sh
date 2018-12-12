CREATE USER ccd WITH PASSWORD 'ccd';
CREATE USER sscsjobscheduler WITH PASSWORD 'sscsjobscheduler';
CREATE DATABASE sscsjobscheduler
    WITH OWNER = sscsjobscheduler
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
CREATE DATABASE ccd_user_profile
    WITH OWNER = ccd
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
CREATE DATABASE ccd_data
    WITH OWNER = ccd
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
CREATE DATABASE ccd_definition
    WITH OWNER = ccd
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
CREATE DATABASE evidence
    WITH OWNER = ccd
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
