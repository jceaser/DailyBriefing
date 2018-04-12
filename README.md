# Daily Briefing #

![Your Daily Briefing in thermal color][logo]

## Design ##

* Escpos::Report
    * Printer58 - functions that work on a 58 Thermal Printer (BP-5890S-USB)
        * MyReport (report2.rb)
* Segment
    * CalendarSegment - prints out the current month
    * EvilSegment - random rule from the [Evil Overlord List](https://google.com?q=evil%20overload%20list)
    * News - Top 5 stories on [CNN](http://rss.cnn.com/rss/cnn_topstories.rss)
    * RandomQuoteSegment - A random quote from notable people
    * WeatherSegment - Current weather for 21228

## Running ##

execute the report2.rb file and pipe it to your printer as so:

`ruby report2.rb | lp -d CATEX_TECH__POS5890U -`

[logo]: ./docs/daily_briefing.jpg "Your Daily Briefing in thermal color"

## Code ##

* [MiniTest](http://ruby-doc.org/stdlib-2.0.0/libdoc/minitest/rdoc/MiniTest.html)