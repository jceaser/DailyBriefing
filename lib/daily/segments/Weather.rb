require 'escpos'
require_relative 'Segment'

module Daily
module Segments

class Weather < Segment
    include Escpos::Helpers
    def segment_display
        [
            title("## Weather ##\n"),
            `curl -s 'wttr.in/21228?0&T' | sed 's/\xc2\xb0//'`,
            "curl -s 'wttr.in/21228?0&T'"
        ].join
    end
end

end
end