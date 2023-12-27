class CommentsController < ApplicationController
  def create
    # Each comment request has to keep track of the associated article, hence the find request
    @article = Article.find(params[:article_id])
    # Able to chain this because of the association
    # By chaining #create to the @article we've associated that comment to that @article
    @comment = @article.comments.create(comment_params)
    # Redirect to the article's show page so users can see their comment
    redirect_to article_path(@article)
  end

  def destroy
    # Find the associated article
    @article = Article.find(params[:article_id])
    # Find the comment based on the id through the article comments collection
    @comment = @article.comments.find(params[:id])
    # Destroy
    @comment.destroy

    # Redirect back to article show page
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

end
