class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.integer :status
      t.string :survey_url
      t.integer :requested_answers
      t.integer :current_answers
      t.date :deadline
      t.integer :period
      t.jsonb :questions_detail
      t.jsonb :answers_detail
      t.references :team, null: false, foreign_key: true
      t.index :answers_detail, using: :gin
      t.index :questions_detail, using: :gin
      t.index :period

      t.timestamps
    end
  end
end
