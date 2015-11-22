Data Science Capstone Project
========================================================
## Yelp Dataset Challenge
author: Kenneth Lim  
date: 22 Nov 2015



Introduction
========================================================
- Course participants are to use [Yelp Dataset Challenge](http://www.yelp.com/dataset_challenge) dataset to come up with their own data science ideas and implement them.
- Yelp is a business review online platform where users share reviews with other users or businesses.
- Target question is -- **If a specific business is looking to expand i.e. setting up a new outlet, which location/neighbourhood/city would likely be most favourable?**



Method
========================================================
1. For a specific business category, we look for cities where there are high ratio of open businesses to closed ones as well as high volume of transactions proxied by no. of check-ins provided by the check-in dataset.  This reflects that market demand there are able to support the specific business and market supply have not gone past market saturation point.
2. Once we have selected the city, we shall make a preliminary plot of the restaurants' locations for any obvious pattern or clusters.
3. Using data clustering algorithms (e.g. K-means), we attempt to identify locations of high market demands (proxied by check-ins volume) and conducive consumer market (proxied by high review ratings and high volume of reviews).



Preliminary Plot
========================================================
- Initial data exploration reveals most businesses in dataset to reside in US.  Also restaurant business is the dominant business category.  Thus both are selected to the focus.
- Plotting a bubble chart using volume of open restaurants, closed restaurants and their check-in data reveals Las Vegas to have the bulk of restaurant business.
![Candidate Cities](candidate_cities.png)



K-Means Clustering
========================================================
- Plotting on map reveals restaurants always line-up against major roads, concentrate around renowned Las Vegas Strip and city center while avoiding north cone-shape area (airport and likely low-income residentials).
- Using K-means clustering based on check-ins volume, star ratings, volume of reviews as well as latitude/longitude reveals (unsurprisingly) locations along renowned Las Vegas Strip to have highest potential.
***
![K-means Clustering](k_clusters.png)
