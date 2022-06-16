FactoryBot.define do
  factory :team do
    added_date { "2022-06-14 13:19:29" }
    team_type { TeamType.new }
  end
end
