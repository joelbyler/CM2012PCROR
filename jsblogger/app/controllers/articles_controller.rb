class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end
  def show
    #raise params.inspect
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def create
    #raise params.inspect
    
    #@article = Article.new
    #@article.title = params[:article][:title]
    #@article.body = params[:article][:body]
    #@article.save
    
    #@article = Article.new(
	# 	:title => params[:article][:title],
    #	:body  => params[:article][:body]
	#)
    #@article.save
    	
    @article = Article.new(params[:article])
    if @article.save    
      #send user to show action  (we could either render or redirect_to, in this case redirect because render could cause duplicate record if they refresh)
      redirect_to article_path(@article)
    else
      # Show them the form (from the new action) again with the data, so you're not a jerk.  But @article will contain values from this method instead of new method, just using the new template
      render :new
    end
  end
  
end
