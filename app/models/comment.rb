class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { scope: :movie_id, message: "You've already made a comment!" }
  validates :body, presence: true, allow_blank: false
end
