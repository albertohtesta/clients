# frozen_string_literal: true

require "faker"

######### ADD CATALOGS FIELDS
AccountStatus.create([
                       { status: "New", status_code: "new_project" },{ status: "In Development", status_code: "in_development" }, { status: "Finished", status_code: "finished" }, { status: "Cancelled", status_code: "cancelled" }
                     ])
TeamType.create([
                  { name: "POD" }, { name: "Big POD" }, { name: "Staff Augmentation" }
                ])
Tool.create([
              { name: "AWS" }, { name: "Rails" }, { name: "Azure" }, { name: "Cognito" }, { name: "Sentry" }
            ])

TechStack.create([
                   { name: "Java" }, { name: "Ruby" }, { name: "JavaScript" }, { name: "ReactJS" }, { name: "C#" }
                 ])

# **************************************
# CREATE 7 ACCOUNT'S FIELDS
# **************************************

# **************************************
# CREATE 7 ACCOUNT'S FIELDS
# **************************************
Role.create!([
  {name: 'Developer'},
  {name: 'Scrum master'},
  {name: 'QA'},
  {name: 'UI/UX'}]
)
# **************************************
# CREATING 40 COLLABORATORS
# **************************************
role = Role.find_by(name: 'Developer')
40.times do
  Collaborator.create([
                        {
                          first_name: Faker::Name.unique.name,
                          last_name: Faker::Name.unique.name,
                          uuid: Faker::IDNumber.unique.invalid,
                          email: Faker::Internet.unique.email,
                          tech_stacks: TechStack.all.sample(2),
                          tools: Tool.all.sample(2),
                          role: role
                        }
                      ])
end

def random_price
  rand(500_000.00..10_000_000.00).round(2)
end

def account_amounts
  {
    balance: rand(0..100),
    blended_rate: random_price,
    gross_profit: random_price,
    payroll: random_price,
    total_expenses: random_price,
    total_revenue: random_price
  }
end

def random_salesforce_id(length, id = "")
  id = random_salesforce_id(length, id += (0..9).to_a.union(("A".."Z").to_a).sample.to_s) if id.length < length

  id
end

# GET 2 COLLABORATORS AS MANAGERS TO ASSIGN ACCOUNTS TO
managers = Collaborator.limit(2)
locations = ["California", "New York City", "Washington", "San Francisco"]

7.times do
  Account.create([
                   {
                     account_uuid: Faker::IDNumber.unique.invalid,
                     manager: managers.sample,
                     name: Faker::Company.unique.bs,
                     contact_name: Faker::Name.unique.name,
                     contact_email: Faker::Internet.unique.email,
                     contact_phone: Faker::PhoneNumber.unique.phone_number,
                     account_web_page: Faker::Internet.unique.url,
                     account_status_id: AccountStatus.first.id,
                     salesforce_id: random_salesforce_id(15),
                     city: locations.sample,
                     client_satisfaction: rand(0..100),
                     moral: rand(0..100),
                     bugs_detected: rand(0..100),
                     permanence: rand(0..100),
                     productivity: rand(0..100),
                     speed: rand(0..100)
                   }.merge(account_amounts)
                 ])
end

# ADD TWO ACCOUNTS WITH NO USED STATUS
Account.first.update(account_status: AccountStatus.find_by(status: "Finished"))
Account.last.update(account_status: AccountStatus.find_by(status: "Cancelled"))

# ************************************************
# CREATE 2 PAYMENTS AND 1 PROJECT BY EACH ACCOUNT
# ***********************************************
def payment_field
  {
    payment_date: nil,
    cut_off_date: Date.new(Date.today.year, Date.today.month, 1),
    payday_limit: Date.new(Date.today.year, Date.today.month, 28)
  }
end
Account.all.each do |account|
  Payment.create([
                   payment_field.merge({ account_id: account.id }),
                   payment_field.merge({
                                         account_id: account.id,
                                         payment_date: Faker::Date.between(
                                           from: Date.new(Date.today.year, (Date.today.month - 1), 5),
                                           to: Date.new(Date.today.year, (Date.today.month - 1), 25)
                                         )
                                       })
                 ])
  Project.create([
                   {
                     name: account.name,
                     start_date: Faker::Date.between(from: 5.months.ago, to: (DateTime.now + 1.year)),
                     description: Faker::Lorem.sentence,
                     account_id: account.id,
                     tech_stacks: TechStack.all.sample(2),
                     tools: Tool.all.sample(2)
                   }
                 ])
end

# **************************************
# CREATING 7 TEAMS WITH 5 COLLABORATORS AND LINKED WITH A PROJECT
# **************************************
7.times do |idx|
  Team.create(
    added_date: Faker::Date.between(from: 5.months.ago, to: DateTime.yesterday),
    team_type_id: TeamType.all.to_a.sample.id,
    collaborators: Collaborator.limit(5).offset(idx * 5),
    projects: Project.limit(1).offset(idx)
  )
end


posts_for_collaborators = []
Collaborator.all.each do |collaborator|
  posts_for_collaborators << {
    title: Faker::Name.unique.name,
    description: Faker::Lorem.sentence,
    collaborator_id: collaborator.id,
    project_id: collaborator.teams&.first&.projects&.first&.id
  }
end
Post.create(posts_for_collaborators)


one_single_metric = {
  "team_id"=> 1, "date" => "21-05-2022", "value"=> 75, "total_tickets" => 20, "finished_tickets" => 15, "missing_tickets" => 5
}
Team.all.each_with_index do |team, idx|
  Metric.create([
    {date: Date.tomorrow.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "performance"},
    {date: Date.today.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "performance"},
    {date: Date.yesterday.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "performance"},

    {date: Date.today.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "velocity"},
    {date: Date.today.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "morale"},
    {date: Date.today.months_ago(idx), metrics: one_single_metric.to_json, team_id: Team.all.sample.id, indicator_type: "balance"}
  ])
end

p "Seed... #{AccountStatus.count} AccountStatus created"
p "Seed... #{TeamType.count} TeamType created"
p "Seed... #{Tool.count} Tool created"
p "Seed... #{TechStack.count} TechStack created"
p "Seed... #{Account.count} Account created"
p "Seed... #{Payment.count} Payment created"
p "Seed... #{Project.count} Project created"
p "Seed... #{Collaborator.count} Collaborator created"
p "Seed... #{Team.count} Teams created"
p "Seed... #{Post.count} Posts created"
p "Seed... #{Metric.count} Metrics created"
