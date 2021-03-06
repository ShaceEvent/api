# --- !Ups

create table se_access_token (
  token                     varchar(40) not null,
  auto_renew                boolean,
  creation                  bigint,
  expiration                bigint,
  user_id                   integer,
  type                      integer,
  lang                      integer,
  constraint ck_se_access_token_type check (type in (0,1)),
  constraint ck_se_access_token_lang check (lang in (0,1,2)),
  constraint pk_se_access_token primary key (token))
;

create table se_access_token_event_relation (
  id                        integer not null,
  event_id                  varchar(36),
  accessToken_id            varchar(40),
  permission                integer,
  constraint ck_se_access_token_event_relation_permission check (permission in (0,1,2,3,4)),
  constraint pk_se_access_token_event_relatio primary key (id))
;

create table se_beta_invitation (
  id                        integer not null,
  original_user_id          integer,
  created_user_id           integer,
  email                     varchar(255),
  password                  varchar(40),
  first_name                varchar(35),
  last_name                 varchar(35),
  invitation_date           timestamp,
  invited_people            integer,
  state                     integer,
  lang                      integer,
  constraint ck_se_beta_invitation_state check (state in (0,1,2)),
  constraint ck_se_beta_invitation_lang check (lang in (0,1,2)),
  constraint pk_se_beta_invitation primary key (id))
;

create table se_bucket (
  id                        integer not null,
  name                      varchar(255),
  parent_id                 integer,
  level                     integer,
  first                     timestamp,
  last                      timestamp,
  size                      integer,
  event_id                  varchar(36),
  constraint pk_se_bucket primary key (id))
;

create table se_comment (
  id                        integer not null,
  creation                  timestamp,
  message                   varchar(255),
  owner_id                  integer,
  media_id                  integer,
  constraint pk_se_comment primary key (id))
;

create table se_email (
  id                        integer not null,
  lang                      integer,
  type                      integer,
  subject                   varchar(255),
  from_email                varchar(255),
  html                      text,
  constraint ck_se_email_lang check (lang in (0,1,2)),
  constraint pk_se_email primary key (id))
;

create table se_event (
  id                        varchar(36) not null,
  token                     varchar(255),
  name                      varchar(255),
  description               varchar(255),
  reading_privacy           integer,
  writing_privacy           integer,
  reading_password          varchar(40),
  writing_password          varchar(40),
  creation                  timestamp,
  root_id                   integer,
  cover_image_id            integer,
  constraint ck_se_event_reading_privacy check (reading_privacy in (0,1,2,3)),
  constraint ck_se_event_writing_privacy check (writing_privacy in (0,1,2,3)),
  constraint uq_se_event_token unique (token),
  constraint pk_se_event primary key (id))
;

create table se_event_user_relation (
  id                        integer not null,
  event_token               varchar(36),
  user_id                   integer,
  permission                integer,
  constraint ck_se_event_user_relation_permission check (permission in (0,1,2,3,4)),
  constraint pk_se_event_user_relation primary key (id))
;

create table se_feedback (
  id                        integer not null,
  description               varchar(255),
  user_id                   integer,
  sender_email              varchar(254),
  ok_for_answer             boolean,
  creation_date             timestamp,
  admin_read                boolean,
  constraint pk_se_feedback primary key (id))
;

create table se_file (
  id                        integer not null,
  creation                  timestamp,
  uid                       varchar(255),
  base_url                  varchar(255),
  type                      integer,
  constraint ck_se_file_type check (type in (0,1)),
  constraint pk_se_file primary key (id))
;

create table se_image (
  id                        integer not null,
  creation                  timestamp,
  constraint pk_se_image primary key (id))
;

create table se_image_file_relation (
  id                        integer not null,
  image_id                  integer,
  file_id                   integer,
  width                     integer,
  height                    integer,
  format                    varchar(255),
  constraint pk_se_image_file_relation primary key (id))
;

