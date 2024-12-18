select * from youtube;

Q1. Calculate the total revenue (SUM(RevenueLastMonth)) for influencers in the
"Gaming" category.

select sum(RevenueLastMonth) as total_revenue from youtube
where channeltype='Gaming';

• Q2. Find the total revenue for each Country.

select country,sum(RevenueLastMonth) as total_revenue from youtube
group by country
order by total_revenue desc;

• Q3. Calculate the total revenue for each country, but only include rows where
ChannelType is "Gaming".

select country,sum(RevenueLastMonth) as total_revenue from youtube
where channeltype='Gaming'
group by country
order by total_revenue desc;

• Q4. Find countries where the total revenue exceeds $200,00;

SELECT Country, SUM(RevenueLastMonth) AS TotalRevenue
FROM youtube
GROUP BY Country
HAVING SUM(RevenueLastMonth) > 200000;


• Q5. Find countries with influencers in the "Gaming" category, where the total revenue
for gaming channels exceeds $30,000.

SELECT Country, SUM(RevenueLastMonth) AS TotalGamingRevenue
FROM youtube
WHERE channeltype = 'Gaming'
GROUP BY Country
HAVING 
SUM(RevenueLastMonth) > 30000;


Q6. For each Country, calculate the total number of influencers (COUNT(*)), total
revenue (SUM), and average revenue (AVG).

select Country,count(*) as total_number_of_influencers,sum(RevenueLastMonth) as total_revenue,avg(RevenueLastMonth) as avg_revenue
from youtube
group by Country;

• Q7.Find countries where the total revenue exceeds $150,000 and the average revenue
per influencer exceeds $20,000.

SELECT Country, 
SUM(RevenueLastMonth) AS TotalRevenue, 
AVG(RevenueLastMonth) AS AverageRevenuePerInfluencer
FROM youtube
GROUP BY Country
HAVING SUM(RevenueLastMonth) > 150000 AND 
AVG(RevenueLastMonth) > 20000;


• Q8. Find the ChannelType with the highest total revenue.
select channeltype,sum(RevenueLastMonth) as highest_total_revenue
from youtube 
group by channeltype
order by highest_total_revenue desc
limit 1;

• Q9. Identify ChannelType groups where the average revenue per influencer
(AVG(RevenueLastMonth)) is greater than 50% of the maximum revenue among all
influencers.

SELECT 
ChannelType, AVG(RevenueLastMonth) AS AverageRevenuePerInfluencer
FROM youtube
GROUP BY ChannelType
HAVING AVG(RevenueLastMonth)>
(0.5 * (SELECT MAX(RevenueLastMonth) FROM youtube)
);


• Q10. Identify ChannelType groups where the total views (SUM(AvgViewsPerVideo))
contribute more than 10% of the overall views across all influencers in the dataset.

SELECT 
ChannelType, sum(AvgViewsPerVideo) AS AvgViewsPerVideo
FROM youtube
GROUP BY ChannelType
HAVING sum(AvgViewsPerVideo)> (0.1 * (SELECT sum(AvgViewsPerVideo) FROM youtube ))