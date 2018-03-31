#require 'escpos'
require "HTTParty"
require 'feedjira'
require_relative 'Rss'
require 'escpos/Helpers'

require 'nokogiri'

# my_report.rb:
class Traffic < Rss
    
    include Escpos::Helpers
    
    def initialize(p, opt={})
        super p, opt
        #@url = "http://chart.maryland.gov/rss/ProduceRSS.aspx?Type=TIandRC&filter=TI"
        @url1 = "http://chart.maryland.gov/rss/ProduceRSS.aspx?Type=TravelSpeedsWLoc&filter=I-95"
        @url2 = "http://chart.maryland.gov/rss/ProduceRSS.aspx?Type=TravelSpeedsWLoc&filter=I-70"
        
        today = Date.today.wday
        
        @url = if (0<today and today<6) then @url1 else @url2 end
        
        @title_count = 10
    end

    def html2text(raw_html)
        doc = Nokogiri::HTML(raw_html)
        
        text = ''
        doc.css('td').each do |e|
            text << e.content + "\n"
        end
        text
    end
    
    def titles_all()
        #@url = @url1
        out = titles()
        #@url = @url2
        #loadTitles()
        #out += titles()
        out
    end
    
    def titles()
        if @feed==nil then loadTitles end
        
        total = ""
        @feed.entries[1..@title_count].each {
            |x|
            
            title = x.title.capitalize
            
            sum = html2text (x.summary)
            sum = sum.gsub(/Location: .*$/, "")
            sum = sum.gsub(/Last .*$/, "")
            sum = sum.gsub(/L.*itude: .*$/, "")
            sum = sum.gsub(/Average Speed: /, "")
            sum = sum.strip() + "\n"
            
            total += "* #{title}\n"
            total += "\t* #{sum}"
        }
        
        total
    end

    def segment_display
        [
            title("# Traffic #"),
            "\n",
            "\n",
            titles_all(),
        ].join
    end
end