create table se_image_format (
  name                      varchar(255) not null,
  width                     integer,
  height                    integer,
  crop                      boolean,
  type                      integer,
  constraint ck_se_image_format_type check (type in (0,1,2)),
  constraint pk_se_image_format primary key (name))
;

create table se_media (
  id                        integer not null,
  type                      integer,
  name                      varchar(255),
  description               varchar(255),
  rank                      integer,
  creation                  timestamp,
  owner_id                  integer,
  event_id                  varchar(36),
  image_id                  integer,
  original                  timestamp,
  constraint ck_se_media_type check (type in (0,1,2)),
  constraint pk_se_media primary key (id))
;

create table se_tag (
  id                        integer not null,
  name                      varchar(255),
  slug                      varchar(255),
  media_id                  integer,
  user_id                   integer,
  creation                  timestamp,
  constraint pk_se_tag primary key (id))
;

create table se_user (
  id                        integer not null,
  email                     varchar(254),
  password                  varchar(40),
  first_name                varchar(35),
  last_name                 varchar(35),
  birth_date                timestamp,
  inscription_date          timestamp,
  is_admin                  boolean,
  lang                      integer,
  profile_picture_id        integer,
  cover_picture_id          integer,
  constraint ck_se_user_lang check (lang in (0,1,2)),
  constraint uq_se_user_email unique (email),
  constraint pk_se_user primary key (id))
;


create table se_bucket_media (
  se_bucket_id                   integer not null,
  se_media_id                    integer not null,
  constraint pk_se_bucket_media primary key (se_bucket_id, se_media_id))
;
create sequence se_access_token_seq;

create sequence se_access_token_event_relation_seq;

create sequence se_beta_invitation_seq;

create sequence se_bucket_seq;

create sequence se_comment_seq;

create sequence se_email_seq;

create sequence se_event_seq;

create sequence se_event_user_relation_seq;

create sequence se_feedback_seq;

create sequence se_file_seq;

create sequence se_image_seq;

create sequence se_image_file_relation_seq;

create sequence se_image_format_seq;

create sequence se_media_seq;

create sequence se_tag_seq;

create sequence se_user_seq;

