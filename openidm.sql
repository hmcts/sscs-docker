-- noinspection SqlNoDataSourceInspectionForFile

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: fridam; Type: SCHEMA; Schema: -; Owner: openidm
--

CREATE SCHEMA fridam;


ALTER SCHEMA fridam OWNER TO openidm;

--
-- Name: openidm; Type: SCHEMA; Schema: -; Owner: openidm
--

CREATE SCHEMA openidm;


ALTER SCHEMA openidm OWNER TO openidm;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA openidm;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = fridam, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clustercache; Type: TABLE; Schema: fridam; Owner: openidm
--

CREATE TABLE clustercache (
    key text NOT NULL,
    assignments text[] NOT NULL
);


ALTER TABLE clustercache OWNER TO openidm;

--
-- Name: service; Type: TABLE; Schema: fridam; Owner: openidm
--

CREATE TABLE service (
    label text NOT NULL,
    description text NOT NULL,
    allowedroles text[],
    onboardingendpoint text,
    onboardingroles text[],
    oauth2clientid text NOT NULL,
    activationredirecturl text,
    selfregistrationallowed boolean NOT NULL
);


ALTER TABLE service OWNER TO openidm;

SET search_path = openidm, pg_catalog;

--
-- Name: act_ge_bytearray; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE act_ge_bytearray OWNER TO openidm;

--
-- Name: act_ge_property; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_ge_property OWNER TO openidm;

--
-- Name: act_hi_actinst; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_actinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_actinst OWNER TO openidm;

--
-- Name: act_hi_attachment; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64)
);


ALTER TABLE act_hi_attachment OWNER TO openidm;

--
-- Name: act_hi_comment; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE act_hi_comment OWNER TO openidm;

--
-- Name: act_hi_detail; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_hi_detail OWNER TO openidm;

--
-- Name: act_hi_identitylink; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64)
);


ALTER TABLE act_hi_identitylink OWNER TO openidm;

--
-- Name: act_hi_procinst; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_procinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_procinst OWNER TO openidm;

--
-- Name: act_hi_taskinst; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_taskinst OWNER TO openidm;

--
-- Name: act_hi_varinst; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_hi_varinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    rev_ integer,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE act_hi_varinst OWNER TO openidm;

--
-- Name: act_id_group; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE act_id_group OWNER TO openidm;

--
-- Name: act_id_info; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE act_id_info OWNER TO openidm;

--
-- Name: act_id_membership; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE act_id_membership OWNER TO openidm;

--
-- Name: act_id_user; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64)
);


ALTER TABLE act_id_user OWNER TO openidm;

--
-- Name: act_re_deployment; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone
);


ALTER TABLE act_re_deployment OWNER TO openidm;

--
-- Name: act_re_model; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_model OWNER TO openidm;

--
-- Name: act_re_procdef; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_procdef OWNER TO openidm;

--
-- Name: act_ru_event_subscr; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_event_subscr OWNER TO openidm;

--
-- Name: act_ru_execution; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_execution OWNER TO openidm;

--
-- Name: act_ru_identitylink; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64)
);


ALTER TABLE act_ru_identitylink OWNER TO openidm;

--
-- Name: act_ru_job; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_job OWNER TO openidm;

--
-- Name: act_ru_task; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_task OWNER TO openidm;

--
-- Name: act_ru_variable; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_ru_variable OWNER TO openidm;

--
-- Name: auditaccess; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditaccess (
    objectid character varying(56) NOT NULL,
    activitydate character varying(29) NOT NULL,
    eventname character varying(255),
    transactionid character varying(255) NOT NULL,
    userid character varying(255) DEFAULT NULL::character varying,
    trackingids text,
    server_ip character varying(40),
    server_port character varying(5),
    client_ip character varying(40),
    client_port character varying(5),
    request_protocol character varying(255),
    request_operation character varying(255),
    request_detail text,
    http_request_secure character varying(255),
    http_request_method character varying(255),
    http_request_path character varying(255),
    http_request_queryparameters text,
    http_request_headers text,
    http_request_cookies text,
    http_response_headers text,
    response_status character varying(255),
    response_statuscode character varying(255),
    response_elapsedtime character varying(255),
    response_elapsedtimeunits character varying(255),
    response_detail text,
    roles text
);


ALTER TABLE auditaccess OWNER TO openidm;

--
-- Name: auditactivity; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditactivity (
    objectid character varying(56) NOT NULL,
    activitydate character varying(29) NOT NULL,
    eventname character varying(255) DEFAULT NULL::character varying,
    transactionid character varying(255) NOT NULL,
    userid character varying(255) DEFAULT NULL::character varying,
    trackingids text,
    runas character varying(255) DEFAULT NULL::character varying,
    activityobjectid character varying(255),
    operation character varying(255),
    subjectbefore text,
    subjectafter text,
    changedfields text,
    subjectrev character varying(255) DEFAULT NULL::character varying,
    passwordchanged character varying(5) DEFAULT NULL::character varying,
    message text,
    provider character varying(255) DEFAULT NULL::character varying,
    context character varying(25) DEFAULT NULL::character varying,
    status character varying(20)
);


ALTER TABLE auditactivity OWNER TO openidm;

--
-- Name: auditauthentication; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditauthentication (
    objectid character varying(56) NOT NULL,
    transactionid character varying(255) NOT NULL,
    activitydate character varying(29) NOT NULL,
    userid character varying(255) DEFAULT NULL::character varying,
    eventname character varying(50) DEFAULT NULL::character varying,
    provider character varying(255) DEFAULT NULL::character varying,
    method character varying(15) DEFAULT NULL::character varying,
    result character varying(255) DEFAULT NULL::character varying,
    principals text,
    context text,
    entries text,
    trackingids text
);


ALTER TABLE auditauthentication OWNER TO openidm;

