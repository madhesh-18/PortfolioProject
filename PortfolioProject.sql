-- selecting all the data from table coviddeaths
select * from coviddeaths
order by 3, 4;

-- selecting all the data from table covidvaccinations
select * from covidvaccinations
order by 3, 4;

-- select data that are requied for our project 
select location, actdate, total_cases, new_cases, total_deaths, population from coviddeaths
order by 1, 2;

-- total_deaths vs total_cases
-- Shows the likelihood of dying if you have covid in your country
select location, actdate, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage from coviddeaths
where location  like 'india'
order by 1, 2;

-- total cases vs population
-- shows what percentage of population got covid 
select location, actdate, total_cases, population, (total_cases/population)*100 as case_percentage from coviddeaths
where location  like 'india' 
order by 1, 2;

-- highest infection rate 
select location from (select location, actdate, total_cases, population, (total_cases/population)*100 as case_percentage from coviddeaths) as tbl1
where case_percentage = (select max(case_percentage) from (select location, actdate, total_cases, population, (total_cases/population)*100 as case_percentage from coviddeaths where actdate<'2021-04-30') as tbl2);

-- test
select * from coviddeaths where location = 'Brunei';

-- highest infection rate2 as per alex the analyst
select location, population, max(total_cases) as highest_infect_count, (max(total_cases)/population)*100 as highest_infect_rate from coviddeaths
group by location, population 
order by highest_infect_rate desc;

-- test2
select * from coviddeaths where location = 'United kingdom';

-- showing countries with highest death count per population
select location, population, max(total_deaths), (max(total_deaths)/population)*100 as death_percentage_based_on_population from coviddeaths
where location is not null
group by location, population
order by death_percentage_based_on_population desc;


-- continent wise death_percentage_based_on_population
select continent, (total_death/total_pop)*100 as death_percentage_continent from (select distinct continent, sum(population) as total_pop, sum(total_deaths) as total_death from coviddeaths
where continent != '0'
group by continent) as tbl4
order by death_percentage_continent desc, continent;


select distinct continent, population, max(total_deaths), (max(total_deaths)/population)*100 as death_percentage_based_on_population from coviddeaths
group by continent
order by death_percentage_based_on_population desc;

-- showing continents <includes world date as well> with highest death count per population
select distinct location, population, max(total_deaths), (max(total_deaths)/population)*100 as death_percentage_based_on_population from coviddeaths
                                                      where location like 'World' or 
															location like 'Europe' or 
                                                            location like 'North America' or 
                                                            location like 'South America' or 
                                                            location like 'Asia' or 
                                                            location like 'European Union' or 
                                                            location like 'Africa' or 
                                                            location like 'Oceania' 
group by location, population
order by death_percentage_based_on_population desc;

-- showing continents with highest death count per population 

select continent, max(total_deaths) as max_death_country_by_continent from coviddeaths
group by continent
order by max_death_country_by_continent desc;

-- Breaking global numbers by date
select actdate, sum(new_cases), sum(new_deaths), (sum(new_deaths)/sum(new_cases))*100 as death_rate_by_date from coviddeaths
                                                      where location not like 'World' or 
															location not like 'Europe' or 
                                                            location not like 'North America' or 
                                                            location not like 'South America' or 
                                                            location not like 'Asia' or 
                                                            location not like 'European Union' or 
                                                            location not like 'Africa' or 
                                                            location not like 'Oceania' 
group by actdate;

-- Breaking global numbers 
select location, max(total_cases), max(total_deaths), (max(total_deaths)/max(total_cases))*100 as death_rate_by_date from coviddeaths
                                                      where location like 'World'
group by location;


select * from coviddeaths d join covidvaccinations v on d.location = v.location and d.actdate = v.date; 


-- Looking at Total population vs vaccinations
-- Using subquery
select *, (total_vac_till_date/population)  from 
(select d.continent, d.location, d.actdate, d.population, v.new_vaccinations, sum(v.new_vaccinations) over(partition by d.location order by d.actdate) as total_vac_till_date from coviddeaths d join covidvaccinations v 
on d.location = v.location and d.actdate = v.date) as tbl5;

-- Using temp table 

drop table if exists percentpopulaitonvaccinated;
create temporary table if not exists percentpopulaitonvaccinated (
continent varchar(50), 
location varchar(100), 
actdate date,
population bigint, 
new_vaccinations bigint,
total_vac_till_date bigint
);

insert into percentpopulaitonvaccinated(continent, location, actdate, population,  new_vaccinations, total_vac_till_date)
select d.continent, d.location, d.actdate, d.population, v.new_vaccinations, sum(v.new_vaccinations) over(partition by d.location order by d.actdate) as total_vac_till_date from coviddeaths d join covidvaccinations v 
on d.location = v.location and d.actdate = v.date;

select * from percentpopulaitonvaccinated;


-- Using CTE 

with popvsvac as (select d.continent, d.location, d.actdate, d.population, v.new_vaccinations, sum(v.new_vaccinations) over(partition by d.location order by d.actdate) as total_vac_till_date from coviddeaths d join covidvaccinations v 
on d.location = v.location and d.actdate = v.date)
select *, (total_vac_till_date/population) from popvsvac;




