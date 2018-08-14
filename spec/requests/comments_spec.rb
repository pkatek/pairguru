require "rails_helper"

describe "Comments requests", type: :request do
  let!(:comments) { FactoryBot.create_list(:comment, 10, movie: FactoryBot.create(:movie)) }
  let(:comment) { Comment.last }
  let(:user) { comment.user }

  describe "comments commentators list" do
    context "when not signed in" do
      it "do not displays right comments title without login" do
        visit "/comments"
        expect(page).not_to have_selector("h3", text: "Top 10 commentators last 7 days")
      end
    end
    context "when signed in" do
      before do
        sign_in user
      end
      it "displays right comment title without login" do
        visit "/comments"
        expect(page).to have_selector("h1", text: "Top 10 commentators last 7 days")
      end
    end
  end
end
