require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/Calendar'

module Daily
module Segments

describe Calendar do
    before do
        @cal = Calendar.new("daily_brefing.erb", {})
        
        def @cal.cal_content
            %q(
     March 2018
Su Mo Tu We Th Fr Sa
             1  2  3
 4  5  6  7  8  9 10
11 12 13 14 15 16 17
18 19 20 21 22 23 24
25 26 27 28 29 30 31)
        end
    end

    describe 'check calendar' do
        it 'right size, content' do
            segment = @cal.segment_display
            
            segment.must_include "     March 2018"
            segment.must_include "Su Mo Tu We Th Fr Sa"
            segment.must_include "             1  2  3"
            segment.must_include " 4  5  6  7  8  9 10"
            segment.must_include "11 12 13 14 15 16 17"
            segment.must_include "18 19 20 21 22 23 24"
            segment.must_include "25 26 27 28 29 30 31"
        end
    end

end

end
end