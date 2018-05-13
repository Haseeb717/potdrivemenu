require 'json'
require 'httparty'

task :potdrive_scraper => :environment do

      @url = "https://www.themaven.net/api/stream/theweedblog?from=0&size=100&sort=RecentConversation&stories=true&excludeRecentlyViewed=false&viewAnonymous=null"
      response = HTTParty.get(@url)

      auth = { cloud_name: "ticketsage",api_key: "644664617676729",api_secret: "62Vk66zNM1UouZVEzUfZZmsrcMc",:folder => "potdrive"}
      
      data = JSON.parse response.body
      data["documents"].each do |item|
        #category_name = categories["#{category}"]
        uri = item["url"]
        title = item["title"]
        description = item["description"]
        extensions = item["extensions"][0] if item["extensions"].present?
        image_uri = extensions["story"]["photo"] if extensions.present?
        date = item["firstMessage"]["dateTime"]

        Article.find_or_create_by(:title=>title,:summary=>description,:link=>uri,:creation_time=>date) do |article|
          
          begin
            image = Cloudinary::Uploader.upload(image_uri,auth)
          rescue Exception => e
            image = image_uri
          end
        
          image_url = image["url"]
          article.image_url = image_url
        end

      end
    
  
end
  
