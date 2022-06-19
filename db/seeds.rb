# frozen_string_literal: true

require "faker"

######### ADD CATALOGS FIELDS
AccountStatus.create([
                       { status: "In Development" }, { status: "Finished" }, { status: "Cancelled" }
                     ])
TeamType.create([
                  { name: "POD" }, { name: "Big POD" }, { name: "Staff Ahugmentation" }
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
7.times do
  Account.create([
                   {
                     account_uuid: Faker::IDNumber.unique.invalid,
                     name: Faker::Company.unique.bs,
                     contact_name: Faker::Name.unique.name,
                     contact_email: Faker::Internet.unique.email,
                     contact_phone: Faker::PhoneNumber.unique.phone_number,
                     account_web_page: Faker::Internet.unique.url,
                     account_status_id: AccountStatus.first.id
                   }
                 ])
end

# ADD TWO ACCOUNTS WITH NO USED STATUS
Account.first.update(account_status: AccountStatus.find_by(status: "Finished"))
Account.last.update(account_status: AccountStatus.find_by(status: "Cancelled"))

# **************************************
# CREATING 40 COLLABORATORS
# **************************************
40.times do
  Collaborator.create([
                        {
                          name: Faker::Name.unique.name,
                          uuid: Faker::IDNumber.unique.invalid,
                          email: Faker::Internet.unique.email,
                          tech_stacks: TechStack.all.sample(2),
                          tools: Tool.all.sample(2)
                        }
                      ])
end

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

p "Seed... #{AccountStatus.count} AccountStatus created"
p "Seed... #{TeamType.count} TeamType created"
p "Seed... #{Tool.count} Tool created"
p "Seed... #{TechStack.count} TechStack created"
p "Seed... #{Account.count} Account created"
p "Seed... #{Payment.count} Payment created"
p "Seed... #{Project.count} Project created"
p "Seed... #{Collaborator.count} Collaborator created"
p "Seed... #{Team.count} Teams created"
