#!/usr/bin/env ruby

module Daily
    class Configuration
        def initialize()
            @configs = nil
            found = false
            ["~/.config/daily_brefing/config.json"].each { |item|
                path = File.expand_path item
                if File.exist? path
                    file = File.read(path)
                    @configs = JSON.parse(file)
                    found = true
                    break
                end
            }
            if @configs.nil?
                @configs =
                {
                    'segments'=>
                    [
                        {'name'=>"Calendar"},
                        {'name'=>"CountTo", 'opt'=>{'data'=>[{'date'=>"2018-12-25", 'title'=>"Christmas"},]}},
                        {'name'=>"Evil", 'opt'=>{subscription:100}},
                        {'name'=>"Rss", 'opt'=>{'url'=>"http://rss.cnn.com/rss/cnn_topstories.rss"}},
                        {'name'=>"News"},
                        {'name'=>"RandomQuote"},
                        {'name'=>"Traffic"},
                        {'name'=>"UList",'opt'=>{'url' => "http://thomascherry.name/wiki/UList_(Little_Printer)",:id => "example_list"}},
                        {'name'=>"Weather"},
                        {'name'=>"WikiToday"}
                    ]
                }
            end
        end
    
        def get
            @configs
        end
    end
end