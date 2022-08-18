# frozen_string_literal: true

require "faker"

######### ADD CATALOGS FIELDS
AccountStatus.create([
  { status: "New", status_code: "new_project" }, { status: "In Development", status_code: "in_development" }, { status: "Finished", status_code: "finished" }, { status: "Cancelled", status_code: "cancelled" }
])
TeamType.create([ { name: "POD" }, { name: "Big POD" }, { name: "Staff Augmentation" } ])
Tool.create([ { name: "AWS" }, { name: "Rails" }, { name: "Azure" }, { name: "Cognito" }, { name: "Sentry" } ])
TechStack.create([
  { name: "AGILE COACH" },
  { name: "BACKEND DEVELOPER" },
  { name: "FRONTEND DEVELOPER" },
  { name: "FULL STACK DEVELOPER" },
  { name: "PRODUCT OWNER" },
  { name: "QUALITY ASURANCE" },
  { name: "SCRUM MASTER" },
  { name: "SCRUM PRODUCT OWNER" },
  { name: "UX/UI" },
  { name: "Java" }, { name: "Ruby" }, { name: "JavaScript" }, { name: "ReactJS" }, { name: "C#" }
])
Badge.create!([
  { id: 1, name: "1 YEAR" },
  { id: 2, name: "5 YEARS" },
  { id: 3, name: "10 YEARS" },
  { id: 4, name: "15 YEARS" },
  { id: 5, name: "20 YEARS" },
  { id: 6, name: "ACCOUNT" },
  { id: 7, name: "ADAPTABILITY" },
  { id: 8, name: "CRITICAL THINKING" },
  { id: 9, name: "EFFECTIVE COMMUNICATION" },
  { id: 10, name: "EMPATHY" },
  { id: 11, name: "MIND TEAMS" },
  { id: 12, name: "OPENING" },
  { id: 13, name: "PLANNING" },
  { id: 14, name: "RESPONSIBILITY" },
  { id: 15, name: "SALARY GROWTH" },
  { id: 16, name: "SENIORITY GROWTH" },
  { id: 17, name: "TEAMWORK" }
])

Role.create!([
  { name: "AGILE COACH" },
  { name: "BACKEND DEVELOPER" },
  { name: "FRONTEND DEVELOPER" },
  { name: "FULL STACK DEVELOPER" },
  { name: "PRODUCT OWNER" },
  { name: "QUALITY ASURANCE" },
  { name: "SCRUM MASTER" },
  { name: "SCRUM PRODUCT OWNER" },
  { name: "UX/UI" },
  { name: "Developer" },
  { name: "Account Manager" },
  { name: "Scrum master" },
  { name: "QA" },
  { name: "UI/UX" }
])

MetricLimit.create([
  { indicator_type: :balance, label: METRICS_TYPES[:balance], low_priority_min: 90, low_priority_max: 100, medium_priority_min: 80, medium_priority_max: 89, high_priority_min: 0, high_priority_max: 79 },
  { indicator_type: :client_engagement, label: METRICS_TYPES[:client_engagement], low_priority_min: 90, low_priority_max: 100, medium_priority_min: 80, medium_priority_max: 89, high_priority_min: 0, high_priority_max: 79 },
  { indicator_type: :performance, label: METRICS_TYPES[:performance], low_priority_min: 90, low_priority_max: 100, medium_priority_min: 80, medium_priority_max: 89, high_priority_min: 0, high_priority_max: 79 },
  { indicator_type: :morale, label: METRICS_TYPES[:morale], low_priority_min: 90, low_priority_max: 100, medium_priority_min: 80, medium_priority_max: 89, high_priority_min: 0, high_priority_max: 79 },
  { indicator_type: :gross_marging, label: METRICS_TYPES[:gross_marging], low_priority_min: 40, low_priority_max: 100, medium_priority_min: 25, medium_priority_max: 39, high_priority_min: 0, high_priority_max: 24 }
])

