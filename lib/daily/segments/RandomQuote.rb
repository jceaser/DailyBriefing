require 'escpos'
require_relative 'Segment'

module Daily
module Segments
class RandomQuote < Segment
    include Escpos::Helpers
    def readFile
        lines_of_interest = []
        File.open('lib/daily/segments/quotes.md').each do |raw_line|
            line = raw_line.strip
            if line.start_with? "*"
                lines_of_interest += [line.replace(line[2..-1])]
            end
        end

        lines_of_interest
    end
    
    def randomFromFile()
        list = readFile()
        list[rand(0..(list.count-1))]
    end
    
    def segment_display
        [
            title("## Quotes ##\n"),
            randomFromFile
        ]
    end
end

end
end

#o = RandomQuote.new(nil)
#puts o.segment_display
