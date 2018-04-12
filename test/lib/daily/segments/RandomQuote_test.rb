require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/RandomQuote'

module Daily
module Segments

describe RandomQuote do
    before do
        @q = RandomQuote.new("daily_brefing.erb", {})
        
        def @q.readFile
            ["Was it something I said?"]
        end
        
        @q
    end

    describe 'random quote test' do
        it 'not so random' do
            @q.randomFromFile.must_include "Was it something I said?"
        end
    end

end

end
end