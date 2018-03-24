require 'escpos'
require_relative 'Segment'

# my_report.rb:
class RandomQuote < Segment

    def readFile
        line_num=0
        lines_of_interest = []
        File.open('segments/quotes.md').each do |raw_line|
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
            randomFromFile
        ].sample
    end
end

o = RandomQuoteSegment.new(nil)
puts o.segment_display