# **************************************
# CREATING 2 ACCOUNT MANAGERS
# **************************************
role = Role.find_by(name: "Account Manager")
Collaborator.create([
                      {
                        id: 102,
                        first_name: Faker::Name.unique.name,
                        last_name: Faker::Name.unique.name,
                        uuid: Faker::IDNumber.unique.invalid,
                        email: Faker::Internet.unique.email,
                        tech_stacks: TechStack.all.sample(2),
                        tools: Tool.all.sample(2),
                        role:
                      },
                      {
                        id: 101,
                        first_name: Faker::Name.unique.name,
                        last_name: Faker::Name.unique.name,
                        uuid: Faker::IDNumber.unique.invalid,
                        email: Faker::Internet.unique.email,
                        tech_stacks: TechStack.all.sample(2),
                        tools: Tool.all.sample(2),
                        role:
                      }
                    ])

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


# **************************************
# CREATING COLLABORATORS PUBLIC PROFILES
# **************************************
role = Role.find_by(name: "Developer")

# TODO: position of this collabs need be a relation with ROLE table
Collaborator.create([
  { id: 1, seniority: "MIDDLE", english_level: "B2", profile: "https://drive.google.com/file/d/1jqN8_y7Y08uHvdUZQD9sEyRebuy2X1KZ/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "JESUS ALEJANDRO", last_name: "BELTRAN\tHERNANDEZ", email: "jbeltran@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Mid developer with 3 years of experience working with clients from Mexico. Jesus has experience with some technologies and he is always looking for new things to learn. During these last 3 years he had the opportunity to implement solutions and resolve problems with software.", nickname: "JESUS", category: "DEVELOPER" },
  { id: 2, seniority: "JUNIOR", english_level: "C1", profile: "https://drive.google.com/file/d/1pOCD2a5HUw63JllPWfvl5JgWyUeGs7hm/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "BRANDOM", last_name: "RODRIGUEZ\tBORQUEZ", email: "bborquez@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Junior developer freshly graduated from university as a software engineer with experience with agile methodologies and modern backend frameworks such as Express on Node and Flask on Python. Worked previously on teams that developed different projects, like a real estate selling app, and a classroom status monitoring system. I also developed by myself an Android app meant to help students organize their time and remind them about homeworks.", nickname: "BRANDOM", category: "DEVELOPER" },
  { id: 3, seniority: "JUNIOR", english_level: "C1", profile: "https://drive.google.com/file/d/1fx-GL5webzFyOj1nWh9r8L3McmEvFlJ2/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "ANGEL ARTURO", last_name: "DAVILA\tGOVEA", email: "adavila@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Engineer in software development, aiming to develop backend solutions yet focused on learning any technology required.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 4, seniority: "MIDDLE", english_level: "C1", profile: "https://drive.google.com/file/d/1oIocpbnMW1mlxZ5Boxhb44eitoeGH3xd/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "ANGEL", last_name: "AYON\tLUIS", email: "layon@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Web and Desktop Software Developer. I am a passionate person in what I do, I constantly seek personal and work growth where I fulfill all the goals that are assigned to me. My hobbies are drawing, exercising, playing video games, reading articles, and playing guitar.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 5, seniority: "SENIOR", english_level: "C2", profile: "https://drive.google.com/file/d/1exzf7-cs4hvlYOMkz2ahmxc1MEo73PlD/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "LUIS ARTURO", last_name: "RENTERIA\tTOSTADO", email: "lrenteria@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Im a developer,  I have 8 years of expierence with java developing web-based aplications also  I worked with php for 3 years developing web-basaed aplications and in the last 7 years  I gained expierence with .net and ecommerce platforms.", nickname: "LOLO", category: "DEVELOPER" },
  { id: 6, seniority: "SENIOR", english_level: "C1", profile: "https://drive.google.com/file/d/1mfDvyE3L125cn4n6iUwk82CMRcmvezqx/view?usp=sharing", work_modality: "MIXED", position: "SOFTWARE ENGINEER", first_name: "ANGEL MARIN", last_name: "RENTERIA\tTOSTADO", email: "aespinoza@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Senior Android developer with more than 8 years of experience. Angel has experience with Java and Kotlin for application development and has held a technical lead position. also has experience in some other programming languages for backend.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 7, seniority: "MIDDLE", english_level: "B2", profile: "https://drive.google.com/file/d/1CbuHDO3GkSgGUl7Dpg5eP_cEk6wX8PAx/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "FRANCISCO EDUARDO", last_name: "ESCOBAR\tESPINOSA", email: "paco.escobar@michelada.io", role:, uuid: Faker::IDNumber.unique.invalid, about: "Mid developer with 4 year of experience working in Swift, 1 years with Objective-C and React Native and currently learning SwiftUI. Francisco loves to learn new things and he's not afraid to take on challenges, learn quickly and adapt to whatever the client needs", nickname: "PACO", category: "DEVELOPER" },
  { id: 8, seniority: "MIDDLE", english_level: "B1", profile: "https://drive.google.com/file/d/1r45dOmDWXqyIYQ5EJfVbCOIQwDDoy_dl/view?usp=sharing", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "MARIA FERNANDA", last_name: "CEREZO\tGOMEZ", email: "mcerezo@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Fernanda is a developer with 2 year of experience and has worked with clients from both the US and Mexico. Fernanda has experience with several technologies and she is always looking for new challenges. During these recent years she had the opportunity to implement solutions and resolve problems with software.", nickname: "FERNANDA", category: "DEVELOPER" },
  { id: 9, seniority: "MIDDLE", english_level: "B2", profile: "https://drive.google.com/file/d/1J-P_3sPfczU0oWZCb1xasNitmXSmc63t/view?usp=sharing", work_modality: "REMOTE", position: "PRODUCT OWNER", first_name: "MIGUEL ANGEL", last_name: "FELIX\tGARCIA", email: "mfelix@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Product Owner and Scrum Master with +10 years of experience and has worked with clients from Mexico. Experience being the bridge between the clients and the developers. During these years he had the opportunity to implement solutions and resolve problems with client requirements.", nickname: "MIKE", category: "MANAGER" },
  { id: 200, seniority: "MIDDLE", english_level: "C1", profile: "https://drive.google.com/file/d/1c7PqPTRe_LqA1o5QlSNiQpG4O6Gh2UMM/view?usp=sharing", work_modality: "REMOTE", position: "PRODUCT OWNER", first_name: "JONATHAN", last_name: "RUBEN\tHERNANDEZ", email: "jrhernandez@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Product Owner with certifications as a scrum master, design thinking, and kanban. +5 years of experience working with agile frameworks and 3 years working as a .Net developer (Back and front). Collecting  software requirements. Defining user stories, Setting acceptance criteria, defining the minimum viable product and the release plan, adding value focuss on results.", nickname: "JON", category: "MANAGER" },
  { id: 201, seniority: "MIDDLE", english_level: "C1", profile: "https://drive.google.com/file/d/1uqrG0inP-60KZUCNrX9vLAjjYLmOZa6M/view?usp=sharing", work_modality: "REMOTE", position: "QA ENGINEER", first_name: "MICAELA MARIA", last_name: "CRUZ\tILLESCAS", email: "milescas@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Micaela, as a bicultural person, has worked with clients from both the US and Mexico. Has experience with several technologies and she is always looking for new challenges. During these recent years she had the opportunity to work for Arkusnexus as a manual QA tester for mobile apps. added 10.3 years of QA experience, 23 years of development for Mainframes and middlewares using different programming languages and methodologies and a year as Planning Center Lead.", nickname: "MICAELA", category: "TESTER" },
  { id: 202, seniority: "SENIOR", english_level: "C2", profile: "https://drive.google.com/file/d/1ztsoT-m4-d8C8wCjxhqxWtkRgnCTQwyF/view?usp=sharing", work_modality: "REMOTE", position: "QA ENGINEER", first_name: "JITHIN", last_name: "CHERUTALA", email: "jcheruthala@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Over ten years of proven experience in advising clients on test automation strategy, setting direction for long-term automation plans, bringing in best practices, and RoI evaluation and Possess in-depth knowledge of multiple open source/commercial tools for Web test automation (Selenium, QTP/ UFT, etc.) and Mobile test automation.", nickname: "JITHIN", category: "TESTER" },
  { id: 203, seniority: "SENIOR", english_level: "B1", profile: "https://drive.google.com/file/d/1eLA0k1ntkt8LJCraURhn945XO2Fa0hLf/view?usp=sharing", work_modality: "MIXED", position: "SCRUM MASTER", first_name: "LEOPOLDO", last_name: "CHIQUETE\tZAZUETA", email: "lchiquete@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "I had been working in Arkusnexus for 10 years in several projects with differents clients from both the US and Mexico, as developer until leading a whole team, he always is developing his knowledge and acquiring multiple skills, his ability to learn new things and the desire of always looking new challenges.", nickname: "CHIQUETE", category: "MANAGER" }
])

Collaborator.find(1).update(badges: Badge.where({ id: [9, 11, 13, 17] }))
Collaborator.find(2).update(badges: Badge.where({ id: [7, 9, 10, 11, 14] }))
Collaborator.find(3).update(badges: Badge.where({ id: [1, 7, 8, 11, 14, 17] }))
Collaborator.find(4).update(badges: Badge.where({ id: [7, 11, 14, 17] }))
Collaborator.find(5).update(badges: Badge.where({ id: [7, 11, 14] }))
Collaborator.find(6).update(badges: Badge.where({ id: [7, 11, 14, 17] }))
Collaborator.find(7).update(badges: Badge.where({ id: [1, 2, 3, 11] }))


# GET 2 COLLABORATORS AS MANAGERS TO ASSIGN ACCOUNTS TO
managers = CollaboratorRepository.by_role_name("Account Manager").limit(2)
locations = ["California", "New York City", "Washington", "San Francisco"]



# ****************************************************************************
# CREATING ADVANTA ACCOUNT DATA FOR QA
# ****************************************************************************
advanta = Account.create(
  { account_uuid: Faker::IDNumber.unique.invalid, manager: managers.sample, name: "ADVANTA", manager_started_date: 3.months.ago, contact_name: Faker::Name.unique.name, contact_email: Faker::Internet.unique.email, contact_phone: Faker::PhoneNumber.unique.phone_number, account_status_id: AccountStatus.first.id, salesforce_id: random_salesforce_id(15), city: locations.sample, client_satisfaction: rand(0..100), moral: rand(0..100), bugs_detected: rand(0..100), permanence: rand(0..100), productivity: rand(0..100), speed: rand(0..100) }.merge(account_amounts)
)
project_advanta = Project.create(
  { name: advanta.name, start_date: Faker::Date.between(from: 10.months.ago, to: 5.months.ago), description: "ADVANTA PROJECT", account_id: advanta.id, tech_stacks: TechStack.all.sample(3), tools: Tool.all.sample(2) }
)
advanta_collaborators = Collaborator.create([
  { id: 10, role:, position: "QUALITY ASURANCE", first_name: "Andres", last_name: "Pacheco", email: "mario.pacheco@michelada.io", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 11, role:, position: "BACKEND DEVELOPER", first_name: "Bryan", last_name: "Guerrero", email: "bryan.guerrero@michelada.io", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 12, role:, position: "FRONTEND DEVELOPER", first_name: "Edgar", last_name: "Zea", email: "edgar.zea@michelada.io", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 13, role:, position: "FRONTEND DEVELOPER", first_name: "Eduardo", last_name: "Chavez", email: "echavez@arkusnexus.com", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 14, role:, position: "BACKEND DEVELOPER", first_name: "Jesus", last_name: "Vazquez", email: "jesus.macedo@michelada.io", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 15, role:, position: "BACKEND DEVELOPER", first_name: "Jonathan", last_name: "Calderon", email: "jcalderon@arkusnexus.com", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 16, role:, position: "PRODUCT OWNER", first_name: "Jonathan", last_name: "Hernandez", email: "jrhernandez@arkusnexus.com", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 17, role:, position: "SCRUM MASTER", first_name: "Leopoldo", last_name: "Chiquete", email: "lchiquete@arkusnexus.com", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 18, role:, position: "FULL STACK DEVELOPER", first_name: "Monica", last_name: "Morais", email: "monica.morais@michelada.io", seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid }
])
team_advanta = Team.create(
  { added_date: project_advanta.start_date, team_type_id: TeamType.find_by({ name: "POD" }).id, collaborators: advanta_collaborators, project: project_advanta }
)
Metric.create([
  # PERFORMANCE
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 50 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 60 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 70 }.to_json },
  { date: "15-04-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-04-2022", "value" => 80 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 90 }.to_json },
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 100 }.to_json },
  # VELOCITY
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 35 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 45 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 35 }.to_json },
  { date: "15-04-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-04-2022", "value" => 60 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 70 }.to_json },
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 75 }.to_json },
  # MORALE
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 90 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 95 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 50 }.to_json },
  { date: "15-04-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-04-2022", "value" => 80 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 90 }.to_json },
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 95 }.to_json },
  # BALANCE
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 80 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 80 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 90 }.to_json },
  { date: "15-04-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-04-2022", "value" => 100 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 100 }.to_json },
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 90 }.to_json },
])
team_advanta.investments.create([
  { value: 55000.00, date: "15-01-2022".to_date },
  { value: 55000.00, date: "15-02-2022".to_date },
  { value: 60000.00, date: "15-03-2022".to_date },
  { value: 70000.00, date: "15-04-2022".to_date },
  { value: 70000.00, date: "15-05-2022".to_date },
  { value: 60000.00, date: "15-06-2022".to_date }
])
# ****************************************************************************
# CREATING Contact of an account
# ****************************************************************************
# ToDo: We have an error when we have to create a new collaborator
# collaborator_savid = Collaborator.create(
#   id: Collaborator.last.id + 30,
#   role: Role.first,
#   first_name: Faker::Name.unique.name,
#   last_name: Faker::Name.unique.name,
#   uuid: Faker::IDNumber.unique.invalid,
#   email: "ssalazar@arkus-solutions.com",
#   tech_stacks: TechStack.all.sample(2),
#   tools: Tool.all.sample(2)
# )

