class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_movie!, only: [:create, :destroy]

  def index
    @comments = Comment.where("created_at >= ?", 1.week.ago.utc).group(:user).order("count_id desc").count("id").first(10)
  end

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
