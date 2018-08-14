require "rails_helper"

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(create(:comment)).to be_valid
  end

  it "is invalid without an user" do
    expect(build(:comment, user: nil)).not_to be_valid
  end

  it "is invalid without a movie" do
    expect(build(:comment, movie: nil)).not_to be_valid
  end
end
