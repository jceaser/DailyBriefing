#require 'escpos'
require "HTTParty"
require 'feedjira'
require_relative 'Segment'


# my_report.rb:
class News < Segment
    
    def titles()
        url = "http://rss.cnn.com/rss/cnn_topstories.rss"
        #xml = HTTParty.get(url).body
        #feed = Feedjira.parse(xml)
        feed = Feedjira::Feed.fetch_and_parse url
        total = ""
        feed.entries[0..4].each {|x| total += "* #{x.title}\n"}
        total
    end
    
    def segment_display
        [
            "# News #\n",
            titles()
        ].join
    end
end
