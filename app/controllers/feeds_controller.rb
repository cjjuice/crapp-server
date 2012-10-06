class FeedsController < ApplicationController
  
  def index
    render :json => { 'feeds' => ['cnn','espn'] }
  end
    
  def fetch
    feedHash = {'cnn' => "http://rss.cnn.com/rss/cnn_mostpopular.rss",
      'espn' => "http://sports.espn.go.com/espn/rss/news"}
    feed = Feedzirra::Feed.fetch_and_parse(feedHash[params[:feed]])
    items = []
    
    feed.entries.each do |entry|
      items.push({"title" => entry.title,
                  "summary" => entry.summary,
                  "content" => entry.content,
                  "url" => entry.url,
                  "published" => entry.published
                   })
    end  
    
      begin
        render :json => { 'title' => feed.title, 'items' => items }
      rescue
        render :json => { 'title' => "krapp!!", 'items' => [] }
      end    
         
  end  
end
