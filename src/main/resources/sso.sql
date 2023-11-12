-- tutorial 上传到Github时，创建的仓库名为 tutorial-项目名。为的是用于区分是否用于学习的教程

-- 用于单点登录的数据库
create database if not exists sso;

-- 使用数据库 sso
use sso;

-- --------------------------------------------------------
-- 创建表
create table if not exists accounts
(
    a_id             varchar(50) not null PRIMARY key,
    a_account_number varchar(50) not null comment '登录账号：手机号/邮箱',
    a_password       varchar(50) not null comment '登录密码：字母、数字和特殊符号, 密码长度为8到20位',
    a_public_key     varchar(500) comment '密码加密公钥',
    create_datetime  datetime comment '创建时间',
    modify_datetime  datetime comment '修改时间'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

create table if not exists users
(
    u_id            varchar(50)  not null PRIMARY key,
    u_phone         varchar(11)  null comment '用户手机号',
    u_email         varchar(100) null comment '用户邮箱',
    u_h_img_name    varchar(500) null comment '用户头像名称',
    u_h_img_url     varchar(500) null comment '用户头像路径',
    u_h_img_mp_url  varchar(500) null comment '用户头像映射路径',
    u_a_id          varchar(50)  not null unique comment '用户账号外键',
    create_datetime datetime comment '创建时间',
    modify_datetime datetime comment '修改时间',
    CONSTRAINT accounts_users_fk_id foreign key (u_a_id) references accounts (a_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


create table if not exists account_trace
(
    at_id           varchar(50)  not null PRIMARY key,
    at_a_id         varchar(50)  not null comment '用户账号外键',
    trace_state     varchar(10)  not null comment '用户登录轨迹：1-登录，0-登出',
    trace_ip        varchar(50)  not null comment '登录IP',
    trace_addr      varchar(100) not null comment '登录地址',
    trace_dev       varchar(100) not null comment '登录设备',
    create_datetime datetime comment '创建时间',
    modify_datetime datetime comment '修改时间',
    CONSTRAINT accounts_account_trace_fk_id foreign key (at_a_id) references accounts (a_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


create table if not exists account_status
(
    as_id           varchar(50) not null PRIMARY key,
    as_a_id         varchar(50) not null comment '用户账号外键',
    status_code     varchar(10) not null comment '账号状态代码：0-启用，1-禁用，2-注销',
    status_name     varchar(50) not null comment '账号状态名称',
    create_datetime datetime comment '创建时间',
    modify_datetime datetime comment '修改时间',
    CONSTRAINT accounts_account_status_fk_id foreign key (as_a_id) references accounts (a_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

create table if not exists access_platform
(
    ap_id           varchar(50)  not null PRIMARY key,
    platform_name   varchar(100) null comment '应用名称',
    platform_id     varchar(64)  NULL COMMENT '应用标识',
    platform_secret varchar(64)  NOT NULL COMMENT '应用秘钥',
    sso_url         varchar(128) DEFAULT NULL COMMENT '单点登录地址',
    create_datetime datetime comment '创建时间',
    modify_datetime datetime comment '修改时间'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
