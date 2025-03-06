# !/usr/bin/env

echo "Creating ams database and tables"

psql -v ON_ERROR_STOP=1 --username "$DB_USERNAME" <<- EOSQL
CREATE ROLE kennedy LOGIN PASSWORD '${DB_PASSWORD}';
CREATE DATABASE ams;
GRANT ALL PRIVILEGES ON DATABASE ams to kennedy;

\c ams postgres
GRANT ALL PRIVILEGES ON SCHEMA public TO kennedy;

CREATE TABLE "users" (
  "user_id" integer PRIMARY KEY,
  "name" varchar,
  "email" varchar,
  "password" varchar,
  "phone_number" varchar,
  "profile_picture" varchar,
  "address" text,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "categories" (
  "category_id" integer PRIMARY KEY,
  "name" varchar,
  "description" text,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "tags" (
  "tag_id" integer PRIMARY KEY,
  "name" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "questions" (
  "question_id" integer PRIMARY KEY,
  "unique_id" varchar UNIQUE,
  "title" varchar,
  "description" text,
  "category_id" integer,
  "asker_id" integer,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "question_tags" (
  "tag_id" integer,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "answers" (
  "answer_id" integer PRIMARY KEY,
  "question_id" integer,
  "user_id" integer,
  "answer_text" text,
  "is_accepted" boolean DEFAULT false,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "votes" (
  "vote_id" integer PRIMARY KEY,
  "answer_id" integer,
  "voter_id" integer,
  "vote_value" integer,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

CREATE TABLE "rating" (
  "rating_id" integer PRIMARY KEY,
  "user_id" integer,
  "question_id" integer,
  "answer_id" integer,
  "rating_value" integer,
  "created_at" timestamp,
  "updated_at" timestamp,
  "created_by" integer,
  "updated_by" integer,
  "voided" boolean DEFAULT false,
  "voided_by" integer,
  "voided_reason" text,
  "voided_date" timestamp
);

ALTER TABLE "questions" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id");

ALTER TABLE "questions" ADD FOREIGN KEY ("asker_id") REFERENCES "users" ("user_id");

ALTER TABLE "question_tags" ADD FOREIGN KEY ("tag_id") REFERENCES "tags" ("tag_id");

ALTER TABLE "answers" ADD FOREIGN KEY ("question_id") REFERENCES "questions" ("question_id");

ALTER TABLE "answers" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "votes" ADD FOREIGN KEY ("answer_id") REFERENCES "answers" ("answer_id");

ALTER TABLE "votes" ADD FOREIGN KEY ("voter_id") REFERENCES "users" ("user_id");

ALTER TABLE "rating" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "rating" ADD FOREIGN KEY ("question_id") REFERENCES "questions" ("question_id");

ALTER TABLE "rating" ADD FOREIGN KEY ("answer_id") REFERENCES "answers" ("answer_id");

EOSQL

echo "Done initializing keycloak and orthanc database users"