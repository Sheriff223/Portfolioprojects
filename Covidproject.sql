SELECT *
FROM [Portfolio Project]..CovidDeaths$
ORDER BY 3,4


SELECT location, date,total_cases,new_cases, total_deaths, population
FROM [Portfolio Project]..CovidDeaths$
ORDER BY 1,2

--Looking at total cases vs total deaths

SELECT location, date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
FROM [Portfolio Project]..CovidDeaths$
where location like '%states%'
ORDER BY 1,2

--looking at total cases vs population
-- shows what percentage of population was infected
SELECT location, date,total_cases,population, (total_cases/population)*100 as percentageinfected
FROM [Portfolio Project]..CovidDeaths$
ORDER BY 1,2

--looking at countries with heighest infection rate compared to population

SELECT location, population,MAX(total_cases) as HeighestInfectioncount, MAX((total_cases/population))*100 as percentagepopulationinfected
FROM [Portfolio Project]..CovidDeaths$
GROUP BY location, population
ORDER BY percentagepopulationinfected DESC

--Showing countries with heighest death count

SELECT location,MAX(cast(total_deaths as int)) as totaldeathcount 
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
GROUP BY location
ORDER BY totaldeathcount DESC


--showing continent with the heighest death count


SELECT location,MAX(cast(total_deaths as int)) as totaldeathcount 
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is null 
GROUP BY location
ORDER BY totaldeathcount DESC

--Global numbers of new cases and new deaths per day


SELECT date,SUM(new_cases) as total_cases, SUM(CAST(new_deaths as INT)) as Total_death,(SUM(CAST(new_deaths as INT))/SUM(new_cases))*100 AS deathpercentage
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null 
GROUP BY date
ORDER BY 1,2


--Looking at population vs vaccination(as they are in two different tables)


SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.date)
FROM [Portfolio Project]..CovidDeaths$ dea
JOIN [Portfolio Project]..CovidVaccinations$ vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent is not null
ORDER BY 2,3



