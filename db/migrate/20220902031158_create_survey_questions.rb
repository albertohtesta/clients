class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions do |t|
      t.string :question, null: false
      t.references :morale_attribute, null: false, foreign_key: true
      t.timestamps
    end
    add_index :survey_questions, :question, unique: true
  end
end
