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
      flash[:message] = "Article '#{article.title} was created.'"
      redirect_to article_path(@article)
    else
      # Show them the form (from the new action) again with the data, so you're not a jerk.  But @article will contain values from this method instead of new method, just using the new template
      flash[:message] = "Sorry, article '#{article.title} was not saved due to errors.'"
      render :new
    end
  end
  
  def destroy
    #raise params.inspect
    article = Article.find(params[:id])
    article.destroy
    
    # article.destroy will delete the object from the database but the values still exist in memmory for the duration of this request
    flash[:message] = "Article '#{article.title} was deleted.'"
    redirect_to articles_path
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:message] = "Article '#{@article.title} was saved.'"
      redirect_to article_path(@article)
    else
      flash[:message] = "There were errors in the form below."
      render :edit
    end
  end
  
end
