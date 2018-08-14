class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_movie!

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back(fallback_location: movie_path(@movie),
                    notice: "Comment was successfully created.")
    else
      redirect_back(fallback_location: movie_path(@movie),
                    notice: "Comment has not been created.")
    end
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    if @comment.destroy
      redirect_back(fallback_location: movie_path(@movie),
                    notice: "Comment was successfully deleted.")
    else
      redirect_back(fallback_location: movie_path(@movie),
                    notice: "Comment has not been removed.")
    end
  end

  private

  def find_movie!
    @movie = Movie.find(params[:movie_id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
