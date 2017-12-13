require 'json'
require 'httparty'

task :potdrive_scraper => :environment do

    categories = Hash.new 
    categories["234"] = "Industry Top Stories"
    categories["233"] = "Health"
    categories["232"] = "Business"
    categories["231"] = "Politics"
    categories["230"] = "Culture"

    (230..234).each do |category|
      @url = "http://news.potdrive.com/concepts/channel/documents?uri=http%3A%2F%2Fwww.ontotext.com%2Fpublishing%#{category}&limit=10000&offset=0"
      response = HTTParty.get(@url)

      auth = { cloud_name: "ticketsage",api_key: "644664617676729",api_secret: "62Vk66zNM1UouZVEzUfZZmsrcMc",:folder => "potdrive"}
      
      data = JSON.parse response.body
      data["values"].each do |item|
        category_name = categories["#{category}"]
        uri = item["uri"]
        title = item["title"]
        description = item["summary"]
        
        date = item["dateTime"]

        Article.find_or_create_by(:title=>title,:summary=>description,:category=>category_name,:link=>uri,:creation_time=>date,:category_id=>category) do |article|
          
          begin
            image = Cloudinary::Uploader.upload(item["imageUri"],auth)
          rescue Exception => e
            image = item["imageUri"]
          end
        
          image_url = image["url"]
          article.image_url = image_url
        end

      end
    end
    
  
end
  
