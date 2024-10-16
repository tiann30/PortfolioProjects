/*

Queries used for Tableau Project

*/

-- 1. Calculate total cases, total deaths, and death percentage globally
-- This query sums new cases and deaths to calculate the global death percentage
-- where continent is not null.

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- Validation: Uncomment below for comparison with "International" location

-- Select SUM(new_cases) as total_cases, 
--        SUM(cast(new_deaths as int)) as total_deaths, 
--        SUM(cast(new_deaths as int)) / SUM(New_Cases) * 100 as DeathPercentage
-- From PortfolioProject..CovidDeaths
-- where location = 'World'
-- order by 1, 2


-- 2. Locations not part of any continent (excluding 'World', 'European Union', 'International')
-- This query excludes specific locations to maintain consistency in analysis.

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- 3. Highest infection count and percentage of population infected per location
-- This query calculates the maximum infection count and infection rate 
-- for each location based on population size.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- 4. Highest infection count and infection percentage per location and date
-- This query breaks down infection rates per population by date and location.

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc


