# collaborator_amunoz = Collaborator.create(
#   id: Collaborator.last.id + 30,
#   role: Role.first,
#   first_name: Faker::Name.unique.name,
#   last_name: Faker::Name.unique.name,
#   uuid: Faker::IDNumber.unique.invalid,
#   email: "amunoz@arkusnexus.com",
#   tech_stacks: TechStack.all.sample(2),
#   tools: Tool.all.sample(2)
# )

# AccountCollaborator.create!([
#   { account_id: advanta.id, collaborator: collaborator_savid},
#   { account: advanta.id, collaborator: collaborator_amunoz}
# ])

Contact.create([
  { email: "ssalazar@arkus-solutions.com", first_name: "Savid", last_name: "Salazar", phone: "5556581111", account_id: advanta.id, salesforce_id: Faker::IDNumber.unique.invalid },
  { email: "amunoz@arkusnexus.com", first_name: "Alvaro", last_name: "Muñoz", phone: "5557802912", account_id: advanta.id, salesforce_id: Faker::IDNumber.unique.invalid }
])


# ****************************************************************************
# CREATING BREAKTHROGHT BROKER ACCOUNT DATA FOR QA
# ****************************************************************************
broker = Account.create(
  { manager: managers.sample, name: "Breakthrough Broker", contact_name: Faker::Name.unique.name, manager_started_date: 3.months.ago, contact_email: Faker::Internet.unique.email, contact_phone: Faker::PhoneNumber.unique.phone_number, account_status_id: AccountStatus.first.id, account_uuid: Faker::IDNumber.unique.invalid, salesforce_id: random_salesforce_id(15), city: locations.sample, client_satisfaction: rand(0..100), moral: rand(0..100), bugs_detected: rand(0..100), permanence: rand(0..100), productivity: rand(0..100), speed: rand(0..100) }.merge(account_amounts)
)
project_broker = Project.create(
  { name: broker.name, start_date: Faker::Date.between(from: 10.months.ago, to: 5.months.ago), description: "breakthrough_broker project", account_id: broker.id, tech_stacks: TechStack.all.sample(3), tools: Tool.all.sample(2) }
)
broker_collaborators = Collaborator.create([
  { id: 20, role:, position: "QUALITY ASURANCE", first_name: "Jithin", last_name: "Cheruthala", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 21, role:, position: "BACKEND DEVELOPER", first_name: "Karla", last_name: "Alvarez", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 22, role:, position: "FRONTEND DEVELOPER", first_name: "Isai", last_name: "Madueño", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 23, role:, position: "FRONTEND DEVELOPER", first_name: "Aldo", last_name: "Enriquez", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 24, role:, position: "BACKEND DEVELOPER", first_name: "Alejandro", last_name: "Rebollar", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 25, role:, position: "BACKEND DEVELOPER", first_name: "Andrés", last_name: "Becerra", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 26, role:, position: "PRODUCT OWNER", first_name: "Francisco", last_name: "Rosete", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 27, role:, position: "SCRUM MASTER", first_name: "Carlos", last_name: "Sanchez", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid },
  { id: 28, role:, position: "FULL STACK DEVELOPER", first_name: "Edgar", last_name: "Aguilar", email: Faker::Internet.unique.email, seniority: "MIDDLE", uuid: Faker::IDNumber.unique.invalid }
])
team_broker = Team.create(
  { added_date: project_broker.start_date, team_type_id: TeamType.find_by({ name: "POD" }).id, collaborators: broker_collaborators, project: project_broker }
)
Metric.create([
  # PERFORMANCE
  { date: "15-01-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-01-2022", "value" => 80 }.to_json },
  { date: "15-02-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-02-2022", "value" => 80 }.to_json },
  { date: "15-03-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-03-2022", "value" => 82 }.to_json },
  { date: "15-04-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-04-2022", "value" => 85 }.to_json },
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 90 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 100 }.to_json },
  # VELOCITY
  { date: "15-01-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-01-2022", "value" => 40 }.to_json },
  { date: "15-02-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-02-2022", "value" => 45 }.to_json },
  { date: "15-03-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-03-2022", "value" => 50 }.to_json },
  { date: "15-04-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-04-2022", "value" => 40 }.to_json },
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 70 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 70 }.to_json },
  # MORALE
  { date: "15-01-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-01-2022", "value" => 60 }.to_json },
  { date: "15-02-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-02-2022", "value" => 80 }.to_json },
  { date: "15-03-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-03-2022", "value" => 85 }.to_json },
  { date: "15-04-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-04-2022", "value" => 60 }.to_json },
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 90 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 95 }.to_json },
  # BALANCE
  { date: "15-01-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-01-2022", "value" => 100 }.to_json },
  { date: "15-02-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-02-2022", "value" => 100 }.to_json },
  { date: "15-03-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-03-2022", "value" => 100 }.to_json },
  { date: "15-04-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-04-2022", "value" => 100 }.to_json },
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 90 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 90 }.to_json },
])
team_broker.investments.create([
  { value: 70000.00, date: "15-01-2022".to_date },
  { value: 70000.00, date: "15-02-2022".to_date },
  { value: 70000.00, date: "15-03-2022".to_date },
  { value: 70000.00, date: "15-04-2022".to_date },
  { value: 60000.00, date: "15-05-2022".to_date },
  { value: 60000.00, date: "15-06-2022".to_date }
])
Contact.create([
  { email: "ssalazar@arkus-solutions.com", first_name: "Savid", last_name: "Salazar", phone: "5556581111", account_id: team_broker.id, salesforce_id: Faker::IDNumber.unique.invalid },
  { email: "amunoz@arkusnexus.com", first_name: "Alvaro", last_name: "Muñoz", phone: "5557802912", account_id: team_broker.id, salesforce_id: Faker::IDNumber.unique.invalid }
])



