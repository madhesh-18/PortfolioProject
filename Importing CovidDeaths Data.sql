create database if not exists portfolioproject;

use portfolioproject;


create table if not exists coviddeaths(
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    actdate DATE,
    population BIGINT,
    total_cases INT default null,
    new_cases BIGINT,
    new_cases_smoothed FLOAT,
    total_deaths BIGINT,
    new_deaths BIGINT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients BIGINT,
    icu_patients_per_million FLOAT,
    hosp_patients BIGINT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions BIGINT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions BIGINT,
    weekly_hosp_admissions_per_million FLOAT
);


CREATE TABLE  if not exists covidvaccinations (
    iso_code VARCHAR(20),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_tests BIGINT, -- Assuming this is a count, using BIGINT for large numbers
    new_tests BIGINT,
    total_tests_per_thousand DECIMAL(10, 3), -- Decimal for percentage values
    new_tests_per_thousand DECIMAL(10, 3),
    new_tests_smoothed BIGINT,
    new_tests_smoothed_per_thousand DECIMAL(10, 3),
    positive_rate DECIMAL(5, 4), -- Decimal for percentage values
    tests_per_case DECIMAL(20, 2), -- Decimal for ratio values
    tests_units VARCHAR(50),
    total_vaccinations BIGINT,
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    total_boosters BIGINT,
    new_vaccinations BIGINT,
    new_vaccinations_smoothed BIGINT,
    total_vaccinations_per_hundred DECIMAL(8, 2),
    people_vaccinated_per_hundred DECIMAL(8, 2),
    people_fully_vaccinated_per_hundred DECIMAL(8, 2),
    total_boosters_per_hundred DECIMAL(8, 2),
    new_vaccinations_smoothed_per_million BIGINT,
    new_people_vaccinated_smoothed BIGINT,
    new_people_vaccinated_smoothed_per_hundred DECIMAL(8, 2),
    stringency_index DECIMAL(8, 2),
    population_density DECIMAL(10, 2),
    median_age DECIMAL(5, 2),
    aged_65_older DECIMAL(5, 2),
    aged_70_older DECIMAL(5, 2),
    gdp_per_capita DECIMAL(12, 2),
    extreme_poverty DECIMAL(5, 2),
    cardiovasc_death_rate DECIMAL(8, 2),
    diabetes_prevalence DECIMAL(8, 2),
    female_smokers DECIMAL(5, 2),
    male_smokers DECIMAL(5, 2),
    handwashing_facilities DECIMAL(8, 2),
    hospital_beds_per_thousand DECIMAL(8, 2),
    life_expectancy DECIMAL(5, 2),
    human_development_index DECIMAL(5, 3),
    excess_mortality_cumulative_absolute BIGINT,
    excess_mortality_cumulative BIGINT,
    excess_mortality BIGINT,
    excess_mortality_cumulative_per_million BIGINT
);



Load data infile 'CovidDeaths.csv' into table coviddeaths
fields terminated by ','
ignore 1 lines;

Load data infile 'CovidVaccinations.csv' into table covidvaccinations
fields terminated by ','
ignore 1 lines;

select * from coviddeaths where total_deaths = 7037007; 
select * from covidvaccinations;


select * from coviddeaths d join covidvaccinations v on d.location = v.location and d.actdate = v.date; 
