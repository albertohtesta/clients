# frozen_string_literal: true

RSpec.describe PostPresenter do
  describe "post_url" do
    it "must retrieve posts' url" do
      create(:post, title: "url", url: "//icon.gif")
      result = described_class.json_collection(Post.where(title: "url"))
      expect(result.first["post_url"]).to eq("//icon.gif")
    end

    it "must validate empty url" do
      create(:post, title: "clear")
      result = described_class.json_collection(Post.where(title: "clear"))
      expect(result.first["post_url"]).to be_nil
    end
  end
end