# **************************************
# CREATING 40 COLLABORATOR
# **************************************
40.times.each do |idx|
  Collaborator.create([
    { id: idx + 30, role:, first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, uuid: Faker::IDNumber.unique.invalid, email: Faker::Internet.unique.email, tech_stacks: TechStack.all.sample(2), tools: Tool.all.sample(2) }
  ])
end
# **************************************
# CREATING 7 ACCOUNTS
# **************************************
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

current_month = Time.now.month

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
  Project.create(
                   {
                     name: account.name,
                     start_date: Faker::Date.between(from: 5.months.ago, to: (DateTime.now + 1.year)),
                     description: Faker::Lorem.sentence,
                     account_id: account.id,
                     tech_stacks: TechStack.all.sample(2),
                     tools: Tool.all.sample(2)
                   }
                 )
end

# **************************************
# CREATING 7 TEAMS WITH 5 COLLABORATORS AND LINKED WITH A PROJECT
# **************************************
7.times do |idx|
  team = Team.create(
    added_date: Faker::Date.between(from: 5.months.ago, to: DateTime.yesterday),
    team_type_id: TeamType.all.to_a.sample.id,
    collaborators: CollaboratorRepository.by_role_name("Developer").limit(5).offset(idx * 5),
    project: Project.limit(1).offset(idx).first
  )

  20.times do |t|
    team.investments.create({
      value: rand(1000.00..500000.00).round(2),
      date: rand(-current_month.months..(12 - current_month).months).ago
    })
  end

  rand(1..5).times do |t|
    team.team_requirements.create({
      account: team.project.account,
      role: Role.all.sample,
      seniority: SENIORITY_TYPES.to_a.sample[1],
      tech_stacks: TechStack.all.sample(2),
    })
  end
