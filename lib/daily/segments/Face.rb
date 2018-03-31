#require 'escpos'
require "HTTParty"
require 'feedjira'
require_relative 'Segment'
require_relative 'Rss'


# my_report.rb:
class Face < Segment
    :normal
    :sad
    
    def initialize(p, opt={})
        super p, opt
        @hair_length = rand(0..5)
        @style = :happy
    end
    
    def hair_length= (val)
        @hair_length = val
    end
    
    def  hair_top (row=0)
        [
            lt, "*/*/*/*", rt, "\n",
        ].join
    end
    
    def lt
        "/ "
    end
    
    def rt
        " \\"
    end

    def l (row=0)
        if row<@hair_length then "# " else "  " end
    end
    
    def r (row=0)
        if row<@hair_length then " #" else "  " end
    end
    
    def face_happy
        [
            hair_top,
            l(1) ,  "-     -" , r(1) , "\n",
            l(2) ,  "*     *" , r(2) , "\n",
            l(3) ,  "   U   " , r(3) , "\n",
            l(4) , "\\_____/" , r(4) , "\n"
        ]
    end

    def face_sad
        [
            hair_top,
            l(1) ,  "/     \\" , r(1) , "\n",
            l(2) ,  "*     *" , r(2) , "\n",
            l(3) ,  "   U   " , r(3) , "\n",
            l(4) , "/-----\\" , r(4) , "\n"
        ]
    end
    
    def segment_display
        case @style
            when :happy
                out = face_happy
            when :sad
                out = face_sad
        end
        out.join
    end
end
