require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/UList'

module Daily
module Segments

describe UList do
    before do
        @ul = UList.new("daily_brefing.erb", {'url' => "http://thomascherry.name/wiki/UList_(Little_Printer)",:id => "example_list"})
        
        def @ul.readFile
            %q(
    <body>
        <div id="content">
            <header>
                <img height="55" src="http://thomascherry.name/littleprinter/ulist/logo.png">
                U-List: Sample List
            </header>
            <section>
                <div id="list">
<ol><li>Major Item</li><li>Scheduled item <span class="date">1521 days ago</span></li><li>
                            With sub items
                            <ul><li>item 1</li><li>item 2</li></ul>
                        </li><li>
                            With another set of sub items
                            <ul><li>item 1
                                    <ul><li>first item</li><li>second item</li><li>third item</li></ul>
                                </li><li>item 2</li></ul>
                        </li></ol>
                </div>
                <div style="font-size:12pt">Last updated: Tue, 28 Jan 2014 04:40:02 GMT</div>
            </section>
            <footer>
                Provided by me@thomascherry.name.<br>
                http://thomascherry.name/wiki/UList_(Little_Printer)
            </footer>
        </div>
    </body>
)
        end
        
        @ul
    end

    describe 'UList tests' do
        it 'title clean up' do
            @ul.segment_display.must_include " U-List: UList (Little Printer) - The Wiki of Thomas Cherry"
        end
        it 'list check' do
            @ul.segment_display.must_include " 1. one\n 2. Two\n"
        end
    end

end

end
end