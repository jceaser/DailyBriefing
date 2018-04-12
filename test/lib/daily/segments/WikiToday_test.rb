require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/WikiToday'

module Daily
    module Segments
        describe WikiToday do
            before do
                @wtoday = WikiToday.new("daily_brefing.erb",{})
                @wtoday
            end

            describe 'check content' do
                it 'must equal' do
                    converted = @wtoday.html2text %q(
<div class="mw-parser-output"><p>content</p></div>
)
                    puts "converted is #{converted}."
                    converted.must_equal "content\n"
                end
            end
        end
    end
end