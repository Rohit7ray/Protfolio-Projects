use PortfolioProject

select * from CovidDeaths
where continent is not null

--Selecting data which we are going to use
select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
where continent is not null
order by 1,2


--looking at total cases vs total deaths
--show likelihood of dying if you cantract covid in your contry
select location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 as Deathpercentage
from CovidDeaths
where location like '%India%'
and continent is not null
order by 1,2

--looking at total cases vs population
--Show what % of population got covid
select location, date, population,total_cases, (total_cases/population)*100 as totalcasesPercentage
from CovidDeaths
where location = 'India'
--and continent is not null
order by 1,2

--Looking at countries with highest infection rate compared to  population
select location, population,max(total_cases) as highestInfectionRate, 
max((total_cases/population))*100 as totalcasesPercentage
from CovidDeaths
--where location = 'India'
where continent is not null
group by location, population
order by 4 desc

--showing countries with highest death count per population
select location, max(cast(total_deaths as int)) as total_death_Count
from CovidDeaths
--where location = 'India'
where continent is not null
group by location
order by 2 desc



--Breakng down into continents
--Showing continent with highest death count per popuulation
select location, max(cast(total_deaths as int)) as total_death_Count
from CovidDeaths
--where location = 'India'
where continent is null
group by location
order by 2 desc


select continent, max(cast(total_deaths as int)) as total_death_Count
from CovidDeaths
--where location = 'India'
where continent is not null
group by continent
order by 2 desc


--Global numbers
select date, sum(new_cases) Total_cases, sum(cast(new_deaths as int)) Total_deaths,
(sum(cast(new_deaths as int))/sum(new_cases)) * 100 death_percentage
from CovidDeaths
where 
continent is not null
group by date
order by 1

