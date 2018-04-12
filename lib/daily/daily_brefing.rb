#!/usr/bin/env ruby

require 'escpos'

require_relative 'Configuration'
require_relative 'Printer58'
require_relative 'segments/Calendar'
require_relative 'segments/CountTo'
require_relative 'segments/Evil'
require_relative 'segments/Face'
require_relative 'segments/News'
require_relative 'segments/RandomQuote'
require_relative 'segments/Traffic'
require_relative 'segments/UList'
require_relative 'segments/UnixTips'
require_relative 'segments/Weather'
require_relative 'segments/WikiToday'

@printer = Escpos::Printer.new

module Daily
class DailyBrefing < Printer58
    def configs
        @configs = Configuration.new
    end
    def head_section(msg)
        quad_text "#{msg}"
    end
#     def item_large(text)
#         @l_count ||= 0
#         @l_count += 1
#         quad_text "#{@l_count}. #{text}"
#     end
#     def item(text)
#         @l_count ||= 0
#         @l_count += 1
#         text "#{@l_count}. #{text}"
#     end
    def foot_section(msg="")
        face = Daily::Segments::Face.new(self, {})
        
        [
            "-"*32, "\n", 
            msg,
            face.display,
            "\nEOL\n"
        ].join
    end
    
    def load_segments
        out = ""
        
        configs().get["segments"].each { |c|
            obj_name = "Daily::Segments::#{c['name']}"
            opt = c['opt']
            out += load_segment obj_name, opt
        }
        out
    end
    
    def load_segment (name, opt={})
        if opt==nil then opt = {} end
        obj = Object.const_get name
        seg = obj.new(self, opt)
        seg.display
    end
    
end
end
report = Daily::DailyBrefing.new 'daily_brefing.erb'
@printer.write report.render
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.cut!

puts @printer.to_escpos
