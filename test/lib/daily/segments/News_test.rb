require 'minitest/autorun'
require_relative '../../../../lib/daily/segments/News'

module Daily
module Segments

describe News do
    before do
        @news=News.new("daily_brefing.erb",{'url'=>"http://news.com/news.rss"})
        @news
    end

    describe 'must have a url' do
        it 'does url exist' do
            @news.url_rss.must_equal "http://news.com/news.rss"
        end
    end

end

end
end