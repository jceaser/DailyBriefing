require 'escpos'
require_relative 'Segment'

# my_report.rb:
class UList < Segment
    def initialize(p, opt={})
        super p, opt
        
        @url = @options[:url]
        raise ArgumentError.new("must supply a URL") if @url==nil
        
        @id = @options[:id]
        #raise ArgumentError.new("must supply a URL") if @url==nil
        
        @title_count = 5
    end
    def segment_display
        edition = subscription_count
        host = "http://thomascherry.name/littleprinter/ulist/edition/"
        list_text = `curl -s "#{host}?url_option=#{@url}&tag_id=#{@id}" | lynx --dump -stdin`
        list_text = list_text.sub("[logo.png]", "")
        list_text = list_text.gsub(/^   /, "")  #page comes with to much space
        list_text = list_text.gsub(/^    /, "")  #page comes with to much space
        #list_text = list_text.gsub(/^    /, "")    #page comes with to much space
        #list_text = list_text.gsub(/^    /, "")  #page comes with to much space
        
        [
            list_text,
            "What else will you do today:\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n",
            "\n[ ] " + "-"*28 + "\n"
        ].join
    end
end
