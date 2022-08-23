# frozen_string_literal: true

require "test_helper"

class CollaboratorPresenterTest < ActiveSupport::TestCase
  def collaborator
    @collaborator ||= build(:collaborator)
    @account ||= create(:account)
    @project ||= create(:project, account: @account)
    @team ||= create(:team, { project: @project })
    @collaborator ||= create(:collaborator)
    @collaborator2 ||= create(:collaborator)
  end

  def collaborator_presenter
    @collaborator_presenter ||= CollaboratorPresenter.new(@collaborator)
  end

  test "must return json" do
    collaborator
    @collaborator_team = create(:collaborators_team, collaborator: @collaborator, team: @team)
    @post ||= create(:post, collaborator: @collaborator, project: @project)
    @post.post.attach(
      io: File.open(Rails.root.join("test/fixtures/files/example.png")),
      filename: "example.png"
    )

    collaborator_presenter

    expected_json = {
      "id" => @collaborator.id,
      "position" => "Developer",
      "name" => "MyString MyString",
      "posts_count" => 1,
      "img" => nil,
      "post" => {
        "id" => @post.id,
        "title" => "MyString",
        "description" => "MyText",
        "collaborator_id" => @collaborator.id,
        "project_id" => @project.id,
        "created_at" => @post.created_at,
        "post_url" => Rails.application.routes.url_helpers.rails_blob_path(@post.post, only_path: true)
      }
    }

    assert_equal expected_json, collaborator_presenter.json
  end

  test "must return json without post" do
    collaborator
    @collaborator_team = create(:collaborators_team, collaborator: @collaborator, team: @team)
    collaborator_presenter

    expected_json = {
      "id" => @collaborator.id,
      "name" => "MyString MyString",
      "position" => "Developer",
      "posts_count" => 0,
      "img" => nil,
      "post" => []
    }

    assert_equal expected_json, collaborator_presenter.json
  end
end