--
-- Name: auditconfig; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditconfig (
    objectid character varying(56) NOT NULL,
    activitydate character varying(29) NOT NULL,
    eventname character varying(255) DEFAULT NULL::character varying,
    transactionid character varying(255) NOT NULL,
    userid character varying(255) DEFAULT NULL::character varying,
    trackingids text,
    runas character varying(255) DEFAULT NULL::character varying,
    configobjectid character varying(255),
    operation character varying(255),
    beforeobject text,
    afterobject text,
    changedfields text,
    rev character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE auditconfig OWNER TO openidm;

--
-- Name: auditrecon; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditrecon (
    objectid character varying(56) NOT NULL,
    transactionid character varying(255) NOT NULL,
    activitydate character varying(29) NOT NULL,
    eventname character varying(50) DEFAULT NULL::character varying,
    userid character varying(255) DEFAULT NULL::character varying,
    trackingids text,
    activity character varying(24) DEFAULT NULL::character varying,
    exceptiondetail text,
    linkqualifier character varying(255) DEFAULT NULL::character varying,
    mapping character varying(511) DEFAULT NULL::character varying,
    message text,
    messagedetail text,
    situation character varying(24) DEFAULT NULL::character varying,
    sourceobjectid character varying(511) DEFAULT NULL::character varying,
    status character varying(20) DEFAULT NULL::character varying,
    targetobjectid character varying(511) DEFAULT NULL::character varying,
    reconciling character varying(12) DEFAULT NULL::character varying,
    ambiguoustargetobjectids text,
    reconaction character varying(36) DEFAULT NULL::character varying,
    entrytype character varying(7) DEFAULT NULL::character varying,
    reconid character varying(56) DEFAULT NULL::character varying
);


ALTER TABLE auditrecon OWNER TO openidm;

--
-- Name: auditsync; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE auditsync (
    objectid character varying(56) NOT NULL,
    transactionid character varying(255) NOT NULL,
    activitydate character varying(29) NOT NULL,
    eventname character varying(50) DEFAULT NULL::character varying,
    userid character varying(255) DEFAULT NULL::character varying,
    trackingids text,
    activity character varying(24) DEFAULT NULL::character varying,
    exceptiondetail text,
    linkqualifier character varying(255) DEFAULT NULL::character varying,
    mapping character varying(511) DEFAULT NULL::character varying,
    message text,
    messagedetail text,
    situation character varying(24) DEFAULT NULL::character varying,
    sourceobjectid character varying(511) DEFAULT NULL::character varying,
    status character varying(20) DEFAULT NULL::character varying,
    targetobjectid character varying(511) DEFAULT NULL::character varying
);


ALTER TABLE auditsync OWNER TO openidm;

--
-- Name: clusteredrecontargetids; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE clusteredrecontargetids (
    objectid character varying(38) NOT NULL,
    rev character varying(38) NOT NULL,
    reconid character varying(255) NOT NULL,
    targetids json NOT NULL
);


ALTER TABLE clusteredrecontargetids OWNER TO openidm;

--
-- Name: clusterobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE clusterobjectproperties (
    clusterobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE clusterobjectproperties OWNER TO openidm;

--
-- Name: clusterobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE clusterobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE clusterobjects OWNER TO openidm;

--
-- Name: clusterobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE clusterobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clusterobjects_id_seq OWNER TO openidm;

--
-- Name: clusterobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE clusterobjects_id_seq OWNED BY clusterobjects.id;


--
-- Name: configobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE configobjectproperties (
    configobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(255) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE configobjectproperties OWNER TO openidm;

--
-- Name: configobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE configobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE configobjects OWNER TO openidm;

--
-- Name: configobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE configobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE configobjects_id_seq OWNER TO openidm;

--
-- Name: configobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE configobjects_id_seq OWNED BY configobjects.id;


--
-- Name: genericobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE genericobjectproperties (
    genericobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE genericobjectproperties OWNER TO openidm;

--
-- Name: genericobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE genericobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE genericobjects OWNER TO openidm;

--
-- Name: genericobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE genericobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE genericobjects_id_seq OWNER TO openidm;

--
-- Name: genericobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE genericobjects_id_seq OWNED BY genericobjects.id;


--
-- Name: internalrole; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE internalrole (
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    description character varying(510) DEFAULT NULL::character varying
);


ALTER TABLE internalrole OWNER TO openidm;

--
-- Name: internaluser; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE internaluser (
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    pwd character varying(510) DEFAULT NULL::character varying,
    roles character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE internaluser OWNER TO openidm;

--
-- Name: links; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE links (
    objectid character varying(38) NOT NULL,
    rev character varying(38) NOT NULL,
    linktype character varying(50) NOT NULL,
    linkqualifier character varying(50) NOT NULL,
    firstid character varying(255) NOT NULL,
    secondid character varying(255) NOT NULL
);


ALTER TABLE links OWNER TO openidm;

--
-- Name: managedobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE managedobjectproperties (
    managedobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE managedobjectproperties OWNER TO openidm;

--
-- Name: managedobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE managedobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE managedobjects OWNER TO openidm;

--
-- Name: managedobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE managedobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE managedobjects_id_seq OWNER TO openidm;

--
-- Name: managedobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE managedobjects_id_seq OWNED BY managedobjects.id;


--
-- Name: objecttypes; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE objecttypes (
    id bigint NOT NULL,
    objecttype character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE objecttypes OWNER TO openidm;

--
-- Name: objecttypes_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE objecttypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE objecttypes_id_seq OWNER TO openidm;

--
-- Name: objecttypes_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE objecttypes_id_seq OWNED BY objecttypes.id;


--
-- Name: relationshipproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE relationshipproperties (
    relationships_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE relationshipproperties OWNER TO openidm;

--
-- Name: relationships; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE relationships (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE relationships OWNER TO openidm;

--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relationships_id_seq OWNER TO openidm;

--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


--
-- Name: schedulerobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE schedulerobjectproperties (
    schedulerobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE schedulerobjectproperties OWNER TO openidm;

--
-- Name: schedulerobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE schedulerobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE schedulerobjects OWNER TO openidm;

--
-- Name: schedulerobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE schedulerobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE schedulerobjects_id_seq OWNER TO openidm;

--
-- Name: schedulerobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE schedulerobjects_id_seq OWNED BY schedulerobjects.id;


--
-- Name: securitykeys; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE securitykeys (
    objectid character varying(38) NOT NULL,
    rev character varying(38) NOT NULL,
    keypair text
);


ALTER TABLE securitykeys OWNER TO openidm;

--
-- Name: uinotification; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE uinotification (
    objectid character varying(38) NOT NULL,
    rev character varying(38) NOT NULL,
    notificationtype character varying(255) NOT NULL,
    createdate character varying(255) NOT NULL,
    message text NOT NULL,
    requester character varying(255),
    receiverid character varying(255) NOT NULL,
    requesterid character varying(255),
    notificationsubtype character varying(255)
);


ALTER TABLE uinotification OWNER TO openidm;

--
-- Name: updateobjectproperties; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE updateobjectproperties (
    updateobjects_id bigint NOT NULL,
    propkey character varying(255) NOT NULL,
    proptype character varying(32) DEFAULT NULL::character varying,
    propvalue text
);


ALTER TABLE updateobjectproperties OWNER TO openidm;

--
-- Name: updateobjects; Type: TABLE; Schema: openidm; Owner: openidm
--

CREATE TABLE updateobjects (
    id bigint NOT NULL,
    objecttypes_id bigint NOT NULL,
    objectid character varying(255) NOT NULL,
    rev character varying(38) NOT NULL,
    fullobject json
);


ALTER TABLE updateobjects OWNER TO openidm;

--
-- Name: updateobjects_id_seq; Type: SEQUENCE; Schema: openidm; Owner: openidm
--

CREATE SEQUENCE updateobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE updateobjects_id_seq OWNER TO openidm;

--
-- Name: updateobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: openidm; Owner: openidm
--

ALTER SEQUENCE updateobjects_id_seq OWNED BY updateobjects.id;


--
-- Name: clusterobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusterobjects ALTER COLUMN id SET DEFAULT nextval('clusterobjects_id_seq'::regclass);


--
-- Name: configobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY configobjects ALTER COLUMN id SET DEFAULT nextval('configobjects_id_seq'::regclass);


--
-- Name: genericobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjects ALTER COLUMN id SET DEFAULT nextval('genericobjects_id_seq'::regclass);


--
-- Name: managedobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY managedobjects ALTER COLUMN id SET DEFAULT nextval('managedobjects_id_seq'::regclass);


--
-- Name: objecttypes id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY objecttypes ALTER COLUMN id SET DEFAULT nextval('objecttypes_id_seq'::regclass);


--
-- Name: relationships id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: schedulerobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY schedulerobjects ALTER COLUMN id SET DEFAULT nextval('schedulerobjects_id_seq'::regclass);


--
-- Name: updateobjects id; Type: DEFAULT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjects ALTER COLUMN id SET DEFAULT nextval('updateobjects_id_seq'::regclass);


SET search_path = fridam, pg_catalog;

--
-- Data for Name: clustercache; Type: TABLE DATA; Schema: fridam; Owner: openidm
--

COPY clustercache (key, assignments) FROM stdin;
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: fridam; Owner: openidm
--

COPY service (label, description, allowedroles, onboardingendpoint, onboardingroles, oauth2clientid, activationredirecturl, selfregistrationallowed) FROM stdin;
ccd_gateway	ccd_gateway	{a116f566-b548-4b48-b95a-d2f758d6dc37}	\N	{}	ccd_gateway	\N	f
sscs	sscs	{81cafa26-6d3d-4afc-a10c-d0b5df01ab6d,2cc3c15e-277e-4281-bfb4-5efd372dccbb,6d5b60a4-2e96-459d-93a3-3642d019eabc,0086da2d-5cf4-46fd-a7d4-59018982ed88,0e30b8d1-534b-476e-bacb-025328800d21,86a2595d-0daf-4f7c-974d-f54ecae57832,ce646a01-8d62-42b9-9941-226620e1e3a1,d782a3c8-7140-4240-ab4c-43da97765b86,72d23e7d-9ee9-4195-805f-11fb226eaad7,c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae,0cd2d788-0859-4870-8e06-710112fafe82,ba40315a-59d7-4b23-acdb-039282082d60,a069a459-dd5f-442f-a09b-1c2d8555af94}	\N	{}	sscs	\N	f
\.


SET search_path = openidm, pg_catalog;

--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) FROM stdin;
\.


--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ge_property (name_, value_, rev_) FROM stdin;
schema.version	5.15	1
schema.history	create(5.15)	1
next.dbid	1	1
\.


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_actinst (id_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, duration_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_attachment (id_, rev_, user_id_, name_, description_, type_, task_id_, proc_inst_id_, url_, content_id_) FROM stdin;
\.


--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) FROM stdin;
\.


--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_detail (id_, type_, proc_inst_id_, execution_id_, task_id_, act_inst_id_, name_, var_type_, rev_, time_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
\.


--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, proc_inst_id_) FROM stdin;
\.


--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_procinst (id_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_taskinst (id_, proc_def_id_, task_def_key_, proc_inst_id_, execution_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_hi_varinst (id_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, rev_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) FROM stdin;
\.


--
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_id_group (id_, rev_, name_, type_) FROM stdin;
\.


--
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_id_info (id_, rev_, user_id_, type_, key_, value_, password_, parent_id_) FROM stdin;
\.


--
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_id_membership (user_id_, group_id_) FROM stdin;
\.


--
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_id_user (id_, rev_, first_, last_, email_, pwd_, picture_id_) FROM stdin;
\.


--
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_re_deployment (id_, name_, category_, tenant_id_, deploy_time_) FROM stdin;
\.


--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_re_model (id_, rev_, name_, key_, category_, create_time_, last_update_time_, version_, meta_info_, deployment_id_, editor_source_value_id_, editor_source_extra_value_id_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, suspension_state_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_event_subscr (id_, rev_, event_type_, event_name_, execution_id_, proc_inst_id_, activity_id_, configuration_, created_, proc_def_id_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_execution (id_, rev_, proc_inst_id_, business_key_, parent_id_, proc_def_id_, super_exec_, act_id_, is_active_, is_concurrent_, is_scope_, is_event_scope_, suspension_state_, cached_ent_state_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_identitylink (id_, rev_, group_id_, type_, user_id_, task_id_, proc_inst_id_, proc_def_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_job (id_, rev_, type_, lock_exp_time_, lock_owner_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, retries_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_task (id_, rev_, execution_id_, proc_inst_id_, proc_def_id_, name_, parent_task_id_, description_, task_def_key_, owner_, assignee_, delegation_, priority_, create_time_, due_date_, category_, suspension_state_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY act_ru_variable (id_, rev_, type_, name_, execution_id_, proc_inst_id_, task_id_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
\.


--
-- Data for Name: auditaccess; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditaccess (objectid, activitydate, eventname, transactionid, userid, trackingids, server_ip, server_port, client_ip, client_port, request_protocol, request_operation, request_detail, http_request_secure, http_request_method, http_request_path, http_request_queryparameters, http_request_headers, http_request_cookies, http_response_headers, response_status, response_statuscode, response_elapsedtime, response_elapsedtimeunits, response_detail, roles) FROM stdin;
\.


--
-- Data for Name: auditactivity; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditactivity (objectid, activitydate, eventname, transactionid, userid, trackingids, runas, activityobjectid, operation, subjectbefore, subjectafter, changedfields, subjectrev, passwordchanged, message, provider, context, status) FROM stdin;
\.


--
-- Data for Name: auditauthentication; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditauthentication (objectid, transactionid, activitydate, userid, eventname, provider, method, result, principals, context, entries, trackingids) FROM stdin;
\.


--
-- Data for Name: auditconfig; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditconfig (objectid, activitydate, eventname, transactionid, userid, trackingids, runas, configobjectid, operation, beforeobject, afterobject, changedfields, rev) FROM stdin;
\.


--
-- Data for Name: auditrecon; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditrecon (objectid, transactionid, activitydate, eventname, userid, trackingids, activity, exceptiondetail, linkqualifier, mapping, message, messagedetail, situation, sourceobjectid, status, targetobjectid, reconciling, ambiguoustargetobjectids, reconaction, entrytype, reconid) FROM stdin;
\.


--
-- Data for Name: auditsync; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY auditsync (objectid, transactionid, activitydate, eventname, userid, trackingids, activity, exceptiondetail, linkqualifier, mapping, message, messagedetail, situation, sourceobjectid, status, targetobjectid) FROM stdin;
\.


--
-- Data for Name: clusteredrecontargetids; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY clusteredrecontargetids (objectid, rev, reconid, targetids) FROM stdin;
\.


--
-- Data for Name: clusterobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY clusterobjectproperties (clusterobjects_id, propkey, proptype, propvalue) FROM stdin;
\.


--
-- Data for Name: clusterobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY clusterobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
2	2	493c85e00ab7	637	{"recoveryAttempts":0,"_rev":"637","detectedDown":"0000000000000000000","type":"state","recoveryFinished":"0000000000000000000","instanceId":"493c85e00ab7","startup":"0000001564405945657","recoveringInstanceId":null,"state":1,"recoveringTimestamp":"0000000000000000000","recoveryStarted":"0000000000000000000","_id":"493c85e00ab7","shutdown":"0000000000000000000","timestamp":"0000001564409130486"}
\.


--
-- Name: clusterobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('clusterobjects_id_seq', 2, true);


--
-- Data for Name: configobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY configobjectproperties (configobjects_id, propkey, proptype, propvalue) FROM stdin;
\.


--
-- Data for Name: configobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY configobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
1	1	org.forgerock.openidm.managed	1	{"_rev":"1","service__pid":"org.forgerock.openidm.managed","_id":"org.forgerock.openidm.managed","jsonconfig":{"objects":[{"name":"user","onCreate":{"type":"text/javascript","source":"require('ui/onCreateUser').setDefaultFields(object);require('ui/onCreateUser').createIdpRelationships(object);require('roles/conditionalRoles').updateConditionalGrantsForUser(object, 'roles');require('ui/onCreateUser').emailUser(object);require('ui/lastChanged').updateLastChanged(object);"},"onUpdate":{"type":"text/javascript","source":"require('ui/onUpdateUser').preserveLastSync(object, oldObject, request);require('ui/onUpdateUser').updateIdpRelationships(object);require('roles/conditionalRoles').updateConditionalGrantsForUser(object, 'roles');require('ui/onUpdateUser').createNotification(object, oldObject);require('ui/lastChanged').updateLastChanged(object);"},"onDelete":{"type":"text/javascript","file":"ui/onDelete-user-cleanup.js"},"postCreate":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"postUpdate":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"postDelete":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"actions":{"resetPassword":{"type":"text/javascript","source":"require('ui/resetPassword').sendMail(object);"}},"schema":{"$schema":"http://forgerock.org/json-schema#","type":"object","title":"User","viewable":true,"id":"urn:jsonschema:org:forgerock:openidm:managed:api:User","description":"","icon":"fa-user","properties":{"_id":{"description":"User ID","type":"string","viewable":false,"searchable":false,"userEditable":false,"usageDescription":"","isPersonal":false,"policies":[{"policyId":"cannot-contain-characters","params":{"forbiddenChars":["/"]}}]},"userName":{"title":"Username","description":"Username","viewable":true,"type":"string","searchable":true,"userEditable":true,"minLength":1,"usageDescription":"","isPersonal":true,"policies":[{"policyId":"unique"},{"policyId":"no-internal-user-conflict"},{"policyId":"cannot-contain-characters","params":{"forbiddenChars":"*()&!%;/"}}]},"password":{"title":"Password","description":"Password","type":"string","viewable":false,"searchable":false,"minLength":8,"userEditable":true,"encryption":{"key":"openidm-sym-default"},"scope":"private","isProtected":true,"usageDescription":"","isPersonal":false,"policies":[{"policyId":"at-least-X-capitals","params":{"numCaps":1}},{"policyId":"at-least-X-numbers","params":{"numNums":1}},{"policyId":"cannot-contain-others","params":{"disallowedFields":["userName","givenName","sn"]}},{"policyId":"maximum-length","params":{"maxLength":"256"}},{"policyId":"password-blacklisted","params":{"filePath":"conf/blacklist.txt"}}]},"givenName":{"title":"First Name","description":"First Name","viewable":true,"type":"string","searchable":true,"userEditable":true,"usageDescription":"","isPersonal":true},"sn":{"title":"Last Name","description":"Last Name","viewable":true,"type":"string","searchable":true,"userEditable":true,"usageDescription":"","isPersonal":true},"mail":{"title":"Email Address","description":"Email Address","viewable":true,"type":"string","searchable":true,"userEditable":true,"usageDescription":"","isPersonal":true,"policies":[{"policyId":"valid-email-address-format"},{"policyId":"cannot-contain-characters","params":{"forbiddenChars":"*()&!%;/"}}]},"description":{"title":"Description","description":"Description","viewable":true,"type":"string","searchable":true,"userEditable":true,"usageDescription":"","isPersonal":false},"accountStatus":{"title":"Status","description":"Status","viewable":true,"type":"string","searchable":true,"userEditable":false,"usageDescription":"","isPersonal":false},"telephoneNumber":{"type":"string","title":"Mobile Phone","description":"Mobile Phone","viewable":true,"userEditable":true,"pattern":"^\\\\+?([0-9\\\\- \\\\(\\\\)])*$","usageDescription":"","isPersonal":true},"postalAddress":{"type":"string","title":"Address 1","description":"Address 1","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":true},"address2":{"type":"string","title":"Address 2","description":"Address 2","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":true},"city":{"type":"string","title":"City","description":"City","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":false},"postalCode":{"type":"string","title":"Postal Code","description":"Postal Code","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":false},"country":{"type":"string","title":"Country","description":"Country","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":false},"stateProvince":{"type":"string","title":"State/Province","description":"State/Province","viewable":true,"userEditable":true,"usageDescription":"","isPersonal":false},"roles":{"description":"Provisioning Roles","title":"Provisioning Roles","id":"urn:jsonschema:org:forgerock:openidm:managed:api:User:roles","viewable":true,"userEditable":false,"returnByDefault":false,"usageDescription":"","isPersonal":false,"type":"array","items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:User:roles:items","title":"Provisioning Roles Items","reverseRelationship":true,"reversePropertyName":"members","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Provisioning Roles Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"},"_grantType":{"description":"Grant Type","type":"string","label":"Grant Type"}}}},"resourceCollection":[{"path":"managed/role","label":"Role","query":{"queryFilter":"true","fields":["name"]}}]}},"manager":{"type":"relationship","validate":true,"reverseRelationship":true,"reversePropertyName":"reports","description":"Manager","title":"Manager","viewable":true,"searchable":false,"usageDescription":"","isPersonal":false,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Manager _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"managed/user","label":"User","query":{"queryFilter":"true","fields":["userName","givenName","sn"]}}],"userEditable":false},"authzRoles":{"description":"Authorization Roles","title":"Authorization Roles","id":"urn:jsonschema:org:forgerock:openidm:managed:api:User:authzRoles","viewable":true,"type":"array","userEditable":false,"returnByDefault":false,"usageDescription":"","isPersonal":false,"items":{"type":"relationship","title":"Authorization Roles Items","id":"urn:jsonschema:org:forgerock:openidm:managed:api:User:authzRoles:items","reverseRelationship":true,"reversePropertyName":"authzMembers","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Authorization Roles Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"repo/internal/role","label":"Internal Role","query":{"queryFilter":"true","fields":["_id","description"]}},{"path":"managed/role","label":"Role","query":{"queryFilter":"true","fields":["name"]}}]}},"reports":{"description":"Direct Reports","title":"Direct Reports","viewable":true,"userEditable":false,"type":"array","returnByDefault":false,"usageDescription":"","isPersonal":false,"items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:User:reports:items","title":"Direct Reports Items","reverseRelationship":true,"reversePropertyName":"manager","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Direct Reports Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"managed/user","label":"User","query":{"queryFilter":"true","fields":["userName","givenName","sn"]}}]}},"effectiveRoles":{"type":"array","title":"Effective Roles","description":"Effective Roles","viewable":false,"returnByDefault":true,"isVirtual":true,"usageDescription":"","isPersonal":false,"onRetrieve":{"type":"text/javascript","source":"require('roles/effectiveRoles').calculateEffectiveRoles(object, 'roles');"},"items":{"type":"object","title":"Effective Roles Items"}},"effectiveAssignments":{"type":"array","title":"Effective Assignments","description":"Effective Assignments","viewable":false,"returnByDefault":true,"isVirtual":true,"usageDescription":"","isPersonal":false,"onRetrieve":{"type":"text/javascript","file":"roles/effectiveAssignments.js","effectiveRolesPropName":"effectiveRoles"},"items":{"type":"object","title":"Effective Assignments Items"}},"lastSync":{"description":"Last Sync timestamp","title":"Last Sync timestamp","type":"object","scope":"private","viewable":false,"searchable":false,"usageDescription":"","isPersonal":false,"properties":{"effectiveAssignments":{"description":"Effective Assignments","title":"Effective Assignments","type":"array","items":{"type":"object","title":"Effective Assignments Items"}},"timestamp":{"description":"Timestamp","type":"string"}},"required":[],"order":["effectiveAssignments","timestamp"]},"kbaInfo":{"description":"KBA Info","type":"array","userEditable":true,"viewable":false,"usageDescription":"","isPersonal":true,"items":{"type":"object","title":"KBA Info Items","properties":{"answer":{"description":"Answer","type":"string"},"customQuestion":{"description":"Custom question","type":"string"},"questionId":{"description":"Question ID","type":"string"}},"order":["answer","customQuestion","questionId"],"required":[]}},"preferences":{"title":"Preferences","description":"Preferences","viewable":true,"searchable":false,"userEditable":true,"type":"object","usageDescription":"","isPersonal":false,"properties":{"updates":{"description":"Send me news and updates","type":"boolean"},"marketing":{"description":"Send me special offers and services","type":"boolean"}},"required":[],"order":["updates","marketing"]},"termsAccepted":{"title":"Terms Accepted","type":"object","viewable":false,"searchable":false,"userEditable":true,"usageDescription":"","isPersonal":false,"properties":{"termsVersion":{"title":"","description":"Terms & Conditions Version","type":"string","viewable":true,"userEditable":false},"iso8601date":{"title":"","description":"ISO 8601 Date and time format","type":"string","viewable":true,"userEditable":false}},"order":["termsVersion","iso8601date"],"required":[],"description":"Terms Accepted","returnByDefault":true,"isVirtual":false},"lastChanged":{"title":"Last Changed","type":"object","viewable":false,"searchable":false,"userEditable":false,"usageDescription":"","isPersonal":false,"properties":{"date":{"title":"","description":"Last changed date","type":"string","viewable":true,"searchable":true,"userEditable":true}},"required":["date"],"order":["date"],"description":"Last Changed","returnByDefault":true,"isVirtual":false},"consentedMappings":{"title":"Consented Mappings","description":"Consented Mappings","type":"array","viewable":false,"searchable":false,"userEditable":true,"usageDescription":"","isPersonal":false,"items":{"type":"array","title":"Consented Mappings Items","items":{"type":"object","title":"Consented Mappings Item","properties":{"mapping":{"title":"Mapping","description":"Mapping","type":"string","viewable":true,"searchable":true,"userEditable":true},"consentDate":{"title":"Consent Date","description":"Consent Date","type":"string","viewable":true,"searchable":true,"userEditable":true}},"order":["mapping","consentDate"],"required":["mapping","consentDate"]}},"returnByDefault":false,"isVirtual":false},"sunset":{"title":"Sunset","type":"object","viewable":true,"searchable":false,"userEditable":true,"properties":{"date":{"title":"Date","type":"string","viewable":true,"searchable":true,"userEditable":true}},"order":["date"],"description":"","isVirtual":false,"required":[]},"tacticalPassword":{"title":"Tactical Password (hashed)","type":["string","null"],"viewable":true,"searchable":true,"userEditable":false,"description":"","minLength":"","isVirtual":false,"scope":"private"},"tacticalRoles":{"title":"Tactical roles (comma-separated)","type":["string","null"],"viewable":true,"searchable":true,"userEditable":false,"description":"","minLength":"","isVirtual":false}},"order":["_id","userName","password","givenName","sn","mail","description","accountStatus","telephoneNumber","postalAddress","address2","city","postalCode","country","stateProvince","roles","manager","authzRoles","reports","effectiveRoles","effectiveAssignments","lastSync","kbaInfo","preferences","termsAccepted","lastChanged","consentedMappings","sunset","tacticalPassword","tacticalRoles"],"required":["userName","givenName","sn","mail"]}},{"name":"role","onDelete":{"type":"text/javascript","file":"roles/onDelete-roles.js"},"onSync":{"type":"text/javascript","source":"require('roles/onSync-roles').syncUsersOfRoles(resourceName, oldObject, newObject, ['members']);"},"onCreate":{"type":"text/javascript","source":"require('roles/conditionalRoles').roleCreate(object);"},"onUpdate":{"type":"text/javascript","source":"require('roles/conditionalRoles').roleUpdate(oldObject, object);"},"postCreate":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"postUpdate":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"postDelete":{"type":"text/javascript","file":"roles/postOperation-roles.js"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:managed:api:Role","$schema":"http://forgerock.org/json-schema#","type":"object","title":"Role","icon":"fa-check-square-o","description":"","properties":{"_id":{"description":"Role ID","title":"Name","viewable":false,"searchable":false,"type":"string"},"name":{"description":"The role name, used for display purposes.","title":"Name","viewable":true,"searchable":true,"type":"string"},"description":{"description":"The role description, used for display purposes.","title":"Description","viewable":true,"searchable":true,"type":"string"},"members":{"description":"Role Members","title":"Role Members","viewable":true,"type":"array","returnByDefault":false,"items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:Role:members:items","title":"Role Members Items","reverseRelationship":true,"reversePropertyName":"roles","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Role Members Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"},"_grantType":{"description":"Grant Type","type":"string","label":"Grant Type"}}}},"resourceCollection":[{"path":"managed/user","label":"User","query":{"queryFilter":"true","fields":["userName","givenName","sn"]}}]}},"authzMembers":{"description":"Authorization Role Members","title":"Authorization Role Members","viewable":true,"type":"array","returnByDefault":false,"items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:Role:authzMembers:items","title":"Authorization Role Members Items","reverseRelationship":true,"reversePropertyName":"authzRoles","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Authorization Role Members Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"managed/user","label":"User","query":{"queryFilter":"true","fields":["userName","givenName","sn"]}}]}},"assignments":{"description":"Managed Assignments","title":"Managed Assignments","viewable":true,"returnByDefault":false,"type":"array","items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:Role:assignments:items","title":"Managed Assignments Items","reverseRelationship":true,"reversePropertyName":"roles","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","title":"Managed Assignments Items _refProperties","type":"object","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"managed/assignment","label":"Assignment","query":{"queryFilter":"true","fields":["name"]}}]}},"condition":{"description":"A conditional filter for this role","title":"Condition","viewable":false,"searchable":false,"type":"string"},"temporalConstraints":{"description":"An array of temporal constraints for a role","title":"Temporal Constraints","viewable":false,"returnByDefault":true,"type":"array","items":{"type":"object","title":"Temporal Constraints Items","properties":{"duration":{"description":"Duration","type":"string"}},"required":["duration"],"order":["duration"]}}},"required":["name"],"order":["_id","name","description","assignments","members","condition","temporalConstraints"]}},{"name":"assignment","onSync":{"type":"text/javascript","source":"require('roles/onSync-assignments').syncUsersOfRolesWithAssignment(resourceName, oldObject, newObject, ['roles']);"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:managed:api:Assignment","$schema":"http://forgerock.org/json-schema#","type":"object","title":"Assignment","icon":"fa-key","description":"A role assignment","properties":{"_id":{"description":"The assignment ID","title":"Name","viewable":false,"searchable":false,"type":"string"},"name":{"description":"The assignment name, used for display purposes.","title":"Name","viewable":true,"searchable":true,"type":"string"},"description":{"description":"The assignment description, used for display purposes.","title":"Description","viewable":true,"searchable":true,"type":"string"},"mapping":{"description":"The name of the mapping this assignment applies to","title":"Mapping","viewable":true,"searchable":true,"type":"string","policies":[{"policyId":"mapping-exists"}]},"attributes":{"description":"The attributes operated on by this assignment.","title":"Assignment Attributes","viewable":true,"type":"array","items":{"type":"object","title":"Assignment Attributes Items","properties":{"assignmentOperation":{"description":"Assignment operation","type":"string"},"unassignmentOperation":{"description":"Unassignment operation","type":"string"},"name":{"description":"Name","type":"string"},"value":{"description":"Value","type":"string"}},"order":["assignmentOperation","unassignmentOperation","name","value"],"required":[]}},"linkQualifiers":{"description":"Conditional link qualifiers to restrict this assignment to.","title":"Link Qualifiers","viewable":true,"type":"array","items":{"type":"string","title":"Link Qualifiers Items"}},"roles":{"description":"Managed Roles","title":"Managed Roles","viewable":true,"userEditable":false,"type":"array","returnByDefault":false,"items":{"type":"relationship","id":"urn:jsonschema:org:forgerock:openidm:managed:api:Assignment:roles:items","title":"Managed Roles Items","reverseRelationship":true,"reversePropertyName":"assignments","validate":true,"properties":{"_ref":{"description":"References a relationship from a managed object","type":"string"},"_refProperties":{"description":"Supports metadata within the relationship","type":"object","title":"Managed Roles Items _refProperties","properties":{"_id":{"description":"_refProperties object ID","type":"string"}}}},"resourceCollection":[{"path":"managed/role","label":"Role","query":{"queryFilter":"true","fields":["name"]}}]}}},"required":["name","description","mapping"],"order":["_id","name","description","attributes","linkQualifiers"]}}],"_id":"managed"}}
2	1	org.forgerock.openidm.authentication	1	{"_rev":"1","service__pid":"org.forgerock.openidm.authentication","_id":"org.forgerock.openidm.authentication","jsonconfig":{"serverAuthContext":{"sessionModule":{"name":"JWT_SESSION","properties":{"keyAlias":"&{openidm.https.keystore.cert.alias}","privateKeyPassword":"&{openidm.keystore.password}","keystoreType":"&{openidm.keystore.type}","keystoreFile":"&{openidm.keystore.location}","keystorePassword":"&{openidm.keystore.password}","maxTokenLifeMinutes":"120","tokenIdleTimeMinutes":"30","sessionOnly":true,"isHttpOnly":true}},"authModules":[{"enabled":true,"properties":{"queryOnResource":"managed/user","queryId":"credential-query","defaultUserRoles":[],"augmentSecurityContext":{"type":"text/javascript","globals":{},"source":"require('auth/customAuthz').setProtectedAttributes(security)"},"propertyMapping":{"authenticationId":"username","userCredential":"password","userRoles":"roles"}},"name":"MANAGED_USER"},{"name":"INTERNAL_USER","properties":{"queryId":"credential-internaluser-query","queryOnResource":"repo/internal/user","propertyMapping":{"authenticationId":"username","userCredential":"password","userRoles":"roles"},"defaultUserRoles":[]},"enabled":true},{"name":"CLIENT_CERT","properties":{"queryOnResource":"security/truststore","defaultUserRoles":["openidm-cert"],"allowedAuthenticationIdPatterns":[]},"enabled":true},{"name":"SOCIAL_PROVIDERS","properties":{"defaultUserRoles":["openidm-authorized"],"augmentSecurityContext":{"type":"text/javascript","globals":{},"file":"auth/populateAsManagedUserFromRelationship.js"},"propertyMapping":{"userRoles":"authzRoles"}},"enabled":true}]},"_id":"authentication"}}
3	1	org.forgerock.openidm.cluster	1	{"_rev":"1","service__pid":"org.forgerock.openidm.cluster","_id":"org.forgerock.openidm.cluster","jsonconfig":{"instanceId":"&{openidm.node.id}","instanceTimeout":"30000","instanceRecoveryTimeout":"30000","instanceCheckInInterval":"5000","instanceCheckInOffset":"0","enabled":true,"_id":"cluster"}}
4	1	org.forgerock.openidm.selfservice.01df6cfe-e030-4b3d-a97b-29dfb725f476	0	{"config__factory-pid":"registration","felix__fileinstall__filename":"file:/opt/openidm/conf/selfservice-registration.json","_rev":"0","service__pid":"org.forgerock.openidm.selfservice.01df6cfe-e030-4b3d-a97b-29dfb725f476","_id":"org.forgerock.openidm.selfservice.01df6cfe-e030-4b3d-a97b-29dfb725f476","jsonconfig":{"allInOneRegistration":false,"stageConfigs":[{"name":"idmUserDetails","identityEmailField":"mail","socialRegistrationEnabled":false,"registrationProperties":["userName","givenName","sn","mail"],"identityServiceUrl":"managed/user"},{"name":"emailValidation","identityEmailField":"mail","emailServiceUrl":"external/email","emailServiceParameters":{"waitForCompletion":false},"from":"do_not_reply@hmcts.net","subject":"Register new account","mimeType":"text/html","subjectTranslations":{"en":"Complete your registration request"},"messageTranslations":{"en":"<h1>Activate your account</h1>\\nHello,<br/><br/>\\n\\nPlease click <a href=\\"%link%\\" target=\\"_self\\">here</a> to activate your account.<br/><br/>\\n                                                                \\nThe HMCTS IdAM team.\\n                                                                "},"verificationLinkToken":"%link%","verificationLink":"http://localhost:9002/users/register?"},{"class":"org.forgerock.selfservice.custom.UserInfoConfig","identityServiceUrl":"managed/user"},{"name":"selfRegistration","identityServiceUrl":"managed/user"}],"snapshotToken":{"type":"jwt","jweAlgorithm":"RSAES_PKCS1_V1_5","encryptionMethod":"A128CBC_HS256","jwsAlgorithm":"HS256","tokenExpiry":"172800"},"storage":"stateless","_id":"selfservice/registration"},"service__factoryPid":"org.forgerock.openidm.selfservice"}
6	1	org.forgerock.openidm.endpoint.a8b5220d-3b35-4f9c-a7df-115bac574a4a	0	{"config__factory-pid":"getprocessesforuser","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-getprocessesforuser.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.a8b5220d-3b35-4f9c-a7df-115bac574a4a","_id":"org.forgerock.openidm.endpoint.a8b5220d-3b35-4f9c-a7df-115bac574a4a","jsonconfig":{"type":"text/javascript","file":"workflow/getprocessesforuser.js","_id":"endpoint/getprocessesforuser"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
8	1	org.forgerock.openidm.schedule.9e295777-1688-44a9-82d8-dca00cb4317d	0	{"config__factory-pid":"reconcile-roles","felix__fileinstall__filename":"file:/opt/openidm/conf/schedule-reconcile-roles.json","_rev":"0","service__pid":"org.forgerock.openidm.schedule.9e295777-1688-44a9-82d8-dca00cb4317d","_id":"org.forgerock.openidm.schedule.9e295777-1688-44a9-82d8-dca00cb4317d","jsonconfig":{"enabled":true,"type":"cron","schedule":"0 0 20 * * ?","timezone":"GMT","persisted":true,"invokeService":"sync","invokeContext":{"action":"reconcile","mapping":"managedRole_systemLdapGroup0"},"_id":"schedule/reconcile-roles"},"service__factoryPid":"org.forgerock.openidm.schedule"}
10	1	org.forgerock.openidm.repo.jdbc	1	{"_rev":"1","service__pid":"org.forgerock.openidm.repo.jdbc","_id":"org.forgerock.openidm.repo.jdbc","jsonconfig":{"dbType":"POSTGRESQL","useDataSource":"default","maxBatchSize":100,"maxTxRetry":5,"queries":{"genericTables":{"credential-query":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON objtype.id = obj.objecttypes_id WHERE lower(json_extract_path_text(fullobject, 'userName')) = lower(${username}) AND json_extract_path_text(fullobject, 'accountStatus') = 'active' AND objtype.objecttype = ${_resource}","get-by-field-value":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON objtype.id = obj.objecttypes_id WHERE json_extract_path_text(fullobject, ${field}) = ${value} AND objtype.objecttype = ${_resource}","query-all-ids":"SELECT obj.objectid FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON obj.objecttypes_id = objtype.id WHERE objtype.objecttype = ${_resource} LIMIT ${int:_pageSize} OFFSET ${int:_pagedResultsOffset}","query-all-ids-count":"SELECT COUNT(obj.objectid) AS total FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON obj.objecttypes_id = objtype.id WHERE objtype.objecttype = ${_resource}","query-all":"SELECT obj.fullobject::text FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON obj.objecttypes_id = objtype.id WHERE objtype.objecttype = ${_resource} LIMIT ${int:_pageSize} OFFSET ${int:_pagedResultsOffset}","query-all-count":"SELECT COUNT(obj.fullobject) AS total FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON obj.objecttypes_id = objtype.id WHERE objtype.objecttype = ${_resource}","for-userName":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj INNER JOIN ${_dbSchema}.objecttypes objtype ON objtype.id = obj.objecttypes_id WHERE lower(json_extract_path_text(fullobject, 'userName')) = lower(${uid}) AND objtype.objecttype = ${_resource}","query-cluster-failed-instances":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj WHERE json_extract_path_text(fullobject, 'timestamp') <= ${timestamp} AND json_extract_path_text(fullobject, 'state') IN ('1','2')","query-cluster-instances":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj WHERE json_extract_path_text(fullobject, 'type') = 'state'","query-cluster-events":"SELECT fullobject::text FROM ${_dbSchema}.${_mainTable} obj WHERE json_extract_path_text(fullobject, 'type') = 'event' AND json_extract_path_text(fullobject, 'instanceId') = ${instanceId}","find-relationships-for-resource":"SELECT fullobject::text FROM ${_dbSchema}.relationships obj WHERE (((json_extract_path_text(obj.fullobject, 'firstId') = (${fullResourceId})) AND (json_extract_path_text(obj.fullobject, 'firstPropertyName') = (${resourceFieldName})))) OR (((json_extract_path_text(obj.fullobject, 'secondId') = (${fullResourceId})) AND (json_extract_path_text(obj.fullobject, 'secondPropertyName') = (${resourceFieldName}))))","find-relationship-edges":"SELECT fullobject::text FROM ${_dbSchema}.relationships obj WHERE (((json_extract_path_text(obj.fullobject, 'firstId') = (${vertex1Id})) AND (json_extract_path_text(obj.fullobject, 'firstPropertyName') = (${vertex1FieldName})) AND (json_extract_path_text(obj.fullobject, 'secondId') = (${vertex2Id})) AND (json_extract_path_text(obj.fullobject, 'secondPropertyName') = (${vertex2FieldName}))) OR ((json_extract_path_text(obj.fullobject, 'firstId') = (${vertex2Id})) AND (json_extract_path_text(obj.fullobject, 'firstPropertyName') = (${vertex2FieldName})) AND (json_extract_path_text(obj.fullobject, 'secondId') = (${vertex1Id})) AND (json_extract_path_text(obj.fullobject, 'secondPropertyName') = (${vertex1FieldName}))))"},"explicitTables":{"query-all-ids":"SELECT objectid FROM ${_dbSchema}.${_table}","for-internalcredentials":"select * FROM ${_dbSchema}.${_table} WHERE objectid = ${uid}","get-notifications-for-user":"select * FROM ${_dbSchema}.${_table} WHERE receiverId = ${userId} order by createDate desc","credential-query":"SELECT * FROM ${_dbSchema}.${_table} WHERE objectid = ${username}","credential-internaluser-query":"SELECT objectid, pwd, roles FROM ${_dbSchema}.${_table} WHERE objectid = ${username}","links-for-firstId":"SELECT * FROM ${_dbSchema}.${_table} WHERE linkType = ${linkType} AND firstid = ${firstId}","links-for-linkType":"SELECT * FROM ${_dbSchema}.${_table} WHERE linkType = ${linkType}","query-all":"SELECT * FROM ${_dbSchema}.${_table}","get-recons":"SELECT reconid, activitydate, mapping FROM ${_dbSchema}.${_table} WHERE mapping LIKE ${includeMapping} AND mapping NOT LIKE ${excludeMapping} AND entrytype = 'summary' ORDER BY activitydate DESC"}},"commands":{"genericTables":{},"explicitTables":{"purge-by-recon-ids-to-keep":"DELETE FROM ${_dbSchema}.${_table} WHERE mapping LIKE ${includeMapping} AND mapping NOT LIKE ${excludeMapping} AND reconId NOT IN (${list:reconIds})","purge-by-recon-expired":"DELETE FROM ${_dbSchema}.${_table} WHERE mapping LIKE ${includeMapping} AND mapping NOT LIKE ${excludeMapping} AND activitydate < ${timestamp}","delete-mapping-links":"DELETE FROM ${_dbSchema}.${_table} WHERE linktype = ${mapping}","delete-target-ids-for-recon":"DELETE FROM ${_dbSchema}.${_table} WHERE reconId = ${reconId}"}},"resourceMapping":{"default":{"mainTable":"genericobjects","propertiesTable":"genericobjectproperties","searchableDefault":true},"genericMapping":{"managed/*":{"mainTable":"managedobjects","propertiesTable":"managedobjectproperties","searchableDefault":true},"managed/user":{"mainTable":"managedobjects","propertiesTable":"managedobjectproperties","searchableDefault":false},"scheduler":{"mainTable":"schedulerobjects","propertiesTable":"schedulerobjectproperties","searchableDefault":false},"scheduler/*":{"mainTable":"schedulerobjects","propertiesTable":"schedulerobjectproperties","searchableDefault":false},"cluster":{"mainTable":"clusterobjects","propertiesTable":"clusterobjectproperties","searchableDefault":false},"config":{"mainTable":"configobjects","propertiesTable":"configobjectproperties","searchableDefault":false},"relationships":{"mainTable":"relationships","propertiesTable":"relationshipproperties","searchableDefault":false},"updates":{"mainTable":"updateobjects","propertiesTable":"updateobjectproperties","searchableDefault":false},"reconprogressstate":{"mainTable":"genericobjects","propertiesTable":"genericobjectproperties","searchableDefault":false,"properties":{"/reconId":{"searchable":true},"/startTime":{"searchable":true}}},"jsonstorage":{"mainTable":"genericobjects","propertiesTable":"genericobjectproperties","searchableDefault":false,"properties":{"/timestamp":{"searchable":true}}}},"explicitMapping":{"link":{"table":"links","objectToColumn":{"_id":"objectid","_rev":"rev","linkType":"linktype","firstId":"firstid","secondId":"secondid","linkQualifier":"linkqualifier"}},"ui/notification":{"table":"uinotification","objectToColumn":{"_id":"objectid","_rev":"rev","requester":"requester","requesterId":"requesterId","receiverId":"receiverId","createDate":"createDate","notificationType":"notificationType","notificationSubtype":"notificationSubtype","message":"message"}},"internal/user":{"table":"internaluser","objectToColumn":{"_id":"objectid","_rev":"rev","password":"pwd","roles":{"column":"roles","type":"JSON_LIST"}}},"internal/role":{"table":"internalrole","objectToColumn":{"_id":"objectid","_rev":"rev","description":"description"}},"audit/authentication":{"table":"auditauthentication","objectToColumn":{"_id":"objectid","transactionId":"transactionid","timestamp":"activitydate","userId":"userid","eventName":"eventname","provider":"provider","method":"method","result":"result","principal":{"column":"principals","type":"JSON_LIST"},"context":{"column":"context","type":"JSON_MAP"},"entries":{"column":"entries","type":"JSON_LIST"},"trackingIds":{"column":"trackingids","type":"JSON_LIST"}}},"audit/config":{"table":"auditconfig","objectToColumn":{"_id":"objectid","timestamp":"activitydate","eventName":"eventname","transactionId":"transactionid","userId":"userid","trackingIds":{"column":"trackingids","type":"JSON_LIST"},"runAs":"runas","objectId":"configobjectid","operation":"operation","before":"beforeObject","after":"afterObject","changedFields":{"column":"changedfields","type":"JSON_LIST"},"revision":"rev"}},"audit/activity":{"table":"auditactivity","objectToColumn":{"_id":"objectid","timestamp":"activitydate","eventName":"eventname","transactionId":"transactionid","userId":"userid","trackingIds":{"column":"trackingids","type":"JSON_LIST"},"runAs":"runas","objectId":"activityobjectid","operation":"operation","before":"subjectbefore","after":"subjectafter","changedFields":{"column":"changedfields","type":"JSON_LIST"},"revision":"subjectrev","passwordChanged":"passwordchanged","message":"message","provider":"provider","context":"context","status":"status"}},"audit/recon":{"table":"auditrecon","objectToColumn":{"_id":"objectid","transactionId":"transactionid","timestamp":"activitydate","eventName":"eventname","userId":"userid","trackingIds":{"column":"trackingids","type":"JSON_LIST"},"action":"activity","exception":"exceptiondetail","linkQualifier":"linkqualifier","mapping":"mapping","message":"message","messageDetail":{"column":"messagedetail","type":"JSON_MAP"},"situation":"situation","sourceObjectId":"sourceobjectid","status":"status","targetObjectId":"targetobjectid","reconciling":"reconciling","ambiguousTargetObjectIds":"ambiguoustargetobjectids","reconAction":"reconaction","entryType":"entrytype","reconId":"reconid"}},"audit/sync":{"table":"auditsync","objectToColumn":{"_id":"objectid","transactionId":"transactionid","timestamp":"activitydate","eventName":"eventname","userId":"userid","trackingIds":{"column":"trackingids","type":"JSON_LIST"},"action":"activity","exception":"exceptiondetail","linkQualifier":"linkqualifier","mapping":"mapping","message":"message","messageDetail":{"column":"messagedetail","type":"JSON_MAP"},"situation":"situation","sourceObjectId":"sourceobjectid","status":"status","targetObjectId":"targetobjectid"}},"audit/access":{"table":"auditaccess","objectToColumn":{"_id":"objectid","timestamp":"activitydate","eventName":"eventname","transactionId":"transactionid","userId":"userid","trackingIds":{"column":"trackingids","type":"JSON_LIST"},"server/ip":"server_ip","server/port":"server_port","client/ip":"client_ip","client/port":"client_port","request/protocol":"request_protocol","request/operation":"request_operation","request/detail":{"column":"request_detail","type":"JSON_MAP"},"http/request/secure":"http_request_secure","http/request/method":"http_request_method","http/request/path":"http_request_path","http/request/queryParameters":{"column":"http_request_queryparameters","type":"JSON_MAP"},"http/request/headers":{"column":"http_request_headers","type":"JSON_MAP"},"http/request/cookies":{"column":"http_request_cookies","type":"JSON_MAP"},"http/response/headers":{"column":"http_response_headers","type":"JSON_MAP"},"response/status":"response_status","response/statusCode":"response_statuscode","response/elapsedTime":"response_elapsedtime","response/elapsedTimeUnits":"response_elapsedtimeunits","response/detail":{"column":"response_detail","type":"JSON_MAP"},"roles":"roles"}},"security/keys":{"table":"securitykeys","objectToColumn":{"_id":"objectid","_rev":"rev","keyPair":"keypair"}},"clusteredrecontargetids":{"table":"clusteredrecontargetids","objectToColumn":{"_id":"objectid","_rev":"rev","reconId":"reconid","targetIds":{"column":"targetids","type":"JSON_LIST"}}}}},"_id":"repo.jdbc"}}
11	1	org.forgerock.openidm.ui.context.d2796db5-f915-4d22-b976-8957365c62fa	0	{"config__factory-pid":"api","felix__fileinstall__filename":"file:/opt/openidm/conf/ui.context-api.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.context.d2796db5-f915-4d22-b976-8957365c62fa","_id":"org.forgerock.openidm.ui.context.d2796db5-f915-4d22-b976-8957365c62fa","jsonconfig":{"enabled":true,"urlContextRoot":"/api","defaultDir":"&{launcher.install.location}/ui/api/default","extensionDir":"&{launcher.install.location}/ui/api/extension","_id":"ui.context/api"},"service__factoryPid":"org.forgerock.openidm.ui.context"}
12	1	org.forgerock.openidm.ui.context.factory	3	{"factory__pid":"org.forgerock.openidm.ui.context","factory__pidList":["org.forgerock.openidm.ui.context.207d191d-22f0-45c3-80c3-e1383dfa2c4f","org.forgerock.openidm.ui.context.d2796db5-f915-4d22-b976-8957365c62fa","org.forgerock.openidm.ui.context.caa966f5-5cd8-4582-bf77-3a4e3a1c5f8e","org.forgerock.openidm.ui.context.c2a77b43-8206-4005-a134-c526a2e95069","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"3","_id":"org.forgerock.openidm.ui.context.factory","jsonconfig":null}
5	1	org.forgerock.openidm.selfservice.factory	1	{"factory__pid":"org.forgerock.openidm.selfservice","factory__pidList":["org.forgerock.openidm.selfservice.b61e1b34-5823-4d8d-bdd8-da96ac9458f6","org.forgerock.openidm.selfservice.01df6cfe-e030-4b3d-a97b-29dfb725f476","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"1","_id":"org.forgerock.openidm.selfservice.factory","jsonconfig":null}
9	1	org.forgerock.openidm.schedule.factory	2	{"factory__pid":"org.forgerock.openidm.schedule","factory__pidList":["org.forgerock.openidm.schedule.9e295777-1688-44a9-82d8-dca00cb4317d","org.forgerock.openidm.schedule.832d9581-d9ae-4736-aa63-ad87e830d32a","org.forgerock.openidm.schedule.7eb4c308-dfb8-4814-95a6-a6eeecf006c6","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"2","_id":"org.forgerock.openidm.schedule.factory","jsonconfig":null}
13	1	org.forgerock.openidm.selfservice.propertymap	1	{"_rev":"1","service__pid":"org.forgerock.openidm.selfservice.propertymap","_id":"org.forgerock.openidm.selfservice.propertymap","jsonconfig":{"properties":[{"source":"givenName","target":"givenName"},{"source":"familyName","target":"sn"},{"source":"email","target":"mail"},{"source":"postalAddress","target":"postalAddress","condition":"/object/postalAddress  pr"},{"source":"addressLocality","target":"city","condition":"/object/addressLocality  pr"},{"source":"addressRegion","target":"stateProvince","condition":"/object/addressRegion  pr"},{"source":"postalCode","target":"postalCode","condition":"/object/postalCode  pr"},{"source":"country","target":"country","condition":"/object/country  pr"},{"source":"phone","target":"telephoneNumber","condition":"/object/phone  pr"},{"source":"username","target":"userName"}],"_id":"selfservice.propertymap"}}
14	1	org.forgerock.openidm.metrics	1	{"_rev":"1","service__pid":"org.forgerock.openidm.metrics","_id":"org.forgerock.openidm.metrics","jsonconfig":{"enabled":false,"_id":"metrics"}}
15	1	org.forgerock.openidm.endpoint.601e78e1-11b1-46a5-b356-900c4d47940f	0	{"config__factory-pid":"getavailableuserstoassign","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-getavailableuserstoassign.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.601e78e1-11b1-46a5-b356-900c4d47940f","_id":"org.forgerock.openidm.endpoint.601e78e1-11b1-46a5-b356-900c4d47940f","jsonconfig":{"type":"text/javascript","file":"workflow/getavailableuserstoassign.js","_id":"endpoint/getavailableuserstoassign"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
16	1	org.forgerock.openidm.endpoint.52e65bdd-5982-477d-9a8c-af6077b004d2	0	{"config__factory-pid":"gettasksview","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-gettasksview.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.52e65bdd-5982-477d-9a8c-af6077b004d2","_id":"org.forgerock.openidm.endpoint.52e65bdd-5982-477d-9a8c-af6077b004d2","jsonconfig":{"type":"text/javascript","file":"workflow/gettasksview.js","_id":"endpoint/gettasksview"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
17	1	org.forgerock.openidm.servletfilter.cc742f00-3aa1-4469-a633-693534d9e779	0	{"config__factory-pid":"cors","felix__fileinstall__filename":"file:/opt/openidm/conf/servletfilter-cors.json","_rev":"0","service__pid":"org.forgerock.openidm.servletfilter.cc742f00-3aa1-4469-a633-693534d9e779","_id":"org.forgerock.openidm.servletfilter.cc742f00-3aa1-4469-a633-693534d9e779","jsonconfig":{"classPathURLs":[],"systemProperties":{},"requestAttributes":{},"scriptExtensions":{},"initParams":{"allowedOrigins":"https://localhost:&{openidm.port.https}","allowedMethods":"GET,POST,PUT,DELETE,PATCH","allowedHeaders":"accept,x-openidm-password,x-openidm-nosession,x-openidm-username,content-type,origin,x-requested-with","allowCredentials":"true","chainPreflight":"false"},"urlPatterns":["/*"],"filterClass":"org.eclipse.jetty.servlets.CrossOriginFilter","_id":"servletfilter/cors"},"service__factoryPid":"org.forgerock.openidm.servletfilter"}
19	1	org.forgerock.openidm.process.f8ad846f-d54a-414a-bc6b-6382d7a09d74	0	{"config__factory-pid":"access","felix__fileinstall__filename":"file:/opt/openidm/conf/process-access.json","_rev":"0","service__pid":"org.forgerock.openidm.process.f8ad846f-d54a-414a-bc6b-6382d7a09d74","_id":"org.forgerock.openidm.process.f8ad846f-d54a-414a-bc6b-6382d7a09d74","jsonconfig":{"workflowAccess":[{"propertiesCheck":{"property":"_id","matches":".*","requiresRole":"openidm-authorized"}},{"propertiesCheck":{"property":"_id","matches":".*","requiresRole":"openidm-admin"}}],"_id":"process/access"},"service__factoryPid":"org.forgerock.openidm.process"}
20	1	org.forgerock.openidm.process.factory	0	{"factory__pid":"org.forgerock.openidm.process","factory__pidList":["org.forgerock.openidm.process.f8ad846f-d54a-414a-bc6b-6382d7a09d74","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"0","_id":"org.forgerock.openidm.process.factory","jsonconfig":null}
21	1	org.forgerock.openidm.felix.webconsole	1	{"_rev":"1","service__pid":"org.forgerock.openidm.felix.webconsole","_id":"org.forgerock.openidm.felix.webconsole","jsonconfig":{"username":"admin","password":{"$crypto":{"type":"x-simple-encryption","value":{"cipher":"AES/CBC/PKCS5Padding","salt":"6rWQ+w5aFyfz01VyDGqQag==","data":"ofVg6er2fxzbDH6A2Asb7A==","iv":"M0rdVRJ28u40EnQ5L/kINQ==","key":"openidm-sym-default","mac":"+nC/vbOefNjNONWb967TZw=="}}},"_id":"felix.webconsole"}}
22	1	org.forgerock.openidm.selfservice.kba	1	{"_rev":"1","service__pid":"org.forgerock.openidm.selfservice.kba","_id":"org.forgerock.openidm.selfservice.kba","jsonconfig":{"kbaPropertyName":"kbaInfo","minimumAnswersToDefine":2,"minimumAnswersToVerify":1,"questions":{"1":{"en":"What's your favorite color?","en_GB":"What is your favourite colour?","fr":"Quelle est votre couleur préférée?"},"2":{"en":"Who was your first employer?"}},"_id":"selfservice.kba"}}
41	1	org.forgerock.openidm.emailTemplate.8b230c01-5808-4de9-8807-605f3e5c415b	0	{"config__factory-pid":"welcome","felix__fileinstall__filename":"file:/opt/openidm/conf/emailTemplate-welcome.json","_rev":"0","service__pid":"org.forgerock.openidm.emailTemplate.8b230c01-5808-4de9-8807-605f3e5c415b","_id":"org.forgerock.openidm.emailTemplate.8b230c01-5808-4de9-8807-605f3e5c415b","jsonconfig":{"enabled":false,"from":"","subject":{"en":"Your account has been created"},"message":{"en":"<html><body><html><body><p>Welcome to OpenIDM. Your username is '{{object.userName}}'.</p></body></html></body></html>"},"defaultLocale":"en","_id":"emailTemplate/welcome"},"service__factoryPid":"org.forgerock.openidm.emailTemplate"}
43	1	org.forgerock.openidm.endpoint.2bc5fef9-5b31-4d03-998f-f0eeafae3871	0	{"config__factory-pid":"oauthproxy","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-oauthproxy.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.2bc5fef9-5b31-4d03-998f-f0eeafae3871","_id":"org.forgerock.openidm.endpoint.2bc5fef9-5b31-4d03-998f-f0eeafae3871","jsonconfig":{"context":"endpoint/oauthproxy","type":"text/javascript","file":"ui/oauthProxy.js","_id":"endpoint/oauthproxy"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
18	1	org.forgerock.openidm.servletfilter.factory	1	{"factory__pid":"org.forgerock.openidm.servletfilter","factory__pidList":["org.forgerock.openidm.servletfilter.cc742f00-3aa1-4469-a633-693534d9e779","org.forgerock.openidm.servletfilter.d180ed1f-7c1a-42ac-8b0d-4b104f72176a","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"1","_id":"org.forgerock.openidm.servletfilter.factory","jsonconfig":null}
44	1	org.forgerock.openidm.servletfilter.d180ed1f-7c1a-42ac-8b0d-4b104f72176a	0	{"config__factory-pid":"gzip","felix__fileinstall__filename":"file:/opt/openidm/conf/servletfilter-gzip.json","_rev":"0","service__pid":"org.forgerock.openidm.servletfilter.d180ed1f-7c1a-42ac-8b0d-4b104f72176a","_id":"org.forgerock.openidm.servletfilter.d180ed1f-7c1a-42ac-8b0d-4b104f72176a","jsonconfig":{"classPathURLs":[],"systemProperties":{},"requestAttributes":{},"initParams":{},"scriptExtensions":{},"urlPatterns":["/*"],"filterClass":"org.eclipse.jetty.servlets.GzipFilter","_id":"servletfilter/gzip"},"service__factoryPid":"org.forgerock.openidm.servletfilter"}
23	1	org.forgerock.openidm.sync	1	{"_rev":"1","service__pid":"org.forgerock.openidm.sync","_id":"org.forgerock.openidm.sync","jsonconfig":{"mappings":[{"target":"system/ldap/account","source":"managed/user","name":"managedUser_systemLdapAccount","properties":[{"target":"givenName","source":"givenName"},{"target":"sn","source":"sn"},{"target":"cn","transform":{"type":"text/javascript","globals":{},"source":"source.displayName || (source.givenName + ' ' + source.sn)"},"source":""},{"target":"uid","source":"userName"},{"target":"mail","source":"mail"},{"target":"userPassword","transform":{"type":"text/javascript","globals":{},"source":"openidm.decrypt(source)"},"source":"password","condition":{"type":"text/javascript","globals":{},"source":"object.password != null"}},{"target":"userPassword","source":"tacticalPassword","transform":{"type":"text/javascript","globals":{},"source":"\\"{BCRYPT}\\" + source"},"condition":{"type":"text/javascript","globals":{},"source":"(object.password == null && object.tacticalPassword != null)"}},{"target":"dn","source":"userName","transform":{"type":"text/javascript","globals":{},"source":"username = source.replace(/[\\\\,\\\\+\\\\=\\\\;\\\\/]/g, \\"\\\\\\\\\\\\$&\\");\\nusername = username.replace(/[%]/g, \\"%25\\");\\n\\"uid=\\" + username + \\",ou=people,dc=reform,dc=hmcts,dc=net\\""}},{"target":"inetUserStatus","source":"accountStatus"}],"policies":[{"action":"EXCEPTION","situation":"AMBIGUOUS"},{"action":"DELETE","situation":"SOURCE_MISSING"},{"action":"UNLINK","situation":"MISSING"},{"action":"EXCEPTION","situation":"FOUND_ALREADY_LINKED"},{"action":"DELETE","situation":"UNQUALIFIED"},{"action":"EXCEPTION","situation":"UNASSIGNED"},{"action":"EXCEPTION","situation":"LINK_ONLY"},{"action":"IGNORE","situation":"TARGET_IGNORED"},{"action":"IGNORE","situation":"SOURCE_IGNORED"},{"action":"IGNORE","situation":"ALL_GONE"},{"action":"UPDATE","situation":"CONFIRMED"},{"action":"UPDATE","situation":"FOUND"},{"action":"CREATE","situation":"ABSENT"}],"enableSync":true,"correlationQuery":[{"linkQualifier":"default","type":"text/javascript","globals":{},"source":"var map = {'_queryFilter': 'uid eq \\\\\\"' + source.userName + '\\\\\\"'}; map;\\n"}]},{"target":"system/ldap/group","source":"managed/role","name":"managedRole_systemLdapGroup0","properties":[{"target":"dn","transform":{"type":"text/javascript","globals":{},"source":"\\"cn=\\" + source.name + \\",ou=groups,dc=reform,dc=hmcts,dc=net\\""},"source":""},{"target":"cn","transform":{"type":"text/javascript","globals":{},"source":"source.name"},"source":""}],"policies":[{"action":"EXCEPTION","situation":"AMBIGUOUS"},{"action":"DELETE","situation":"SOURCE_MISSING"},{"action":"CREATE","situation":"MISSING"},{"action":"EXCEPTION","situation":"FOUND_ALREADY_LINKED"},{"action":"DELETE","situation":"UNQUALIFIED"},{"action":"EXCEPTION","situation":"UNASSIGNED"},{"action":"EXCEPTION","situation":"LINK_ONLY"},{"action":"IGNORE","situation":"TARGET_IGNORED"},{"action":"IGNORE","situation":"SOURCE_IGNORED"},{"action":"IGNORE","situation":"ALL_GONE"},{"action":"UPDATE","situation":"CONFIRMED"},{"action":"UPDATE","situation":"FOUND"},{"action":"CREATE","situation":"ABSENT"}],"correlationQuery":[{"linkQualifier":"default","expressionTree":{"any":["dn","cn"]},"mapping":"managedRole_systemLdapGroup0","type":"text/javascript","file":"ui/correlateTreeToQueryFilter.js"}]},{"target":"managed/user","source":"system/CsvTacticalUsers/RegisteredUser","name":"TacticalUser__managedUser","icon":null,"properties":[{"target":"_id","source":"__UID__"},{"target":"userName","source":"","transform":{"type":"text/javascript","globals":{},"source":"if (source.pin != null) { \\n  source.pin; \\n} else { \\n  source.email; \\n}"}},{"target":"tacticalPassword","source":"","transform":{"type":"text/javascript","globals":{},"source":"if (source.pin != null && source.password == null) { \\n  \\"$2a$12$WBqkE.0Fk80hlY0WPp0HF.XnYppE7qEOccR4gw4sFoLCsVicwzFFO\\"; \\n} else {\\n  source.password; \\n}"}},{"target":"tacticalRoles","source":"roles"},{"target":"givenName","source":"forename"},{"target":"sn","source":"surname"},{"target":"accountStatus","source":"enabled","transform":{"type":"text/javascript","globals":{},"source":"if (source == \\"f\\") { \\n  \\"inactive\\"; \\n} else { \\n  \\"active\\"; \\n}"}},{"target":"mail","transform":{"type":"text/javascript","globals":{},"source":"if (source.pin != null) { \\n  var firstName = source.forename; \\n  var lastName = source.surname; \\n  var pin = source.pin; \\n  \\"${firstName}.${lastName}@${pin}.idampin\\"\\n    .replace(\\"${firstName}\\", firstName)\\n    .replace(\\"${lastName}\\", lastName)\\n    .replace(\\"${pin}\\", pin); \\n} else { \\n  source.email; \\n}"},"source":""},{"target":"sunset","source":"","transform":{"type":"text/javascript","globals":{},"source":"var sunset = {};\\nif (source.pin != null) { \\n  var expirationDate = new Date(); \\n  expirationDate.setSeconds(expirationDate.getSeconds() + 1728000); \\n  sunset = {\\"date\\" : expirationDate.toISOString()};\\n  \\n} \\nsunset;"}}],"policies":[{"action":"EXCEPTION","situation":"AMBIGUOUS"},{"action":"EXCEPTION","situation":"SOURCE_MISSING"},{"action":"CREATE","situation":"MISSING"},{"action":"EXCEPTION","situation":"FOUND_ALREADY_LINKED"},{"action":"EXCEPTION","situation":"UNQUALIFIED"},{"action":"EXCEPTION","situation":"UNASSIGNED"},{"action":"IGNORE","situation":"LINK_ONLY"},{"action":"IGNORE","situation":"TARGET_IGNORED"},{"action":"IGNORE","situation":"SOURCE_IGNORED"},{"action":"IGNORE","situation":"ALL_GONE"},{"action":"UPDATE","situation":"CONFIRMED"},{"action":"UPDATE","situation":"FOUND"},{"action":"CREATE","situation":"ABSENT"}],"enableSync":false}],"_id":"sync"}}
24	1	org.forgerock.openidm.ui.f4a3a484-d582-4f24-ac36-43a0f0039866	0	{"config__factory-pid":"themeconfig","felix__fileinstall__filename":"file:/opt/openidm/conf/ui-themeconfig.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.f4a3a484-d582-4f24-ac36-43a0f0039866","_id":"org.forgerock.openidm.ui.f4a3a484-d582-4f24-ac36-43a0f0039866","jsonconfig":{"icon":"favicon.ico","path":"","stylesheets":["css/bootstrap-3.3.5-custom.css","css/structure.css","css/theme.css"],"settings":{"logo":{"src":"images/logo-horizontal.png","title":"ForgeRock","alt":"ForgeRock"},"loginLogo":{"src":"images/login-logo.png","title":"ForgeRock","alt":"ForgeRock","height":"104px","width":"210px"},"footer":{"mailto":"info@forgerock.com"}},"_id":"ui/themeconfig"},"service__factoryPid":"org.forgerock.openidm.ui"}
26	1	org.forgerock.openidm.scheduler	1	{"_rev":"1","service__pid":"org.forgerock.openidm.scheduler","_id":"org.forgerock.openidm.scheduler","jsonconfig":{"threadPool":{"threadCount":"10"},"scheduler":{"executePersistentSchedules":"&{openidm.scheduler.execute.persistent.schedules}"},"_id":"scheduler"}}
27	1	org.forgerock.openidm.endpoint.a8bb1458-4286-4f0b-8101-600f2006b3ba	0	{"config__factory-pid":"reconResults","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-reconResults.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.a8bb1458-4286-4f0b-8101-600f2006b3ba","_id":"org.forgerock.openidm.endpoint.a8bb1458-4286-4f0b-8101-600f2006b3ba","jsonconfig":{"type":"text/javascript","context":"endpoint/reconResults","file":"ui/reconResults.js","_id":"endpoint/reconResults"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
28	1	org.forgerock.openidm.ui.context.207d191d-22f0-45c3-80c3-e1383dfa2c4f	0	{"config__factory-pid":"selfservice","felix__fileinstall__filename":"file:/opt/openidm/conf/ui.context-selfservice.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.context.207d191d-22f0-45c3-80c3-e1383dfa2c4f","_id":"org.forgerock.openidm.ui.context.207d191d-22f0-45c3-80c3-e1383dfa2c4f","jsonconfig":{"enabled":true,"urlContextRoot":"/","defaultDir":"&{launcher.install.location}/ui/selfservice/default","extensionDir":"&{launcher.install.location}/ui/selfservice/extension","responseHeaders":{"X-Frame-Options":"DENY"},"_id":"ui.context/selfservice"},"service__factoryPid":"org.forgerock.openidm.ui.context"}
29	1	org.forgerock.openidm.ui.d0b71f50-f715-49c3-82a7-c38734859a03	0	{"config__factory-pid":"configuration","felix__fileinstall__filename":"file:/opt/openidm/conf/ui-configuration.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.d0b71f50-f715-49c3-82a7-c38734859a03","_id":"org.forgerock.openidm.ui.d0b71f50-f715-49c3-82a7-c38734859a03","jsonconfig":{"configuration":{"selfRegistration":true,"passwordReset":true,"forgotUsername":false,"lang":"en","passwordResetLink":"","roles":{"openidm-authorized":"ui-user","openidm-admin":"ui-admin"},"notificationTypes":{"info":{"name":"common.notification.types.info","iconPath":"images/notifications/info.png"},"warning":{"name":"common.notification.types.warning","iconPath":"images/notifications/warning.png"},"error":{"name":"common.notification.types.error","iconPath":"images/notifications/error.png"}},"defaultNotificationType":"info","kbaDefinitionEnabled":true,"kbaEnabled":true},"_id":"ui/configuration"},"service__factoryPid":"org.forgerock.openidm.ui"}
30	1	org.forgerock.openidm.info.bf2b6da5-3dae-4d16-8bad-95f49d9b9890	0	{"config__factory-pid":"uiconfig","felix__fileinstall__filename":"file:/opt/openidm/conf/info-uiconfig.json","_rev":"0","service__pid":"org.forgerock.openidm.info.bf2b6da5-3dae-4d16-8bad-95f49d9b9890","_id":"org.forgerock.openidm.info.bf2b6da5-3dae-4d16-8bad-95f49d9b9890","jsonconfig":{"file":"info/uiconfig.js","type":"text/javascript","apiDescription":{"title":"Information","description":"Service that provides OpenIDM UI information.","mvccSupported":false,"read":{"description":"Provides the UI configuration of this OpenIDM instance."},"resourceSchema":{"title":"UI Info","type":"object","required":["configuration"],"properties":{"configuration":{"type":"object","title":"OpenIDM UI configuration","required":["selfRegistration","passwordReset","forgottenUsername","roles","notificationTypes","defaultNotificationType"],"properties":{"selfRegistration":{"type":"boolean","description":"Whether self-registration is enabled"},"passwordReset":{"type":"boolean","description":"Whether password reset is enabled"},"forgottenUsername":{"type":"boolean","description":"Whether forgotten username is enabled"},"lang":{"type":"string","description":"The user-agent requested language, or default language if not supplied"},"passwordResetLink":{"type":"string","description":"Link to an external application that can perform password reset"},"roles":{"type":"object","title":"Maps OpenIDM users' authzRoles to UI roles"},"notificationTypes":{"type":"object","title":"Configuration for UI notification icons","required":["info","warning","error"],"properties":{"info":{"type":"object","title":"Information notification","required":["name","iconPath"],"properties":{"name":{"type":"string","description":"The translation key for the notification text"},"iconPath":{"type":"string","description":"The path to the notification icon"}}},"warning":{"type":"object","title":"Warning notification","required":["name","iconPath"],"properties":{"name":{"type":"string","description":"The translation key for the notification text"},"iconPath":{"type":"string","description":"The path to the notification icon"}}},"error":{"type":"object","title":"Error notification","required":["name","iconPath"],"properties":{"name":{"type":"string","description":"The translation key for the notification text"},"iconPath":{"type":"string","description":"The path to the notification icon"}}}}},"defaultNotificationType":{"type":"object","description":"The default notification type"}}}}}},"_id":"info/uiconfig"},"service__factoryPid":"org.forgerock.openidm.info"}
42	1	org.forgerock.openidm.emailTemplate.factory	1	{"factory__pid":"org.forgerock.openidm.emailTemplate","factory__pidList":["org.forgerock.openidm.emailTemplate.7e21bcdc-e079-4d20-b004-27de218c8e19","org.forgerock.openidm.emailTemplate.8b230c01-5808-4de9-8807-605f3e5c415b","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"1","_id":"org.forgerock.openidm.emailTemplate.factory","jsonconfig":null}
25	1	org.forgerock.openidm.ui.factory	3	{"factory__pid":"org.forgerock.openidm.ui","factory__pidList":["org.forgerock.openidm.ui.f4a3a484-d582-4f24-ac36-43a0f0039866","org.forgerock.openidm.ui.d0b71f50-f715-49c3-82a7-c38734859a03","org.forgerock.openidm.ui.8a2fd12d-5c33-4d1e-86c6-54b75f73e15d","org.forgerock.openidm.ui.172f1099-94c9-423e-ae40-03df70a5f672","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"3","_id":"org.forgerock.openidm.ui.factory","jsonconfig":null}
32	1	org.forgerock.openidm.info.25633d08-9464-497f-b838-b84bb35416c9	0	{"config__factory-pid":"login","felix__fileinstall__filename":"file:/opt/openidm/conf/info-login.json","_rev":"0","service__pid":"org.forgerock.openidm.info.25633d08-9464-497f-b838-b84bb35416c9","_id":"org.forgerock.openidm.info.25633d08-9464-497f-b838-b84bb35416c9","jsonconfig":{"file":"info/login.js","type":"text/javascript","apiDescription":{"title":"Information","description":"Service that provides information about an authenticated account.","mvccSupported":false,"read":{"description":"Provides authentication and authorization details, for the authenticated caller (e.g., User)."},"resourceSchema":{"title":"Auth Info","type":"object","required":["authorization","authenticationId"],"properties":{"authorization":{"type":"object","title":"Authorization","description":"Authorization details","required":["component","roles","ipAddress","id","moduleId"],"properties":{"component":{"type":"string","description":"Resource path (e.g., repo/internal/user)"},"roles":{"type":"array","items":{"type":"string"},"description":"Roles"},"ipAddress":{"type":"string","description":"Client IP Address"},"id":{"type":"string","description":"Resource ID (e.g., User ID)"},"moduleId":{"type":"string","description":"Auth Module ID","enum":["JWT_SESSION","OPENAM_SESSION","CLIENT_CERT","DELEGATED","MANAGED_USER","INTERNAL_USER","STATIC_USER","PASSTHROUGH","IWA","SOCIAL_PROVIDERS","OAUTH_CLIENT","TRUSTED_ATTRIBUTE"],"enum_titles":["JSON Web Token Session","OpenAM Session","Client Certificate","Delegated","Managed User","Internal User","Static User","Passthrough","Integrated Windows Authentication","Social Providers","Single OAuth Client","Trusted Attribute"]}}},"authenticationId":{"type":"string","description":"Resource ID (e.g., User ID)"}}}},"_id":"info/login"},"service__factoryPid":"org.forgerock.openidm.info"}
33	1	org.forgerock.openidm.datasource.jdbc.47095bd4-dcb9-457d-95f4-41d75d833140	0	{"config__factory-pid":"default","felix__fileinstall__filename":"file:/opt/openidm/conf/datasource.jdbc-default.json","_rev":"0","service__pid":"org.forgerock.openidm.datasource.jdbc.47095bd4-dcb9-457d-95f4-41d75d833140","_id":"org.forgerock.openidm.datasource.jdbc.47095bd4-dcb9-457d-95f4-41d75d833140","jsonconfig":{"driverClass":"org.postgresql.Driver","jdbcUrl":"jdbc:postgresql://shared-db:5432/openidm","databaseName":"openidm","username":"openidm","password":{"$crypto":{"type":"x-simple-encryption","value":{"cipher":"AES/CBC/PKCS5Padding","salt":"mYvOTSMQrsE+pf59sv3H+A==","data":"eHEvlAd0EdeiB9gC7UbgUw==","iv":"JnQ4I17VP9HTXjMCiBYV9Q==","key":"openidm-sym-default","mac":"QOft2ptPGbaF/eDKi9t5Tw=="}}},"connectionTimeout":30000,"connectionPool":{"type":"hikari","minimumIdle":20,"maximumPoolSize":50},"_id":"datasource.jdbc/default"},"service__factoryPid":"org.forgerock.openidm.datasource.jdbc"}
34	1	org.forgerock.openidm.datasource.jdbc.factory	0	{"factory__pid":"org.forgerock.openidm.datasource.jdbc","factory__pidList":["org.forgerock.openidm.datasource.jdbc.47095bd4-dcb9-457d-95f4-41d75d833140","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"0","_id":"org.forgerock.openidm.datasource.jdbc.factory","jsonconfig":null}
35	1	org.forgerock.openidm.info.4ba76273-40ff-44bf-8307-8d5e1b29b08c	0	{"config__factory-pid":"version","felix__fileinstall__filename":"file:/opt/openidm/conf/info-version.json","_rev":"0","service__pid":"org.forgerock.openidm.info.4ba76273-40ff-44bf-8307-8d5e1b29b08c","_id":"org.forgerock.openidm.info.4ba76273-40ff-44bf-8307-8d5e1b29b08c","jsonconfig":{"file":"info/version.js","type":"text/javascript","apiDescription":{"title":"Information","description":"Service that provides OpenIDM version information.","mvccSupported":false,"read":{"description":"Provides the software version of this OpenIDM instance."},"resourceSchema":{"title":"Version Info","type":"object","required":["productVersion","productRevision"],"properties":{"productVersion":{"type":"string","description":"OpenIDM version number"},"productRevision":{"type":"string","description":"OpenIDM source-code revision","default":"unknown"}}}},"_id":"info/version"},"service__factoryPid":"org.forgerock.openidm.info"}
36	1	org.forgerock.openidm.jsonstore	1	{"_rev":"1","service__pid":"org.forgerock.openidm.jsonstore","_id":"org.forgerock.openidm.jsonstore","jsonconfig":{"cleanupDwellSeconds":3600,"entryExpireSeconds":1800,"_id":"jsonstore"}}
37	1	org.forgerock.openidm.endpoint.5a6f7be3-e04d-4a18-928f-e0532b2d5d76	0	{"config__factory-pid":"usernotifications","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-usernotifications.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.5a6f7be3-e04d-4a18-928f-e0532b2d5d76","_id":"org.forgerock.openidm.endpoint.5a6f7be3-e04d-4a18-928f-e0532b2d5d76","jsonconfig":{"type":"text/javascript","file":"ui/notification/userNotifications.js","_id":"endpoint/usernotifications"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
38	1	org.forgerock.openidm.schedule.7eb4c308-dfb8-4814-95a6-a6eeecf006c6	0	{"config__factory-pid":"reconcile-accounts","felix__fileinstall__filename":"file:/opt/openidm/conf/schedule-reconcile-accounts.json","_rev":"0","service__pid":"org.forgerock.openidm.schedule.7eb4c308-dfb8-4814-95a6-a6eeecf006c6","_id":"org.forgerock.openidm.schedule.7eb4c308-dfb8-4814-95a6-a6eeecf006c6","jsonconfig":{"enabled":true,"type":"cron","schedule":"0 0 22 * * ?","timezone":"GMT","persisted":true,"invokeService":"sync","invokeContext":{"action":"reconcile","mapping":"managedUser_systemLdapAccount"},"_id":"schedule/reconcile-accounts"},"service__factoryPid":"org.forgerock.openidm.schedule"}
39	1	org.forgerock.openidm.ui.172f1099-94c9-423e-ae40-03df70a5f672	0	{"config__factory-pid":"profile","felix__fileinstall__filename":"file:/opt/openidm/conf/ui-profile.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.172f1099-94c9-423e-ae40-03df70a5f672","_id":"org.forgerock.openidm.ui.172f1099-94c9-423e-ae40-03df70a5f672","jsonconfig":{"tabs":[{"name":"personalInfoTab","view":"org/forgerock/openidm/ui/user/profile/personalInfo/PersonalInfoTab"},{"name":"signInAndSecurity","view":"org/forgerock/openidm/ui/user/profile/signInAndSecurity/SignInAndSecurityTab"},{"name":"preference","view":"org/forgerock/openidm/ui/user/profile/PreferencesTab"},{"name":"trustedDevice","view":"org/forgerock/openidm/ui/user/profile/TrustedDevicesTab"},{"name":"oauthApplication","view":"org/forgerock/openidm/ui/user/profile/OauthApplicationsTab"},{"name":"privacyAndConsent","view":"org/forgerock/openidm/ui/user/profile/PrivacyAndConsentTab"},{"name":"sharing","view":"org/forgerock/openidm/ui/user/profile/uma/SharingTab"},{"name":"auditHistory","view":"org/forgerock/openidm/ui/user/profile/uma/ActivityTab"},{"name":"accountControls","view":"org/forgerock/openidm/ui/user/profile/accountControls/AccountControlsTab"}],"_id":"ui/profile"},"service__factoryPid":"org.forgerock.openidm.ui"}
40	1	org.forgerock.openidm.endpoint.91afa283-a85f-45f1-b6dc-ce8897be4a5d	0	{"config__factory-pid":"linkedView","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-linkedView.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.91afa283-a85f-45f1-b6dc-ce8897be4a5d","_id":"org.forgerock.openidm.endpoint.91afa283-a85f-45f1-b6dc-ce8897be4a5d","jsonconfig":{"context":"endpoint/linkedView/*","type":"text/javascript","source":"require('linkedView').fetch(request.resourcePath);","_id":"endpoint/linkedView"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
45	1	org.forgerock.openidm.selfservice.b61e1b34-5823-4d8d-bdd8-da96ac9458f6	0	{"config__factory-pid":"reset","felix__fileinstall__filename":"file:/opt/openidm/conf/selfservice-reset.json","_rev":"0","service__pid":"org.forgerock.openidm.selfservice.b61e1b34-5823-4d8d-bdd8-da96ac9458f6","_id":"org.forgerock.openidm.selfservice.b61e1b34-5823-4d8d-bdd8-da96ac9458f6","jsonconfig":{"stageConfigs":[{"name":"userQuery","validQueryFields":["userName","mail","givenName","sn"],"identityIdField":"_id","identityEmailField":"mail","identityUsernameField":"userName","identityServiceUrl":"managed/user"},{"name":"emailValidation","identityEmailField":"mail","emailServiceUrl":"external/email","from":"do_not_reply@hmcts.net","subject":"Reset password email","mimeType":"text/html","subjectTranslations":{"en":"Complete your password reset request"},"messageTranslations":{"en":"<h1>Reset your password</h1>\\n                                Hello,<br/><br/>\\n                                \\n                Please click <a href=\\"%link%\\" target=\\"_self\\">here</a> to reset your password.<br/><br/>\\n                                \\n                                The HMCTS IdAM team.\\n                                "},"verificationLinkToken":"%link%","verificationLink":"http://localhost:9002/passwordReset?action=start"},{"name":"resetStage","identityServiceUrl":"managed/user","identityPasswordField":"password"}],"snapshotToken":{"type":"jwt","jweAlgorithm":"RSAES_PKCS1_V1_5","encryptionMethod":"A128CBC_HS256","jwsAlgorithm":"HS256","tokenExpiry":"172800"},"storage":"stateless","_id":"selfservice/reset"},"service__factoryPid":"org.forgerock.openidm.selfservice"}
46	1	org.forgerock.openidm.endpoint.d19fb0e2-0e8f-469d-97f8-715e21fae1c8	0	{"config__factory-pid":"mappingDetails","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-mappingDetails.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.d19fb0e2-0e8f-469d-97f8-715e21fae1c8","_id":"org.forgerock.openidm.endpoint.d19fb0e2-0e8f-469d-97f8-715e21fae1c8","jsonconfig":{"type":"text/javascript","context":"endpoint/mappingDetails","file":"ui/mappingDetails.js","_id":"endpoint/mappingDetails"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
47	1	org.forgerock.openidm.info.c792bc28-88d7-4dfb-8cfa-b7a5139e1f05	0	{"config__factory-pid":"ping","felix__fileinstall__filename":"file:/opt/openidm/conf/info-ping.json","_rev":"0","service__pid":"org.forgerock.openidm.info.c792bc28-88d7-4dfb-8cfa-b7a5139e1f05","_id":"org.forgerock.openidm.info.c792bc28-88d7-4dfb-8cfa-b7a5139e1f05","jsonconfig":{"source":"require('info/ping').checkState(request, healthinfo)","type":"text/javascript","apiDescription":{"title":"Information","description":"Service that allows you to ping the server.","mvccSupported":false,"read":{"description":"Returns OpenIDM status information, and is an endpoint suitable for pinging the server."},"resourceSchema":{"title":"Status Info","type":"object","required":["shortDesc","state"],"properties":{"shortDesc":{"type":"string","description":"Short description of OpenIDM's state"},"state":{"type":"string","description":"OpenIDM's current state","enum":["STARTING","ACTIVE_READY","ACTIVE_NOT_READY","STOPPING"],"enum_titles":["Starting","Ready","Not Ready","Stopping"]}}}},"_id":"info/ping"},"service__factoryPid":"org.forgerock.openidm.info"}
31	1	org.forgerock.openidm.info.factory	3	{"factory__pid":"org.forgerock.openidm.info","factory__pidList":["org.forgerock.openidm.info.25633d08-9464-497f-b838-b84bb35416c9","org.forgerock.openidm.info.4ba76273-40ff-44bf-8307-8d5e1b29b08c","org.forgerock.openidm.info.bf2b6da5-3dae-4d16-8bad-95f49d9b9890","org.forgerock.openidm.info.c792bc28-88d7-4dfb-8cfa-b7a5139e1f05","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"3","_id":"org.forgerock.openidm.info.factory","jsonconfig":null}
48	1	org.forgerock.openidm.external.email	1	{"_rev":"1","service__pid":"org.forgerock.openidm.external.email","_id":"org.forgerock.openidm.external.email","jsonconfig":{"host":"smtp-server","port":"1025","auth":{"enable":false,"username":"amido.idam@gmail.com","password":{"$crypto":{"type":"x-simple-encryption","value":{"cipher":"AES/CBC/PKCS5Padding","salt":"p5SZxlKdmh11FO8qXO665Q==","data":"1ncP3eAlBXE75BsASgOFeg==","iv":"2bXiBkg9cDNii42TgyqkAw==","key":"openidm-sym-default","mac":"0hRJ0OfFp6KEX6mL/j9Y9A=="}}}},"starttls":{"enable":true},"from":"idamadmin@reform.hmcts.net","_id":"external.email"}}
49	1	org.forgerock.openidm.identityProviders	1	{"_rev":"1","service__pid":"org.forgerock.openidm.identityProviders","_id":"org.forgerock.openidm.identityProviders","jsonconfig":{"providers":[{"provider":"google","authorizationEndpoint":"https://accounts.google.com/o/oauth2/v2/auth","tokenEndpoint":"https://www.googleapis.com/oauth2/v4/token","userInfoEndpoint":"https://www.googleapis.com/oauth2/v3/userinfo","wellKnownEndpoint":"https://accounts.google.com/.well-known/openid-configuration","clientId":"","clientSecret":"","uiConfig":{"iconBackground":"#4184f3","iconClass":"fa-google","iconFontColor":"white","buttonImage":"images/g-logo.png","buttonClass":"","buttonCustomStyle":"background-color: #fff; color: #757575; border-color: #ddd;","buttonCustomStyleHover":"color: #6d6d6d; background-color: #eee; border-color: #ccc;","buttonDisplayName":"Google"},"scope":["openid","profile","email"],"authenticationIdKey":"sub","schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Google","title":"Google","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"sub":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"given_name":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"family_name":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"picture":{"description":"Profile Picture URL","title":"Profile Picture URL","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true},"locale":{"description":"Locale Code","title":"Locale Code","viewable":true,"type":"string","searchable":true}},"order":["sub","name","given_name","family_name","picture","email","locale"],"required":[]},"propertyMap":[{"source":"sub","target":"id"},{"source":"name","target":"displayName"},{"source":"given_name","target":"givenName"},{"source":"family_name","target":"familyName"},{"source":"picture","target":"photoUrl"},{"source":"email","target":"email"},{"source":"email","target":"username"},{"source":"locale","target":"locale"}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oidc.OpenIDConnectClientConfiguration","basicAuth":false},{"provider":"facebook","authorizationEndpoint":"https://www.facebook.com/dialog/oauth","tokenEndpoint":"https://graph.facebook.com/v2.7/oauth/access_token","userInfoEndpoint":"https://graph.facebook.com/me?fields=id,name,picture,email,first_name,last_name,locale","clientId":"","clientSecret":"","scope":["email","user_birthday"],"uiConfig":{"iconBackground":"#3b5998","iconClass":"fa-facebook","iconFontColor":"white","buttonImage":"","buttonClass":"fa-facebook-official","buttonDisplayName":"Facebook","buttonCustomStyle":"background-color: #3b5998;border-color: #3b5998; color: white;","buttonCustomStyleHover":"background-color: #334b7d;border-color: #334b7d; color: white;"},"basicAuth":false,"authenticationIdKey":"id","schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Facebook","title":"Facebook","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"first_name":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"last_name":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true},"locale":{"description":"Locale Code","title":"Locale Code","viewable":true,"type":"string","searchable":true}},"order":["id","name","first_name","last_name","email","locale"],"required":[]},"propertyMap":[{"source":"id","target":"id"},{"source":"name","target":"displayName"},{"source":"first_name","target":"givenName"},{"source":"last_name","target":"familyName"},{"source":"email","target":"email"},{"source":"email","target":"username"},{"source":"locale","target":"locale"}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration"},{"provider":"linkedIn","authorizationEndpoint":"https://www.linkedin.com/oauth/v2/authorization","tokenEndpoint":"https://www.linkedin.com/oauth/v2/accessToken","userInfoEndpoint":"https://api.linkedin.com/v1/people/~:(id,formatted-name,first-name,last-name,email-address,location)?format=json","clientId":"","clientSecret":"","scope":["r_basicprofile","r_emailaddress"],"authenticationIdKey":"id","basicAuth":false,"uiConfig":{"iconBackground":"#0077b5","iconClass":"fa-linkedin","iconFontColor":"white","buttonImage":"","buttonClass":"fa-linkedin","buttonDisplayName":"LinkedIn","buttonCustomStyle":"background-color:#0077b5;border-color:#0077b5;color:white;","buttonCustomStyleHover":"background-color:#006ea9; border-color:#006ea9;color:white;"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:LinkedIn","title":"LinkedIn","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":false},"formattedName":{"description":"Formatted Name","title":"Formatted Name","viewable":true,"type":"string","searchable":true},"firstName":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"lastName":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"emailAddress":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true},"location":{"description":"Location","title":"Location","viewable":true,"type":"object","searchable":true,"properties":{"country":{"description":"Country","title":"Country","type":"object","properties":{"code":{"description":"Locale Code","title":"Locale Code","type":"string"}}},"name":{"description":"Area Name","type":"string","title":"Area Name"}}}},"order":["id","formattedName","emailAddress","firstName","lastName","location"],"required":[]},"propertyMap":[{"source":"id","target":"id"},{"source":"formattedName","target":"displayName"},{"source":"firstName","target":"givenName"},{"source":"lastName","target":"familyName"},{"source":"emailAddress","target":"email"},{"source":"emailAddress","target":"username"},{"source":"location","target":"locale","transform":{"type":"text/javascript","source":"source.country.code"}}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration"},{"provider":"amazon","authorizationEndpoint":"https://www.amazon.com/ap/oa","tokenEndpoint":"https://api.amazon.com/auth/o2/token","userInfoEndpoint":"https://api.amazon.com/user/profile","enabled":false,"clientId":"","clientSecret":"","scope":["profile"],"authenticationIdKey":"user_id","basicAuth":false,"uiConfig":{"iconBackground":"#f0c14b","iconClass":"fa-amazon","iconFontColor":"black","buttonImage":"","buttonClass":"fa-amazon","buttonDisplayName":"Amazon","buttonCustomStyle":"background: linear-gradient(to bottom, #f7e09f 15%,#f5c646 85%);color: black;border-color: #b48c24;","buttonCustomStyleHover":"background: linear-gradient(to bottom, #f6c94e 15%,#f6c94e 85%);color: black;border-color: #b48c24;"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Amazon","title":"Amazon","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"user_id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true}},"order":["user_id","name","email"],"required":[]},"propertyMap":[{"source":"user_id","target":"id"},{"source":"name","target":"displayName"},{"source":"email","target":"email"},{"source":"email","target":"username"}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration"},{"provider":"wordpress","authorizationEndpoint":"https://public-api.wordpress.com/oauth2/authorize","tokenEndpoint":"https://public-api.wordpress.com/oauth2/token","userInfoEndpoint":"https://public-api.wordpress.com/rest/v1.1/me/","enabled":false,"clientId":"","clientSecret":"","scope":["auth"],"authenticationIdKey":"username","basicAuth":false,"uiConfig":{"iconBackground":"#0095cc","iconClass":"fa-wordpress","iconFontColor":"white","buttonImage":"","buttonClass":"fa-wordpress","buttonDisplayName":"WordPress","buttonCustomStyle":"background-color: #0095cc; border-color: #0095cc; color:white;","buttonCustomStyleHover":"background-color: #0095cc; border-color: #0095cc; color:white;"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Wordpress","username":"http://jsonschema.net","title":"Wordpress","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"username":{"description":"username","title":"username","viewable":true,"type":"string","searchable":true},"email":{"description":"email","title":"email","viewable":true,"type":"string","searchable":true}},"order":["username","email"],"required":[]},"propertyMap":[{"source":"username","target":"username"},{"source":"username","target":"id"},{"source":"email","target":"email"}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration"},{"provider":"microsoft","authorizationEndpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/authorize","tokenEndpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/token","userInfoEndpoint":"https://graph.microsoft.com/v1.0/me","clientId":"","clientSecret":"","scope":["User.Read"],"authenticationIdKey":"id","basicAuth":false,"uiConfig":{"iconBackground":"#0078d7","iconClass":"fa-windows","iconFontColor":"white","buttonImage":"images/microsoft-logo.png","buttonClass":"","buttonDisplayName":"Microsoft","buttonCustomStyle":"background-color: #fff; border-color: #8b8b8b; color: #8b8b8b;","buttonCustomStyleHover":"background-color: #fff; border-color: #8b8b8b; color: #8b8b8b;"},"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Microsoft","title":"Microsoft","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":false},"displayName":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"givenName":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"surname":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"userPrincipalName":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true}},"order":["id","displayName","userPrincipalName","givenName","surname"],"required":[]},"propertyMap":[{"source":"id","target":"id"},{"source":"displayName","target":"displayName"},{"source":"givenName","target":"givenName"},{"source":"surname","target":"familyName"},{"source":"userPrincipalName","target":"email"},{"source":"userPrincipalName","target":"username"}],"redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration"},{"provider":"vkontakte","configClass":"org.forgerock.oauth.clients.vk.VKClientConfiguration","basicAuth":false,"clientId":"","clientSecret":"","authorizationEndpoint":"https://oauth.vk.com/authorize","tokenEndpoint":"https://oauth.vk.com/access_token","userInfoEndpoint":"https://api.vk.com/method/users.get","redirectUri":"https://localhost:8443/oauthReturn/","scope":["email"],"uiConfig":{"iconBackground":"#4c75a3","iconClass":"fa-vk","iconFontColor":"white","buttonImage":"","buttonClass":"fa-vk","buttonDisplayName":"VK","buttonCustomStyle":"background-color: #4c75a3; border-color: #4c75a3;color: white;","buttonCustomStyleHover":"background-color: #43658c; border-color: #43658c;color: white;"},"authenticationIdKey":"uid","propertyMap":[{"source":"uid","target":"id"},{"source":"first_name","target":"displayName"},{"source":"first_name","target":"givenName"},{"source":"last_name","target":"familyName"},{"source":"email","target":"email"},{"source":"email","target":"username"}],"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Vkontakte","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"uid":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"first_name":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"last_name":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true}},"order":["uid","name","last_name","first_name","email"],"required":[]}},{"provider":"instagram","configClass":"org.forgerock.oauth.clients.instagram.InstagramClientConfiguration","basicAuth":false,"clientId":"","clientSecret":"","authorizationEndpoint":"https://api.instagram.com/oauth/authorize/","tokenEndpoint":"https://api.instagram.com/oauth/access_token","userInfoEndpoint":"https://api.instagram.com/v1/users/self/","redirectUri":"https://localhost:8443/oauthReturn/","scope":["basic","public_content"],"uiConfig":{"iconBackground":"#3f729b","iconClass":"fa-instagram","iconFontColor":"white","buttonImage":"","buttonClass":"fa-instagram","buttonDisplayName":"Instagram","buttonCustomStyle":"background-color: #3f729b; border-color: #3f729b;color: white;","buttonCustomStyleHover":"background-color: #305777; border-color: #305777;color: white;"},"connectionTimeout":0,"readTimeout":0,"authenticationIdKey":"id","propertyMap":[{"source":"id","target":"id"},{"full_name":"full_name","target":"displayName"},{"source":"profile_picture","target":"photoUrl"},{"source":"username","target":"username"}],"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Instagram","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"full_name":{"description":"Full Name","title":"Full Name","viewable":true,"type":"string","searchable":true},"profile_picture":{"description":"Profile Picture URL","title":"Profile Picture URL","viewable":true,"type":"string","searchable":true},"username":{"description":"Username","title":"Username","viewable":true,"type":"string","searchable":true}},"order":["id","full_name","profile_picture","photoUrl","username"],"required":[]}},{"provider":"wechat","configClass":"org.forgerock.oauth.clients.wechat.WeChatClientConfiguration","basicAuth":false,"clientId":"","clientSecret":"","authorizationEndpoint":"https://open.weixin.qq.com/connect/qrconnect","tokenEndpoint":"https://api.wechat.com/sns/oauth2/access_token","refreshTokenEndpoint":"https://api.wechat.com/sns/oauth2/refresh_token","userInfoEndpoint":"https://api.wechat.com/sns/userinfo","redirectUri":"https://localhost:8443/oauthReturn/","scope":["snsapi_login"],"uiConfig":{"iconBackground":"#09b507","iconClass":"fa-wechat","iconFontColor":"white","buttonImage":"","buttonClass":"fa-wechat","buttonDisplayName":"WeChat","buttonCustomStyle":"background-color: #09b507; border-color: #09b507;color: white;","buttonCustomStyleHover":"background-color: #09a007; border-color: #09a007;color: white;"},"connectionTimeout":0,"readTimeout":0,"authenticationIdKey":"openid","propertyMap":[{"source":"openid","target":"id"},{"source":"nickname","target":"displayName"},{"source":"nickname","target":"username"},{"source":"headimgurl","target":"photoUrl"}],"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Wechat","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"openid":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"nickname":{"description":"Username","title":"Username","viewable":true,"type":"string","searchable":true},"headimgurl":{"description":"Profile Picture URL","title":"Profile Picture URL","viewable":true,"type":"string","searchable":true}},"order":["openid","nickname","headimgurl"],"required":[]}},{"provider":"yahoo","scope":["openid","sdpp-w"],"uiConfig":{"iconBackground":"#7B0099","iconClass":"fa-yahoo","iconFontColor":"white","buttonImage":"","buttonClass":"fa-yahoo","buttonDisplayName":"Yahoo","buttonCustomStyle":"background-color: #7B0099; border-color: #7B0099; color:white;","buttonCustomStyleHover":"background-color: #7B0099; border-color: #7B0099; color:white;"},"propertyMap":[{"source":"sub","target":"id"},{"source":"name","target":"displayName"},{"source":"given_name","target":"givenName"},{"source":"family_name","target":"familyName"},{"source":"email","target":"email"},{"source":"email","target":"username"},{"source":"locale","target":"locale"}],"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Yahoo","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"sub":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"given_name":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"family_name":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true},"locale":{"description":"Locale Code","title":"Locale Code","viewable":true,"type":"string","searchable":true}},"order":["sub","name","given_name","family_name","email","locale"],"required":[]},"authorizationEndpoint":"https://api.login.yahoo.com/oauth2/request_auth","tokenEndpoint":"https://api.login.yahoo.com/oauth2/get_token","wellKnownEndpoint":"https://login.yahoo.com/.well-known/openid-configuration","clientId":"","clientSecret":"","authenticationIdKey":"sub","redirectUri":"https://localhost:8443/oauthReturn/","basicAuth":false,"configClass":"org.forgerock.oauth.clients.oidc.OpenIDConnectClientConfiguration"},{"provider":"salesforce","authorizationEndpoint":"https://login.salesforce.com/services/oauth2/authorize","tokenEndpoint":"https://login.salesforce.com/services/oauth2/token","userInfoEndpoint":"https://login.salesforce.com/services/oauth2/userinfo","clientId":"","clientSecret":"","scope":["id","api","web"],"uiConfig":{"iconBackground":"#21a0df","iconClass":"fa-cloud","iconFontColor":"white","buttonImage":"","buttonClass":"fa-cloud","buttonDisplayName":"Salesforce","buttonCustomStyle":"background-color: #21a0df; border-color: #21a0df; color: white;","buttonCustomStyleHover":"background-color: #21a0df; border-color: #21a0df; color: white;"},"authenticationIdKey":"user_id","redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.oauth2.OAuth2ClientConfiguration","basicAuth":false,"schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Salesforce","title":"Salesforce","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"user_id":{"description":"ID","title":"ID","viewable":true,"type":"string","searchable":true},"name":{"description":"Name","title":"Name","viewable":true,"type":"string","searchable":true},"given_name":{"description":"First Name","title":"First Name","viewable":true,"type":"string","searchable":true},"family_name":{"description":"Last Name","title":"Last Name","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true},"zoneInfo":{"description":"Locale Code","title":"Locale Code","viewable":true,"type":"string","searchable":true}},"order":["user_id","name","given_name","family_name","email","zoneInfo"],"required":[]},"propertyMap":[{"source":"user_id","target":"id"},{"source":"name","target":"displayName"},{"source":"given_name","target":"givenName"},{"source":"family_name","target":"familyName"},{"source":"email","target":"email"},{"source":"email","target":"username"},{"source":"zoneInfo","target":"locale"}]},{"provider":"twitter","requestTokenEndpoint":"https://api.twitter.com/oauth/request_token","authorizationEndpoint":"https://api.twitter.com/oauth/authenticate","tokenEndpoint":"https://api.twitter.com/oauth/access_token","userInfoEndpoint":"https://api.twitter.com/1.1/account/verify_credentials.json","clientId":"","clientSecret":"","uiConfig":{"iconBackground":"#00b6e9","iconClass":"fa-twitter","iconFontColor":"white","buttonImage":"","buttonClass":"fa-twitter","buttonDisplayName":"Twitter","buttonCustomStyle":"background-color: #00b6e9; border-color: #00b6e9; color: #fff;","buttonCustomStyleHover":"background-color: #01abda; border-color: #01abda; color: #fff;"},"authenticationIdKey":"id_str","redirectUri":"https://localhost:8443/oauthReturn/","configClass":"org.forgerock.oauth.clients.twitter.TwitterClientConfiguration","schema":{"id":"urn:jsonschema:org:forgerock:openidm:identityProviders:api:Twitter","title":"Twitter","viewable":true,"type":"object","$schema":"http://json-schema.org/draft-03/schema","properties":{"id_str":{"description":"ID","title":"Id","viewable":true,"type":"string","searchable":true},"name":{"description":"Full Name","title":"Full Name","viewable":true,"type":"string","searchable":true},"screen_name":{"description":"User Id","title":"User Id","viewable":true,"type":"string","searchable":true},"email":{"description":"Email Address","title":"Email Address","viewable":true,"type":"string","searchable":true}},"order":["id_str","name","screen_name","email"],"required":[]},"propertyMap":[{"source":"id_str","target":"id"},{"source":"name","target":"displayName"},{"source":"email","target":"email"},{"source":"screen_name","target":"username"}]}],"_id":"identityProviders"}}
50	1	org.forgerock.openidm.router	1	{"_rev":"1","service__pid":"org.forgerock.openidm.router","_id":"org.forgerock.openidm.router","jsonconfig":{"filters":[{"condition":{"type":"text/javascript","source":"context.caller.external === true || context.current.name === 'selfservice'"},"onRequest":{"type":"text/javascript","file":"router-authz.js"}},{"pattern":"^(managed|system|repo/internal)($|(/.+))","onRequest":{"type":"text/javascript","file":"policyFilter.js"},"methods":["create","update"]},{"pattern":"repo/internal/user.*","onRequest":{"type":"text/javascript","source":"request.content.password = require('crypto').hash(request.content.password);"},"methods":["create","update"]}],"_id":"router"}}
51	1	org.forgerock.openidm.workflow	1	{"_rev":"1","service__pid":"org.forgerock.openidm.workflow","_id":"org.forgerock.openidm.workflow","jsonconfig":{"useDataSource":"default","workflowDirectory":"&{launcher.project.location}/workflow","_id":"workflow"}}
52	1	org.forgerock.openidm.ui.context.caa966f5-5cd8-4582-bf77-3a4e3a1c5f8e	0	{"config__factory-pid":"oauth","felix__fileinstall__filename":"file:/opt/openidm/conf/ui.context-oauth.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.context.caa966f5-5cd8-4582-bf77-3a4e3a1c5f8e","_id":"org.forgerock.openidm.ui.context.caa966f5-5cd8-4582-bf77-3a4e3a1c5f8e","jsonconfig":{"enabled":true,"urlContextRoot":"/oauthReturn","defaultDir":"&{launcher.install.location}/ui/oauth/default","extensionDir":"&{launcher.install.location}/ui/oauth/extension","_id":"ui.context/oauth"},"service__factoryPid":"org.forgerock.openidm.ui.context"}
53	1	org.forgerock.openidm.emailTemplate.7e21bcdc-e079-4d20-b004-27de218c8e19	0	{"config__factory-pid":"resetPassword","felix__fileinstall__filename":"file:/opt/openidm/conf/emailTemplate-resetPassword.json","_rev":"0","service__pid":"org.forgerock.openidm.emailTemplate.7e21bcdc-e079-4d20-b004-27de218c8e19","_id":"org.forgerock.openidm.emailTemplate.7e21bcdc-e079-4d20-b004-27de218c8e19","jsonconfig":{"enabled":true,"from":"","subject":{"en":"Your password has been reset"},"message":{"en":"<html><body><p>Your new password is: {{password}}</p></body></html>"},"defaultLocale":"en","passwordRules":[{"rule":"UPPERCASE","minimum":1},{"rule":"LOWERCASE","minimum":1},{"rule":"INTEGERS","minimum":1},{"rule":"SPECIAL","minimum":1}],"passwordLength":16,"_id":"emailTemplate/resetPassword"},"service__factoryPid":"org.forgerock.openidm.emailTemplate"}
54	1	org.forgerock.openidm.script	1	{"_rev":"1","service__pid":"org.forgerock.openidm.script","_id":"org.forgerock.openidm.script","jsonconfig":{"properties":{},"ECMAScript":{"#javascript.debug":"transport=socket,suspend=y,address=9888,trace=true","javascript.recompile.minimumInterval":"60000"},"Groovy":{"#groovy.warnings":"likely errors #othere values [none,likely,possible,paranoia]","#groovy.source.encoding":"utf-8 #default US-ASCII","groovy.source.encoding":"UTF-8","groovy.target.directory":"&{launcher.install.location}/classes","#groovy.target.bytecode":"1.5","groovy.classpath":"&{launcher.install.location}/lib/jose4j-0.5.5.jar:&{launcher.install.location}/lib/notifications-java-client-3.8.0-RELEASE.jar:&{launcher.install.location}/lib/*","#groovy.output.verbose":"false","#groovy.output.debug":"false","#groovy.errors.tolerance":"10","#groovy.script.extension":".groovy","#groovy.script.base":"#any class extends groovy.lang.Script","groovy.recompile":"true","groovy.recompile.minimumInterval":"60000","#groovy.target.indy":"true","#groovy.disabled.global.ast.transformations":""},"sources":{"default":{"directory":"&{launcher.install.location}/bin/defaults/script"},"install":{"directory":"&{launcher.install.location}"},"project":{"directory":"&{launcher.project.location}"},"project-script":{"directory":"&{launcher.project.location}/script"}},"_id":"script"}}
55	1	org.forgerock.openidm.audit	1	{"_rev":"1","service__pid":"org.forgerock.openidm.audit","_id":"org.forgerock.openidm.audit","jsonconfig":{"auditServiceConfig":{"handlerForQueries":"json","availableAuditEventHandlers":["org.forgerock.audit.handlers.csv.CsvAuditEventHandler","org.forgerock.audit.handlers.elasticsearch.ElasticsearchAuditEventHandler","org.forgerock.audit.handlers.jms.JmsAuditEventHandler","org.forgerock.audit.handlers.json.JsonAuditEventHandler","org.forgerock.openidm.audit.impl.RepositoryAuditEventHandler","org.forgerock.openidm.audit.impl.RouterAuditEventHandler","org.forgerock.audit.handlers.splunk.SplunkAuditEventHandler","org.forgerock.audit.handlers.syslog.SyslogAuditEventHandler"],"filterPolicies":{"value":{"excludeIf":["/access/http/request/headers/Authorization","/access/http/request/headers/X-OpenIDM-Password","/access/http/request/cookies/session-jwt","/access/http/response/headers/Authorization","/access/http/response/headers/X-OpenIDM-Password"],"includeIf":[]}}},"eventHandlers":[{"class":"org.forgerock.audit.handlers.json.JsonAuditEventHandler","config":{"name":"json","logDirectory":"&{launcher.working.location}/audit","buffering":{"maxSize":100000,"writeInterval":"100 millis"},"topics":["access","activity","recon","sync","authentication","config"]}},{"class":"org.forgerock.openidm.audit.impl.RepositoryAuditEventHandler","config":{"name":"repo","enabled":false,"topics":["access","activity","recon","sync","authentication","config"]}}],"eventTopics":{"config":{"filter":{"actions":["create","update","delete","patch","action"]}},"activity":{"filter":{"actions":["create","update","delete","patch","action"]},"watchedFields":[],"passwordFields":["password"]}},"exceptionFormatter":{"type":"text/javascript","file":"bin/defaults/script/audit/stacktraceFormatter.js"},"_id":"audit"}}
56	1	org.forgerock.openidm.endpoint.9a44a90e-e91f-4d4e-962c-81c6669fee8d	0	{"config__factory-pid":"notify","felix__fileinstall__filename":"file:/opt/openidm/conf/endpoint-notify.json","_rev":"0","service__pid":"org.forgerock.openidm.endpoint.9a44a90e-e91f-4d4e-962c-81c6669fee8d","_id":"org.forgerock.openidm.endpoint.9a44a90e-e91f-4d4e-962c-81c6669fee8d","jsonconfig":{"type":"groovy","file":"notify.groovy","context":"endpoint/notify/*","_id":"endpoint/notify"},"service__factoryPid":"org.forgerock.openidm.endpoint"}
7	1	org.forgerock.openidm.endpoint.factory	8	{"factory__pid":"org.forgerock.openidm.endpoint","factory__pidList":["org.forgerock.openidm.endpoint.91afa283-a85f-45f1-b6dc-ce8897be4a5d","org.forgerock.openidm.endpoint.52e65bdd-5982-477d-9a8c-af6077b004d2","org.forgerock.openidm.endpoint.d19fb0e2-0e8f-469d-97f8-715e21fae1c8","org.forgerock.openidm.endpoint.a8b5220d-3b35-4f9c-a7df-115bac574a4a","org.forgerock.openidm.endpoint.601e78e1-11b1-46a5-b356-900c4d47940f","org.forgerock.openidm.endpoint.5a6f7be3-e04d-4a18-928f-e0532b2d5d76","org.forgerock.openidm.endpoint.9a44a90e-e91f-4d4e-962c-81c6669fee8d","org.forgerock.openidm.endpoint.a8bb1458-4286-4f0b-8101-600f2006b3ba","org.forgerock.openidm.endpoint.2bc5fef9-5b31-4d03-998f-f0eeafae3871","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"8","_id":"org.forgerock.openidm.endpoint.factory","jsonconfig":null}
57	1	org.forgerock.openidm.policy	1	{"_rev":"1","service__pid":"org.forgerock.openidm.policy","_id":"org.forgerock.openidm.policy","jsonconfig":{"type":"text/javascript","file":"policy.js","additionalFiles":[],"resources":[{"resource":"selfservice/registration","calculatedProperties":{"type":"text/javascript","source":"require('selfServicePolicies').getRegistrationProperties()"}},{"resource":"selfservice/reset","calculatedProperties":{"type":"text/javascript","source":"require('selfServicePolicies').getResetProperties()"}},{"resource":"repo/internal/user/*","properties":[{"name":"_id","policies":[{"policyId":"cannot-contain-characters","params":{"forbiddenChars":["/"]}}]},{"name":"password","policies":[{"policyId":"required"},{"policyId":"not-empty"},{"policyId":"at-least-X-capitals","params":{"numCaps":1}},{"policyId":"at-least-X-numbers","params":{"numNums":1}},{"policyId":"minimum-length","params":{"minLength":8}}]}]}],"_id":"policy"}}
58	1	org.forgerock.openidm.ui.context.c2a77b43-8206-4005-a134-c526a2e95069	0	{"config__factory-pid":"admin","felix__fileinstall__filename":"file:/opt/openidm/conf/ui.context-admin.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.context.c2a77b43-8206-4005-a134-c526a2e95069","_id":"org.forgerock.openidm.ui.context.c2a77b43-8206-4005-a134-c526a2e95069","jsonconfig":{"enabled":true,"urlContextRoot":"/admin","defaultDir":"&{launcher.install.location}/ui/admin/default","extensionDir":"&{launcher.install.location}/ui/admin/extension","responseHeaders":{"X-Frame-Options":"DENY"},"_id":"ui.context/admin"},"service__factoryPid":"org.forgerock.openidm.ui.context"}
59	1	org.forgerock.openidm.schedule.832d9581-d9ae-4736-aa63-ad87e830d32a	0	{"config__factory-pid":"sunset-task","felix__fileinstall__filename":"file:/opt/openidm/conf/schedule-sunset-task.json","_rev":"0","service__pid":"org.forgerock.openidm.schedule.832d9581-d9ae-4736-aa63-ad87e830d32a","_id":"org.forgerock.openidm.schedule.832d9581-d9ae-4736-aa63-ad87e830d32a","jsonconfig":{"enabled":true,"type":"cron","schedule":"0 0 * * * ?","persisted":true,"concurrentExecution":false,"invokeService":"taskscanner","invokeContext":{"waitForCompletion":false,"numberOfThreads":5,"scan":{"_queryFilter":"((/sunset/date lt \\"${Time.now}\\") AND !(/sunset/task-completed pr))","object":"managed/user","taskState":{"started":"/sunset/task-started","completed":"/sunset/task-completed"},"recovery":{"timeout":"10m"}},"task":{"script":{"type":"text/javascript","file":"script/sunset.js"}}},"_id":"schedule/sunset-task"},"service__factoryPid":"org.forgerock.openidm.schedule"}
60	1	org.forgerock.openidm.ui.8a2fd12d-5c33-4d1e-86c6-54b75f73e15d	0	{"config__factory-pid":"dashboard","felix__fileinstall__filename":"file:/opt/openidm/conf/ui-dashboard.json","_rev":"0","service__pid":"org.forgerock.openidm.ui.8a2fd12d-5c33-4d1e-86c6-54b75f73e15d","_id":"org.forgerock.openidm.ui.8a2fd12d-5c33-4d1e-86c6-54b75f73e15d","jsonconfig":{"dashboard":{"widgets":[{"type":"workflow"},{"type":"quickStart","size":"large","cards":[{"name":"dashboard.quickStart.viewProfile","icon":"fa-user","href":"#profile/details"},{"name":"dashboard.quickStart.changePassword","icon":"fa-lock","href":"#signinandsecurity/password/"}]}]},"adminDashboards":[{"name":"Administration","isDefault":true,"widgets":[{"type":"quickStart","size":"large","cards":[{"name":"Add Connector","icon":"fa-database","href":"#connectors/add/"},{"name":"Create Mapping","icon":"fa-map-marker","href":"#mapping/add/"},{"name":"Manage Roles","icon":"fa-check-square-o","href":"#resource/managed/role/list/"},{"name":"Add Device","icon":"fa-tablet","href":"#managed/add/"},{"name":"Configure Registration","icon":"fa-gear","href":"#selfservice/userregistration/"},{"name":"Configure Password Reset","icon":"fa-gear","href":"#selfservice/passwordreset/"},{"name":"Manage Users","icon":"fa-user","href":"#resource/managed/user/list/"},{"name":"Configure System Preferences","icon":"fa-user","href":"#settings/"}]},{"type":"resourceList","size":"large"}]},{"name":"System Monitoring","isDefault":false,"widgets":[{"type":"audit","size":"large","minRange":"#b0d4cd","maxRange":"#24423c","legendRange":{"week":[10,30,90,270,810],"month":[500,2500,5000],"year":[10000,40000,100000,250000]}},{"type":"systemHealthFull","size":"large"},{"type":"lastRecon","size":"large","barchart":"false"}]}],"_id":"ui/dashboard"},"service__factoryPid":"org.forgerock.openidm.ui"}
61	1	org.forgerock.openidm.provisioner.openicf.56d7f7b9-a11a-4e62-8fc7-defa40030eea	0	{"config__factory-pid":"CsvTacticalUsers","felix__fileinstall__filename":"file:/opt/openidm/conf/provisioner.openicf-CsvTacticalUsers.json","_rev":"0","service__pid":"org.forgerock.openidm.provisioner.openicf.56d7f7b9-a11a-4e62-8fc7-defa40030eea","_id":"org.forgerock.openidm.provisioner.openicf.56d7f7b9-a11a-4e62-8fc7-defa40030eea","jsonconfig":{"connectorRef":{"systemType":"provisioner.openicf","bundleName":"org.forgerock.openicf.connectors.csvfile-connector","connectorName":"org.forgerock.openicf.csvfile.CSVFileConnector","displayName":"CSV File Connector","bundleVersion":"1.5.2.0"},"poolConfigOption":{"maxObjects":10,"maxIdle":10,"maxWait":150000,"minEvictableIdleTimeMillis":120000,"minIdle":1},"resultsHandlerConfig":{"enableNormalizingResultsHandler":true,"enableFilteredResultsHandler":true,"enableCaseInsensitiveFilter":false,"enableAttributesToGetSearchResultsHandler":true},"operationTimeout":{"CREATE":-1,"UPDATE":-1,"DELETE":-1,"TEST":-1,"SCRIPT_ON_CONNECTOR":-1,"SCRIPT_ON_RESOURCE":-1,"GET":-1,"RESOLVEUSERNAME":-1,"AUTHENTICATE":-1,"SEARCH":-1,"VALIDATE":-1,"SYNC":-1,"SCHEMA":-1},"configurationProperties":{"headerPassword":"ignoreNotUsed","csvFile":"/opt/data/tactical-users.csv","newlineString":"\\n","headerUid":"id","quoteCharacter":"\\"","fieldDelimiter":",","syncFileRetentionCount":"3","readSchema":false},"name":"CsvTacticalUsers","enabled":true,"objectTypes":{"RegisteredUser":{"$schema":"http://json-schema.org/draft-03/schema","type":"object","id":"__REGISTERED_USER__","nativeType":"__ACCOUNT__","properties":{"__UID__":{"type":"string","nativeName":"__UID__","nativeType":"string","flags":[],"required":true,"runAsUser":false},"surname":{"type":"string","nativeName":"surname","nativeType":"string","required":true},"forename":{"type":"string","nativeName":"forename","nativeType":"string","required":true},"email":{"type":"string","nativeName":"email","nativeType":"string","required":true},"password":{"type":"string","nativeName":"password","nativeType":"string","required":true},"pin":{"type":"string","nativeName":"pin","nativeType":"string","required":false},"enabled":{"type":"string","nativeName":"enabled","nativeType":"string","required":false},"roles":{"type":"string","nativeName":"roles","nativeType":"string","required":false}}}},"_id":"provisioner.openicf/CsvTacticalUsers"},"service__factoryPid":"org.forgerock.openidm.provisioner.openicf"}
62	1	org.forgerock.openidm.provisioner.openicf.factory	1	{"factory__pid":"org.forgerock.openidm.provisioner.openicf","factory__pidList":["org.forgerock.openidm.provisioner.openicf.4ee5df6e-0237-4008-aa0f-77784ebe8795","org.forgerock.openidm.provisioner.openicf.56d7f7b9-a11a-4e62-8fc7-defa40030eea","_openidm_orig_array","_openidm_orig_array_type=java.lang.String"],"_rev":"1","_id":"org.forgerock.openidm.provisioner.openicf.factory","jsonconfig":null}
63	1	org.forgerock.openidm.provisioner.openicf.4ee5df6e-0237-4008-aa0f-77784ebe8795	1	{"config__factory-pid":"ldap","_rev":"1","service__pid":"org.forgerock.openidm.provisioner.openicf.4ee5df6e-0237-4008-aa0f-77784ebe8795","_id":"org.forgerock.openidm.provisioner.openicf.4ee5df6e-0237-4008-aa0f-77784ebe8795","jsonconfig":{"name":"ldap","connectorRef":{"bundleName":"org.forgerock.openicf.connectors.ldap-connector","bundleVersion":"[1.4.0.0,1.5.0.0)","connectorName":"org.identityconnectors.ldap.LdapConnector"},"configurationProperties":{"host":"fr-am","port":"1389","ssl":false,"principal":"cn=Directory Manager","credentials":{"$crypto":{"type":"x-simple-encryption","value":{"cipher":"AES/CBC/PKCS5Padding","salt":"yWSi2VY3MQSdTZ2k40QPjQ==","data":"k/OonmWncUmkkpP9MM9fFg==","iv":"JgxcGJ5UalGdxW4ovp1DQQ==","key":"openidm-sym-default","mac":"HFPjA/xN/HPGweom5XBXYA=="}}},"accountSearchFilter":null,"accountSynchronizationFilter":null,"groupSearchFilter":null,"groupSynchronizationFilter":null,"synchronizePasswords":false,"removeLogEntryObjectClassFromFilter":true,"modifiersNamesToFilterOut":[],"passwordDecryptionKey":null,"changeLogBlockSize":100,"attributesToSynchronize":[],"changeNumberAttribute":"changeNumber","passwordDecryptionInitializationVector":null,"filterWithOrInsteadOfAnd":false,"objectClassesToSynchronize":["inetOrgPerson","inetuser","inetUser"],"vlvSortAttribute":"uid","passwordAttribute":"userPassword","useBlocks":false,"maintainPosixGroupMembership":false,"failover":[],"readSchema":true,"accountObjectClasses":["top","person","organizationalPerson","inetOrgPerson","inetUser"],"accountUserNameAttributes":["uid"],"groupMemberAttribute":"uniqueMember","usePagedResultControl":true,"blockSize":100,"uidAttribute":"entryUUID","maintainLdapGroupMembership":false,"respectResourcePasswordPolicyChangeAfterReset":false,"passwordAttributeToSynchronize":"password","groupObjectClasses":["top","groupofuniquenames"],"baseContexts":["dc=reform,dc=hmcts,dc=net"],"baseContextsToSynchronize":["dc=reform,dc=hmcts,dc=net"]},"resultsHandlerConfig":{"enableNormalizingResultsHandler":true,"enableFilteredResultsHandler":false,"enableCaseInsensitiveFilter":false,"enableAttributesToGetSearchResultsHandler":true},"poolConfigOption":{"maxObjects":10,"maxIdle":10,"maxWait":150000,"minEvictableIdleTimeMillis":120000,"minIdle":1},"operationTimeout":{"CREATE":-1,"VALIDATE":-1,"TEST":-1,"SCRIPT_ON_CONNECTOR":-1,"SCHEMA":-1,"DELETE":-1,"UPDATE":-1,"SYNC":-1,"AUTHENTICATE":-1,"GET":-1,"SCRIPT_ON_RESOURCE":-1,"SEARCH":-1},"syncFailureHandler":{"maxRetries":5,"postRetryAction":"logged-ignore"},"objectTypes":{"group":{"$schema":"http://json-schema.org/draft-03/schema","id":"__GROUP__","type":"object","nativeType":"__GROUP__","properties":{"seeAlso":{"type":"array","nativeType":"string","nativeName":"seeAlso","required":false,"items":{"type":"string","nativeType":"string"}},"description":{"type":"array","nativeType":"string","nativeName":"description","required":false,"items":{"type":"string","nativeType":"string"}},"uniqueMember":{"type":"array","nativeType":"string","nativeName":"uniqueMember","required":false,"items":{"type":"string","nativeType":"string"}},"dn":{"type":"string","nativeType":"string","nativeName":"__NAME__","required":true},"o":{"type":"array","nativeType":"string","nativeName":"o","required":false,"items":{"type":"string","nativeType":"string"}},"ou":{"type":"array","nativeType":"string","nativeName":"ou","required":false,"items":{"type":"string","nativeType":"string"}},"businessCategory":{"type":"array","nativeType":"string","nativeName":"businessCategory","required":false,"items":{"type":"string","nativeType":"string"}},"owner":{"type":"array","nativeType":"string","nativeName":"owner","required":false,"items":{"type":"string","nativeType":"string"}},"cn":{"type":"array","nativeType":"string","nativeName":"cn","required":true,"items":{"type":"string","nativeType":"string"}},"id":{"type":"string","nativeType":"string","nativeName":"id","required":false}}},"account":{"$schema":"http://json-schema.org/draft-03/schema","id":"__ACCOUNT__","type":"object","nativeType":"__ACCOUNT__","properties":{"cn":{"type":"string","nativeType":"string","nativeName":"cn","required":false},"employeeType":{"type":"string","nativeType":"string","nativeName":"employeeType","required":false},"description":{"type":"string","nativeType":"string","nativeName":"description","required":false},"givenName":{"type":"string","nativeType":"string","nativeName":"givenName","required":false},"mail":{"type":"string","nativeType":"string","nativeName":"mail","required":false},"telephoneNumber":{"type":"string","nativeType":"string","nativeName":"telephoneNumber","required":false},"sn":{"type":"string","nativeType":"string","nativeName":"sn","required":false},"uid":{"type":"string","nativeType":"string","nativeName":"uid","required":false},"dn":{"type":"string","nativeType":"string","nativeName":"__NAME__","required":true},"userPassword":{"type":"string","nativeType":"string","nativeName":"userPassword","required":false,"flags":["NOT_READABLE","NOT_RETURNED_BY_DEFAULT"],"runAsUser":true},"ldapGroups":{"type":"array","nativeType":"string","nativeName":"ldapGroups","required":false,"items":{"type":"string","nativeType":"string"}},"disabled":{"type":"string","nativeType":"string","nativeName":"ds-pwp-account-disabled","required":false},"aliasList":{"type":"array","nativeType":"string","nativeName":"iplanet-am-user-alias-list","required":false},"objectClass":{"type":"array","nativeType":"string","nativeName":"objectClass","required":false},"kbaInfo":{"type":"array","nativeType":"string","nativeName":"kbaInfo","required":false},"pwdAccountLockedTime":{"type":"string","nativeType":"string","nativeName":"pwdAccountLockedTime","flags":["NOT_UPDATEABLE"],"required":false},"inetUserStatus":{"type":"string","nativeName":"inetUserStatus","nativeType":"string","required":false}}}},"operationOptions":{"DELETE":{"denied":false,"onDeny":"DO_NOTHING"},"UPDATE":{"denied":false,"onDeny":"DO_NOTHING"},"CREATE":{"denied":false,"onDeny":"DO_NOTHING"}},"enabled":true,"_id":"provisioner.openicf/ldap"},"service__factoryPid":"org.forgerock.openidm.provisioner.openicf"}
\.


--
-- Name: configobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('configobjects_id_seq', 63, true);


--
-- Data for Name: genericobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY genericobjectproperties (genericobjects_id, propkey, proptype, propvalue) FROM stdin;
2	/reconId	java.lang.String	6f084858-818f-47e1-b1f6-113b847ca1b1-20
2	/startTime	java.lang.Long	1564405966876
1	/reconId	java.lang.String	6f084858-818f-47e1-b1f6-113b847ca1b1-15
1	/startTime	java.lang.Long	1564405966572
\.


--
-- Data for Name: genericobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY genericobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
2	12	17f22b36-820b-41bd-b4a4-67040421c417	2	{"reconId":"6f084858-818f-47e1-b1f6-113b847ca1b1-20","serializedState":"rO0ABXNyADJvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLlJlY29uUHJvZ3Jlc3NTdGF0ZQAAAAAAAAABAgAKWgALaXNDbHVzdGVyZWRMAAttYXBwaW5nTmFtZXQAEkxqYXZhL2xhbmcvU3RyaW5nO0wACG5vZGVzSWRzdAAPTGphdmEvdXRpbC9TZXQ7TAAScmVjb25IYW5kbGVyUGFyYW1zdAASTGphdmEvbGFuZy9PYmplY3Q7TAAHcmVjb25JZHEAfgABTAAKcmVjb25TdGFnZXQALExvcmcvZm9yZ2Vyb2NrL29wZW5pZG0vc3luYy9pbXBsL1JlY29uU3RhZ2U7TAAXcmVjb25jaWxpYXRpb25TdGF0aXN0aWN0AD9Mb3JnL2Zvcmdlcm9jay9vcGVuaWRtL3N5bmMvaW1wbC9zdGF0cy9SZWNvbmNpbGlhdGlvblN0YXRpc3RpYztMABB0b3RhbExpbmtFbnRyaWVzdAAxTG9yZy9mb3JnZXJvY2svb3BlbmlkbS9zeW5jL2ltcGwvVG90YWxFbnRyeVZhbHVlO0wAEnRvdGFsU291cmNlRW50cmllc3EAfgAGTAASdG90YWxUYXJnZXRFbnRyaWVzcQB+AAZ4cAB0AB1tYW5hZ2VkVXNlcl9zeXN0ZW1MZGFwQWNjb3VudHNyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAABA/QAAAAAAAAXQADDQ5M2M4NWUwMGFiN3hzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHIAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAAA3cIAAAABAAAAAJ0AAtzb3VyY2VRdWVyeXNxAH4ADD9AAAAAAAAMdwgAAAAQAAAAAnQADHJlc291cmNlTmFtZXQADG1hbmFnZWQvdXNlcnQAB3F1ZXJ5SWR0AA1xdWVyeS1hbGwtaWRzeAB0AAt0YXJnZXRRdWVyeXNxAH4ADD9AAAAAAAAMdwgAAAAQAAAAAnEAfgARdAATc3lzdGVtL2xkYXAvYWNjb3VudHEAfgATcQB+ABR4AHgAdAAnNmYwODQ4NTgtODE4Zi00N2UxLWIxZjYtMTEzYjg0N2NhMWIxLTIwfnIAKm9yZy5mb3JnZXJvY2sub3BlbmlkbS5zeW5jLmltcGwuUmVjb25TdGFnZQAAAAAAAAAAEgAAeHIADmphdmEubGFuZy5FbnVtAAAAAAAAAAASAAB4cHQAEENPTVBMRVRFRF9GQUlMRURzcgA9b3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5zdGF0cy5SZWNvbmNpbGlhdGlvblN0YXRpc3RpYwAAAAAAAAABAgASSgAHZW5kVGltZUoAEGxpbmtRdWVyeUVuZFRpbWVKABJsaW5rUXVlcnlTdGFydFRpbWVKAAlzdGFydFRpbWVMAAxkdXJhdGlvblN0YXR0AChMamF2YS91dGlsL2NvbmN1cnJlbnQvQ29uY3VycmVudEhhc2hNYXA7TAALbGlua0NyZWF0ZWR0ACtMamF2YS91dGlsL2NvbmN1cnJlbnQvYXRvbWljL0F0b21pY0ludGVnZXI7TAANbGlua1Byb2Nlc3NlZHEAfgAfTAALbWFwcGluZ05hbWVxAH4AAUwABm5vZGVJZHEAfgABTAAHcmVjb25JZHEAfgABTAAPc291cmNlUHJvY2Vzc2VkcQB+AB9MABVzb3VyY2VQcm9jZXNzZWRCeU5vZGV0AA9MamF2YS91dGlsL01hcDtMAApzb3VyY2VTdGF0dAA2TG9yZy9mb3JnZXJvY2svb3BlbmlkbS9zeW5jL2ltcGwvc3RhdHMvUGhhc2VTdGF0aXN0aWM7TAAJc3RhZ2VTdGF0cQB+ACBMAA9zdGF0dXNQcm9jZXNzZWRxAH4AIEwADXRhcmdldENyZWF0ZWRxAH4AH0wAD3RhcmdldFByb2Nlc3NlZHEAfgAfTAAKdGFyZ2V0U3RhdHEAfgAheHAAAAFsPdyqqgAAAAAAAAAAAAAAAAAAAAAAAAFsPdyoHHNyACZqYXZhLnV0aWwuY29uY3VycmVudC5Db25jdXJyZW50SGFzaE1hcGSZ3hKdhyk9AwADSQALc2VnbWVudE1hc2tJAAxzZWdtZW50U2hpZnRbAAhzZWdtZW50c3QAMVtMamF2YS91dGlsL2NvbmN1cnJlbnQvQ29uY3VycmVudEhhc2hNYXAkU2VnbWVudDt4cAAAAA8AAAAcdXIAMVtMamF2YS51dGlsLmNvbmN1cnJlbnQuQ29uY3VycmVudEhhc2hNYXAkU2VnbWVudDtSdz9BMps5dAIAAHhwAAAAEHNyAC5qYXZhLnV0aWwuY29uY3VycmVudC5Db25jdXJyZW50SGFzaE1hcCRTZWdtZW50HzZMkFiTKT0CAAFGAApsb2FkRmFjdG9yeHIAKGphdmEudXRpbC5jb25jdXJyZW50LmxvY2tzLlJlZW50cmFudExvY2tmVagsLMhq6wIAAUwABHN5bmN0AC9MamF2YS91dGlsL2NvbmN1cnJlbnQvbG9ja3MvUmVlbnRyYW50TG9jayRTeW5jO3hwc3IANGphdmEudXRpbC5jb25jdXJyZW50LmxvY2tzLlJlZW50cmFudExvY2skTm9uZmFpclN5bmNliDLnU3u/CwIAAHhyAC1qYXZhLnV0aWwuY29uY3VycmVudC5sb2Nrcy5SZWVudHJhbnRMb2NrJFN5bmO4HqKUqkRafAIAAHhyADVqYXZhLnV0aWwuY29uY3VycmVudC5sb2Nrcy5BYnN0cmFjdFF1ZXVlZFN5bmNocm9uaXplcmZVqEN1P1LjAgABSQAFc3RhdGV4cgA2amF2YS51dGlsLmNvbmN1cnJlbnQubG9ja3MuQWJzdHJhY3RPd25hYmxlU3luY2hyb25pemVyM9+vua1tb6kCAAB4cAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAcQB+AA9zcgAtb3JnLmZvcmdlcm9jay5vcGVuaWRtLnV0aWwuRHVyYXRpb25TdGF0aXN0aWNzlw58liJb1AkCAAZMAApkZWx0YUNvdW50dAAoTGphdmEvdXRpbC9jb25jdXJyZW50L2F0b21pYy9BdG9taWNMb25nO0wACGRlbHRhTWF4cQB+AFBMAAlkZWx0YU1lYW50ADlMb3JnL2Zvcmdlcm9jay9ndWF2YS9jb21tb24vdXRpbC9jb25jdXJyZW50L0F0b21pY0RvdWJsZTtMAAhkZWx0YU1pbnEAfgBQTAALZGVsdGFTdGREZXZxAH4AUUwACGRlbHRhU3VtcQB+AFB4cHNyACZqYXZhLnV0aWwuY29uY3VycmVudC5hdG9taWMuQXRvbWljTG9uZxrA+rR3ABcYAgABSgAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAAAAAAAAXNxAH4AUwAAAAAAQM3Tc3IAN29yZy5mb3JnZXJvY2suZ3VhdmEuY29tbW9uLnV0aWwuY29uY3VycmVudC5BdG9taWNEb3VibGUAAAAAAAAAAAMAAHhxAH4AVHcIQVAzdMAAAAB4c3EAfgBTAAAAAABAzdNzcQB+AFd3CAAAAAAAAAAAeHNxAH4AUwAAAAAAQM3TdAAIYXVkaXRMb2dzcQB+AE9zcQB+AFMAAAAAAAAAAnNxAH4AUwAAAAADmeB/c3EAfgBXdwhBfWmTYAAAAHhzcQB+AFMAAAAAABNR7XNxAH4AV3cIQxjcIfh8loh4c3EAfgBTAAAAAAOtMmx0AA1vblJlY29uU2NyaXB0c3EAfgBPc3EAfgBTAAAAAAAAAAFzcQB+AFMAAAAAG11xmHNxAH4AV3cIQbtdcZgAAAB4c3EAfgBTAAAAABtdcZhzcQB+AFd3CAAAAAAAAAAAeHNxAH4AUwAAAAAbXXGYcHB4c3IAKWphdmEudXRpbC5jb25jdXJyZW50LmF0b21pYy5BdG9taWNJbnRlZ2VyVj9ezIxsFooCAAFJAAV2YWx1ZXhxAH4AVAAAAABzcQB+AGwAAAAAcQB+AAhxAH4AC3EAfgAYc3EAfgBsAAAAAHNxAH4ADT9AAAAAAAAAdwgAAAAQAAAAAHhzcgA0b3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5zdGF0cy5QaGFzZVN0YXRpc3RpYwAAAAAAAAABAgAJSgAMcGhhc2VFbmRUaW1lSgAOcGhhc2VTdGFydFRpbWVKAAxxdWVyeUVuZFRpbWVKAA5xdWVyeVN0YXJ0VGltZUwABG5hbWVxAH4AAUwACG5vdFZhbGlkdAAsTGphdmEvdXRpbC9jb25jdXJyZW50L0NvbmN1cnJlbnRMaW5rZWRRdWV1ZTtMAAVwaGFzZXQAPExvcmcvZm9yZ2Vyb2NrL29wZW5pZG0vc3luYy9pbXBsL3N0YXRzL1BoYXNlU3RhdGlzdGljJFBoYXNlO0wAEHByb2Nlc3NlZEVudHJpZXNxAH4AUEwAD3NpdHVhdGlvbkNvdW50c3EAfgAgeHAAAAAAAAAAAAAAAAAAAAAAAAABbD3cqhEAAAFsPdyqDXEAfgASc3IAKmphdmEudXRpbC5jb25jdXJyZW50LkNvbmN1cnJlbnRMaW5rZWRRdWV1ZQK6+ypmTHCMAwAAeHBweH5yADpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLnN0YXRzLlBoYXNlU3RhdGlzdGljJFBoYXNlAAAAAAAAAAASAAB4cQB+ABp0AAZTT1VSQ0VzcQB+AFMAAAAAAAAAAHNyACVqYXZhLnV0aWwuQ29sbGVjdGlvbnMkVW5tb2RpZmlhYmxlTWFw8aWo/nT1B0ICAAFMAAFtcQB+ACB4cHNyABFqYXZhLnV0aWwuRW51bU1hcAZdffe+kHyhAwABTAAHa2V5VHlwZXQAEUxqYXZhL2xhbmcvQ2xhc3M7eHB2cgApb3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5TaXR1YXRpb24AAAAAAAAAABIAAHhxAH4AGncEAAAADX5xAH4AgHQACUNPTkZJUk1FRHNxAH4AbAAAAAB+cQB+AIB0AAVGT1VORHNxAH4AbAAAAAB+cQB+AIB0ABRGT1VORF9BTFJFQURZX0xJTktFRHNxAH4AbAAAAAB+cQB+AIB0AAZBQlNFTlRzcQB+AGwAAAAAfnEAfgCAdAAJQU1CSUdVT1VTc3EAfgBsAAAAAH5xAH4AgHQAB01JU1NJTkdzcQB+AGwAAAAAfnEAfgCAdAALVU5RVUFMSUZJRURzcQB+AGwAAAAAfnEAfgCAdAAOU09VUkNFX0lHTk9SRURzcQB+AGwAAAAAfnEAfgCAdAAOVEFSR0VUX0lHTk9SRURzcQB+AGwAAAAAfnEAfgCAdAAKVU5BU1NJR05FRHNxAH4AbAAAAAB+cQB+AIB0AA5TT1VSQ0VfTUlTU0lOR3NxAH4AbAAAAAB+cQB+AIB0AAlMSU5LX09OTFlzcQB+AGwAAAAAfnEAfgCAdAAIQUxMX0dPTkVzcQB+AGwAAAAAeHNxAH4AIwAAAA8AAAAcdXEAfgAmAAAAEHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAfnEAfgAZdAAUQUNUSVZFX1FVRVJZX0VOVFJJRVNzcQB+ACMAAAAPAAAAHHVxAH4AJgAAABBzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHQACXN0YXJ0VGltZXNyAA5qYXZhLmxhbmcuTG9uZzuL5JDMjyPfAgABSgAFdmFsdWV4cQB+AFQAAAFsPdyoQXQAB2VuZFRpbWVzcQB+APAAAAFsPdyqqnBweHBweHNxAH4AfXZyACdvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uYXVkaXQudXRpbC5TdGF0dXMAAAAAAAAAABIAAHhxAH4AGncEAAAAAn5xAH4A9XQAB1NVQ0NFU1NzcQB+AGwAAAAAfnEAfgD1dAAHRkFJTFVSRXNxAH4AbAAAAAB4c3EAfgBsAAAAAHNxAH4AbAAAAABzcQB+AHEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFsPdyqgHEAfgAXc3EAfgB1cHh+cQB+AHd0AAZUQVJHRVRzcQB+AFMAAAAAAAAAAHNxAH4Ae3NxAH4AfXEAfgCBdwQAAAANcQB+AIJzcQB+AGwAAAAAcQB+AIVzcQB+AGwAAAAAcQB+AIhzcQB+AGwAAAAAcQB+AItzcQB+AGwAAAAAcQB+AI5zcQB+AGwAAAAAcQB+AJFzcQB+AGwAAAAAcQB+AJRzcQB+AGwAAAAAcQB+AJdzcQB+AGwAAAAAcQB+AJpzcQB+AGwAAAAAcQB+AJ1zcQB+AGwAAAAAcQB+AKBzcQB+AGwAAAAAcQB+AKNzcQB+AGwAAAAAcQB+AKZzcQB+AGwAAAAAeHNyAC9vcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLlRvdGFsRW50cnlWYWx1ZQAAAAAAAAABAgABSQAFdG90YWx4cIAAAABzcQB+ARMAAAABc3EAfgETgAAAAA==","startTime":1564405966876,"isComplete":true,"_rev":"2","_id":"17f22b36-820b-41bd-b4a4-67040421c417"}
1	12	fe89906d-e336-459d-ae35-e05b35d69064	2	{"reconId":"6f084858-818f-47e1-b1f6-113b847ca1b1-15","serializedState":"rO0ABXNyADJvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLlJlY29uUHJvZ3Jlc3NTdGF0ZQAAAAAAAAABAgAKWgALaXNDbHVzdGVyZWRMAAttYXBwaW5nTmFtZXQAEkxqYXZhL2xhbmcvU3RyaW5nO0wACG5vZGVzSWRzdAAPTGphdmEvdXRpbC9TZXQ7TAAScmVjb25IYW5kbGVyUGFyYW1zdAASTGphdmEvbGFuZy9PYmplY3Q7TAAHcmVjb25JZHEAfgABTAAKcmVjb25TdGFnZXQALExvcmcvZm9yZ2Vyb2NrL29wZW5pZG0vc3luYy9pbXBsL1JlY29uU3RhZ2U7TAAXcmVjb25jaWxpYXRpb25TdGF0aXN0aWN0AD9Mb3JnL2Zvcmdlcm9jay9vcGVuaWRtL3N5bmMvaW1wbC9zdGF0cy9SZWNvbmNpbGlhdGlvblN0YXRpc3RpYztMABB0b3RhbExpbmtFbnRyaWVzdAAxTG9yZy9mb3JnZXJvY2svb3BlbmlkbS9zeW5jL2ltcGwvVG90YWxFbnRyeVZhbHVlO0wAEnRvdGFsU291cmNlRW50cmllc3EAfgAGTAASdG90YWxUYXJnZXRFbnRyaWVzcQB+AAZ4cAB0ABxtYW5hZ2VkUm9sZV9zeXN0ZW1MZGFwR3JvdXAwc3IAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAAMNDkzYzg1ZTAwYWI3eHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cgARamF2YS51dGlsLkhhc2hNYXAFB9rBwxZg0QMAAkYACmxvYWRGYWN0b3JJAAl0aHJlc2hvbGR4cD9AAAAAAAADdwgAAAAEAAAAAnQAC3NvdXJjZVF1ZXJ5c3EAfgAMP0AAAAAAAAx3CAAAABAAAAACdAAMcmVzb3VyY2VOYW1ldAAMbWFuYWdlZC9yb2xldAAHcXVlcnlJZHQADXF1ZXJ5LWFsbC1pZHN4AHQAC3RhcmdldFF1ZXJ5c3EAfgAMP0AAAAAAAAx3CAAAABAAAAACcQB+ABF0ABFzeXN0ZW0vbGRhcC9ncm91cHEAfgATcQB+ABR4AHgAdAAnNmYwODQ4NTgtODE4Zi00N2UxLWIxZjYtMTEzYjg0N2NhMWIxLTE1fnIAKm9yZy5mb3JnZXJvY2sub3BlbmlkbS5zeW5jLmltcGwuUmVjb25TdGFnZQAAAAAAAAAAEgAAeHIADmphdmEubGFuZy5FbnVtAAAAAAAAAAASAAB4cHQAEENPTVBMRVRFRF9GQUlMRURzcgA9b3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5zdGF0cy5SZWNvbmNpbGlhdGlvblN0YXRpc3RpYwAAAAAAAAABAgASSgAHZW5kVGltZUoAEGxpbmtRdWVyeUVuZFRpbWVKABJsaW5rUXVlcnlTdGFydFRpbWVKAAlzdGFydFRpbWVMAAxkdXJhdGlvblN0YXR0AChMamF2YS91dGlsL2NvbmN1cnJlbnQvQ29uY3VycmVudEhhc2hNYXA7TAALbGlua0NyZWF0ZWR0ACtMamF2YS91dGlsL2NvbmN1cnJlbnQvYXRvbWljL0F0b21pY0ludGVnZXI7TAANbGlua1Byb2Nlc3NlZHEAfgAfTAALbWFwcGluZ05hbWVxAH4AAUwABm5vZGVJZHEAfgABTAAHcmVjb25JZHEAfgABTAAPc291cmNlUHJvY2Vzc2VkcQB+AB9MABVzb3VyY2VQcm9jZXNzZWRCeU5vZGV0AA9MamF2YS91dGlsL01hcDtMAApzb3VyY2VTdGF0dAA2TG9yZy9mb3JnZXJvY2svb3BlbmlkbS9zeW5jL2ltcGwvc3RhdHMvUGhhc2VTdGF0aXN0aWM7TAAJc3RhZ2VTdGF0cQB+ACBMAA9zdGF0dXNQcm9jZXNzZWRxAH4AIEwADXRhcmdldENyZWF0ZWRxAH4AH0wAD3RhcmdldFByb2Nlc3NlZHEAfgAfTAAKdGFyZ2V0U3RhdHEAfgAheHAAAAFsPdyqSgAAAAAAAAAAAAAAAAAAAAAAAAFsPdym7HNyACZqYXZhLnV0aWwuY29uY3VycmVudC5Db25jdXJyZW50SGFzaE1hcGSZ3hKdhyk9AwADSQALc2VnbWVudE1hc2tJAAxzZWdtZW50U2hpZnRbAAhzZWdtZW50c3QAMVtMamF2YS91dGlsL2NvbmN1cnJlbnQvQ29uY3VycmVudEhhc2hNYXAkU2VnbWVudDt4cAAAAA8AAAAcdXIAMVtMamF2YS51dGlsLmNvbmN1cnJlbnQuQ29uY3VycmVudEhhc2hNYXAkU2VnbWVudDtSdz9BMps5dAIAAHhwAAAAEHNyAC5qYXZhLnV0aWwuY29uY3VycmVudC5Db25jdXJyZW50SGFzaE1hcCRTZWdtZW50HzZMkFiTKT0CAAFGAApsb2FkRmFjdG9yeHIAKGphdmEudXRpbC5jb25jdXJyZW50LmxvY2tzLlJlZW50cmFudExvY2tmVagsLMhq6wIAAUwABHN5bmN0AC9MamF2YS91dGlsL2NvbmN1cnJlbnQvbG9ja3MvUmVlbnRyYW50TG9jayRTeW5jO3hwc3IANGphdmEudXRpbC5jb25jdXJyZW50LmxvY2tzLlJlZW50cmFudExvY2skTm9uZmFpclN5bmNliDLnU3u/CwIAAHhyAC1qYXZhLnV0aWwuY29uY3VycmVudC5sb2Nrcy5SZWVudHJhbnRMb2NrJFN5bmO4HqKUqkRafAIAAHhyADVqYXZhLnV0aWwuY29uY3VycmVudC5sb2Nrcy5BYnN0cmFjdFF1ZXVlZFN5bmNocm9uaXplcmZVqEN1P1LjAgABSQAFc3RhdGV4cgA2amF2YS51dGlsLmNvbmN1cnJlbnQubG9ja3MuQWJzdHJhY3RPd25hYmxlU3luY2hyb25pemVyM9+vua1tb6kCAAB4cAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAcQB+AA9zcgAtb3JnLmZvcmdlcm9jay5vcGVuaWRtLnV0aWwuRHVyYXRpb25TdGF0aXN0aWNzlw58liJb1AkCAAZMAApkZWx0YUNvdW50dAAoTGphdmEvdXRpbC9jb25jdXJyZW50L2F0b21pYy9BdG9taWNMb25nO0wACGRlbHRhTWF4cQB+AFBMAAlkZWx0YU1lYW50ADlMb3JnL2Zvcmdlcm9jay9ndWF2YS9jb21tb24vdXRpbC9jb25jdXJyZW50L0F0b21pY0RvdWJsZTtMAAhkZWx0YU1pbnEAfgBQTAALZGVsdGFTdGREZXZxAH4AUUwACGRlbHRhU3VtcQB+AFB4cHNyACZqYXZhLnV0aWwuY29uY3VycmVudC5hdG9taWMuQXRvbWljTG9uZxrA+rR3ABcYAgABSgAFdmFsdWV4cgAQamF2YS5sYW5nLk51bWJlcoaslR0LlOCLAgAAeHAAAAAAAAAAAXNxAH4AUwAAAAACcuIoc3IAN29yZy5mb3JnZXJvY2suZ3VhdmEuY29tbW9uLnV0aWwuY29uY3VycmVudC5BdG9taWNEb3VibGUAAAAAAAAAAAMAAHhxAH4AVHcIQYOXEUAAAAB4c3EAfgBTAAAAAAJy4ihzcQB+AFd3CAAAAAAAAAAAeHNxAH4AUwAAAAACcuIodAAIYXVkaXRMb2dzcQB+AE9zcQB+AFMAAAAAAAAAAnNxAH4AUwAAAAAGrW1jc3EAfgBXdwhBk4IcEAAAAHhzcQB+AFMAAAAAAxOgpXNxAH4AV3cIQxnuZaW2ugh4c3EAfgBTAAAAAAnBDgh0AA1vblJlY29uU2NyaXB0c3EAfgBPc3EAfgBTAAAAAAAAAAFzcQB+AFMAAAAAEKNoIXNxAH4AV3cIQbCjaCEAAAB4c3EAfgBTAAAAABCjaCFzcQB+AFd3CAAAAAAAAAAAeHNxAH4AUwAAAAAQo2ghcHB4c3IAKWphdmEudXRpbC5jb25jdXJyZW50LmF0b21pYy5BdG9taWNJbnRlZ2VyVj9ezIxsFooCAAFJAAV2YWx1ZXhxAH4AVAAAAABzcQB+AGwAAAAAcQB+AAhxAH4AC3EAfgAYc3EAfgBsAAAAAHNxAH4ADT9AAAAAAAAAdwgAAAAQAAAAAHhzcgA0b3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5zdGF0cy5QaGFzZVN0YXRpc3RpYwAAAAAAAAABAgAJSgAMcGhhc2VFbmRUaW1lSgAOcGhhc2VTdGFydFRpbWVKAAxxdWVyeUVuZFRpbWVKAA5xdWVyeVN0YXJ0VGltZUwABG5hbWVxAH4AAUwACG5vdFZhbGlkdAAsTGphdmEvdXRpbC9jb25jdXJyZW50L0NvbmN1cnJlbnRMaW5rZWRRdWV1ZTtMAAVwaGFzZXQAPExvcmcvZm9yZ2Vyb2NrL29wZW5pZG0vc3luYy9pbXBsL3N0YXRzL1BoYXNlU3RhdGlzdGljJFBoYXNlO0wAEHByb2Nlc3NlZEVudHJpZXNxAH4AUEwAD3NpdHVhdGlvbkNvdW50c3EAfgAgeHAAAAAAAAAAAAAAAAAAAAAAAAABbD3cqTcAAAFsPdypDnEAfgASc3IAKmphdmEudXRpbC5jb25jdXJyZW50LkNvbmN1cnJlbnRMaW5rZWRRdWV1ZQK6+ypmTHCMAwAAeHBweH5yADpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLnN0YXRzLlBoYXNlU3RhdGlzdGljJFBoYXNlAAAAAAAAAAASAAB4cQB+ABp0AAZTT1VSQ0VzcQB+AFMAAAAAAAAAAHNyACVqYXZhLnV0aWwuQ29sbGVjdGlvbnMkVW5tb2RpZmlhYmxlTWFw8aWo/nT1B0ICAAFMAAFtcQB+ACB4cHNyABFqYXZhLnV0aWwuRW51bU1hcAZdffe+kHyhAwABTAAHa2V5VHlwZXQAEUxqYXZhL2xhbmcvQ2xhc3M7eHB2cgApb3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMuaW1wbC5TaXR1YXRpb24AAAAAAAAAABIAAHhxAH4AGncEAAAADX5xAH4AgHQACUNPTkZJUk1FRHNxAH4AbAAAAAB+cQB+AIB0AAVGT1VORHNxAH4AbAAAAAB+cQB+AIB0ABRGT1VORF9BTFJFQURZX0xJTktFRHNxAH4AbAAAAAB+cQB+AIB0AAZBQlNFTlRzcQB+AGwAAAAAfnEAfgCAdAAJQU1CSUdVT1VTc3EAfgBsAAAAAH5xAH4AgHQAB01JU1NJTkdzcQB+AGwAAAAAfnEAfgCAdAALVU5RVUFMSUZJRURzcQB+AGwAAAAAfnEAfgCAdAAOU09VUkNFX0lHTk9SRURzcQB+AGwAAAAAfnEAfgCAdAAOVEFSR0VUX0lHTk9SRURzcQB+AGwAAAAAfnEAfgCAdAAKVU5BU1NJR05FRHNxAH4AbAAAAAB+cQB+AIB0AA5TT1VSQ0VfTUlTU0lOR3NxAH4AbAAAAAB+cQB+AIB0AAlMSU5LX09OTFlzcQB+AGwAAAAAfnEAfgCAdAAIQUxMX0dPTkVzcQB+AGwAAAAAeHNxAH4AIwAAAA8AAAAcdXEAfgAmAAAAEHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAfnEAfgAZdAAUQUNUSVZFX1FVRVJZX0VOVFJJRVNzcQB+ACMAAAAPAAAAHHVxAH4AJgAAABBzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHNxAH4AKHNxAH4ALAAAAAA/QAAAc3EAfgAoc3EAfgAsAAAAAD9AAABzcQB+AChzcQB+ACwAAAAAP0AAAHQACXN0YXJ0VGltZXNyAA5qYXZhLmxhbmcuTG9uZzuL5JDMjyPfAgABSgAFdmFsdWV4cQB+AFQAAAFsPdynwXQAB2VuZFRpbWVzcQB+APAAAAFsPdyqSXBweHBweHNxAH4AfXZyACdvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uYXVkaXQudXRpbC5TdGF0dXMAAAAAAAAAABIAAHhxAH4AGncEAAAAAn5xAH4A9XQAB1NVQ0NFU1NzcQB+AGwAAAAAfnEAfgD1dAAHRkFJTFVSRXNxAH4AbAAAAAB4c3EAfgBsAAAAAHNxAH4AbAAAAABzcQB+AHEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFsPdypk3EAfgAXc3EAfgB1cHh+cQB+AHd0AAZUQVJHRVRzcQB+AFMAAAAAAAAAAHNxAH4Ae3NxAH4AfXEAfgCBdwQAAAANcQB+AIJzcQB+AGwAAAAAcQB+AIVzcQB+AGwAAAAAcQB+AIhzcQB+AGwAAAAAcQB+AItzcQB+AGwAAAAAcQB+AI5zcQB+AGwAAAAAcQB+AJFzcQB+AGwAAAAAcQB+AJRzcQB+AGwAAAAAcQB+AJdzcQB+AGwAAAAAcQB+AJpzcQB+AGwAAAAAcQB+AJ1zcQB+AGwAAAAAcQB+AKBzcQB+AGwAAAAAcQB+AKNzcQB+AGwAAAAAcQB+AKZzcQB+AGwAAAAAeHNyAC9vcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luYy5pbXBsLlRvdGFsRW50cnlWYWx1ZQAAAAAAAAABAgABSQAFdG90YWx4cIAAAABzcQB+ARMAAAAGc3EAfgETgAAAAA==","startTime":1564405966572,"isComplete":true,"_rev":"2","_id":"fe89906d-e336-459d-ae35-e05b35d69064"}
\.


--
-- Name: genericobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('genericobjects_id_seq', 2, true);


--
-- Data for Name: internalrole; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY internalrole (objectid, rev, description) FROM stdin;
openidm-authorized	0	Basic minimum user
openidm-admin	0	Administrative access
openidm-cert	0	Authenticated via certificate
openidm-tasks-manager	0	Allowed to reassign workflow tasks
openidm-reg	0	Anonymous access
\.


--
-- Data for Name: internaluser; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY internaluser (objectid, rev, pwd, roles) FROM stdin;
openidm-admin	0	openidm-admin	[ { "_ref" : "repo/internal/role/openidm-admin" }, { "_ref" : "repo/internal/role/openidm-authorized" } ]
anonymous	0	anonymous	[ { "_ref" : "repo/internal/role/openidm-reg" } ]
\.


--
-- Data for Name: links; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY links (objectid, rev, linktype, linkqualifier, firstid, secondid) FROM stdin;
6a14c344-f839-40b6-bcd2-2581f6d531fe	0	managedRole_systemLdapGroup0	default	citizen	7553b356-9615-4b52-a1f8-2ad9478e676a
e54c41cd-d333-498b-a2fe-6aaf84b9c887	0	managedRole_systemLdapGroup0	default	solicitor	668a9a7d-dc10-4768-b07a-0a3da3cf0e89
ba5495c5-e845-48b8-9218-b8111071262e	0	managedRole_systemLdapGroup0	default	letter-holder	ab4a5b58-6bb4-443e-9cc5-5cc824bf23b6
0e377901-a7a4-4c41-a177-3f4a882301ef	0	managedRole_systemLdapGroup0	default	IDAM_ADMIN_USER	9fc0d36f-9950-4301-80f0-17530db40799
7eeaaa81-c6fe-4542-a8b1-3c1d17ff36cf	0	managedRole_systemLdapGroup0	default	IDAM_SUPER_USER	0f75f4e9-28e6-4dd7-9574-cb5f3d2feee6
412904a7-b948-4680-85f3-a91e191f278a	0	managedRole_systemLdapGroup0	default	IDAM_SYSTEM_OWNER	398c5d8e-25e1-4aff-8223-99d4f7b3cc7e
c641b69c-7447-4659-9e01-8dcd22d38532	0	managedUser_systemLdapAccount	default	cf9aba46-30d1-4102-ad78-3ff0ee84ac27	da500528-37a1-4f35-9427-c151e498dc28
2f744018-16f0-4b88-ab6e-5d904639e117	0	managedRole_systemLdapGroup0	default	a116f566-b548-4b48-b95a-d2f758d6dc37	acc50d11-04d5-41c0-a137-29b1183474b2
74289d93-deb9-48c7-8ab7-49acc3966a80	0	managedRole_systemLdapGroup0	default	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d	5c618142-e575-4ab5-8ac3-4539ce9bd112
1ccd3814-43ee-480e-80cb-8ca55b017399	0	managedRole_systemLdapGroup0	default	2cc3c15e-277e-4281-bfb4-5efd372dccbb	b7e4d8e9-c6ed-4bc0-a95b-5cecca4a6770
dfbe5640-b67d-4a24-9d5d-271299b657c0	0	managedRole_systemLdapGroup0	default	6d5b60a4-2e96-459d-93a3-3642d019eabc	99963e82-df2f-4a60-ac90-047eab22c52a
c6c46734-da13-47c5-9b5a-407c9c826ad7	0	managedRole_systemLdapGroup0	default	0086da2d-5cf4-46fd-a7d4-59018982ed88	3f15b895-48ac-4f3b-9409-e5bf8ef0b6ea
55ea5b7f-89be-45bd-a3e3-ae996e8d19a5	0	managedRole_systemLdapGroup0	default	0e30b8d1-534b-476e-bacb-025328800d21	8962956f-f738-42b4-b4dc-fff96423f07f
72c30da4-eb51-409e-acb1-c2e70e9986f7	0	managedRole_systemLdapGroup0	default	86a2595d-0daf-4f7c-974d-f54ecae57832	1d67350d-aaf4-4686-876d-7e08dc5c282e
357b45c1-16ac-460a-a556-0883bffe5813	0	managedRole_systemLdapGroup0	default	ce646a01-8d62-42b9-9941-226620e1e3a1	0f3260a3-6ea8-4fea-99ac-f3af1e37e1bb
db3ad477-96c5-45dd-b3c3-3f77add02174	0	managedRole_systemLdapGroup0	default	d782a3c8-7140-4240-ab4c-43da97765b86	7d663a6d-01cf-4fdf-92b4-5ab262ff48ea
d650bcc0-620a-4ae6-b7d7-5a9b2a58af8a	0	managedRole_systemLdapGroup0	default	72d23e7d-9ee9-4195-805f-11fb226eaad7	67db170c-3fde-4856-bce9-067bd52a0809
1817d72f-a41d-4fb7-b6ae-f602d1d3452e	0	managedRole_systemLdapGroup0	default	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae	5f7c111e-7fbf-4d27-834b-8111b0a807e1
7bc28a7f-f512-4990-9a8f-7bd6a25efb84	0	managedRole_systemLdapGroup0	default	0cd2d788-0859-4870-8e06-710112fafe82	5cd4cbd9-050c-46c9-969a-38f5f4255103
13fd66ca-4d0f-4524-ba2d-6c955d8b49a8	0	managedRole_systemLdapGroup0	default	ba40315a-59d7-4b23-acdb-039282082d60	15180e0a-d311-40d1-b16d-ea3df6626a7e
1e87c0a0-5800-407d-9ab2-d99c9f56f2f0	0	managedRole_systemLdapGroup0	default	a069a459-dd5f-442f-a09b-1c2d8555af94	2a1db682-480e-4a1b-8096-b48cfbc03509
\.


--
-- Data for Name: managedobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY managedobjectproperties (managedobjects_id, propkey, proptype, propvalue) FROM stdin;
2	/_id	java.lang.String	citizen
2	/name	java.lang.String	citizen
2	/description	java.lang.String	Citizen
2	/mapping	java.lang.String	managedUser_systemLdapAccount
2	/attributes/0/name	java.lang.String	ldapGroups
2	/attributes/0/value/0	java.lang.String	cn=citizen,ou=groups,dc=reform,dc=hmcts,dc=net
2	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
2	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
2	/_rev	java.lang.String	0
1	/_id	java.lang.String	citizen
1	/name	java.lang.String	citizen
1	/description	java.lang.String	Citizen
1	/_rev	java.lang.String	1
4	/_id	java.lang.String	solicitor
4	/name	java.lang.String	solicitor
4	/description	java.lang.String	Solicitor
4	/mapping	java.lang.String	managedUser_systemLdapAccount
4	/attributes/0/name	java.lang.String	ldapGroups
4	/attributes/0/value/0	java.lang.String	cn=solicitor,ou=groups,dc=reform,dc=hmcts,dc=net
4	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
4	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
4	/_rev	java.lang.String	0
3	/_id	java.lang.String	solicitor
3	/name	java.lang.String	solicitor
3	/description	java.lang.String	Solicitor
3	/_rev	java.lang.String	1
6	/_id	java.lang.String	letter-holder
6	/name	java.lang.String	letter-holder
6	/description	java.lang.String	Letter Holder
6	/mapping	java.lang.String	managedUser_systemLdapAccount
6	/attributes/0/name	java.lang.String	ldapGroups
6	/attributes/0/value/0	java.lang.String	cn=letter-holder,ou=groups,dc=reform,dc=hmcts,dc=net
6	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
6	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
6	/_rev	java.lang.String	0
5	/_id	java.lang.String	letter-holder
5	/name	java.lang.String	letter-holder
5	/description	java.lang.String	Letter Holder
5	/_rev	java.lang.String	1
8	/_id	java.lang.String	IDAM_ADMIN_USER
8	/name	java.lang.String	IDAM_ADMIN_USER
8	/description	java.lang.String	IdAM Admin User
8	/mapping	java.lang.String	managedUser_systemLdapAccount
8	/attributes/0/name	java.lang.String	ldapGroups
8	/attributes/0/value/0	java.lang.String	cn=IDAM_ADMIN_USER,ou=groups,dc=reform,dc=hmcts,dc=net
8	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
8	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
8	/_rev	java.lang.String	0
10	/_id	java.lang.String	IDAM_SUPER_USER
10	/name	java.lang.String	IDAM_SUPER_USER
10	/description	java.lang.String	IdAM Super User
10	/mapping	java.lang.String	managedUser_systemLdapAccount
10	/attributes/0/name	java.lang.String	ldapGroups
10	/attributes/0/value/0	java.lang.String	cn=IDAM_SUPER_USER,ou=groups,dc=reform,dc=hmcts,dc=net
10	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
10	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
10	/_rev	java.lang.String	0
12	/_id	java.lang.String	IDAM_SYSTEM_OWNER
12	/name	java.lang.String	IDAM_SYSTEM_OWNER
12	/description	java.lang.String	IdAM System Owner
12	/mapping	java.lang.String	managedUser_systemLdapAccount
12	/attributes/0/name	java.lang.String	ldapGroups
12	/attributes/0/value/0	java.lang.String	cn=IDAM_SYSTEM_OWNER,ou=groups,dc=reform,dc=hmcts,dc=net
12	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
12	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
12	/_rev	java.lang.String	0
36	/_id	java.lang.String	ce646a01-8d62-42b9-9941-226620e1e3a1
9	/_id	java.lang.String	IDAM_SUPER_USER
9	/name	java.lang.String	IDAM_SUPER_USER
9	/description	java.lang.String	IdAM Super User
9	/assignableRoles/0	java.lang.String	IDAM_ADMIN_USER
9	/_rev	java.lang.String	2
7	/_id	java.lang.String	IDAM_ADMIN_USER
7	/name	java.lang.String	IDAM_ADMIN_USER
7	/description	java.lang.String	IdAM Admin User
7	/assignableRoles/0	java.lang.String	citizen
7	/_rev	java.lang.String	2
36	/name	java.lang.String	caseworker-sscs-judge
36	/description	java.lang.String	caseworker-sscs-judge
36	/mapping	java.lang.String	managedUser_systemLdapAccount
36	/attributes/0/name	java.lang.String	ldapGroups
15	/_id	java.lang.String	a116f566-b548-4b48-b95a-d2f758d6dc37
15	/name	java.lang.String	ccd-import
15	/description	java.lang.String	ccd-import
15	/mapping	java.lang.String	managedUser_systemLdapAccount
15	/attributes/0/name	java.lang.String	ldapGroups
15	/attributes/0/value/0	java.lang.String	cn=ccd-import,ou=groups,dc=reform,dc=hmcts,dc=net
15	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
15	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
15	/_rev	java.lang.String	0
36	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-judge,ou=groups,dc=reform,dc=hmcts,dc=net
36	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
14	/name	java.lang.String	ccd-import
14	/description	java.lang.String	ccd-import
14	/_id	java.lang.String	a116f566-b548-4b48-b95a-d2f758d6dc37
14	/_rev	java.lang.String	1
33	/_id	java.lang.String	86a2595d-0daf-4f7c-974d-f54ecae57832
33	/name	java.lang.String	caseworker-sscs-callagent
33	/description	java.lang.String	caseworker-sscs-callagent
33	/mapping	java.lang.String	managedUser_systemLdapAccount
33	/attributes/0/name	java.lang.String	ldapGroups
33	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-callagent,ou=groups,dc=reform,dc=hmcts,dc=net
33	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
33	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
33	/_rev	java.lang.String	0
32	/name	java.lang.String	caseworker-sscs-callagent
18	/_id	java.lang.String	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d
18	/name	java.lang.String	caseworker-sscs
18	/description	java.lang.String	caseworker-sscs
18	/mapping	java.lang.String	managedUser_systemLdapAccount
18	/attributes/0/name	java.lang.String	ldapGroups
18	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs,ou=groups,dc=reform,dc=hmcts,dc=net
18	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
18	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
18	/_rev	java.lang.String	0
17	/name	java.lang.String	caseworker-sscs
17	/description	java.lang.String	caseworker-sscs
17	/_id	java.lang.String	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d
17	/_rev	java.lang.String	1
32	/description	java.lang.String	caseworker-sscs-callagent
32	/_id	java.lang.String	86a2595d-0daf-4f7c-974d-f54ecae57832
32	/_rev	java.lang.String	1
21	/_id	java.lang.String	2cc3c15e-277e-4281-bfb4-5efd372dccbb
21	/name	java.lang.String	caseworker-sscs-systemupdate
21	/description	java.lang.String	caseworker-sscs-systemupdate
21	/mapping	java.lang.String	managedUser_systemLdapAccount
21	/attributes/0/name	java.lang.String	ldapGroups
21	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-systemupdate,ou=groups,dc=reform,dc=hmcts,dc=net
21	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
21	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
21	/_rev	java.lang.String	0
20	/name	java.lang.String	caseworker-sscs-systemupdate
20	/description	java.lang.String	caseworker-sscs-systemupdate
20	/_id	java.lang.String	2cc3c15e-277e-4281-bfb4-5efd372dccbb
20	/_rev	java.lang.String	1
35	/name	java.lang.String	caseworker-sscs-judge
35	/description	java.lang.String	caseworker-sscs-judge
35	/_id	java.lang.String	ce646a01-8d62-42b9-9941-226620e1e3a1
35	/_rev	java.lang.String	1
24	/_id	java.lang.String	6d5b60a4-2e96-459d-93a3-3642d019eabc
24	/name	java.lang.String	caseworker-sscs-clerk
24	/description	java.lang.String	caseworker-sscs-clerk
24	/mapping	java.lang.String	managedUser_systemLdapAccount
24	/attributes/0/name	java.lang.String	ldapGroups
24	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-clerk,ou=groups,dc=reform,dc=hmcts,dc=net
24	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
24	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
24	/_rev	java.lang.String	0
23	/name	java.lang.String	caseworker-sscs-clerk
23	/description	java.lang.String	caseworker-sscs-clerk
23	/_id	java.lang.String	6d5b60a4-2e96-459d-93a3-3642d019eabc
23	/_rev	java.lang.String	1
39	/_id	java.lang.String	d782a3c8-7140-4240-ab4c-43da97765b86
39	/name	java.lang.String	caseworker-sscs-dwpresponsewriter
39	/description	java.lang.String	caseworker-sscs-dwpresponsewriter
39	/mapping	java.lang.String	managedUser_systemLdapAccount
39	/attributes/0/name	java.lang.String	ldapGroups
39	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-dwpresponsewriter,ou=groups,dc=reform,dc=hmcts,dc=net
27	/_id	java.lang.String	0086da2d-5cf4-46fd-a7d4-59018982ed88
27	/name	java.lang.String	caseworker
27	/description	java.lang.String	caseworker
27	/mapping	java.lang.String	managedUser_systemLdapAccount
27	/attributes/0/name	java.lang.String	ldapGroups
27	/attributes/0/value/0	java.lang.String	cn=caseworker,ou=groups,dc=reform,dc=hmcts,dc=net
27	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
27	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
27	/_rev	java.lang.String	0
26	/name	java.lang.String	caseworker
26	/description	java.lang.String	caseworker
26	/_id	java.lang.String	0086da2d-5cf4-46fd-a7d4-59018982ed88
26	/_rev	java.lang.String	1
36	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
36	/_rev	java.lang.String	0
30	/_id	java.lang.String	0e30b8d1-534b-476e-bacb-025328800d21
30	/name	java.lang.String	caseworker-sscs-anonymouscitizen
30	/description	java.lang.String	caseworker-sscs-anonymouscitizen
30	/mapping	java.lang.String	managedUser_systemLdapAccount
30	/attributes/0/name	java.lang.String	ldapGroups
30	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-anonymouscitizen,ou=groups,dc=reform,dc=hmcts,dc=net
30	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
30	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
30	/_rev	java.lang.String	0
29	/name	java.lang.String	caseworker-sscs-anonymouscitizen
29	/description	java.lang.String	caseworker-sscs-anonymouscitizen
29	/_id	java.lang.String	0e30b8d1-534b-476e-bacb-025328800d21
29	/_rev	java.lang.String	1
39	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
39	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
39	/_rev	java.lang.String	0
38	/name	java.lang.String	caseworker-sscs-dwpresponsewriter
38	/description	java.lang.String	caseworker-sscs-dwpresponsewriter
38	/_id	java.lang.String	d782a3c8-7140-4240-ab4c-43da97765b86
38	/_rev	java.lang.String	1
42	/_id	java.lang.String	72d23e7d-9ee9-4195-805f-11fb226eaad7
42	/name	java.lang.String	caseworker-sscs-registrar
42	/description	java.lang.String	caseworker-sscs-registrar
42	/mapping	java.lang.String	managedUser_systemLdapAccount
42	/attributes/0/name	java.lang.String	ldapGroups
42	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-registrar,ou=groups,dc=reform,dc=hmcts,dc=net
45	/_id	java.lang.String	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae
45	/name	java.lang.String	caseworker-sscs-superuser
45	/description	java.lang.String	caseworker-sscs-superuser
45	/mapping	java.lang.String	managedUser_systemLdapAccount
45	/attributes/0/name	java.lang.String	ldapGroups
45	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-superuser,ou=groups,dc=reform,dc=hmcts,dc=net
45	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
45	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
45	/_rev	java.lang.String	0
42	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
42	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
42	/_rev	java.lang.String	0
41	/name	java.lang.String	caseworker-sscs-registrar
41	/description	java.lang.String	caseworker-sscs-registrar
41	/_id	java.lang.String	72d23e7d-9ee9-4195-805f-11fb226eaad7
41	/_rev	java.lang.String	1
44	/name	java.lang.String	caseworker-sscs-superuser
44	/description	java.lang.String	caseworker-sscs-superuser
44	/_id	java.lang.String	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae
44	/_rev	java.lang.String	1
48	/_id	java.lang.String	0cd2d788-0859-4870-8e06-710112fafe82
48	/name	java.lang.String	caseworker-sscs-teamleader
48	/description	java.lang.String	caseworker-sscs-teamleader
48	/mapping	java.lang.String	managedUser_systemLdapAccount
48	/attributes/0/name	java.lang.String	ldapGroups
48	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-teamleader,ou=groups,dc=reform,dc=hmcts,dc=net
48	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
48	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
48	/_rev	java.lang.String	0
51	/_id	java.lang.String	ba40315a-59d7-4b23-acdb-039282082d60
51	/name	java.lang.String	caseworker-sscs-panelmember
51	/description	java.lang.String	caseworker-sscs-panelmember
51	/mapping	java.lang.String	managedUser_systemLdapAccount
51	/attributes/0/name	java.lang.String	ldapGroups
51	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-panelmember,ou=groups,dc=reform,dc=hmcts,dc=net
51	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
51	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
51	/_rev	java.lang.String	0
50	/name	java.lang.String	caseworker-sscs-panelmember
50	/description	java.lang.String	caseworker-sscs-panelmember
50	/_id	java.lang.String	ba40315a-59d7-4b23-acdb-039282082d60
50	/_rev	java.lang.String	1
47	/name	java.lang.String	caseworker-sscs-teamleader
47	/description	java.lang.String	caseworker-sscs-teamleader
47	/_id	java.lang.String	0cd2d788-0859-4870-8e06-710112fafe82
47	/_rev	java.lang.String	1
54	/_id	java.lang.String	a069a459-dd5f-442f-a09b-1c2d8555af94
54	/name	java.lang.String	caseworker-sscs-bulkscan
54	/description	java.lang.String	caseworker-sscs-bulkscan
54	/mapping	java.lang.String	managedUser_systemLdapAccount
54	/attributes/0/name	java.lang.String	ldapGroups
54	/attributes/0/value/0	java.lang.String	cn=caseworker-sscs-bulkscan,ou=groups,dc=reform,dc=hmcts,dc=net
54	/attributes/0/assignmentOperation	java.lang.String	mergeWithTarget
54	/attributes/0/unassignmentOperation	java.lang.String	removeFromTarget
54	/_rev	java.lang.String	0
11	/_id	java.lang.String	IDAM_SYSTEM_OWNER
11	/_rev	java.lang.String	16
11	/name	java.lang.String	IDAM_SYSTEM_OWNER
11	/description	java.lang.String	IdAM System Owner
11	/assignableRoles/0	java.lang.String	IDAM_SUPER_USER
11	/assignableRoles/1	java.lang.String	a116f566-b548-4b48-b95a-d2f758d6dc37
11	/assignableRoles/2	java.lang.String	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d
11	/assignableRoles/3	java.lang.String	2cc3c15e-277e-4281-bfb4-5efd372dccbb
11	/assignableRoles/4	java.lang.String	6d5b60a4-2e96-459d-93a3-3642d019eabc
11	/assignableRoles/5	java.lang.String	0086da2d-5cf4-46fd-a7d4-59018982ed88
11	/assignableRoles/6	java.lang.String	0e30b8d1-534b-476e-bacb-025328800d21
11	/assignableRoles/7	java.lang.String	86a2595d-0daf-4f7c-974d-f54ecae57832
11	/assignableRoles/8	java.lang.String	ce646a01-8d62-42b9-9941-226620e1e3a1
11	/assignableRoles/9	java.lang.String	d782a3c8-7140-4240-ab4c-43da97765b86
11	/assignableRoles/10	java.lang.String	72d23e7d-9ee9-4195-805f-11fb226eaad7
11	/assignableRoles/11	java.lang.String	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae
11	/assignableRoles/12	java.lang.String	0cd2d788-0859-4870-8e06-710112fafe82
11	/assignableRoles/13	java.lang.String	ba40315a-59d7-4b23-acdb-039282082d60
11	/assignableRoles/14	java.lang.String	a069a459-dd5f-442f-a09b-1c2d8555af94
53	/name	java.lang.String	caseworker-sscs-bulkscan
53	/description	java.lang.String	caseworker-sscs-bulkscan
53	/_id	java.lang.String	a069a459-dd5f-442f-a09b-1c2d8555af94
53	/_rev	java.lang.String	1
\.


--
-- Data for Name: managedobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY managedobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
2	9	citizen	0	{"_id":"citizen","name":"citizen","description":"Citizen","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=citizen,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
1	8	citizen	1	{"_id":"citizen","name":"citizen","description":"Citizen","assignableRoles":[],"conflictingRoles":[],"_rev":"1"}
4	9	solicitor	0	{"_id":"solicitor","name":"solicitor","description":"Solicitor","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=solicitor,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
3	8	solicitor	1	{"_id":"solicitor","name":"solicitor","description":"Solicitor","assignableRoles":[],"conflictingRoles":[],"_rev":"1"}
6	9	letter-holder	0	{"_id":"letter-holder","name":"letter-holder","description":"Letter Holder","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=letter-holder,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
5	8	letter-holder	1	{"_id":"letter-holder","name":"letter-holder","description":"Letter Holder","assignableRoles":[],"conflictingRoles":[],"_rev":"1"}
8	9	IDAM_ADMIN_USER	0	{"_id":"IDAM_ADMIN_USER","name":"IDAM_ADMIN_USER","description":"IdAM Admin User","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=IDAM_ADMIN_USER,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
10	9	IDAM_SUPER_USER	0	{"_id":"IDAM_SUPER_USER","name":"IDAM_SUPER_USER","description":"IdAM Super User","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=IDAM_SUPER_USER,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
12	9	IDAM_SYSTEM_OWNER	0	{"_id":"IDAM_SYSTEM_OWNER","name":"IDAM_SYSTEM_OWNER","description":"IdAM System Owner","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=IDAM_SYSTEM_OWNER,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
9	8	IDAM_SUPER_USER	2	{"_id":"IDAM_SUPER_USER","name":"IDAM_SUPER_USER","description":"IdAM Super User","assignableRoles":["IDAM_ADMIN_USER"],"conflictingRoles":[],"_rev":"2"}
7	8	IDAM_ADMIN_USER	2	{"_id":"IDAM_ADMIN_USER","name":"IDAM_ADMIN_USER","description":"IdAM Admin User","assignableRoles":["citizen"],"conflictingRoles":[],"_rev":"2"}
13	11	cf9aba46-30d1-4102-ad78-3ff0ee84ac27	3	{"password":{"$crypto":{"type":"x-simple-encryption","value":{"cipher":"AES/CBC/PKCS5Padding","salt":"QgF+0uTNolqb2c3hIqmxhA==","data":"LPfMEvFVuuSEw1gtLxfarA==","iv":"GsvabMP8zgIoaSoenqdtOw==","key":"openidm-sym-default","mac":"vLanaXoQOkMMRf/x+aKz+A=="}}},"mail":"idamOwner@HMCTS.NET","sn":"Owner","givenName":"System","userName":"idamOwner@HMCTS.NET","accountStatus":"active","lastChanged":{"date":"2019-04-08T12:46:41.070Z"},"effectiveRoles":[{"_ref":"managed/role/IDAM_SYSTEM_OWNER"}],"effectiveAssignments":[{"_id":"IDAM_SYSTEM_OWNER","name":"IDAM_SYSTEM_OWNER","description":"IdAM System Owner","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=IDAM_SYSTEM_OWNER,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}],"_id":"cf9aba46-30d1-4102-ad78-3ff0ee84ac27","_rev":"3","lastSync":{"managedUser_systemLdapAccount":{"effectiveAssignments":[{"_id":"IDAM_SYSTEM_OWNER","name":"IDAM_SYSTEM_OWNER","description":"IdAM System Owner","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=IDAM_SYSTEM_OWNER,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}],"timestamp":"2019-04-08T12:46:40.981Z"}}}
15	9	a116f566-b548-4b48-b95a-d2f758d6dc37	0	{"_id":"a116f566-b548-4b48-b95a-d2f758d6dc37","name":"ccd-import","description":"ccd-import","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=ccd-import,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
14	8	a116f566-b548-4b48-b95a-d2f758d6dc37	1	{"name":"ccd-import","description":"ccd-import","assignableRoles":[],"conflictingRoles":[],"_id":"a116f566-b548-4b48-b95a-d2f758d6dc37","_rev":"1"}
18	9	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d	0	{"_id":"81cafa26-6d3d-4afc-a10c-d0b5df01ab6d","name":"caseworker-sscs","description":"caseworker-sscs","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
17	8	81cafa26-6d3d-4afc-a10c-d0b5df01ab6d	1	{"name":"caseworker-sscs","description":"caseworker-sscs","assignableRoles":[],"conflictingRoles":[],"_id":"81cafa26-6d3d-4afc-a10c-d0b5df01ab6d","_rev":"1"}
21	9	2cc3c15e-277e-4281-bfb4-5efd372dccbb	0	{"_id":"2cc3c15e-277e-4281-bfb4-5efd372dccbb","name":"caseworker-sscs-systemupdate","description":"caseworker-sscs-systemupdate","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-systemupdate,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
20	8	2cc3c15e-277e-4281-bfb4-5efd372dccbb	1	{"name":"caseworker-sscs-systemupdate","description":"caseworker-sscs-systemupdate","assignableRoles":[],"conflictingRoles":[],"_id":"2cc3c15e-277e-4281-bfb4-5efd372dccbb","_rev":"1"}
24	9	6d5b60a4-2e96-459d-93a3-3642d019eabc	0	{"_id":"6d5b60a4-2e96-459d-93a3-3642d019eabc","name":"caseworker-sscs-clerk","description":"caseworker-sscs-clerk","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-clerk,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
23	8	6d5b60a4-2e96-459d-93a3-3642d019eabc	1	{"name":"caseworker-sscs-clerk","description":"caseworker-sscs-clerk","assignableRoles":[],"conflictingRoles":[],"_id":"6d5b60a4-2e96-459d-93a3-3642d019eabc","_rev":"1"}
27	9	0086da2d-5cf4-46fd-a7d4-59018982ed88	0	{"_id":"0086da2d-5cf4-46fd-a7d4-59018982ed88","name":"caseworker","description":"caseworker","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
26	8	0086da2d-5cf4-46fd-a7d4-59018982ed88	1	{"name":"caseworker","description":"caseworker","assignableRoles":[],"conflictingRoles":[],"_id":"0086da2d-5cf4-46fd-a7d4-59018982ed88","_rev":"1"}
30	9	0e30b8d1-534b-476e-bacb-025328800d21	0	{"_id":"0e30b8d1-534b-476e-bacb-025328800d21","name":"caseworker-sscs-anonymouscitizen","description":"caseworker-sscs-anonymouscitizen","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-anonymouscitizen,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
29	8	0e30b8d1-534b-476e-bacb-025328800d21	1	{"name":"caseworker-sscs-anonymouscitizen","description":"caseworker-sscs-anonymouscitizen","assignableRoles":[],"conflictingRoles":[],"_id":"0e30b8d1-534b-476e-bacb-025328800d21","_rev":"1"}
33	9	86a2595d-0daf-4f7c-974d-f54ecae57832	0	{"_id":"86a2595d-0daf-4f7c-974d-f54ecae57832","name":"caseworker-sscs-callagent","description":"caseworker-sscs-callagent","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-callagent,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
32	8	86a2595d-0daf-4f7c-974d-f54ecae57832	1	{"name":"caseworker-sscs-callagent","description":"caseworker-sscs-callagent","assignableRoles":[],"conflictingRoles":[],"_id":"86a2595d-0daf-4f7c-974d-f54ecae57832","_rev":"1"}
36	9	ce646a01-8d62-42b9-9941-226620e1e3a1	0	{"_id":"ce646a01-8d62-42b9-9941-226620e1e3a1","name":"caseworker-sscs-judge","description":"caseworker-sscs-judge","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-judge,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
35	8	ce646a01-8d62-42b9-9941-226620e1e3a1	1	{"name":"caseworker-sscs-judge","description":"caseworker-sscs-judge","assignableRoles":[],"conflictingRoles":[],"_id":"ce646a01-8d62-42b9-9941-226620e1e3a1","_rev":"1"}
39	9	d782a3c8-7140-4240-ab4c-43da97765b86	0	{"_id":"d782a3c8-7140-4240-ab4c-43da97765b86","name":"caseworker-sscs-dwpresponsewriter","description":"caseworker-sscs-dwpresponsewriter","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-dwpresponsewriter,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
38	8	d782a3c8-7140-4240-ab4c-43da97765b86	1	{"name":"caseworker-sscs-dwpresponsewriter","description":"caseworker-sscs-dwpresponsewriter","assignableRoles":[],"conflictingRoles":[],"_id":"d782a3c8-7140-4240-ab4c-43da97765b86","_rev":"1"}
42	9	72d23e7d-9ee9-4195-805f-11fb226eaad7	0	{"_id":"72d23e7d-9ee9-4195-805f-11fb226eaad7","name":"caseworker-sscs-registrar","description":"caseworker-sscs-registrar","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-registrar,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
41	8	72d23e7d-9ee9-4195-805f-11fb226eaad7	1	{"name":"caseworker-sscs-registrar","description":"caseworker-sscs-registrar","assignableRoles":[],"conflictingRoles":[],"_id":"72d23e7d-9ee9-4195-805f-11fb226eaad7","_rev":"1"}
45	9	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae	0	{"_id":"c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae","name":"caseworker-sscs-superuser","description":"caseworker-sscs-superuser","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-superuser,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
44	8	c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae	1	{"name":"caseworker-sscs-superuser","description":"caseworker-sscs-superuser","assignableRoles":[],"conflictingRoles":[],"_id":"c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae","_rev":"1"}
48	9	0cd2d788-0859-4870-8e06-710112fafe82	0	{"_id":"0cd2d788-0859-4870-8e06-710112fafe82","name":"caseworker-sscs-teamleader","description":"caseworker-sscs-teamleader","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-teamleader,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
47	8	0cd2d788-0859-4870-8e06-710112fafe82	1	{"name":"caseworker-sscs-teamleader","description":"caseworker-sscs-teamleader","assignableRoles":[],"conflictingRoles":[],"_id":"0cd2d788-0859-4870-8e06-710112fafe82","_rev":"1"}
51	9	ba40315a-59d7-4b23-acdb-039282082d60	0	{"_id":"ba40315a-59d7-4b23-acdb-039282082d60","name":"caseworker-sscs-panelmember","description":"caseworker-sscs-panelmember","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-panelmember,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
50	8	ba40315a-59d7-4b23-acdb-039282082d60	1	{"name":"caseworker-sscs-panelmember","description":"caseworker-sscs-panelmember","assignableRoles":[],"conflictingRoles":[],"_id":"ba40315a-59d7-4b23-acdb-039282082d60","_rev":"1"}
54	9	a069a459-dd5f-442f-a09b-1c2d8555af94	0	{"_id":"a069a459-dd5f-442f-a09b-1c2d8555af94","name":"caseworker-sscs-bulkscan","description":"caseworker-sscs-bulkscan","mapping":"managedUser_systemLdapAccount","attributes":[{"name":"ldapGroups","value":["cn=caseworker-sscs-bulkscan,ou=groups,dc=reform,dc=hmcts,dc=net"],"assignmentOperation":"mergeWithTarget","unassignmentOperation":"removeFromTarget"}],"_rev":"0"}
53	8	a069a459-dd5f-442f-a09b-1c2d8555af94	1	{"name":"caseworker-sscs-bulkscan","description":"caseworker-sscs-bulkscan","assignableRoles":[],"conflictingRoles":[],"_id":"a069a459-dd5f-442f-a09b-1c2d8555af94","_rev":"1"}
11	8	IDAM_SYSTEM_OWNER	16	{"_id":"IDAM_SYSTEM_OWNER","_rev":"16","name":"IDAM_SYSTEM_OWNER","description":"IdAM System Owner","assignableRoles":["IDAM_SUPER_USER","a116f566-b548-4b48-b95a-d2f758d6dc37","81cafa26-6d3d-4afc-a10c-d0b5df01ab6d","2cc3c15e-277e-4281-bfb4-5efd372dccbb","6d5b60a4-2e96-459d-93a3-3642d019eabc","0086da2d-5cf4-46fd-a7d4-59018982ed88","0e30b8d1-534b-476e-bacb-025328800d21","86a2595d-0daf-4f7c-974d-f54ecae57832","ce646a01-8d62-42b9-9941-226620e1e3a1","d782a3c8-7140-4240-ab4c-43da97765b86","72d23e7d-9ee9-4195-805f-11fb226eaad7","c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae","0cd2d788-0859-4870-8e06-710112fafe82","ba40315a-59d7-4b23-acdb-039282082d60","a069a459-dd5f-442f-a09b-1c2d8555af94"],"conflictingRoles":[]}
\.


--
-- Name: managedobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('managedobjects_id_seq', 55, true);


--
-- Data for Name: objecttypes; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY objecttypes (id, objecttype) FROM stdin;
1	config
2	cluster/states
3	scheduler
4	scheduler/jobGroups
5	scheduler/jobs
6	scheduler/triggerGroups
7	scheduler/triggers
8	managed/role
9	managed/assignment
10	relationships
11	managed/user
12	reconprogressstate
\.


--
-- Name: objecttypes_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('objecttypes_id_seq', 12, true);


--
-- Data for Name: relationshipproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY relationshipproperties (relationships_id, propkey, proptype, propvalue) FROM stdin;
\.


--
-- Data for Name: relationships; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY relationships (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
1	10	5f671c5b-634a-466d-ae73-d4dbc4593517	0	{"firstId":"managed/assignment/citizen","firstPropertyName":"roles","secondId":"managed/role/citizen","secondPropertyName":"assignments","properties":null,"_id":"5f671c5b-634a-466d-ae73-d4dbc4593517","_rev":"0"}
2	10	c18d9be5-6903-4357-922b-ef04ed5d887a	0	{"firstId":"managed/assignment/solicitor","firstPropertyName":"roles","secondId":"managed/role/solicitor","secondPropertyName":"assignments","properties":null,"_id":"c18d9be5-6903-4357-922b-ef04ed5d887a","_rev":"0"}
3	10	7e48028d-33ba-4533-b62c-b0fff1472a73	0	{"firstId":"managed/assignment/letter-holder","firstPropertyName":"roles","secondId":"managed/role/letter-holder","secondPropertyName":"assignments","properties":null,"_id":"7e48028d-33ba-4533-b62c-b0fff1472a73","_rev":"0"}
4	10	25b58263-4b13-4b59-a94e-91aea9fdfa2c	0	{"firstId":"managed/assignment/IDAM_ADMIN_USER","firstPropertyName":"roles","secondId":"managed/role/IDAM_ADMIN_USER","secondPropertyName":"assignments","properties":null,"_id":"25b58263-4b13-4b59-a94e-91aea9fdfa2c","_rev":"0"}
5	10	22beeb1a-b741-4996-b60e-2e6dd1679119	0	{"firstId":"managed/assignment/IDAM_SUPER_USER","firstPropertyName":"roles","secondId":"managed/role/IDAM_SUPER_USER","secondPropertyName":"assignments","properties":null,"_id":"22beeb1a-b741-4996-b60e-2e6dd1679119","_rev":"0"}
6	10	77da2f03-d992-43a1-a33c-81efcbb1d694	0	{"firstId":"managed/assignment/IDAM_SYSTEM_OWNER","firstPropertyName":"roles","secondId":"managed/role/IDAM_SYSTEM_OWNER","secondPropertyName":"assignments","properties":null,"_id":"77da2f03-d992-43a1-a33c-81efcbb1d694","_rev":"0"}
7	10	5c535c8e-9ea6-4b4e-986e-c0b7e7a57636	0	{"firstId":"managed/user/cf9aba46-30d1-4102-ad78-3ff0ee84ac27","firstPropertyName":"authzRoles","secondId":"repo/internal/role/openidm-authorized","secondPropertyName":"authzMembers","properties":null,"_id":"5c535c8e-9ea6-4b4e-986e-c0b7e7a57636","_rev":"0"}
8	10	ca42686e-43df-4e6b-8ccb-aa14bcb435b4	1	{"firstId":"managed/role/IDAM_SYSTEM_OWNER","firstPropertyName":"members","secondId":"managed/user/cf9aba46-30d1-4102-ad78-3ff0ee84ac27","secondPropertyName":"roles","properties":{},"_rev":"1","_id":"ca42686e-43df-4e6b-8ccb-aa14bcb435b4"}
9	10	58f3acb3-4221-4b6a-8032-afe3f67806f4	0	{"firstId":"managed/assignment/a116f566-b548-4b48-b95a-d2f758d6dc37","firstPropertyName":"roles","secondId":"managed/role/a116f566-b548-4b48-b95a-d2f758d6dc37","secondPropertyName":"assignments","properties":null,"_id":"58f3acb3-4221-4b6a-8032-afe3f67806f4","_rev":"0"}
10	10	f5bd61d0-2d82-429c-834e-5aa2ce697703	0	{"firstId":"managed/assignment/81cafa26-6d3d-4afc-a10c-d0b5df01ab6d","firstPropertyName":"roles","secondId":"managed/role/81cafa26-6d3d-4afc-a10c-d0b5df01ab6d","secondPropertyName":"assignments","properties":null,"_id":"f5bd61d0-2d82-429c-834e-5aa2ce697703","_rev":"0"}
11	10	b11ecf9a-ef13-47b3-b1ab-a52870d3cbb6	0	{"firstId":"managed/assignment/2cc3c15e-277e-4281-bfb4-5efd372dccbb","firstPropertyName":"roles","secondId":"managed/role/2cc3c15e-277e-4281-bfb4-5efd372dccbb","secondPropertyName":"assignments","properties":null,"_id":"b11ecf9a-ef13-47b3-b1ab-a52870d3cbb6","_rev":"0"}
12	10	5a7f7bbf-5f4e-4d05-91bd-82c08d0a8bda	0	{"firstId":"managed/assignment/6d5b60a4-2e96-459d-93a3-3642d019eabc","firstPropertyName":"roles","secondId":"managed/role/6d5b60a4-2e96-459d-93a3-3642d019eabc","secondPropertyName":"assignments","properties":null,"_id":"5a7f7bbf-5f4e-4d05-91bd-82c08d0a8bda","_rev":"0"}
13	10	5e8ff119-7dd8-4da0-8247-1d0ab59b1827	0	{"firstId":"managed/assignment/0086da2d-5cf4-46fd-a7d4-59018982ed88","firstPropertyName":"roles","secondId":"managed/role/0086da2d-5cf4-46fd-a7d4-59018982ed88","secondPropertyName":"assignments","properties":null,"_id":"5e8ff119-7dd8-4da0-8247-1d0ab59b1827","_rev":"0"}
14	10	af3da7a8-edc2-48db-870b-7f0bdef6208c	0	{"firstId":"managed/assignment/0e30b8d1-534b-476e-bacb-025328800d21","firstPropertyName":"roles","secondId":"managed/role/0e30b8d1-534b-476e-bacb-025328800d21","secondPropertyName":"assignments","properties":null,"_id":"af3da7a8-edc2-48db-870b-7f0bdef6208c","_rev":"0"}
15	10	93b5310a-4268-4e03-a4c4-f63429278984	0	{"firstId":"managed/assignment/86a2595d-0daf-4f7c-974d-f54ecae57832","firstPropertyName":"roles","secondId":"managed/role/86a2595d-0daf-4f7c-974d-f54ecae57832","secondPropertyName":"assignments","properties":null,"_id":"93b5310a-4268-4e03-a4c4-f63429278984","_rev":"0"}
16	10	16bea6e0-9a04-4a67-bd61-21a8af8fac92	0	{"firstId":"managed/assignment/ce646a01-8d62-42b9-9941-226620e1e3a1","firstPropertyName":"roles","secondId":"managed/role/ce646a01-8d62-42b9-9941-226620e1e3a1","secondPropertyName":"assignments","properties":null,"_id":"16bea6e0-9a04-4a67-bd61-21a8af8fac92","_rev":"0"}
17	10	bd84d929-ad7e-4029-ae94-c2f4d675d3f9	0	{"firstId":"managed/assignment/d782a3c8-7140-4240-ab4c-43da97765b86","firstPropertyName":"roles","secondId":"managed/role/d782a3c8-7140-4240-ab4c-43da97765b86","secondPropertyName":"assignments","properties":null,"_id":"bd84d929-ad7e-4029-ae94-c2f4d675d3f9","_rev":"0"}
18	10	d08b2273-1006-4172-a85e-780fd96717a3	0	{"firstId":"managed/assignment/72d23e7d-9ee9-4195-805f-11fb226eaad7","firstPropertyName":"roles","secondId":"managed/role/72d23e7d-9ee9-4195-805f-11fb226eaad7","secondPropertyName":"assignments","properties":null,"_id":"d08b2273-1006-4172-a85e-780fd96717a3","_rev":"0"}
19	10	c731a07c-47bc-44b6-a2ff-8b4ad299b84c	0	{"firstId":"managed/assignment/c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae","firstPropertyName":"roles","secondId":"managed/role/c1fe96db-c8e8-4ebb-8528-d1c3fcc54cae","secondPropertyName":"assignments","properties":null,"_id":"c731a07c-47bc-44b6-a2ff-8b4ad299b84c","_rev":"0"}
20	10	b2e063df-59fa-4efb-bfb2-d79db50c7b35	0	{"firstId":"managed/assignment/0cd2d788-0859-4870-8e06-710112fafe82","firstPropertyName":"roles","secondId":"managed/role/0cd2d788-0859-4870-8e06-710112fafe82","secondPropertyName":"assignments","properties":null,"_id":"b2e063df-59fa-4efb-bfb2-d79db50c7b35","_rev":"0"}
21	10	1e6a6eda-36a7-45cf-82eb-c18f8c040200	0	{"firstId":"managed/assignment/ba40315a-59d7-4b23-acdb-039282082d60","firstPropertyName":"roles","secondId":"managed/role/ba40315a-59d7-4b23-acdb-039282082d60","secondPropertyName":"assignments","properties":null,"_id":"1e6a6eda-36a7-45cf-82eb-c18f8c040200","_rev":"0"}
22	10	2ff4a4a9-da96-4b68-a17a-0425f099c768	0	{"firstId":"managed/assignment/a069a459-dd5f-442f-a09b-1c2d8555af94","firstPropertyName":"roles","secondId":"managed/role/a069a459-dd5f-442f-a09b-1c2d8555af94","secondPropertyName":"assignments","properties":null,"_id":"2ff4a4a9-da96-4b68-a17a-0425f099c768","_rev":"0"}
\.


--
-- Name: relationships_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('relationships_id_seq', 22, true);


--
-- Data for Name: schedulerobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY schedulerobjectproperties (schedulerobjects_id, propkey, proptype, propvalue) FROM stdin;
\.


--
-- Data for Name: schedulerobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY schedulerobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
4	3	jobGroupNames	1	{"_id":"jobGroupNames","_rev":"1","names":["scheduler-service-group"]}
5	5	scheduler-service-group_$x$x$_reconcile-roles	0	{"paused":false,"_rev":"0","_id":"scheduler-service-group_$x$x$_reconcile-roles","key":"scheduler-service-group.reconcile-roles","serialized":"rO0ABXNyABRvcmcucXVhcnR6LkpvYkRldGFpbCv3Er7Ktmg7AgAJWgAKZHVyYWJpbGl0eVoADXNob3VsZFJlY292ZXJaAAp2b2xhdGlsaXR5TAALZGVzY3JpcHRpb250ABJMamF2YS9sYW5nL1N0cmluZztMAAVncm91cHEAfgABTAAIam9iQ2xhc3N0ABFMamF2YS9sYW5nL0NsYXNzO0wACmpvYkRhdGFNYXB0ABdMb3JnL3F1YXJ0ei9Kb2JEYXRhTWFwO0wADGpvYkxpc3RlbmVyc3QAD0xqYXZhL3V0aWwvU2V0O0wABG5hbWVxAH4AAXhwAAABcHQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3VwdnIAPW9yZy5mb3JnZXJvY2sub3BlbmlkbS5xdWFydHouaW1wbC5TdGF0ZWZ1bFNjaGVkdWxlclNlcnZpY2VKb2IAAAAAAAAAAAAAAHhwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ABpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luY3QAFXNjaGVkdWxlci5jb25maWctbmFtZXQAGXNjaGVkdWxlci1yZWNvbmNpbGUtcm9sZXN0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA4/QAAAAAAAA3cIAAAABAAAAAJ0AAZhY3Rpb250AAlyZWNvbmNpbGV0AAdtYXBwaW5ndAAcbWFuYWdlZFJvbGVfc3lzdGVtTGRhcEdyb3VwMHgAdAAPc2NoZWR1bGUuY29uZmlndAFpeyAiZW5hYmxlZCI6IHRydWUsICJwZXJzaXN0ZWQiOiB0cnVlLCAibWlzZmlyZVBvbGljeSI6ICJmaXJlQW5kUHJvY2VlZCIsICJzY2hlZHVsZSI6ICIwIDAgMjAgKiAqID8iLCAidHlwZSI6ICJjcm9uIiwgImludm9rZVNlcnZpY2UiOiAib3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMiLCAiaW52b2tlQ29udGV4dCI6IHsgImFjdGlvbiI6ICJyZWNvbmNpbGUiLCAibWFwcGluZyI6ICJtYW5hZ2VkUm9sZV9zeXN0ZW1MZGFwR3JvdXAwIiB9LCAiaW52b2tlTG9nTGV2ZWwiOiAiaW5mbyIsICJ0aW1lWm9uZSI6IG51bGwsICJzdGFydFRpbWUiOiBudWxsLCAiZW5kVGltZSI6IG51bGwsICJjb25jdXJyZW50RXhlY3V0aW9uIjogZmFsc2UgfXQAGHNjaGVkdWxlci5pbnZva2VMb2dMZXZlbHQABGluZm94AHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAAAeHQAD3JlY29uY2lsZS1yb2xlcw=="}
7	3	triggerGroupNames	1	{"_id":"triggerGroupNames","_rev":"1","names":["scheduler-service-group"]}
9	5	scheduler-service-group_$x$x$_sunset-task	0	{"paused":false,"_rev":"0","_id":"scheduler-service-group_$x$x$_sunset-task","key":"scheduler-service-group.sunset-task","serialized":"rO0ABXNyABRvcmcucXVhcnR6LkpvYkRldGFpbCv3Er7Ktmg7AgAJWgAKZHVyYWJpbGl0eVoADXNob3VsZFJlY292ZXJaAAp2b2xhdGlsaXR5TAALZGVzY3JpcHRpb250ABJMamF2YS9sYW5nL1N0cmluZztMAAVncm91cHEAfgABTAAIam9iQ2xhc3N0ABFMamF2YS9sYW5nL0NsYXNzO0wACmpvYkRhdGFNYXB0ABdMb3JnL3F1YXJ0ei9Kb2JEYXRhTWFwO0wADGpvYkxpc3RlbmVyc3QAD0xqYXZhL3V0aWwvU2V0O0wABG5hbWVxAH4AAXhwAAABcHQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3VwdnIAPW9yZy5mb3JnZXJvY2sub3BlbmlkbS5xdWFydHouaW1wbC5TdGF0ZWZ1bFNjaGVkdWxlclNlcnZpY2VKb2IAAAAAAAAAAAAAAHhwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ACFvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0udGFza3NjYW5uZXJ0ABVzY2hlZHVsZXIuY29uZmlnLW5hbWV0ABVzY2hlZHVsZXItc3Vuc2V0LXRhc2t0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA4/QAAAAAAABncIAAAACAAAAAR0ABF3YWl0Rm9yQ29tcGxldGlvbnNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAB0AA9udW1iZXJPZlRocmVhZHNzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAABXQABHNjYW5zcQB+ABU/QAAAAAAABncIAAAACAAAAAR0AAxfcXVlcnlGaWx0ZXJ0AEIoKC9zdW5zZXQvZGF0ZSBsdCAiJHtUaW1lLm5vd30iKSBBTkQgISgvc3Vuc2V0L3Rhc2stY29tcGxldGVkIHByKSl0AAZvYmplY3R0AAxtYW5hZ2VkL3VzZXJ0AAl0YXNrU3RhdGVzcQB+ABU/QAAAAAAAA3cIAAAABAAAAAJ0AAdzdGFydGVkdAAUL3N1bnNldC90YXNrLXN0YXJ0ZWR0AAljb21wbGV0ZWR0ABYvc3Vuc2V0L3Rhc2stY29tcGxldGVkeAB0AAhyZWNvdmVyeXNxAH4AFT9AAAAAAAABdwgAAAACAAAAAXQAB3RpbWVvdXR0AAMxMG14AHgAdAAEdGFza3NxAH4AFT9AAAAAAAABdwgAAAACAAAAAXQABnNjcmlwdHNxAH4AFT9AAAAAAAADdwgAAAAEAAAAAnQABHR5cGV0AA90ZXh0L2phdmFzY3JpcHR0AARmaWxldAAQc2NyaXB0L3N1bnNldC5qc3gAeAB4AHQAD3NjaGVkdWxlLmNvbmZpZ3QCq3sgImVuYWJsZWQiOiB0cnVlLCAicGVyc2lzdGVkIjogdHJ1ZSwgIm1pc2ZpcmVQb2xpY3kiOiAiZmlyZUFuZFByb2NlZWQiLCAic2NoZWR1bGUiOiAiMCAwICogKiAqID8iLCAidHlwZSI6ICJjcm9uIiwgImludm9rZVNlcnZpY2UiOiAib3JnLmZvcmdlcm9jay5vcGVuaWRtLnRhc2tzY2FubmVyIiwgImludm9rZUNvbnRleHQiOiB7ICJ3YWl0Rm9yQ29tcGxldGlvbiI6IGZhbHNlLCAibnVtYmVyT2ZUaHJlYWRzIjogNSwgInNjYW4iOiB7ICJfcXVlcnlGaWx0ZXIiOiAiKCgvc3Vuc2V0L2RhdGUgbHQgXCIke1RpbWUubm93fVwiKSBBTkQgISgvc3Vuc2V0L3Rhc2stY29tcGxldGVkIHByKSkiLCAib2JqZWN0IjogIm1hbmFnZWQvdXNlciIsICJ0YXNrU3RhdGUiOiB7ICJzdGFydGVkIjogIi9zdW5zZXQvdGFzay1zdGFydGVkIiwgImNvbXBsZXRlZCI6ICIvc3Vuc2V0L3Rhc2stY29tcGxldGVkIiB9LCAicmVjb3ZlcnkiOiB7ICJ0aW1lb3V0IjogIjEwbSIgfSB9LCAidGFzayI6IHsgInNjcmlwdCI6IHsgInR5cGUiOiAidGV4dC9qYXZhc2NyaXB0IiwgImZpbGUiOiAic2NyaXB0L3N1bnNldC5qcyIgfSB9IH0sICJpbnZva2VMb2dMZXZlbCI6ICJpbmZvIiwgInRpbWVab25lIjogbnVsbCwgInN0YXJ0VGltZSI6IG51bGwsICJlbmRUaW1lIjogbnVsbCwgImNvbmN1cnJlbnRFeGVjdXRpb24iOiBmYWxzZSB9dAAYc2NoZWR1bGVyLmludm9rZUxvZ0xldmVsdAAEaW5mb3gAc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAB4dAALc3Vuc2V0LXRhc2s="}
3	4	scheduler-service-group	3	{"jobs":["reconcile-roles","sunset-task","reconcile-accounts"],"name":"scheduler-service-group","paused":false,"_rev":"3","_id":"scheduler-service-group"}
11	5	scheduler-service-group_$x$x$_reconcile-accounts	0	{"paused":false,"_rev":"0","_id":"scheduler-service-group_$x$x$_reconcile-accounts","key":"scheduler-service-group.reconcile-accounts","serialized":"rO0ABXNyABRvcmcucXVhcnR6LkpvYkRldGFpbCv3Er7Ktmg7AgAJWgAKZHVyYWJpbGl0eVoADXNob3VsZFJlY292ZXJaAAp2b2xhdGlsaXR5TAALZGVzY3JpcHRpb250ABJMamF2YS9sYW5nL1N0cmluZztMAAVncm91cHEAfgABTAAIam9iQ2xhc3N0ABFMamF2YS9sYW5nL0NsYXNzO0wACmpvYkRhdGFNYXB0ABdMb3JnL3F1YXJ0ei9Kb2JEYXRhTWFwO0wADGpvYkxpc3RlbmVyc3QAD0xqYXZhL3V0aWwvU2V0O0wABG5hbWVxAH4AAXhwAAABcHQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3VwdnIAPW9yZy5mb3JnZXJvY2sub3BlbmlkbS5xdWFydHouaW1wbC5TdGF0ZWZ1bFNjaGVkdWxlclNlcnZpY2VKb2IAAAAAAAAAAAAAAHhwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ABpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luY3QAFXNjaGVkdWxlci5jb25maWctbmFtZXQAHHNjaGVkdWxlci1yZWNvbmNpbGUtYWNjb3VudHN0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA4/QAAAAAAAA3cIAAAABAAAAAJ0AAZhY3Rpb250AAlyZWNvbmNpbGV0AAdtYXBwaW5ndAAdbWFuYWdlZFVzZXJfc3lzdGVtTGRhcEFjY291bnR4AHQAD3NjaGVkdWxlLmNvbmZpZ3QBansgImVuYWJsZWQiOiB0cnVlLCAicGVyc2lzdGVkIjogdHJ1ZSwgIm1pc2ZpcmVQb2xpY3kiOiAiZmlyZUFuZFByb2NlZWQiLCAic2NoZWR1bGUiOiAiMCAwIDIyICogKiA/IiwgInR5cGUiOiAiY3JvbiIsICJpbnZva2VTZXJ2aWNlIjogIm9yZy5mb3JnZXJvY2sub3BlbmlkbS5zeW5jIiwgImludm9rZUNvbnRleHQiOiB7ICJhY3Rpb24iOiAicmVjb25jaWxlIiwgIm1hcHBpbmciOiAibWFuYWdlZFVzZXJfc3lzdGVtTGRhcEFjY291bnQiIH0sICJpbnZva2VMb2dMZXZlbCI6ICJpbmZvIiwgInRpbWVab25lIjogbnVsbCwgInN0YXJ0VGltZSI6IG51bGwsICJlbmRUaW1lIjogbnVsbCwgImNvbmN1cnJlbnRFeGVjdXRpb24iOiBmYWxzZSB9dAAYc2NoZWR1bGVyLmludm9rZUxvZ0xldmVsdAAEaW5mb3gAc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAB4dAAScmVjb25jaWxlLWFjY291bnRz"}
6	6	scheduler-service-group	3	{"triggers":["trigger-reconcile-roles","trigger-sunset-task","trigger-reconcile-accounts"],"name":"scheduler-service-group","paused":false,"_rev":"3","_id":"scheduler-service-group"}
8	7	scheduler-service-group_$x$x$_trigger-reconcile-roles	5	{"serialized":"rO0ABXNyABZvcmcucXVhcnR6LkNyb25UcmlnZ2VyiAb06o3becICAAVMAAZjcm9uRXh0ABtMb3JnL3F1YXJ0ei9Dcm9uRXhwcmVzc2lvbjtMAAdlbmRUaW1ldAAQTGphdmEvdXRpbC9EYXRlO0wADG5leHRGaXJlVGltZXEAfgACTAAQcHJldmlvdXNGaXJlVGltZXEAfgACTAAJc3RhcnRUaW1lcQB+AAJ4cgASb3JnLnF1YXJ0ei5UcmlnZ2VyydFXOw3g9e4CAAxJABJtaXNmaXJlSW5zdHJ1Y3Rpb25JAAhwcmlvcml0eVoACnZvbGF0aWxpdHlMAAxjYWxlbmRhck5hbWV0ABJMamF2YS9sYW5nL1N0cmluZztMAAtkZXNjcmlwdGlvbnEAfgAETAAOZmlyZUluc3RhbmNlSWRxAH4ABEwABWdyb3VwcQB+AARMAApqb2JEYXRhTWFwdAAXTG9yZy9xdWFydHovSm9iRGF0YU1hcDtMAAhqb2JHcm91cHEAfgAETAAHam9iTmFtZXEAfgAETAAEbmFtZXEAfgAETAAQdHJpZ2dlckxpc3RlbmVyc3QAFkxqYXZhL3V0aWwvTGlua2VkTGlzdDt4cAAAAAEAAAAFAHBwdAANMTU2NDQwNTk2MDkwNHQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3Vwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ABpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luY3QAFXNjaGVkdWxlci5jb25maWctbmFtZXQAGXNjaGVkdWxlci1yZWNvbmNpbGUtcm9sZXN0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA8/QAAAAAAADHcIAAAAEAAAAAJ0AAZhY3Rpb250AAlyZWNvbmNpbGV0AAdtYXBwaW5ndAAcbWFuYWdlZFJvbGVfc3lzdGVtTGRhcEdyb3VwMHgAdAAPc2NoZWR1bGUuY29uZmlndAFpeyAiZW5hYmxlZCI6IHRydWUsICJwZXJzaXN0ZWQiOiB0cnVlLCAibWlzZmlyZVBvbGljeSI6ICJmaXJlQW5kUHJvY2VlZCIsICJzY2hlZHVsZSI6ICIwIDAgMjAgKiAqID8iLCAidHlwZSI6ICJjcm9uIiwgImludm9rZVNlcnZpY2UiOiAib3JnLmZvcmdlcm9jay5vcGVuaWRtLnN5bmMiLCAiaW52b2tlQ29udGV4dCI6IHsgImFjdGlvbiI6ICJyZWNvbmNpbGUiLCAibWFwcGluZyI6ICJtYW5hZ2VkUm9sZV9zeXN0ZW1MZGFwR3JvdXAwIiB9LCAiaW52b2tlTG9nTGV2ZWwiOiAiaW5mbyIsICJ0aW1lWm9uZSI6IG51bGwsICJzdGFydFRpbWUiOiBudWxsLCAiZW5kVGltZSI6IG51bGwsICJjb25jdXJyZW50RXhlY3V0aW9uIjogZmFsc2UgfXQAGHNjaGVkdWxlci5pbnZva2VMb2dMZXZlbHQABGluZm94AHEAfgAJdAAPcmVjb25jaWxlLXJvbGVzdAAXdHJpZ2dlci1yZWNvbmNpbGUtcm9sZXNzcgAUamF2YS51dGlsLkxpbmtlZExpc3QMKVNdSmCIIgMAAHhwdwQAAAAAeHNyABlvcmcucXVhcnR6LkNyb25FeHByZXNzaW9uAAAAAuR+Lw8CAAJMAA5jcm9uRXhwcmVzc2lvbnEAfgAETAAIdGltZVpvbmV0ABRMamF2YS91dGlsL1RpbWVab25lO3hwdAAMMCAwIDIwICogKiA/c3IAGnN1bi51dGlsLmNhbGVuZGFyLlpvbmVJbmZvJNHTzgAdcZsCAAhJAAhjaGVja3N1bUkACmRzdFNhdmluZ3NJAAlyYXdPZmZzZXRJAA1yYXdPZmZzZXREaWZmWgATd2lsbEdNVE9mZnNldENoYW5nZVsAB29mZnNldHN0AAJbSVsAFHNpbXBsZVRpbWVab25lUGFyYW1zcQB+AClbAAt0cmFuc2l0aW9uc3QAAltKeHIAEmphdmEudXRpbC5UaW1lWm9uZTGz6fV3RKyhAgABTAACSURxAH4ABHhwdAADR01UAAAAAAAAAAAAAAAAAAAAAABwcHBwc3IADmphdmEudXRpbC5EYXRlaGqBAUtZdBkDAAB4cHcIAAABbD9RegB4c3EAfgAudwgAAAFsPdyUEXhzcQB+AC53CAAAAWn87NuYeA==","name":"trigger-reconcile-roles","group":"scheduler-service-group","previous_state":-1,"state":0,"acquired":false,"nodeId":null,"_rev":"5","_id":"scheduler-service-group_$x$x$_trigger-reconcile-roles"}
1	3	acquiredTriggers	9	{"localidm":[],"_id":"acquiredTriggers","_rev":"9","493c85e00ab7":[]}
10	7	scheduler-service-group_$x$x$_trigger-sunset-task	9	{"serialized":"rO0ABXNyABZvcmcucXVhcnR6LkNyb25UcmlnZ2VyiAb06o3becICAAVMAAZjcm9uRXh0ABtMb3JnL3F1YXJ0ei9Dcm9uRXhwcmVzc2lvbjtMAAdlbmRUaW1ldAAQTGphdmEvdXRpbC9EYXRlO0wADG5leHRGaXJlVGltZXEAfgACTAAQcHJldmlvdXNGaXJlVGltZXEAfgACTAAJc3RhcnRUaW1lcQB+AAJ4cgASb3JnLnF1YXJ0ei5UcmlnZ2VyydFXOw3g9e4CAAxJABJtaXNmaXJlSW5zdHJ1Y3Rpb25JAAhwcmlvcml0eVoACnZvbGF0aWxpdHlMAAxjYWxlbmRhck5hbWV0ABJMamF2YS9sYW5nL1N0cmluZztMAAtkZXNjcmlwdGlvbnEAfgAETAAOZmlyZUluc3RhbmNlSWRxAH4ABEwABWdyb3VwcQB+AARMAApqb2JEYXRhTWFwdAAXTG9yZy9xdWFydHovSm9iRGF0YU1hcDtMAAhqb2JHcm91cHEAfgAETAAHam9iTmFtZXEAfgAETAAEbmFtZXEAfgAETAAQdHJpZ2dlckxpc3RlbmVyc3QAFkxqYXZhL3V0aWwvTGlua2VkTGlzdDt4cAAAAAEAAAAFAHBwdAANMTU2NDQwNTk2MDkwNnQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3Vwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ACFvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0udGFza3NjYW5uZXJ0ABVzY2hlZHVsZXIuY29uZmlnLW5hbWV0ABVzY2hlZHVsZXItc3Vuc2V0LXRhc2t0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA8/QAAAAAAADHcIAAAAEAAAAAR0ABF3YWl0Rm9yQ29tcGxldGlvbnNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAB0AA9udW1iZXJPZlRocmVhZHNzcgARamF2YS5sYW5nLkludGVnZXIS4qCk94GHOAIAAUkABXZhbHVleHIAEGphdmEubGFuZy5OdW1iZXKGrJUdC5TgiwIAAHhwAAAABXQABHNjYW5zcQB+ABY/QAAAAAAADHcIAAAAEAAAAAR0AAxfcXVlcnlGaWx0ZXJ0AEIoKC9zdW5zZXQvZGF0ZSBsdCAiJHtUaW1lLm5vd30iKSBBTkQgISgvc3Vuc2V0L3Rhc2stY29tcGxldGVkIHByKSl0AAZvYmplY3R0AAxtYW5hZ2VkL3VzZXJ0AAl0YXNrU3RhdGVzcQB+ABY/QAAAAAAADHcIAAAAEAAAAAJ0AAdzdGFydGVkdAAUL3N1bnNldC90YXNrLXN0YXJ0ZWR0AAljb21wbGV0ZWR0ABYvc3Vuc2V0L3Rhc2stY29tcGxldGVkeAB0AAhyZWNvdmVyeXNxAH4AFj9AAAAAAAAMdwgAAAAQAAAAAXQAB3RpbWVvdXR0AAMxMG14AHgAdAAEdGFza3NxAH4AFj9AAAAAAAAMdwgAAAAQAAAAAXQABnNjcmlwdHNxAH4AFj9AAAAAAAAMdwgAAAAQAAAAAnQABHR5cGV0AA90ZXh0L2phdmFzY3JpcHR0AARmaWxldAAQc2NyaXB0L3N1bnNldC5qc3gAeAB4AHQAD3NjaGVkdWxlLmNvbmZpZ3QCq3sgImVuYWJsZWQiOiB0cnVlLCAicGVyc2lzdGVkIjogdHJ1ZSwgIm1pc2ZpcmVQb2xpY3kiOiAiZmlyZUFuZFByb2NlZWQiLCAic2NoZWR1bGUiOiAiMCAwICogKiAqID8iLCAidHlwZSI6ICJjcm9uIiwgImludm9rZVNlcnZpY2UiOiAib3JnLmZvcmdlcm9jay5vcGVuaWRtLnRhc2tzY2FubmVyIiwgImludm9rZUNvbnRleHQiOiB7ICJ3YWl0Rm9yQ29tcGxldGlvbiI6IGZhbHNlLCAibnVtYmVyT2ZUaHJlYWRzIjogNSwgInNjYW4iOiB7ICJfcXVlcnlGaWx0ZXIiOiAiKCgvc3Vuc2V0L2RhdGUgbHQgXCIke1RpbWUubm93fVwiKSBBTkQgISgvc3Vuc2V0L3Rhc2stY29tcGxldGVkIHByKSkiLCAib2JqZWN0IjogIm1hbmFnZWQvdXNlciIsICJ0YXNrU3RhdGUiOiB7ICJzdGFydGVkIjogIi9zdW5zZXQvdGFzay1zdGFydGVkIiwgImNvbXBsZXRlZCI6ICIvc3Vuc2V0L3Rhc2stY29tcGxldGVkIiB9LCAicmVjb3ZlcnkiOiB7ICJ0aW1lb3V0IjogIjEwbSIgfSB9LCAidGFzayI6IHsgInNjcmlwdCI6IHsgInR5cGUiOiAidGV4dC9qYXZhc2NyaXB0IiwgImZpbGUiOiAic2NyaXB0L3N1bnNldC5qcyIgfSB9IH0sICJpbnZva2VMb2dMZXZlbCI6ICJpbmZvIiwgInRpbWVab25lIjogbnVsbCwgInN0YXJ0VGltZSI6IG51bGwsICJlbmRUaW1lIjogbnVsbCwgImNvbmN1cnJlbnRFeGVjdXRpb24iOiBmYWxzZSB9dAAYc2NoZWR1bGVyLmludm9rZUxvZ0xldmVsdAAEaW5mb3gAcQB+AAl0AAtzdW5zZXQtdGFza3QAE3RyaWdnZXItc3Vuc2V0LXRhc2tzcgAUamF2YS51dGlsLkxpbmtlZExpc3QMKVNdSmCIIgMAAHhwdwQAAAAAeHNyABlvcmcucXVhcnR6LkNyb25FeHByZXNzaW9uAAAAAuR+Lw8CAAJMAA5jcm9uRXhwcmVzc2lvbnEAfgAETAAIdGltZVpvbmV0ABRMamF2YS91dGlsL1RpbWVab25lO3hwdAALMCAwICogKiAqID9zcgAac3VuLnV0aWwuY2FsZW5kYXIuWm9uZUluZm8k0dPOAB1xmwIACEkACGNoZWNrc3VtSQAKZHN0U2F2aW5nc0kACXJhd09mZnNldEkADXJhd09mZnNldERpZmZaABN3aWxsR01UT2Zmc2V0Q2hhbmdlWwAHb2Zmc2V0c3QAAltJWwAUc2ltcGxlVGltZVpvbmVQYXJhbXNxAH4ARFsAC3RyYW5zaXRpb25zdAACW0p4cgASamF2YS51dGlsLlRpbWVab25lMbPp9XdErKECAAFMAAJJRHEAfgAEeHB0AANHTVQAAAAAAAAAAAAAAAAAAAAAAHBwcHBzcgAOamF2YS51dGlsLkRhdGVoaoEBS1l0GQMAAHhwdwgAAAFsPj7RgHhzcQB+AEl3CAAAAWw+B+MAeHNxAH4ASXcIAAABafzs25h4","name":"trigger-sunset-task","group":"scheduler-service-group","previous_state":-1,"state":0,"acquired":false,"nodeId":null,"_rev":"9","_id":"scheduler-service-group_$x$x$_trigger-sunset-task"}
2	3	waitingTriggers	17	{"names":["scheduler-service-group_$x$x$_trigger-reconcile-accounts","scheduler-service-group_$x$x$_trigger-reconcile-roles","scheduler-service-group_$x$x$_trigger-sunset-task"],"_id":"waitingTriggers","_rev":"17"}
12	7	scheduler-service-group_$x$x$_trigger-reconcile-accounts	5	{"serialized":"rO0ABXNyABZvcmcucXVhcnR6LkNyb25UcmlnZ2VyiAb06o3becICAAVMAAZjcm9uRXh0ABtMb3JnL3F1YXJ0ei9Dcm9uRXhwcmVzc2lvbjtMAAdlbmRUaW1ldAAQTGphdmEvdXRpbC9EYXRlO0wADG5leHRGaXJlVGltZXEAfgACTAAQcHJldmlvdXNGaXJlVGltZXEAfgACTAAJc3RhcnRUaW1lcQB+AAJ4cgASb3JnLnF1YXJ0ei5UcmlnZ2VyydFXOw3g9e4CAAxJABJtaXNmaXJlSW5zdHJ1Y3Rpb25JAAhwcmlvcml0eVoACnZvbGF0aWxpdHlMAAxjYWxlbmRhck5hbWV0ABJMamF2YS9sYW5nL1N0cmluZztMAAtkZXNjcmlwdGlvbnEAfgAETAAOZmlyZUluc3RhbmNlSWRxAH4ABEwABWdyb3VwcQB+AARMAApqb2JEYXRhTWFwdAAXTG9yZy9xdWFydHovSm9iRGF0YU1hcDtMAAhqb2JHcm91cHEAfgAETAAHam9iTmFtZXEAfgAETAAEbmFtZXEAfgAETAAQdHJpZ2dlckxpc3RlbmVyc3QAFkxqYXZhL3V0aWwvTGlua2VkTGlzdDt4cAAAAAEAAAAFAHBwdAANMTU2NDQwNTk2MDkwNXQAF3NjaGVkdWxlci1zZXJ2aWNlLWdyb3Vwc3IAFW9yZy5xdWFydHouSm9iRGF0YU1hcJ+wg+i/qbDLAgAAeHIAJm9yZy5xdWFydHoudXRpbHMuU3RyaW5nS2V5RGlydHlGbGFnTWFwggjow/vFXSgCAAFaABNhbGxvd3NUcmFuc2llbnREYXRheHIAHW9yZy5xdWFydHoudXRpbHMuRGlydHlGbGFnTWFwE+YurSh2Cs4CAAJaAAVkaXJ0eUwAA21hcHQAD0xqYXZhL3V0aWwvTWFwO3hwAXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAAFdAAXc2NoZWR1bGVyLmludm9rZVNlcnZpY2V0ABpvcmcuZm9yZ2Vyb2NrLm9wZW5pZG0uc3luY3QAFXNjaGVkdWxlci5jb25maWctbmFtZXQAHHNjaGVkdWxlci1yZWNvbmNpbGUtYWNjb3VudHN0ABdzY2hlZHVsZXIuaW52b2tlQ29udGV4dHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AA8/QAAAAAAADHcIAAAAEAAAAAJ0AAZhY3Rpb250AAlyZWNvbmNpbGV0AAdtYXBwaW5ndAAdbWFuYWdlZFVzZXJfc3lzdGVtTGRhcEFjY291bnR4AHQAD3NjaGVkdWxlLmNvbmZpZ3QBansgImVuYWJsZWQiOiB0cnVlLCAicGVyc2lzdGVkIjogdHJ1ZSwgIm1pc2ZpcmVQb2xpY3kiOiAiZmlyZUFuZFByb2NlZWQiLCAic2NoZWR1bGUiOiAiMCAwIDIyICogKiA/IiwgInR5cGUiOiAiY3JvbiIsICJpbnZva2VTZXJ2aWNlIjogIm9yZy5mb3JnZXJvY2sub3BlbmlkbS5zeW5jIiwgImludm9rZUNvbnRleHQiOiB7ICJhY3Rpb24iOiAicmVjb25jaWxlIiwgIm1hcHBpbmciOiAibWFuYWdlZFVzZXJfc3lzdGVtTGRhcEFjY291bnQiIH0sICJpbnZva2VMb2dMZXZlbCI6ICJpbmZvIiwgInRpbWVab25lIjogbnVsbCwgInN0YXJ0VGltZSI6IG51bGwsICJlbmRUaW1lIjogbnVsbCwgImNvbmN1cnJlbnRFeGVjdXRpb24iOiBmYWxzZSB9dAAYc2NoZWR1bGVyLmludm9rZUxvZ0xldmVsdAAEaW5mb3gAcQB+AAl0ABJyZWNvbmNpbGUtYWNjb3VudHN0ABp0cmlnZ2VyLXJlY29uY2lsZS1hY2NvdW50c3NyABRqYXZhLnV0aWwuTGlua2VkTGlzdAwpU11KYIgiAwAAeHB3BAAAAAB4c3IAGW9yZy5xdWFydHouQ3JvbkV4cHJlc3Npb24AAAAC5H4vDwIAAkwADmNyb25FeHByZXNzaW9ucQB+AARMAAh0aW1lWm9uZXQAFExqYXZhL3V0aWwvVGltZVpvbmU7eHB0AAwwIDAgMjIgKiAqID9zcgAac3VuLnV0aWwuY2FsZW5kYXIuWm9uZUluZm8k0dPOAB1xmwIACEkACGNoZWNrc3VtSQAKZHN0U2F2aW5nc0kACXJhd09mZnNldEkADXJhd09mZnNldERpZmZaABN3aWxsR01UT2Zmc2V0Q2hhbmdlWwAHb2Zmc2V0c3QAAltJWwAUc2ltcGxlVGltZVpvbmVQYXJhbXNxAH4AKVsAC3RyYW5zaXRpb25zdAACW0p4cgASamF2YS51dGlsLlRpbWVab25lMbPp9XdErKECAAFMAAJJRHEAfgAEeHB0AANHTVQAAAAAAAAAAAAAAAAAAAAAAHBwcHBzcgAOamF2YS51dGlsLkRhdGVoaoEBS1l0GQMAAHhwdwgAAAFsP79XAHhzcQB+AC53CAAAAWw93JSneHNxAH4ALncIAAABafzs25h4","name":"trigger-reconcile-accounts","group":"scheduler-service-group","previous_state":-1,"state":0,"acquired":false,"nodeId":null,"_rev":"5","_id":"scheduler-service-group_$x$x$_trigger-reconcile-accounts"}
\.


--
-- Name: schedulerobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('schedulerobjects_id_seq', 12, true);


--
-- Data for Name: securitykeys; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY securitykeys (objectid, rev, keypair) FROM stdin;
\.


--
-- Data for Name: uinotification; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY uinotification (objectid, rev, notificationtype, createdate, message, requester, receiverid, requesterid, notificationsubtype) FROM stdin;
\.


--
-- Data for Name: updateobjectproperties; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY updateobjectproperties (updateobjects_id, propkey, proptype, propvalue) FROM stdin;
\.


--
-- Data for Name: updateobjects; Type: TABLE DATA; Schema: openidm; Owner: openidm
--

COPY updateobjects (id, objecttypes_id, objectid, rev, fullobject) FROM stdin;
\.


--
-- Name: updateobjects_id_seq; Type: SEQUENCE SET; Schema: openidm; Owner: openidm
--

SELECT pg_catalog.setval('updateobjects_id_seq', 1, false);


SET search_path = fridam, pg_catalog;

--
-- Name: clustercache clustercache_pkey; Type: CONSTRAINT; Schema: fridam; Owner: openidm
--

ALTER TABLE ONLY clustercache
    ADD CONSTRAINT clustercache_pkey PRIMARY KEY (key);


--
-- Name: service service_pk; Type: CONSTRAINT; Schema: fridam; Owner: openidm
--

ALTER TABLE ONLY service
    ADD CONSTRAINT service_pk PRIMARY KEY (label);


SET search_path = openidm, pg_catalog;

--
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, tenant_id_);


--
-- Name: auditaccess auditaccess_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditaccess
    ADD CONSTRAINT auditaccess_pkey PRIMARY KEY (objectid);


--
-- Name: auditactivity auditactivity_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditactivity
    ADD CONSTRAINT auditactivity_pkey PRIMARY KEY (objectid);


--
-- Name: auditauthentication auditauthentication_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditauthentication
    ADD CONSTRAINT auditauthentication_pkey PRIMARY KEY (objectid);


--
-- Name: auditconfig auditconfig_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditconfig
    ADD CONSTRAINT auditconfig_pkey PRIMARY KEY (objectid);


--
-- Name: auditrecon auditrecon_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditrecon
    ADD CONSTRAINT auditrecon_pkey PRIMARY KEY (objectid);


--
-- Name: auditsync auditsync_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY auditsync
    ADD CONSTRAINT auditsync_pkey PRIMARY KEY (objectid);


--
-- Name: clusteredrecontargetids clusteredrecontargetids_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusteredrecontargetids
    ADD CONSTRAINT clusteredrecontargetids_pkey PRIMARY KEY (objectid);


--
-- Name: clusterobjectproperties clusterobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusterobjectproperties
    ADD CONSTRAINT clusterobjectproperties_pkey PRIMARY KEY (clusterobjects_id, propkey);


--
-- Name: clusterobjects clusterobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusterobjects
    ADD CONSTRAINT clusterobjects_pkey PRIMARY KEY (id);


--
-- Name: configobjectproperties configobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY configobjectproperties
    ADD CONSTRAINT configobjectproperties_pkey PRIMARY KEY (configobjects_id, propkey);


--
-- Name: configobjects configobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY configobjects
    ADD CONSTRAINT configobjects_pkey PRIMARY KEY (id);


--
-- Name: genericobjectproperties genericobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjectproperties
    ADD CONSTRAINT genericobjectproperties_pkey PRIMARY KEY (genericobjects_id, propkey);


--
-- Name: genericobjects genericobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjects
    ADD CONSTRAINT genericobjects_pkey PRIMARY KEY (id);


--
-- Name: genericobjects idx_genericobjects_object; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjects
    ADD CONSTRAINT idx_genericobjects_object UNIQUE (objecttypes_id, objectid);


--
-- Name: objecttypes idx_objecttypes_objecttype; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY objecttypes
    ADD CONSTRAINT idx_objecttypes_objecttype UNIQUE (objecttype);


--
-- Name: relationships idx_relationships_object; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT idx_relationships_object UNIQUE (objecttypes_id, objectid);


--
-- Name: updateobjects idx_updateobjects_object; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjects
    ADD CONSTRAINT idx_updateobjects_object UNIQUE (objecttypes_id, objectid);


--
-- Name: internalrole internalrole_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY internalrole
    ADD CONSTRAINT internalrole_pkey PRIMARY KEY (objectid);


--
-- Name: internaluser internaluser_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY internaluser
    ADD CONSTRAINT internaluser_pkey PRIMARY KEY (objectid);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY links
    ADD CONSTRAINT links_pkey PRIMARY KEY (objectid);


--
-- Name: managedobjectproperties managedobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY managedobjectproperties
    ADD CONSTRAINT managedobjectproperties_pkey PRIMARY KEY (managedobjects_id, propkey);


--
-- Name: managedobjects managedobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY managedobjects
    ADD CONSTRAINT managedobjects_pkey PRIMARY KEY (id);


--
-- Name: objecttypes objecttypes_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY objecttypes
    ADD CONSTRAINT objecttypes_pkey PRIMARY KEY (id);


--
-- Name: relationshipproperties relationshipproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationshipproperties
    ADD CONSTRAINT relationshipproperties_pkey PRIMARY KEY (relationships_id, propkey);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: schedulerobjectproperties schedulerobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY schedulerobjectproperties
    ADD CONSTRAINT schedulerobjectproperties_pkey PRIMARY KEY (schedulerobjects_id, propkey);


--
-- Name: schedulerobjects schedulerobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY schedulerobjects
    ADD CONSTRAINT schedulerobjects_pkey PRIMARY KEY (id);


--
-- Name: securitykeys securitykeys_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY securitykeys
    ADD CONSTRAINT securitykeys_pkey PRIMARY KEY (objectid);


--
-- Name: uinotification uinotification_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY uinotification
    ADD CONSTRAINT uinotification_pkey PRIMARY KEY (objectid);


--
-- Name: updateobjectproperties updateobjectproperties_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjectproperties
    ADD CONSTRAINT updateobjectproperties_pkey PRIMARY KEY (updateobjects_id, propkey);


--
-- Name: updateobjects updateobjects_pkey; Type: CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjects
    ADD CONSTRAINT updateobjects_pkey PRIMARY KEY (id);


--
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_athrz_procedef ON act_ru_identitylink USING btree (proc_def_id_);


--
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_bytear_depl ON act_ge_bytearray USING btree (deployment_id_);


--
-- Name: act_idx_event_subscr; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_event_subscr ON act_ru_event_subscr USING btree (execution_id_);


--
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_event_subscr_config_ ON act_ru_event_subscr USING btree (configuration_);


--
-- Name: act_idx_exe_parent; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_exe_parent ON act_ru_execution USING btree (parent_id_);


--
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_exe_procdef ON act_ru_execution USING btree (proc_def_id_);


--
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_exe_procinst ON act_ru_execution USING btree (proc_inst_id_);


--
-- Name: act_idx_exe_super; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_exe_super ON act_ru_execution USING btree (super_exec_);


--
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_exec_buskey ON act_ru_execution USING btree (business_key_);


--
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_act_inst_end ON act_hi_actinst USING btree (end_time_);


--
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_act_inst_exec ON act_hi_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_act_inst_procinst ON act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_act_inst_start ON act_hi_actinst USING btree (start_time_);


--
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_detail_act_inst ON act_hi_detail USING btree (act_inst_id_);


--
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_detail_name ON act_hi_detail USING btree (name_);


--
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_detail_proc_inst ON act_hi_detail USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_detail_task_id ON act_hi_detail USING btree (task_id_);


--
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_detail_time ON act_hi_detail USING btree (time_);


--
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON act_hi_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_ident_lnk_task ON act_hi_identitylink USING btree (task_id_);


--
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_ident_lnk_user ON act_hi_identitylink USING btree (user_id_);


--
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_pro_i_buskey ON act_hi_procinst USING btree (business_key_);


--
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_pro_inst_end ON act_hi_procinst USING btree (end_time_);


--
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_procvar_name_type ON act_hi_varinst USING btree (name_, var_type_);


--
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON act_hi_varinst USING btree (proc_inst_id_);


--
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_ident_lnk_group ON act_ru_identitylink USING btree (group_id_);


--
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_ident_lnk_user ON act_ru_identitylink USING btree (user_id_);


--
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_idl_procinst ON act_ru_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_job_exception; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_job_exception ON act_ru_job USING btree (exception_stack_id_);


--
-- Name: act_idx_memb_group; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_memb_group ON act_id_membership USING btree (group_id_);


--
-- Name: act_idx_memb_user; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_memb_user ON act_id_membership USING btree (user_id_);


--
-- Name: act_idx_model_deployment; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_model_deployment ON act_re_model USING btree (deployment_id_);


--
-- Name: act_idx_model_source; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_model_source ON act_re_model USING btree (editor_source_value_id_);


--
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_model_source_extra ON act_re_model USING btree (editor_source_extra_value_id_);


--
-- Name: act_idx_task_create; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_task_create ON act_ru_task USING btree (create_time_);


--
-- Name: act_idx_task_exec; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_task_exec ON act_ru_task USING btree (execution_id_);


--
-- Name: act_idx_task_procdef; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_task_procdef ON act_ru_task USING btree (proc_def_id_);


--
-- Name: act_idx_task_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_task_procinst ON act_ru_task USING btree (proc_inst_id_);


--
-- Name: act_idx_tskass_task; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_tskass_task ON act_ru_identitylink USING btree (task_id_);


--
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_var_bytearray ON act_ru_variable USING btree (bytearray_id_);


--
-- Name: act_idx_var_exe; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_var_exe ON act_ru_variable USING btree (execution_id_);


--
-- Name: act_idx_var_procinst; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_var_procinst ON act_ru_variable USING btree (proc_inst_id_);


--
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX act_idx_variable_task_id ON act_ru_variable USING btree (task_id_);


--
-- Name: fk_clusterobjectproperties_clusterobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_clusterobjectproperties_clusterobjects ON clusterobjectproperties USING btree (clusterobjects_id);


--
-- Name: fk_clusterobjects_objectypes; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_clusterobjects_objectypes ON clusterobjects USING btree (objecttypes_id);


--
-- Name: fk_configobjectproperties_configobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_configobjectproperties_configobjects ON configobjectproperties USING btree (configobjects_id);


--
-- Name: fk_configobjects_objecttypes; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_configobjects_objecttypes ON configobjects USING btree (objecttypes_id);


--
-- Name: fk_genericobjectproperties_genericobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_genericobjectproperties_genericobjects ON genericobjectproperties USING btree (genericobjects_id);


--
-- Name: fk_managedobjectproperties_managedobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_managedobjectproperties_managedobjects ON managedobjectproperties USING btree (managedobjects_id);


--
-- Name: fk_relationshipproperties_relationships; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_relationshipproperties_relationships ON relationshipproperties USING btree (relationships_id);


--
-- Name: fk_schedulerobjectproperties_schedulerobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_schedulerobjectproperties_schedulerobjects ON schedulerobjectproperties USING btree (schedulerobjects_id);


--
-- Name: fk_schedulerobjects_objectypes; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_schedulerobjects_objectypes ON schedulerobjects USING btree (objecttypes_id);


--
-- Name: fk_updateobjectproperties_updateobjects; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX fk_updateobjectproperties_updateobjects ON updateobjectproperties USING btree (updateobjects_id);


--
-- Name: idx_auditrecon_entrytype; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_auditrecon_entrytype ON auditrecon USING btree (entrytype);


--
-- Name: idx_auditrecon_reconid; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_auditrecon_reconid ON auditrecon USING btree (reconid);


--
-- Name: idx_clusteredrecontargetids_reconid; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_clusteredrecontargetids_reconid ON clusteredrecontargetids USING btree (reconid);


--
-- Name: idx_clusterobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_clusterobjectproperties_prop ON clusterobjectproperties USING btree (propkey, propvalue);


--
-- Name: idx_clusterobjects_object; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_clusterobjects_object ON clusterobjects USING btree (objecttypes_id, objectid);


--
-- Name: idx_configobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_configobjectproperties_prop ON configobjectproperties USING btree (propkey, propvalue);


--
-- Name: idx_configobjects_object; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_configobjects_object ON configobjects USING btree (objecttypes_id, objectid);


--
-- Name: idx_genericobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_genericobjectproperties_prop ON genericobjectproperties USING btree (propkey, propvalue);


--
-- Name: idx_json_clusterobjects_state; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_clusterobjects_state ON clusterobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['state'::text]));


--
-- Name: idx_json_clusterobjects_timestamp; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_clusterobjects_timestamp ON clusterobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['timestamp'::text]));


--
-- Name: idx_json_managedobjects_accountstatus; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_accountstatus ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['accountStatus'::text]));


--
-- Name: idx_json_managedobjects_accountstatus_gin; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_accountstatus_gin ON managedobjects USING gin (json_extract_path_text(fullobject, VARIADIC ARRAY['accountStatus'::text]) gin_trgm_ops);


--
-- Name: idx_json_managedobjects_givenname; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_givenname ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['givenName'::text]));


--
-- Name: idx_json_managedobjects_givenname_gin; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_givenname_gin ON managedobjects USING gin (json_extract_path_text(fullobject, VARIADIC ARRAY['givenName'::text]) gin_trgm_ops);


--
-- Name: idx_json_managedobjects_mail; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_mail ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['mail'::text]));


--
-- Name: idx_json_managedobjects_mail_gin; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_mail_gin ON managedobjects USING gin (json_extract_path_text(fullobject, VARIADIC ARRAY['mail'::text]) gin_trgm_ops);


--
-- Name: idx_json_managedobjects_rolecondition; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_rolecondition ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['condition'::text]));


--
-- Name: idx_json_managedobjects_roletemporalconstraints; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_roletemporalconstraints ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['temporalConstraints'::text]));


--
-- Name: idx_json_managedobjects_sn; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_sn ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['sn'::text]));


--
-- Name: idx_json_managedobjects_sn_gin; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_sn_gin ON managedobjects USING gin (json_extract_path_text(fullobject, VARIADIC ARRAY['sn'::text]) gin_trgm_ops);


--
-- Name: idx_json_managedobjects_username; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_json_managedobjects_username ON managedobjects USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['userName'::text]), objecttypes_id);


--
-- Name: idx_json_managedobjects_username_gin; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_managedobjects_username_gin ON managedobjects USING gin (json_extract_path_text(fullobject, VARIADIC ARRAY['userName'::text]) gin_trgm_ops);


--
-- Name: idx_json_relationships; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_relationships ON relationships USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['firstId'::text]), json_extract_path_text(fullobject, VARIADIC ARRAY['firstPropertyName'::text]), json_extract_path_text(fullobject, VARIADIC ARRAY['secondId'::text]), json_extract_path_text(fullobject, VARIADIC ARRAY['secondPropertyName'::text]));


--
-- Name: idx_json_relationships_first; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_relationships_first ON relationships USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['firstId'::text]), json_extract_path_text(fullobject, VARIADIC ARRAY['firstPropertyName'::text]));


--
-- Name: idx_json_relationships_second; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_json_relationships_second ON relationships USING btree (json_extract_path_text(fullobject, VARIADIC ARRAY['secondId'::text]), json_extract_path_text(fullobject, VARIADIC ARRAY['secondPropertyName'::text]));


--
-- Name: idx_links_first; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_links_first ON links USING btree (linktype, linkqualifier, firstid);


--
-- Name: idx_links_second; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_links_second ON links USING btree (linktype, linkqualifier, secondid);


--
-- Name: idx_managedobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_managedobjectproperties_prop ON managedobjectproperties USING btree (propkey, propvalue);


--
-- Name: idx_managedobjects_object; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_managedobjects_object ON managedobjects USING btree (objecttypes_id, objectid);


--
-- Name: idx_relationshipproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_relationshipproperties_prop ON relationshipproperties USING btree (propkey, propvalue);


--
-- Name: idx_schedulerobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_schedulerobjectproperties_prop ON schedulerobjectproperties USING btree (propkey, propvalue);


--
-- Name: idx_schedulerobjects_object; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE UNIQUE INDEX idx_schedulerobjects_object ON schedulerobjects USING btree (objecttypes_id, objectid);


--
-- Name: idx_uinotification_receiverid; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_uinotification_receiverid ON uinotification USING btree (receiverid);


--
-- Name: idx_updateobjectproperties_prop; Type: INDEX; Schema: openidm; Owner: openidm
--

CREATE INDEX idx_updateobjectproperties_prop ON updateobjectproperties USING btree (propkey, propvalue);


--
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES act_id_group(id_);


--
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES act_id_user(id_);


--
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES act_ru_task(id_);


--
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: clusterobjectproperties fk_clusterobjectproperties_clusterobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusterobjectproperties
    ADD CONSTRAINT fk_clusterobjectproperties_clusterobjects FOREIGN KEY (clusterobjects_id) REFERENCES clusterobjects(id) ON DELETE CASCADE;


--
-- Name: clusterobjects fk_clusterobjects_objectypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY clusterobjects
    ADD CONSTRAINT fk_clusterobjects_objectypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: configobjectproperties fk_configobjectproperties_configobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY configobjectproperties
    ADD CONSTRAINT fk_configobjectproperties_configobjects FOREIGN KEY (configobjects_id) REFERENCES configobjects(id) ON DELETE CASCADE;


--
-- Name: configobjects fk_configobjects_objecttypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY configobjects
    ADD CONSTRAINT fk_configobjects_objecttypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: genericobjectproperties fk_genericobjectproperties_genericobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjectproperties
    ADD CONSTRAINT fk_genericobjectproperties_genericobjects FOREIGN KEY (genericobjects_id) REFERENCES genericobjects(id) ON DELETE CASCADE;


--
-- Name: genericobjects fk_genericobjects_objecttypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY genericobjects
    ADD CONSTRAINT fk_genericobjects_objecttypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: managedobjectproperties fk_managedobjectproperties_managedobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY managedobjectproperties
    ADD CONSTRAINT fk_managedobjectproperties_managedobjects FOREIGN KEY (managedobjects_id) REFERENCES managedobjects(id) ON DELETE CASCADE;


--
-- Name: managedobjects fk_managedobjects_objectypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY managedobjects
    ADD CONSTRAINT fk_managedobjects_objectypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: relationshipproperties fk_relationshipproperties_relationships; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationshipproperties
    ADD CONSTRAINT fk_relationshipproperties_relationships FOREIGN KEY (relationships_id) REFERENCES relationships(id) ON DELETE CASCADE;


--
-- Name: relationships fk_relationships_objecttypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_relationships_objecttypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: schedulerobjectproperties fk_schedulerobjectproperties_schedulerobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY schedulerobjectproperties
    ADD CONSTRAINT fk_schedulerobjectproperties_schedulerobjects FOREIGN KEY (schedulerobjects_id) REFERENCES schedulerobjects(id) ON DELETE CASCADE;


--
-- Name: schedulerobjects fk_schedulerobjects_objectypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY schedulerobjects
    ADD CONSTRAINT fk_schedulerobjects_objectypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: updateobjectproperties fk_updateobjectproperties_updateobjects; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjectproperties
    ADD CONSTRAINT fk_updateobjectproperties_updateobjects FOREIGN KEY (updateobjects_id) REFERENCES updateobjects(id) ON DELETE CASCADE;


--
-- Name: updateobjects fk_updateobjects_objecttypes; Type: FK CONSTRAINT; Schema: openidm; Owner: openidm
--

ALTER TABLE ONLY updateobjects
    ADD CONSTRAINT fk_updateobjects_objecttypes FOREIGN KEY (objecttypes_id) REFERENCES objecttypes(id) ON DELETE CASCADE;


--
-- Name: fridam; Type: ACL; Schema: -; Owner: openidm
--

GRANT ALL ON SCHEMA fridam TO PUBLIC;


--
-- Name: openidm; Type: ACL; Schema: -; Owner: openidm
--

GRANT ALL ON SCHEMA openidm TO PUBLIC;


--
-- PostgreSQL database dump complete
--

