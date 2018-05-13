class HomeController < ApplicationController
  def index
  	@articles = Article.order('created_at desc').paginate(:page => params[:page], :per_page => 18)
  	respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @articles }
		  format.json { render :json => @articles }
		end
  end

  def api_data
   
    @articles = Article.order('created_at desc').paginate(:page => params[:page], :per_page => 18)
    

  	respond_to do |format|
		  format.xml  { render :xml => @articles }
		  format.json { render :json => @articles }
		end
  end


end
