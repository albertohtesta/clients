class AddColumnsToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :period_value, :integer
    add_column :surveys, :remote_survey_id, :string
    add_column :surveys, :started_at, :date
    add_column :surveys, :description, :string
    add_column :surveys, :year, :integer
  end
end
