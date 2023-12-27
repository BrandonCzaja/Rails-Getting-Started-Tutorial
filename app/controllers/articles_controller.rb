class ArticlesController < ApplicationController
  # Remember that @instance_variables are accessible by the views, hence why we are using an instance variable here
  # The name of the @instance_variable must match the name of the view file variable
  def index
    @articles = Article.all
  end

  # params Hash has a key :id that will find the article based on the id provided in the route parameters
  # By default, the show action will render app/views/articles/show.html.erb
  def show
    @article = Article.find(params[:id])
  end

  # Instantiates a new article, but doesn't save it - it won't be a database entry at this time
  # The article will be used when building the form for the user
  # By default, will render: app/views/articles/new.html.erb
  def new
    @article = Article.new
  end

  # If successfully saved to the database, instantiates a new article with the values from the #new form and redirects to "/articles/:id"
  # Otherwise redirects back to the form with an error message
  def create
    # Using #article_params so I don't have to write out each parameter value, while also securing what data is allowed
    @article = Article.new(article_params)

    if @article.save
      # MUST use redirect_to here otherwise the process will start all over again and the data will be mutated again
      redirect_to @article
    else
      # renders the `new` form with the error code
      render :new, status: :unprocessable_entity
    end
  end

  # Used fetch the article from the database to use when building the form
  # Similar to #new
  # Default renders app/views/articles/edit.html.erb
  def edit
    @article = Article.find(params[:id])
  end

  # Re-fetches the article from the database, attempts to update it with the submitted form data
  # If successful, redirects to the article's show page, else redirects to the form with error message
    # Will render edit.html.erb IF FAILED 
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes the article then redirects to the root path
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # Status see_other is a 303 status
    # Can redirect to any path EXCEPT FOR THE DELETED ARTICLE'S PATH
    redirect_to root_path, status: :see_other
  end

  private
    # This method requires the article model and restricts what values can be passed into it - security measure
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
