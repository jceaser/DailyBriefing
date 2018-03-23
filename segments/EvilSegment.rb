require 'escpos'
require_relative 'Segment'

# my_report.rb:
class EvilSegment < Segment
    def segment_display
        edition = subscription_count
        [
            `curl -s "http://thomascherry.name/littleprinter/eviloverlord/edition/?delivery_count=#{edition}" | lynx --dump -stdin`,
            "What will you do today:\n"#,
            #"\n[ ] " + "-"*28 + "\n",
            #"\n[ ] " + "-"*28 + "\n",
            #"\n[ ] " + "-"*28 + "\n",
            #"\n[ ] " + "-"*28 + "\n"
        ].join
    end
end