end


posts_for_collaborators = []
CollaboratorRepository.by_role_name("Developer").all.each do |collaborator|
  posts_for_collaborators << {
    title: Faker::Name.unique.name,
    description: Faker::Lorem.sentence,
    collaborator_id: collaborator.id,
    project_id: collaborator.teams&.first&.project&.id
  }
end
Post.create(posts_for_collaborators)

Team.create(
  added_date: Faker::Date.between(from: 5.months.ago, to: DateTime.yesterday),
  team_type_id: TeamType.all.to_a.sample.id,
  collaborators: CollaboratorRepository.by_role_name("Developer").limit(5).offset(1 * 5),
  project: Project.limit(1).offset(1).first, id: 10000
)

6.times do |idx|
  Survey.create(
    status: 2,
    survey_url: "www.survey.com",
    requested_answers: rand(10..50),
    current_answers: rand(10..50),
    created_at: Date.today + (idx).months,
    deadline: Date.today + (idx + 1).months,
    period: [0, 1].sample,
    team_id: 10000,
    questions_detail: {
      questions: [
        {
          title: "Pregunta 1",
          category: "Balance de vida",
          final_score: [50, 60, 70, 80, 90, 100].sample,
          answers: [
            {
              title: "respuesta 1",
              responses: 10,
              score: 100
            },
            {
              title: "respuesta 2",
              responses: 0,
              score: 0
            },

            {
              title: "respuesta 3",
              responses: 0,
              score: 0
            }
          ]
        },
        {
          title: "Pregunta 2",
          category: "Balance de vida",
          final_score: [50, 60, 70, 80, 90, 100].sample,
          answers: [
            {
              title: "respuesta 1",
              responses: 10,
              score: 100
            },
            {
              title: "respuesta 2",
              responses: 0,
              score: 0
            },

            {
              title: "respuesta 3",
              responses: 0,
              score: 0
            }
          ]
        },
        {
          title: "Pregunta 3",
          category: "Orgullo",
          final_score: [50, 60, 70, 80, 90, 100].sample,
          answers: [
            {
              title: "respuesta 1",
              responses: 10,
              score: 100
            },
            {
              title: "respuesta 2",
              responses: 0,
              score: 0
            },

            {
              title: "respuesta 3",
              responses: 0,
              score: 0
            }
          ]
        },
        {
          title: "Pregunta 4",
          category: "Orgullo",
          final_score: [50, 60, 70, 80, 90, 100].sample,
          answers: [
            {
              title: "respuesta 1",
              responses: 10,
              score: 100
            },
            {
              title: "respuesta 2",
              responses: 0,
              score: 0
            },

            {
              title: "respuesta 3",
              responses: 0,
              score: 0
            }
          ]
        },
      ]
    }
  )
