-- Data Exploration

select * 
from PortofolioProjects..CovidDeaths
where continent is not null
order by 3 , 4


--select * 
--from PortofolioProjects..CovidVaccinations
--order by 3 , 4

-- Explore CovidDeaths Data
select location , date , population , total_cases ,  new_cases , total_deaths 
from PortofolioProjects..CovidDeaths
where continent is not null
order by 1,2

-- Looking for total_cases vs total_deaths
select location , date , total_cases , total_deaths , (total_deaths/total_cases)*100 as deathsPercentageOfTotalCases
from PortofolioProjects..CovidDeaths
where continent is not null
order by 1 , 2

-- Looking for total_cases vs population
select location , date , population  , total_cases , (total_cases/population)*100 as casesPercentageOfPopulation
from PortofolioProjects..CovidDeaths
where continent is not null
order by 1 , 2

--Looking for highest infected country
select location , population    , MAX(total_cases) as highestInfectionCount 
from PortofolioProjects..CovidDeaths
where continent is not null
group by location , population
order by highestInfectionCount desc

--Looking for highest deaths country
select location , MAX(cast(total_deaths as int)) as highestDeathsCount  
from PortofolioProjects..CovidDeaths
where continent is not null
group by location 
order by highestDeathsCount desc


--Looking for how many people died for each country
select location  , population  ,  SUM(cast(total_deaths as int)) as totalDeathsPerCountry
from PortofolioProjects..CovidDeaths
where continent is not null
group by location  , population
order by totalDeathsPerCountry desc

--BREAKDOWN BY CONTINENT
select continent ,  SUM(cast(total_deaths as int)) as totalDeathsCount
from PortofolioProjects..CovidDeaths
where continent is not null
group by continent  
order by totalDeathsCount desc

-- the highest continent with deaths count per population
select continent , population  ,  SUM(cast(total_deaths as int)) as totalDeaths
from PortofolioProjects..CovidDeaths
where continent is not null
group by continent  , population 
order by totalDeaths desc
 

 -- GLOBAL NUMBERS

select SUM(new_cases) as totalCases , SUM(cast(total_deaths as int)) as globalDeaths ,  (SUM(cast(total_deaths as int)) / SUM(new_cases))*100 as DeathsPercentage
from PortofolioProjects..CovidDeaths
where continent is not null


--Looking at total population vs total vaccinated

select vac.location , population , vac.new_vaccinations
from PortofolioProjects..CovidVaccinations vac
join PortofolioProjects..CovidDeaths dea
	on vac.location = dea.location
	and vac.date = dea.date
order by 3 desc


--Looking at total population vs total vaccinated for each location

select vac.location , population , SUM(cast(vac.total_vaccinations as float )) as totalVaccinated
from PortofolioProjects..CovidVaccinations vac
join PortofolioProjects..CovidDeaths dea
	on vac.location = dea.location
	and vac.date = dea.date
--where vac.location = 'Egypt'
where vac.continent is not null
group by vac.location , dea.population

