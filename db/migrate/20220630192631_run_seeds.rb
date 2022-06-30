

class RunSeeds < ActiveRecord::Migration[7.0]
  def change
    require Rails.root.join('db', 'seeds.rb') unless Collaborator.first
  end
end
