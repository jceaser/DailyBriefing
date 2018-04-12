require 'escpos'
require_relative 'Segment'

module Daily
module Segments
class UnixTips < RandomQuote
    include Escpos::Helpers
    
    def initialize(p, opt={})
        super p, opt
        
        raw_level = @options['level']
        raw_level = raw_level.downcase if raw_level!=nil
        if ["entry", "moderate", "advance"].include? raw_level then
            @level = raw_level
        else
            @level = nil
        end
        if @level==nil then
            raise ArgumentError.new(
                "must pick a valid level (#{raw_level} is #{@level})")
        end
    end
    
    def readFile
        lines_of_interest = []
        
        File.open("lib/daily/segments/unix_#{@level}.md").each do |raw_line|
            line = raw_line.strip
            if line.start_with? "*"
                line_text = [line.replace(line[2..-1])]
                lines_of_interest += line_text
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
            title("## Unix Tip ##\n"),
            randomFromFile
        ]
    end
end

end
end

#o = RandomQuote.new(nil)
#puts o.segment_display
