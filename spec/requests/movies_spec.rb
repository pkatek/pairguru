require "rails_helper"

describe "Movies requests", type: :request do
  let!(:comments) { FactoryBot.create_list(:comment, 10, movie: FactoryBot.create(:movie)) }
  let(:comment) { Comment.last }
  let(:user) { comment.user }

  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "comments list" do
    context "when not signed in" do
      it "do not displays right comment title without login" do
        visit "/movies/#{comment.movie.id}"
        expect(page).not_to have_selector("h3", text: "User Comments")
      end
    end
    context "when signed in" do
      before do
        sign_in user
      end
      it "displays right comment title without login" do
        visit "/movies/#{comment.movie.id}"
        expect(page).to have_selector("h3", text: "User Comments")
      end
    end
  end
end
