require 'escpos'
require_relative 'Segment'

# my_report.rb:
class Calendar < Segment
    def segment_display
        [
            `cal`,
            "What will you do today:\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n"
        ].join
    end
end
