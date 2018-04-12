#!/usr/bin/env ruby

require 'escpos'

@printer = Escpos::Printer.new
#@printer.write "Some text\n"

#@printer.to_escpos # returns ESC/POS data ready to be sent to printer
# on linux this can be piped directly to /dev/usb/lp0
# with network printer sent directly to printer socket
# with serial port printer it can be sent directly to the serial port

#@printer.to_base64 # returns base64 encoded ESC/POS data

# using report class

module Daily
class MyReport < Escpos::Report
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
    def horizontal data
        text data*32
    end
    def horizontal_line
        text "_"*32 
    end
    def horizontal_dash
        text "-"*32
    end
    def horizontal_star
        horizontal "*"
    end
    
    def foot_section(msg)
        [
            "________________________________\r\n",
            msg,
            "\r\neol\r\n"
        ].join
    end
    
    ######################
    # Supported actions in 58 Thermal Printer
    
    def double_width data
        [
            Escpos.sequence(Escpos::TXT_2WIDTH),
            data,
            Escpos.sequence(Escpos::TXT_NORMAL),
        ].join
    end
    # double_height supported
    def barcode8(data, opts = {})
        text_position = opts.fetch(:text_position, Escpos::BARCODE_TXT_OFF)
        unless [Escpos::BARCODE_TXT_OFF, Escpos::BARCODE_TXT_ABV, Escpos::BARCODE_TXT_BLW, Escpos::BARCODE_TXT_BTH].include?(text_position)
            raise ArgumentError("Text position must be one of the following: Escpos::BARCODE_TXT_OFF, Escpos::BARCODE_TXT_ABV, Escpos::BARCODE_TXT_BLW, Escpos::BARCODE_TXT_BTH.")
        end
        height = opts.fetch(:height, 50)
        raise ArgumentError("Height must be in range from 1 to 255.") if height && (height < 1 || height > 255)
        width = opts.fetch(:width, 3)
        raise ArgumentError("Width must be in range from 2 to 6.") if width && (width < 2 || width > 6)
        [
            Escpos.sequence(text_position),
            Escpos.sequence(Escpos::BARCODE_WIDTH),
            Escpos.sequence([width]),
            Escpos.sequence(Escpos::BARCODE_HEIGHT),
            Escpos.sequence([height]),
            Escpos.sequence(opts.fetch(:format, Escpos::BARCODE_EAN8)),
            data,
            "\r\n"
        ].join
    end
    def barcode13 data
        code = barcode data
        [code,"\r\n"].join
   end
end
end
report = Daily::MyReport.new 'report.erb'
@printer.write report.render
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.write Escpos.sequence(Escpos::CTL_FF)
@printer.cut!

puts @printer.to_escpos
