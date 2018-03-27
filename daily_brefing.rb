#!/usr/bin/env ruby

require 'escpos'

require_relative 'Printer58'
require_relative 'Configuration'
require_relative 'segments/Weather'
require_relative 'segments/Calendar'
require_relative 'segments/Evil'
require_relative 'segments/RandomQuote'
require_relative 'segments/News'

@printer = Escpos::Printer.new
#@printer.write "Some text\n"

#@printer.to_escpos # returns ESC/POS data ready to be sent to printer
# on linux this can be piped directly to /dev/usb/lp0
# with network printer sent directly to printer socket
# with serial port printer it can be sent directly to the serial port

#@printer.to_base64 # returns base64 encoded ESC/POS data

# using report class

# my_report.rb:
class DailyBrefing < Printer58
    def configs
        @configs = Configuration.new
    end
    def head_section(msg)
        quad_text "#{msg}"
    end
    def item_large(text)
        @l_count ||= 0
        @l_count += 1
        quad_text "#{@l_count}. #{text}"
    end
    def item(text)
        @l_count ||= 0
        @l_count += 1
        text "#{@l_count}. #{text}"
    end
    def foot_section(msg)
        [
            "-"*32,
            msg,
            "\nEOL\n"
        ].join
    end
    
    def load_segments
        out = ""
        configs().get[:segments].each {|c| out+=load_segment c[:name], c[:opt]}
        out
    end
    
    def load_segment (name, opt={})
        obj = Object.const_get name
        seg = obj.new(self, opt)
        seg.display
    end
    
end

report = DailyBrefing.new 'daily_brefing.erb'
@printer.write report.render
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.cut!

puts @printer.to_escpos
