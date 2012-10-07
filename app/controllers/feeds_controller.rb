class FeedsController < ApplicationController
  
  def index
    render :json => { 'feeds' => ['cnn','espn'] }
  end
    
  def fetch
    feedHash = {'cnn' => "http://rss.cnn.com/rss/cnn_mostpopular.rss",
                'espn' => "http://sports.espn.go.com/espn/rss/news"}
    
    feeds = []
     
    params[:feed].split(",").each  do |f|
      feeds.push(Feedzirra::Feed.fetch_and_parse(feedHash[f]))
    end  
      
    items = []
    
    
    
    feeds.each do |feed|
      feed.entries.each do |entry|
        items.push({"title" => entry.title,
                    "summary" => entry.summary,
                    "content" => entry.content,
                    "url" => entry.url,
                    "published" => entry.published,
                    "feed_title" => feed.title
                    })
      end  
    end  
    
      begin
        render :json => { 'items' => items }, :callback => params[:callback] 
      rescue
        render :json => { 'title' => "krapp!!", 'items' => [] }, :callback => params[:callback] 
      end    
         
  end  
end
