
use workation

select *from workation

Q1 : List the top countries according to their max avg wifi speeed

select Country, max(Average_WiFi_speed)
from workation
group by Country
order by max(Average_WiFi_speed) desc
limit 10

Q2: Find the top 5 cities with maximum number of tourist attraction

select City , Tourist_attractions
from workation
order by Tourist_attractions desc
limit 5

Q3: Find count of each country in the top 10 cities having highest avg wifi speeds

select country,count(country)
from ( select country 
       from workation
       order by average_wifi_speed desc
       limit 10) as B
group by country
order by count(country) desc

Q4: Which of the cities have average wifi speed > 50 MBPS and  Avg cost of a meal at a local midlevel restaurant less than 10 pounds ?

select city
from workation 
where Avg_cost_of_a_meal_at_a_local_midlevel_restaurant < 10 and Average_wifi_speed > 50

Q5 Top cities in which remote workers enjoy the most affordable accomodation, meal, taxi,coffee,beers

select city ,Country, RANK() OVER(order by affordability) as "rank"
from(
select City, Country, ROUND((Avg_cost_of_a_meal_at_a_local_midlevel_restaurant + Avg_price_for_2beers_in_a_bar + Avg_price_of_buying_a_coffee + Avg_price_of_one_bedroom_apartment_per_month + Avg_price_of_taxi),2) as "affordability"
from workation
    ) as B
Q6 Rank the affordable cities in their respective countries

select city ,Country, RANK() OVER(partition by country order by affordability) as "rank", affordability
from(
select City, Country, ROUND((Avg_cost_of_a_meal_at_a_local_midlevel_restaurant + Avg_price_for_2beers_in_a_bar + Avg_price_of_buying_a_coffee + Avg_price_of_one_bedroom_apartment_per_month + Avg_price_of_taxi),2) as "affordability"
from workation
    ) as B
order by country

Q7: Top Cities whixh have affordable wifi speed and more co-working spaces , more tourist attractions, more no of sunshine hours ?

select City, Country, ROUND((Average_WiFi_speed + No_of_coworking_spaces + Tourist_attractions + Avg_no_of_sunshine_hours),2) as "pleasantness"
from workation
order by pleasantness desc


Q8 : rank cities pleasantess within their repsective countries 

select city ,Country, RANK() OVER(partition by country order by pleasantness desc) as "rank", pleasantness
from(
select City, Country, ROUND((Average_WiFi_speed + No_of_coworking_spaces + Tourist_attractions + Avg_no_of_sunshine_hours),2) as "pleasantness"
from workation
) as B
 
 Q9: Top 10 cities and their percentage in total no of co-working spaces  
 
select city,round(((No_of_coworking_spaces*100)/(select sum(No_of_coworking_spaces) from workation)),2) as "perc"
from workation 
order by No_of_coworking_spaces desc
limit 10
 
 Q10: Cities with less than total average of average price of one bedroom apartment per month 
 
select city , avg_price_of_one_bedroom_apartment_per_month
from workation 
where
avg_price_of_one_bedroom_apartment_per_month <=
(select avg(avg_price_of_one_bedroom_apartment_per_month)
 from workation)
                                                      

