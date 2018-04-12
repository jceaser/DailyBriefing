
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
require_relative 'Segment'
require_relative 'Rss'

module Daily
module Segments
class News < Rss
    def initialize(p, opt={})
        super p, opt
        
        @url_rss = @options['url']
        if @url_rss==nil or @url_rss.empty? then
            @url_rss = "http://rss.cnn.com/rss/cnn_topstories.rss"
        end
        
        @title_count = @options['title_count']
        if @title_count == nil or @title_count.empty? then
            @title_count = 5
        end
    end

    def segment_display
        include Escpos::Helpers
        [
            title("## News ##\n"),
            titles()
        ].join
    end
end

end
end