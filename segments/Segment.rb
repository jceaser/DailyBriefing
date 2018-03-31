#require 'escpos'

# my_report.rb:
class Segment
    def initialize(p, opt={})
        @printer = p
        @options = if opt != nil then opt else {} end
    end
    def display
        [
            #@printer.horizontal_dash,
            "\n",
            segment_display,
            "\n",
            @printer.horizontal_line
        ].join
    end
    def segment_display
        ""
    end
    def subscription_count
        rand(1..100)
    end

end
