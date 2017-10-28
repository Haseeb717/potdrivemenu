require 'json'
require 'httparty'

task :potdrive_scraper => :environment do

    
    (230..234).each do |category|
      @url = "http://news.potdrive.com/concepts/channel/documents?uri=http%3A%2F%2Fwww.ontotext.com%2Fpublishing%#{category}&limit=10000&offset=0"
      response = HTTParty.get(@url)
    
      data = JSON.parse response.body
      data["values"].each do |item|
        byebug
        uri = item["uri"]
        title = item["title"]
        description = item["summary"]
        image_url = item["imageUri"]
        date = item["dateTime"]
        
        article = Article.find_or_create_by(:title=>title,:summary=>description,:image_url=>image_url,:link=>uri,:creation_time=>date,:category_id=>category)
      end
    end
    
  
end
  
