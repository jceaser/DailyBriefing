
module Kernel
    def silence_warnings
        with_warnings(nil) { yield }
    end

    def with_warnings(flag)
        old_verbose, $VERBOSE = $VERBOSE, flag
        yield
        ensure
        $VERBOSE = old_verbose
    end
end unless Kernel.respond_to? :silence_warnings

Kernel.silence_warnings do
    require 'feedjira'
end

require "HTTParty"
require "nokogiri"
require_relative 'Segment'
require_relative 'Rss'

module Daily
module Segments
class WikiToday < Rss

    def initialize(p, opt={})
        super p, opt
        
        @url_rss = @options['url']
        if @url_rss==nil or @url_rss.empty? then
            @url_rss = "https://en.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=rss"
        end
        
        #@title_count = @options[:title_count]
        #if @title_count == nil or @title_count.empty? then
        #    @title_count = 5
        #end
    end
    
    def title_from_html(raw_html)
        doc = Nokogiri::HTML(raw_html)
        text = "Title: "
        doc.css("div.mw-parser-output").each do |outer|
            outer.css("div.thumbinner").each do |e|
                e.css("p").each do |ep|
                    text << ep.content + "\n"
                end
            end
        end
        text
    end
    
    def html2text(raw_html)
        doc = Nokogiri::HTML(raw_html)
        
        text = ''
        doc.css('div.mw-parser-output').each do |e|
            e.css("p").each do |ep|
                text << ep.content + "\n"
            end
        end
        
        text
    end

    
    def titles()
        if @feed==nil then loadTitles end
        out = ""
        
        entry = @feed.entries[@feed.entries.length-1]
        
        title = "# #{entry.title} #"
        summary = html2text entry.summary
        
        out = "#{title}\n\n"
        
        i = 0
        if 563<summary.size then
            max = 512
        else
            max = summary.size
        end
        summary.each_char do |c|
            if max<i && c == ' '
                out += "..."
                break
            else
                out += c
            end
            i=i+1
        end
        
        out
    end

    def segment_display
        [
            titles()
        ].join
    end
end

end
end