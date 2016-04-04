from pandas import *
from ggplot import *

def plot_weather_data(turnstile_weather):
    ''' 
    plot_weather_data is passed a dataframe called turnstile_weather. 
    Use turnstile_weather along with ggplot to make another data visualization
    focused on the MTA and weather data we used in Project 3.
    https://www.udacity.com/course/viewer
    Make a type of visualization different than what you did in the previous exercise.
    Try to use the data in a different way (e.g., if you made a lineplot concerning 
    ridership and time of day in exercise #1, maybe look at weather and try to make a 
    histogram in this exercise). Or try to use multiple encodings in your graph if 
    you didn't in the previous exercise.
    
    You should feel free to implement something that we discussed in class 
    (e.g., scatterplots, line plots, or histograms) or attempt to implement
    something more advanced if you'd like.

    Here are some suggestions for things to investigate and illustrate:
     * Ridership by time-of-day or day-of-week
     * How ridership varies by subway station (UNIT)
     * Which stations have more exits or entries at different times of day
       (You can use UNIT as a proxy for subway station.)

    If you'd like to learn more about ggplot and its capabilities, take
    a look at the documentation at:
    https://pypi.python.org/pypi/ggplot/
     
    You can check out the link 
    https://www.dropbox.com/s/meyki2wl9xfa7yk/turnstile_data_master_with_weather.csv
    to see all the columns and data points included in the turnstile_weather 
    dataframe.
     
   However, due to the limitation of our Amazon EC2 server, we are giving you a random
    subset, about 1/3 of the actual data in the turnstile_weather dataframe.
    '''
    entries_df = turnstile_weather[['UNIT','ENTRIESn_hourly', 'rain']]
#    entries_df_summed = entries_df.groupby(['UNIT', 'rain']).sum()

#    entries_with_rain = turnstile_weather[['UNIT', 'ENTRIESn_hourly']][turnstile_weather['rain'] == 1]
#    entries_without_rain = turnstile_weather[['UNIT','ENTRIESn_hourly']][turnstile_weather['rain'] == 0]
#    entries_with_rain_summed = entries_with_rain.groupby(['UNIT']).sum()
#    entries_without_rain_summed = entries_without_rain.groupby(['UNIT']).sum()
    
#    entries_df_summed.reset_index(inplace=True)
#    entries_with_rain_summed.reset_index(inplace=True)
#    entries_without_rain_summed.reset_index(inplace=True)
    #print entries_without_rain
    '''
    plot = ggplot(entries_df_summed, aes(x='ENTRIESn_hourly', fill='rain', color='rain') ) +\
                 geom_histogram(binwidth=10000, position='identity' ) +\
                 xlab('Num of Entries') + ylab('Count')

    plot = ggplot(entries_with_rain_summed, aes(entries_with_rain_summed['ENTRIESn_hourly']) ) +\
                geom_histogram(binwidth=10000) +\
                xlab('Num of Entries') + ylab('Count')

    plot = ggplot(entries_without_rain_summed, aes(entries_without_rain_summed['ENTRIESn_hourly']) ) +\
                geom_histogram(binwidth=10000) +\
                xlab('Num of Entries') + ylab('Count')

    '''
    #print entries_df_summed.max()
    plot = ggplot(entries_df, aes(x='ENTRIESn_hourly', fill='rain', color='rain') ) +\
                 geom_histogram(binwidth=10000, position='identity' ) +\
                 xlab('Num of Entries') + ylab('Count') + ggtitle('Ridership With Rain Vs. Without Rain')
           
    print (plot)


turnstile_weather = pandas.read_csv('.\\Intro to Data Science\\improved-dataset\\turnstile_weather_v2.csv')
plot_weather_data(turnstile_weather)