alter table se_access_token add constraint fk_se_access_token_user_1 foreign key (user_id) references se_user (id);
create index ix_se_access_token_user_1 on se_access_token (user_id);
alter table se_access_token_event_relation add constraint fk_se_access_token_event_relat_2 foreign key (event_id) references se_event (id);
create index ix_se_access_token_event_relat_2 on se_access_token_event_relation (event_id);
alter table se_access_token_event_relation add constraint fk_se_access_token_event_relat_3 foreign key (accessToken_id) references se_access_token (token);
create index ix_se_access_token_event_relat_3 on se_access_token_event_relation (accessToken_id);
alter table se_beta_invitation add constraint fk_se_beta_invitation_original_4 foreign key (original_user_id) references se_user (id);
create index ix_se_beta_invitation_original_4 on se_beta_invitation (original_user_id);
alter table se_beta_invitation add constraint fk_se_beta_invitation_createdU_5 foreign key (created_user_id) references se_user (id);
create index ix_se_beta_invitation_createdU_5 on se_beta_invitation (created_user_id);
alter table se_bucket add constraint fk_se_bucket_parent_6 foreign key (parent_id) references se_bucket (id);
create index ix_se_bucket_parent_6 on se_bucket (parent_id);
alter table se_bucket add constraint fk_se_bucket_event_7 foreign key (event_id) references se_event (id);
create index ix_se_bucket_event_7 on se_bucket (event_id);
alter table se_comment add constraint fk_se_comment_owner_8 foreign key (owner_id) references se_user (id);
create index ix_se_comment_owner_8 on se_comment (owner_id);
alter table se_comment add constraint fk_se_comment_media_9 foreign key (media_id) references se_media (id);
create index ix_se_comment_media_9 on se_comment (media_id);
alter table se_event add constraint fk_se_event_root_10 foreign key (root_id) references se_bucket (id);
create index ix_se_event_root_10 on se_event (root_id);
alter table se_event add constraint fk_se_event_coverImage_11 foreign key (cover_image_id) references se_image (id);
create index ix_se_event_coverImage_11 on se_event (cover_image_id);
alter table se_event_user_relation add constraint fk_se_event_user_relation_eve_12 foreign key (event_token) references se_event (id);
create index ix_se_event_user_relation_eve_12 on se_event_user_relation (event_token);
alter table se_event_user_relation add constraint fk_se_event_user_relation_use_13 foreign key (user_id) references se_user (id);
create index ix_se_event_user_relation_use_13 on se_event_user_relation (user_id);
alter table se_feedback add constraint fk_se_feedback_senderUser_14 foreign key (user_id) references se_user (id);
create index ix_se_feedback_senderUser_14 on se_feedback (user_id);
alter table se_image_file_relation add constraint fk_se_image_file_relation_ima_15 foreign key (image_id) references se_image (id);
create index ix_se_image_file_relation_ima_15 on se_image_file_relation (image_id);
alter table se_image_file_relation add constraint fk_se_image_file_relation_fil_16 foreign key (file_id) references se_file (id);
create index ix_se_image_file_relation_fil_16 on se_image_file_relation (file_id);
alter table se_media add constraint fk_se_media_owner_17 foreign key (owner_id) references se_user (id);
create index ix_se_media_owner_17 on se_media (owner_id);
alter table se_media add constraint fk_se_media_event_18 foreign key (event_id) references se_event (id);
create index ix_se_media_event_18 on se_media (event_id);
alter table se_media add constraint fk_se_media_image_19 foreign key (image_id) references se_image (id);
create index ix_se_media_image_19 on se_media (image_id);
alter table se_tag add constraint fk_se_tag_media_20 foreign key (media_id) references se_media (id);
create index ix_se_tag_media_20 on se_tag (media_id);
alter table se_tag add constraint fk_se_tag_creator_21 foreign key (user_id) references se_user (id);
create index ix_se_tag_creator_21 on se_tag (user_id);
alter table se_user add constraint fk_se_user_profilePicture_22 foreign key (profile_picture_id) references se_image (id);
create index ix_se_user_profilePicture_22 on se_user (profile_picture_id);
alter table se_user add constraint fk_se_user_coverPicture_23 foreign key (cover_picture_id) references se_image (id);
create index ix_se_user_coverPicture_23 on se_user (cover_picture_id);



alter table se_bucket_media add constraint fk_se_bucket_media_se_bucket_01 foreign key (se_bucket_id) references se_bucket (id);

alter table se_bucket_media add constraint fk_se_bucket_media_se_media_02 foreign key (se_media_id) references se_media (id);

# --- !Downs

drop table if exists se_access_token cascade;

drop table if exists se_access_token_event_relation cascade;

drop table if exists se_beta_invitation cascade;

drop table if exists se_bucket cascade;

drop table if exists se_bucket_media cascade;

drop table if exists se_comment cascade;

drop table if exists se_email cascade;

drop table if exists se_event cascade;

drop table if exists se_event_user_relation cascade;

drop table if exists se_feedback cascade;

drop table if exists se_file cascade;

drop table if exists se_image cascade;

drop table if exists se_image_file_relation cascade;

drop table if exists se_image_format cascade;

drop table if exists se_media cascade;

drop table if exists se_tag cascade;

drop table if exists se_user cascade;

drop sequence if exists se_access_token_seq;

drop sequence if exists se_access_token_event_relation_seq;

drop sequence if exists se_beta_invitation_seq;

drop sequence if exists se_bucket_seq;

drop sequence if exists se_comment_seq;

drop sequence if exists se_email_seq;

drop sequence if exists se_event_seq;

drop sequence if exists se_event_user_relation_seq;

drop sequence if exists se_feedback_seq;

drop sequence if exists se_file_seq;

drop sequence if exists se_image_seq;

drop sequence if exists se_image_file_relation_seq;

drop sequence if exists se_image_format_seq;

drop sequence if exists se_media_seq;

drop sequence if exists se_tag_seq;

drop sequence if exists se_user_seq;

