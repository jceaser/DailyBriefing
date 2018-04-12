#require 'escpos'
require_relative 'Segment'

module Daily
    module Segments
        class CountTo < Segment
            include Escpos::Helpers

            def initialize(p, opt={})
                super p, opt
                
                @days = 0
                @target_title = ""
                @target_date = Date.parse "2038-01-13"
                
                @data = @options['data']
            end
            
            def days
                (@target_date - DateTime.now + 1).to_i
            end

            def segment_display
                out = [title("## Count Down ##\n"), "In days\n"]
                @data.each { |value|
                    @target_date = Date.parse value['date']
                    if @target_date == DateTime.now
                        out << "* Today is #{value['title']}\n"
                    else
                        out << "* #{days} : #{value['title']}\n"
                    end
                }
                
                #[
                #    "#{days} days till #{@target_title}."
                #].join
                out
            end
        end
    end
end