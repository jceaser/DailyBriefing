#require 'escpos'
require "HTTParty"
require 'feedjira'
require_relative 'Segment'


# my_report.rb:
class Rss < Segment
    attr_accessor :url
    attr_accessor :title_count

    def initialize(p, opt={})
        super p, opt
        
        @url = @options[:url]
        #raise ArgumentError.new("must supply a URL") if @url==nil
        
        @title_count = 5
        
        Feedjira.logger.level = Logger::FATAL
    end
    
    def loadTitles()
        @feed = Feedjira::Feed.fetch_and_parse @url
        @title = @feed.title
    end
    
    def titles()
        if @feed==nil then loadTitles end
        
        total = ""
        @feed.entries[0..@title_count-1].each {|x| total += "* #{x.title}\n"}
        
        total
    end
    
    def segment_display
        if @feed==nil then loadTitles end
        
        [
            "# #{@title} #\n",
            titles()
        ].join
    end
end

if __FILE__ == $0
    require_relative '../Printer58'
    printer = Printer58.new 'daily_brefing.erb'
    rss = Rss.new(printer, {:url=>ARGV[0]})
    puts rss.display
end