end

# one_single_metric = {
#   "team_id" => 1, "date" => "21-05-2022", "value" => 75, "total_tickets" => 20, "finished_tickets" => 15, "missing_tickets" => 5
# }
# Team.all.each_with_index do |team, idx|
#   Metric.create([
#     { date: Date.tomorrow.months_ago(idx), metrics: one_single_metric.to_json, related: Team.all.sample, indicator_type: "performance" },
#   ])
# end


p "Seed... #{AccountStatus.count} AccountStatus created"
p "Seed... #{TeamType.count} TeamType created"
p "Seed... #{Tool.count} Tool created"
p "Seed... #{TechStack.count} TechStack created"
p "Seed... #{Account.count} Account created"
p "Seed... #{Payment.count} Payment created"
p "Seed... #{Project.count} Project created"
p "Seed... #{CollaboratorRepository.by_role_name("Account Manager").count} Collaborator created"
p "Seed... #{CollaboratorRepository.by_role_name("Account Manager").count} Managers created"
p "Seed... #{Team.count} Teams created"
p "Seed... #{TeamRequirement.count} Teams Requirements created"
p "Seed... #{Investment.count} Investment created"
p "Seed... #{Post.count} Posts created"
p "Seed... #{Metric.count} Metrics created"
p "Seed... #{Badge.count} Badges created"
