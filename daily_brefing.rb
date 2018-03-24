#!/usr/bin/env ruby

require 'escpos'
require_relative 'Printer58'
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
            "\r\n",
            msg,
            "\r\neol\r\n"
        ].join
    end
    def calendar_segment
        cs = Calendar.new self
        cs.display
    end
    def weather_segment
        ws = Weather.new self
        ws.display
    end
    def evil_segment
        es = Evil.new self, {subscription:100}
        es.display
    end
    def random_quote_segment
        es = RandomQuote.new self
        es.display
    end
    def news_segment
        ns = News.new self
        ns.display
    end
end

report = MyReport.new 'report2.erb'
@printer.write report.render
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.cut!

puts @printer.to_escpos
