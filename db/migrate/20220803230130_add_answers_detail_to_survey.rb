class AddAnswersDetailToSurvey < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :answers_detail, :jsonb
    add_index :surveys, :answers_detail, using: :gin
    rename_column :surveys, :survey_monkey_url, :survey_url
  end
end
