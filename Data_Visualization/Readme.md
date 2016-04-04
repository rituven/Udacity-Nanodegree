

#Summary

I analyzed the efficiency of airlines over the years 2000 - 2008 using the number of hours each aircraft spends in the air as the metric for efficiency. What I found was that Southwest Airlines has been the most consistently efficient carrier over the years with the most number of flights per year. 

Although American Airlines has more aircrafts in their fleet, their number of flights per year and the average number of hours spent in air per day is much lower than Southwest Airlines  

I also found that although JetBlue has far fewer aircrafts and flights per year, the average hours spent in the air per day has been higher than Southwest over the years - perhaps indicating longer flight segments overall.

I changed my chart a few times based on feedback, changing the data I was plotting to better convey the results of my analysis.


#Design
I gathered the data for each day each aircraft (uniquely identified by the TailNum) by Carrier, Year, Month and DayofMonth. I calculated the total time in air as the sum of the AirTime plus the TaxiIn and TaxiOut time (in minutes). I then aggregated the data by carrier and day for my analysis. Please refer to the AircraftSummary.sql to see queries I used to aggregate my data and dump it into a csv file.

We could categorize the carriers as Low cost carriers, Regional carriers and Full service carriers. 
Among the carriers I focused, here are the categories:

* The Low Cost Carriers
	*	South West Airlines ("WN")
	*	JetBlue Airways ("B6")

* The Full Service Carriers
	* Alaska Airlines ("AS")
	* American Airlines ("AA")
	* Delta Airlines ("DL")

  I used the above airlines in my charts to compare performance.



#Feedback

#####Feedback1 from stefan_153703:
This looks very clean and polished already. The transition you chose between years looks like flipping to me. That confused me, because the data before and after is actually continuous and not opposed to each other.

######My Response:
@stefan_153703, Thanks for the feedback! I am not sure what you mean by "flipping" though. I have only tested on Chrome and Safari and I see the transition as the bubbles moving upwards to replace the old values which move down. This is the default transition chosen (set) by the Storyboard control and I am not sure how to change it. I did try setting the chart property "ease" to linear but saw no change in the transition (could you please verify?).

Any pointers on how I can change the transition to something that would be less confusing?

######Feedback 2 from Stefan_153703:
I saw the moving up and down as flipping at first, until I figured out that it is just the next year. For changes over time, http://www.gapminder.org/videos/200-years-that-changed-the-world-bbc/2 came to my mind.

######My Response to Feedback 2:
@stefan_153703, I see what you are saying. Keep in mind that the xaxis in the GapMinder chart is year so that each frame has data for a year and the animation moves the data to the respective year. My chart is by Month so each frame would have data by Month for that year but is displayed in the same location (month) as the previous year.

With that said, I have changed the duration of the transition to 0 so you don't see any animation between frames. It does go through very quickly now though. Do you like this better?

######Feedback 3 from Stefan_153703:
It's quite fast now. Is the change over the years important? Or how it changes over the seasons? Or is any airline improving especially strong? Why do you try to show the dynamic?

Wait I just saw that in your chart lower is better. That needs extra explanation. Could you show the "uptime" instead?

######My Response to Feedback 3:
Hi Stefan,

Thanks again for your input. I took you suggestion of making it like the GapMinder visualization and the point about the "uptime" instead of the time on ground as the metric for efficiency and created a new visualization. You can see it here:
http://bl.ocks.org/rituven/6d942eddb591cdaad42e3

I changed the bubble chart to map the Total Flights per carrier against Total Aircrafts for that carrier in any given year. I used the efficiency as the metric for the size of the bubbles. What I found was the SouthWest Airlines consistently has the most number of flights over the years even though other carriers like American airline had more aircrafts. This is reflected in the efficiency percentage for SouthWest Airlines as well.

You will notice that the animation runs through very quickly - this is because my data is much smaller now (aggregated over the years rather than months). The reason I have the years is because I wanted to show SouthWest Airlines' trend over the years in comparison to other carriers - they have always had more flights even when the number of aircrafts they owned was far less than say American Airlines.

I could not figure out a way to make the clickOn for the Years work without making the animation run through at least once. If there is a way to create that simply as a legend with only one year selected and displayed at one time I would very much like to do that. I don't really need to have animation in the visualization. Could one of the Forum Mentors please provide ideas on how to achieve that?

######Feedback 4 from a friend:
Instead of mapping the Total Aircrafts to the Total Flights, it would be better to map the time spent in the air against the total flights and use the number of owned by the carrier as the measure for size of the bubble. Also narrow down the carriers displayed so the viewer can compare performance more easily.

######Response to feedback4:
I changed my chart to plot the average time spent in air per day for each carrier against the total flights per year for that carrier. I changed the bubble to size based on the total aircrafts owned by the carrier that year. This chart clearly defines my central premise that Southwest airlines is more efficient because you can see that even though American Airlines has far more aircrafts, the number or hours spent in air (and number of flights) is lower than Southwest Airlines. It also shows that although JetBlue is has far smaller numbers, in terms of efficiency, they are still better than the larger airlines.

###### Feedback 5 from Carl Ward:
I think its pretty good. I really like the idea, the only other things I would suggest is to emphasize the important elements of the visualization. For instance maybe make the other airlines have more transparency than Southwest. 

######Response to feedback5:
I changed the opacity for Southwest Airlines to 1.0 and for the rest of the airlines to 0.6. This makes Southwest Airlines stand out.

#Resources
* [http://www.d3js.org/](http://www.d3js.org/)
* [http://www.dimplejs.org/ ](http://www.dimplejs.org/)
* [http://stat-computing.org/dataexpo/2009/the-data.html/](http://stat-computing.org/dataexpo/2009/the-data.html/)
* [http://www.stackoverflow.com/](http://www.stackoverflow.com/)
* [http://www.udacity.com/](http://www.udacity.com/)
