#!/usr/bin/env ruby

class Configuration
    def initialize()
    @configs =
    {
        :segments=>
        [
            {:name=>"Calendar"},
            {:name=>"Evil", :opt=>{subscription:100}},
            {:name=>"News"},
            {:name=>"RandomQuote"},
            {:name=>"Weather"}
        ]
    }
    end
    
    def get
        @configs
    end
end