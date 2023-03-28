select*
from [Sql Project portfolio]..CovidDeaths
where continent is not null
order by 3,4

select*
from [Sql Project portfolio]..CovidVaccinations
where continent is not null
order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
from [Sql Project portfolio]..CovidDeaths
where continent is not null
order by 1,2

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Sql Project portfolio]..CovidDeaths
where location like '%states%'
order by 1,2


Select location, date, total_cases, population, (total_cases/population)*100 as PercentageOfPopulationInfected
from [Sql Project portfolio]..CovidDeaths
where location like 'Nigeria'
order by 1,2

select location, population, max(total_cases) as HighestInfectioncCount, max(total_cases/population)*100 as PercentageOfPopulationInfected
from [Sql Project portfolio]..CovidDeaths
where continent is not null
group by location, population
order by PercentageOfPopulationInfected desc

select location, max(cast(Total_deaths as int)) as TotalDeathCount
from [Sql Project portfolio]..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc


select location, max(cast(Total_deaths as int)) as TotalDeathCount
from [Sql Project portfolio]..CovidDeaths
where continent is  null
group by location
order by TotalDeathCount desc

select continent, max(cast(Total_deaths as int)) as TotalDeathCount
from [Sql Project portfolio]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


select continent, max(cast(Total_deaths as int)) as TotalDeathCount
from [Sql Project portfolio]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

Select date, sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_Deaths,sum(cast(new_deaths as int))/sum(new_cases)*100  as DeathPercentage
from [Sql Project portfolio]..CovidDeaths
where continent is not null
Group by date
order by 1,2

Select sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_Deaths,sum(cast(new_deaths as int))/sum(new_cases)*100  as DeathPercentage
from [Sql Project portfolio]..CovidDeaths
where continent is not null
--Group by date
order by 1,2

select*
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
      on dea.location = vac.location
	  and dea.date = vac.date

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 --,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
,sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3

with PopvsVac (continent, location, Date, population, New_vaccinations, RollingPeopleVaccinated) as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 --,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
,sum(convert(int, vac.new_vaccinations))over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select*, (RollingPeopleVaccinated/population)*100
from PopvsVac



Drop Table if exists #PercentpopulationVaccinated
create table #PercentpopulationVaccinated
(
continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #PercentpopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 --,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
,sum(convert(int, vac.new_vaccinations))over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
--order by 2,3
select*, (RollingPeopleVaccinated/Population)*100
from #PercentpopulationVaccinated


create view PercentpopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 --,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
,sum(convert(int, vac.new_vaccinations))over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select*
from PercentpopulationVaccinated


create view DeathPercentage as
Select sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_Deaths,sum(cast(new_deaths as int))/sum(new_cases)*100  as DeathPercentage
from [Sql Project portfolio]..CovidDeaths
where continent is not null
--Group by date
--order by 1,2

select*
from DeathPercentage


create view TotalDeathCount as
select continent, max(cast(Total_deaths as int)) as TotalDeathCount
from [Sql Project portfolio]..CovidDeaths
where continent is not null
group by continent
--order by TotalDeathCount desc

select*
from TotalDeathCount

create view RollingPeopleVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 --,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
,sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Sql Project portfolio]..CovidDeaths dea
join [Sql Project portfolio]..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select*
from RollingPeopleVaccinated



