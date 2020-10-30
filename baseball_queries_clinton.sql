/*The below queries were written to extract data from the baseball_data sql file provided by Codeacademy. IT can be found in the same repository as a zip file.

Each query has a comment at the start to indicate what question we were trying to answer, and then one at the end to show what answer was found.*/
--Query to find heaviest team
select teams.name,batting.yearid, avg(people.weight)
from people
inner join batting 
	on batting.playerid = people.playerid
inner join teams 
	on batting.teamid = teams.teamid
group by teams.name, batting.yearid
order by avg(people.weight) desc;
--Answer: 2009 Chicago White Sox
--Query to find the shortest team
select teams.name,batting.yearid, avg(people.height) as height
from people
inner join batting 
	on batting.playerid = people.playerid
inner join teams 
	on batting.teamid = teams.teamid
group by teams.name, batting.yearid
order by avg(people.height) asc;
--answer: 1872 Middletown Mansfields
--Query to find teams with highest payroll of all time
Select teams.name, salaries.yearid, sum(salaries.salary) as total_spent
from salaries
left join teams 
	on salaries.teamid = teams.teamid and 
	salaries.yearid = teams.yearid
group by teams.name, salaries.yearid
order by total_spent desc
limit 10;
--Highest spending team of all time: 2013 New York Yankees
--Query to find team with lowest cost per win in 2010
select teams.name,salaries.yearid, ROUND(sum(salaries.salary)/teams.w) as cost_per_win,sum(salaries.salary) as payroll,teams.w as wins
from salaries
left join teams
	on salaries.teamid = teams.teamid
	and salaries.yearid = teams.yearid
Where teams.yearid = 2010
group by teams.name, salaries.yearid, teams.w
order by cost_per_win asc
limit 10;
--Most efficient spenders of 2010 were the Padres
--Query to find the pitcher who cost the most money per game they played in during one year
--filtered for pitchers who played at least 10 games
select CONCAT(people.namefirst, ' ', people.namelast) as player, (salaries.salary/pitching.g) as cost_per_game, salaries.yearid
from salaries 
inner join pitching
	on pitching.playerid = salaries.playerid
	and pitching.yearid = salaries.yearid
	and salaries.teamid = pitching.teamid
join people
	on pitching.playerid = people.playerid
where pitching.g >10
order by cost_per_game desc
limit 10;
--Answer is Cliff Lee is 2014
--These are now some of my own queries - last updated 10/30/2020
--Query to find pitcher who made the hall of fame averaging the least strikeouts per game
Select CONCAT(people.namefirst, ' ', people.namelast) as player, 
		sum(pitching.so) as Strikeouts,
		sum(pitching.g) as Games,
		Round(sum(pitching.so)/sum(pitching.g),2) as strikeouts_per_game
from halloffame
inner join pitching
	on halloffame.playerid = pitching.playerid
inner join people
	on halloffame.playerid = people.playerid
group by player, pitching.playerid
--Adding some filters to avoid field players who filled in for a smattering of games
having sum(pitching.so) > 0
	and sum(pitching.g) > 50
order by Strikeouts asc;
--answer is Eddie Dyer
