require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/Face.rb'
 
describe Face do
    before do
        @face = Face.new("daily_brefing.erb", {})
        @face.hair_length = 3
    end

    describe 'is there long hair' do
        it 'it must be long' do
            @face.l(0).must_equal "# "
            @face.l(1).must_equal "# "
            @face.l(2).must_equal "# "
            @face.l(3).must_equal "  "
            @face.l(4).must_equal "  "
            @face.l(5).must_equal "  "
        end
    end

end