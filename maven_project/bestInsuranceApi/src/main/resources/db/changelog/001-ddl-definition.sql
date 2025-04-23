--liquibase formatted sql
--changeset tyler:001-changeset1.sql splitStatements:false

/*
Tables 
Customers, Subscriptions, addresses, countries, states, cities, coverages, policies_coverages, and policies
*/

CREATE TABLE Policies (
    policy_id UUID PRIMARY KEY,
    name VARCHAR(16) NOT NULL,
    description TEXT,
    price NUMERIC(4,2) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL
);

CREATE TABLE Coverages (
    coverage_id UUID PRIMARY KEY,
    name VARCHAR(16) NOT NULL,
    description TEXT
);

CREATE TABLE Countries (
    country_id UUID PRIMARY KEY,
    name VARCHAR(16) NOT NULL,
    population INT
);

/*
CREATE TABLE Customers (
    customer UUID NOT NULL,
    name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    email VARCHAR(320) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    address UUID -- foreign key
);
*/