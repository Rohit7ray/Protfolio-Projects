use PortfolioProject
select * from CovidVaccinations

--Looking at total population vs vaccinations
select dea.continent, vac.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.date)
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
and dea.location = 'India'
order by 2,3



--CTE
WITH popvsvac (continent, location, date, Population, New_vaccinations, RollingCount)
as(
select dea.continent, vac.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.date) as RollingCount
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
and dea.location = 'India'
)

select *, (RollingCount/Population)*100
from popvsvac


--TEMP Table
DROP Table if exists #PPV
create table #PPV(
continent varchar(40),
location varchar(40),
Date date,
Population Numeric,
new_vaccinations Numeric,
RollingCount Numeric
)


insert into #PPV
select dea.continent, vac.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.date) as RollingCount
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
and dea.location = 'India'

select *, (RollingCount/Population)*100
from #PPV





--Creating view for later use in tableau
create view Percentage_Population_vaccinated as
select dea.continent, vac.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.date) as RollingCount
from CovidDeaths as dea
Join CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
