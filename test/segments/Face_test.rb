require 'minitest/autorun'
require_relative '../lib/daily/segments/Face.rb'
 
describe Face do
    before do
        @face = Face.new
    end

    describe 'is there long hair' do
        it 'it must be long' do
            @face.l?.must_equal "# "
        end
    end

end