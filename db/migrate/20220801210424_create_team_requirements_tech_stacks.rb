class CreateTeamRequirementsTechStacks < ActiveRecord::Migration[7.0]
  def change
    create_table :team_requirements_tech_stacks do |t|
      t.references :team_requirement
      t.references :tech_stack

      t.timestamps
    end
  end
end
