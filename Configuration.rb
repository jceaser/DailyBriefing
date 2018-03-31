#!/usr/bin/env ruby

class Configuration
    def initialize()
        @configs = nil
        found = false
        ["~/.config/daily_brefing/config.json"].each { |path|
            if File.exists?(path)
                file = File.read(path)
                @configs = JSON.parse(file)
                found = true
            end
        }
        if @configs.nil?
            @configs =
            {
                :segments=>
                [
                    #{:name=>"Calendar"},
                    #{:name=>"Evil", :opt=>{subscription:100}},
                    #{:name=>"Rss", :opt=>{:url=>"http://rss.cnn.com/rss/cnn_topstories.rss"}},
                    #{:name=>"News"},
                    #{:name=>"RandomQuote"},
                    {:name=>"Traffic"},
                    #{:name=>"UList",:opt=>{:url => "http://thomascherry.name/wiki/UList_(Little_Printer)",:id => "example_list"}},
                    #{:name=>"Weather"}
                ]
            }
        end
    end
    
    def get
        @configs
    end
end