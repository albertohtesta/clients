class AddColumnsToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :period_value, :string
    add_column :surveys, :remote_survey_id, :string
    add_column :surveys, :survey_date, :date
    add_column :surveys, :description, :string
  end
end
