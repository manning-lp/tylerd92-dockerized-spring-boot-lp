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

CREATE TABLE States (
    state_id UUID PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    country UUID NOT NULL,
    population INT,
    FOREIGN KEY (country) REFERENCES Countries(country_id)
);

CREATE TABLE Cities (
    city_id UUID PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    state UUID NOT NULL,
    country UUID NOT NULL,
    population INT,
    FOREIGN KEY (state) REFERENCES States(state_id),
    FOREIGN KEY (country) REFERENCES Countries(country_id)
);

CREATE TABLE Addresses (
    address_id UUID PRIMARY KEY,
    street VARCHAR(128) NOT NULL,
    postal_code VARCHAR(16) NOT NULL,
    city UUID NOT NULL,
    state UUID NOT NULL,
    country UUID NOT NULL,
    FOREIGN KEY (city) REFERENCES Cities(city_id),
    FOREIGN KEY (state) REFERENCES States(state_id),
    FOREIGN KEY (country) REFERENCES Countries(country_id)
);


CREATE TABLE Customers (
    customer_id UUID PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    email VARCHAR(320) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    address UUID,
    FOREIGN KEY (address) REFERENCES Addresses(address_id)
);

CREATE TABLE Subscriptions (
    policy_id UUID NOT NULL,
    customer_id UUID NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    paid_price NUMERIC(4,2) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    PRIMARY KEY (policy_id, customer_id),
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Policy_Coverages (
    policy_id UUID NOT NULL,
    coverage_id UUID NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id),
    FOREIGN KEY (coverage_id) REFERENCES Coverages(coverage_id)
);