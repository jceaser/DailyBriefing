require 'escpos'
require_relative 'Segment'

# my_report.rb:
class Evil < Segment

    def segment_display
        host = "http://thomascherry.name/littleprinter/eviloverlord/edition"
        edition = subscription_count
        
        text = `curl -s "#{host}/?delivery_count=#{edition}" | lynx --dump -stdin`
        text = text.gsub(/\[logo\.png\] /, "")
        text = text.gsub(/^     /, "")  #page comes with to much space
        text = text.gsub(/^   /, "")    #page comes with to much space
        text = text.gsub(/(\* _{5,})/, "\\1\n")
        
        [
            text,
        ].join
    end
end
