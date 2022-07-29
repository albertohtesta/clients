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
    collaborator_presenter

    expected_json = {
      "id" => @collaborator.id,
      "name" => "MyString MyString",
      "position" => "Developer",
      "posts_count" => 1,
      "img" => "",
      "post" => {
        "id" => @post.id,
        "title" => "MyString",
        "description" => "MyText",
        "collaborator_id" => @collaborator.id,
        "project_id" => @project.id,
        "created_at" => @post.created_at
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
      "img" => "",
      "post" => []
    }

    assert_equal expected_json, collaborator_presenter.json
  end
end
