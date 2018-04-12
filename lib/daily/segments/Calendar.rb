#require 'escpos'
require_relative 'Segment'

module Daily
module Segments
class Calendar < Segment

    def cal_content
        `cal`
    end

    def segment_display
        out = [
            cal_content,
            [
                "Top six tasks of the day:\n",
                "What will you do today:\n",
                "Todays tasks:\n",
                "Todo:\n",
            ].sample,
        ]
        (0..5).each do |i| out << "\n[ ] " + "-"*28 + "\n" end
        out.join
    end
end

end
end