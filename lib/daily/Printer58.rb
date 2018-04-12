require 'escpos'

module Daily
class Printer58 < Escpos::Report
#     def horizontal_line
#         text "________________________________"
#     end
#     def horizontal_dash
#         text "--------------------------------"
#     end
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