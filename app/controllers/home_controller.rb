class HomeController < ApplicationController
  def index
  	@articles = Article.order('created_at').paginate(:page => params[:page], :per_page => 18)
  	respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @articles }
		  format.json { render :json => @articles }
		end
  end

  def api_data
    category = params["category_id"]
    if category.present?
  	  @articles = Article.where(:category_id=>category).order('created_at').paginate(:page => params[:page], :per_page => 18)
    else
      @articles = Article.order('created_at').paginate(:page => params[:page], :per_page => 18)
    end

  	respond_to do |format|
		  format.xml  { render :xml => @articles }
		  format.json { render :json => @articles }
		end
  end


end
