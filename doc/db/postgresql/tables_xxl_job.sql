drop table if exists xxl_job_info;
drop table if exists xxl_job_log;
drop table if exists xxl_job_log_report;
drop table if exists xxl_job_logglue;
drop table if exists xxl_job_registry;
drop table if exists xxl_job_lock;
drop table if exists xxl_job_user;
drop table if exists xxl_job_group;
drop SEQUENCE if exists xxl_job_info_id_seq;
drop SEQUENCE if exists xxl_job_log_id_seq;
drop SEQUENCE if exists xxl_job_log_report_id_seq;
drop SEQUENCE if exists xxl_job_logglue_id_seq;
drop SEQUENCE if exists xxl_job_registry_id_seq;
drop SEQUENCE if exists xxl_job_user_id_seq;
drop SEQUENCE if exists xxl_job_group_id_seq;

CREATE SEQUENCE xxl_job_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_log_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_logglue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_registry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE xxl_job_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE "xxl_job_info" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_info_id_seq'::regclass),
  "job_group" int8 NOT NULL,
  "job_cron" varchar(128) NOT NULL,
  "job_desc" varchar(255) NOT NULL,
  "add_time" TIMESTAMP DEFAULT NULL,
  "update_time" TIMESTAMP DEFAULT NULL,
  "author" varchar(64) DEFAULT NULL,
  "alarm_email" varchar(255) DEFAULT NULL,
  "executor_route_strategy" varchar(50) DEFAULT NULL,
  "executor_handler" varchar(255) DEFAULT NULL,
  "executor_param" varchar(512) DEFAULT NULL,
  "executor_block_strategy" varchar(50) DEFAULT NULL,
  "executor_timeout" int4 NOT NULL DEFAULT '0',
  "executor_fail_retry_count" int4 NOT NULL DEFAULT '0',
  "glue_type" varchar(50) NOT NULL,
  "glue_source" text,
  "glue_remark" varchar(128) DEFAULT NULL,
  "glue_updatetime" TIMESTAMP DEFAULT NULL,
  "child_jobid" varchar(255) DEFAULT NULL,
  "trigger_status" int4 NOT NULL DEFAULT '0',
  "trigger_last_time" bigint NOT NULL DEFAULT '0',
  "trigger_next_time" bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_log" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_log_id_seq'::regclass),
  "job_group" int8 NOT NULL,
  "job_id" int8 NOT NULL,
  "executor_address" varchar(255) DEFAULT NULL,
  "executor_handler" varchar(255) DEFAULT NULL,
  "executor_param" varchar(512) DEFAULT NULL,
  "executor_sharding_param" varchar(20) DEFAULT NULL,
  "executor_fail_retry_count" int4 NOT NULL DEFAULT '0',
  "trigger_time" TIMESTAMP DEFAULT NULL,
  "trigger_code" int4 NOT NULL,
  "trigger_msg" text,
  "handle_time" TIMESTAMP DEFAULT NULL,
  "handle_code" int4 NOT NULL,
  "handle_msg" text,
  "alarm_status" int4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_log_report" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_log_report_id_seq'::regclass),
  "trigger_day" TIMESTAMP DEFAULT NULL,
  "running_count" int4 NOT NULL DEFAULT '0',
  "suc_count" int4 NOT NULL DEFAULT '0',
  "fail_count" int4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_logglue" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_logglue_id_seq'::regclass),
  "job_id" int8 NOT NULL,
  "glue_type" varchar(50) DEFAULT NULL,
  "glue_source" text,
  "glue_remark" varchar(128) NOT NULL,
  "add_time" TIMESTAMP DEFAULT NULL,
  "update_time" TIMESTAMP DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_registry" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_registry_id_seq'::regclass),
  "registry_group" varchar(50) NOT NULL,
  "registry_key" varchar(255) NOT NULL,
  "registry_value" varchar(255) NOT NULL,
  "update_time" TIMESTAMP DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_group" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_group_id_seq'::regclass),
  "app_name" varchar(64) NOT NULL,
  "title" varchar(12) NOT NULL,
  "address_type" int4 NOT NULL DEFAULT '0',
  "address_list" varchar(512) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_user" (
  "id" int8 NOT NULL DEFAULT nextval('xxl_job_user_id_seq'::regclass),
  "username" varchar(50) NOT NULL,
  "password" varchar(50) NOT NULL,
  "role" int4 NOT NULL ,
  "permission" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "xxl_job_lock" (
  "lock_name" varchar(50) NOT NULL,
  PRIMARY KEY ("lock_name")
);


INSERT INTO "xxl_job_group"("id", "app_name", "title", "address_type", "address_list")
VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL);
INSERT INTO "xxl_job_info"("id", "job_group", "job_cron", "job_desc", "add_time", "update_time", "author",
 "alarm_email", "executor_route_strategy", "executor_handler", "executor_param", "executor_block_strategy",
 "executor_timeout", "executor_fail_retry_count", "glue_type", "glue_source", "glue_remark", "glue_updatetime",
 "child_jobid") VALUES (1, 1, '0 0 0 * * ? *', '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL',
  '', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31',
   '');
INSERT INTO "xxl_job_user"("id", "username", "password", "role", "permission") VALUES (1, 'admin',
'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO "xxl_job_lock" ( "lock_name") VALUES ( 'schedule_lock');

commit;

