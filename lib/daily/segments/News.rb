#require 'escpos'
require "HTTParty"
require 'feedjira'
require_relative 'Segment'
require_relative 'Rss'

# my_report.rb:
class News < Rss

    def initialize(p, opt={})
        super p, opt
        @url = "http://rss.cnn.com/rss/cnn_topstories.rss"
        @title_count = 5
    end

    def segment_display
        [
            "# News #\n",
            titles()
        ].join
    end
end
