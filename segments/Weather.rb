require 'escpos'
require_relative 'Segment'

# my_report.rb:
class Weather < Segment
    def segment_display
        [
            `curl -s 'wttr.in/21228?0&T' | sed 's/\xc2\xb0//'`,
            "curl -s 'wttr.in/21228?0&T'"
        ].join
    end
end
