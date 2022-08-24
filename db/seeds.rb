# frozen_string_literal: true

require "faker"

######### ADD CATALOGS FIELDS
AccountStatus.create([
  { status: "New", status_code: "new_project" }, { status: "In Development", status_code: "in_development" }, { status: "Finished", status_code: "finished" }, { status: "Cancelled", status_code: "cancelled" }
])
TeamType.create([
  { name: "POD" }, { name: "Big POD" }, { name: "Staff Augmentation" }
])
Tool.create([
  { name: "AWS" }, { name: "Rails" }, { name: "Azure" }, { name: "Cognito" }, { name: "Sentry" }
])
TechStack.create([
  { name: "AGILE COACH" },
  { name: "ANDROID DEVELOPER" },
  { name: "BACKEND DEVELOPER" },
  { name: "DEVOPS" },
  { name: "FRONTEND DEVELOPER" },
  { name: "FULL STACK DEVELOPER" },
  { name: "IOS DEVELOPER" },
  { name: "PRODUCT OWNER" },
  { name: "QUALITY ASURANCE" },
  { name: "SCRUM MASTER" },
  { name: "UX/UI" }
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
  { name: "DEVELOPER" },
  { name: "PRODUCT OWNER" },
  { name: "SCRUM MASTER" },
  { name: "QA" },
  { name: "DEVOPS" },
  { name: "UI/UX" },
  { name: "ACCOUNT MANAGER" }
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
role = Role.find_by(name: "ACCOUNT MANAGER")
Collaborator.create!([
                      {
                        id: 102,
                        first_name: "DIEGO",
                        last_name: "DE LA FUENTE",
                        uuid: Faker::IDNumber.unique.invalid,
                        email: "ddelafuente@arkusnexus.com",
                        tech_stacks: TechStack.all.sample(2),
                        tools: Tool.all.sample(2),
                        role:,
                        position: "ACCOUNT MANAGER",
                        phone: "+526646813494",
                      },
                      {
                        id: 101,
                        first_name: "HECTOR",
                        last_name: "BUSTILLOS",
                        uuid: Faker::IDNumber.unique.invalid,
                        email: "hector@michelada.io",
                        tech_stacks: TechStack.all.sample(2),
                        tools: Tool.all.sample(2),
                        role:,
                        position: "ACCOUNT MANAGER",
                        phone: "+523123236909",
                      }
                    ])

def random_price
  rand(500_000.00..10_000_000.00).round(2)
end

def account_amounts
  { balance: rand(0..100), blended_rate: random_price, gross_profit: random_price, payroll: random_price, total_expenses: random_price, total_revenue: random_price }
end

def random_salesforce_id(length, id = "")
  id = random_salesforce_id(length, id += (0..9).to_a.union(("A".."Z").to_a).sample.to_s) if id.length < length
  id
end


# **************************************
# CREATING COLLABORATORS PUBLIC PROFILES
# **************************************
role = Role.find_by(name: "DEVELOPER")

# TODO: position of this collabs need be a relation with ROLE table
Collaborator.create([
  { id: 1, seniority: "MIDDLE", english_level: "B2", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248743/Work/image_cpp_nbi_jesus_beltran_haxva4.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "JESUS ALEJANDRO", last_name: "BELTRAN\tHERNANDEZ", email: "jbeltran@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Mid developer with 3 years of experience working with clients from Mexico. Jesus has experience with some technologies and he is always looking for new things to learn. During these last 3 years he had the opportunity to implement solutions and resolve problems with software.", nickname: "JESUS", category: "DEVELOPER" },
  { id: 2, seniority: "JUNIOR", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248749/Work/image_cpp_nbi_brandom_rodriguez_cjhr8e.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "BRANDOM", last_name: "RODRIGUEZ\tBORQUEZ", email: "bborquez@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Junior developer freshly graduated from university as a software engineer with experience with agile methodologies and modern backend frameworks such as Express on Node and Flask on Python. Worked previously on teams that developed different projects, like a real estate selling app, and a classroom status monitoring system. I also developed by myself an Android app meant to help students organize their time and remind them about homeworks.", nickname: "BRANDOM", category: "DEVELOPER" },
  { id: 3, seniority: "JUNIOR", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248754/Work/image_cpp_nbi_angel_davila_sr59ea.png", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "ANGEL ARTURO", last_name: "DAVILA\tGOVEA", email: "adavila@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Engineer in software development, aiming to develop backend solutions yet focused on learning any technology required.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 4, seniority: "MIDDLE", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248756/Work/cpp_nbi_luis_ayon_twkgqa.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "ANGEL", last_name: "AYON\tLUIS", email: "layon@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Web and Desktop Software Developer. I am a passionate person in what I do, I constantly seek personal and work growth where I fulfill all the goals that are assigned to me. My hobbies are drawing, exercising, playing video games, reading articles, and playing guitar.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 5, seniority: "SENIOR", english_level: "C2", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248758/Work/image_cpp_nbi_luis_renteria_roqwlt.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "LUIS ARTURO", last_name: "RENTERIA\tTOSTADO", email: "lrenteria@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Im a developer,  I have 8 years of expierence with java developing web-based aplications also  I worked with php for 3 years developing web-basaed aplications and in the last 7 years  I gained expierence with .net and ecommerce platforms.", nickname: "LOLO", category: "DEVELOPER" },
  { id: 6, seniority: "SENIOR", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248761/Work/image_cpp_nbi_angel_espinosa_rdwsmv.jpg", work_modality: "MIXED", position: "SOFTWARE ENGINEER", first_name: "ANGEL MARIN", last_name: "RENTERIA\tTOSTADO", email: "aespinoza@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Senior Android developer with more than 8 years of experience. Angel has experience with Java and Kotlin for application development and has held a technical lead position. also has experience in some other programming languages for backend.", nickname: "ANGEL", category: "DEVELOPER" },
  { id: 7, seniority: "MIDDLE", english_level: "B2", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248764/Work/image_cpp_nbi_francisco_escobar_tqgmk1.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "FRANCISCO EDUARDO", last_name: "ESCOBAR\tESPINOSA", email: "paco.escobar@michelada.io", role:, uuid: Faker::IDNumber.unique.invalid, about: "Mid developer with 4 year of experience working in Swift, 1 years with Objective-C and React Native and currently learning SwiftUI. Francisco loves to learn new things and he's not afraid to take on challenges, learn quickly and adapt to whatever the client needs", nickname: "PACO", category: "DEVELOPER" },
  { id: 8, seniority: "MIDDLE", english_level: "B1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248767/Work/image_cpp_nbi_fernanda_cerezo_skve3v.jpg", work_modality: "REMOTE", position: "SOFTWARE ENGINEER", first_name: "MARIA FERNANDA", last_name: "CEREZO\tGOMEZ", email: "mcerezo@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Fernanda is a developer with 2 year of experience and has worked with clients from both the US and Mexico. Fernanda has experience with several technologies and she is always looking for new challenges. During these recent years she had the opportunity to implement solutions and resolve problems with software.", nickname: "FERNANDA", category: "DEVELOPER" },
  { id: 9, seniority: "MIDDLE", english_level: "B2", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248772/Work/image_cpp_nbi_miguel_felix_uzudzd.png", work_modality: "REMOTE", position: "PRODUCT OWNER", first_name: "MIGUEL ANGEL", last_name: "FELIX\tGARCIA", email: "mfelix@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Product Owner and Scrum Master with +10 years of experience and has worked with clients from Mexico. Experience being the bridge between the clients and the developers. During these years he had the opportunity to implement solutions and resolve problems with client requirements.", nickname: "MIKE", category: "MANAGER" },
  { id: 200, seniority: "MIDDLE", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248776/Work/image_cpp_nbi_jon_hernandez_dipxfn.png", work_modality: "REMOTE", position: "PRODUCT OWNER", first_name: "JONATHAN", last_name: "RUBEN\tHERNANDEZ", email: "jrhernandez@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Product Owner with certifications as a scrum master, design thinking, and kanban. +5 years of experience working with agile frameworks and 3 years working as a .Net developer (Back and front). Collecting  software requirements. Defining user stories, Setting acceptance criteria, defining the minimum viable product and the release plan, adding value focuss on results.", nickname: "JON", category: "MANAGER" },
  { id: 201, seniority: "MIDDLE", english_level: "C1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248781/Work/image_cpp_nbi_micaela_cruz_qlq2f7.jpg", work_modality: "REMOTE", position: "QA ENGINEER", first_name: "MICAELA MARIA", last_name: "CRUZ\tILLESCAS", email: "milescas@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Micaela, as a bicultural person, has worked with clients from both the US and Mexico. Has experience with several technologies and she is always looking for new challenges. During these recent years she had the opportunity to work for Arkusnexus as a manual QA tester for mobile apps. added 10.3 years of QA experience, 23 years of development for Mainframes and middlewares using different programming languages and methodologies and a year as Planning Center Lead.", nickname: "MICAELA", category: "TESTER" },
  { id: 202, seniority: "SENIOR", english_level: "C2", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248785/Work/image_cpp_nbi_jithin_chturala_qh6gwn.jpg", work_modality: "REMOTE", position: "QA ENGINEER", first_name: "JITHIN", last_name: "CHERUTALA", email: "jcheruthala@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "Over ten years of proven experience in advising clients on test automation strategy, setting direction for long-term automation plans, bringing in best practices, and RoI evaluation and Possess in-depth knowledge of multiple open source/commercial tools for Web test automation (Selenium, QTP/ UFT, etc.) and Mobile test automation.", nickname: "JITHIN", category: "TESTER" },
  { id: 203, seniority: "SENIOR", english_level: "B1", profile: "https://res.cloudinary.com/djd2dcqmc/image/upload/v1660248788/Work/image_cpp_nbi_leopoldo_chiquete_jbuxjr.jpg", work_modality: "MIXED", position: "SCRUM MASTER", first_name: "LEOPOLDO", last_name: "CHIQUETE\tZAZUETA", email: "lchiquete@arkusnexus.com", role:, uuid: Faker::IDNumber.unique.invalid, about: "I had been working in Arkusnexus for 10 years in several projects with differents clients from both the US and Mexico, as developer until leading a whole team, he always is developing his knowledge and acquiring multiple skills, his ability to learn new things and the desire of always looking new challenges.", nickname: "CHIQUETE", category: "MANAGER" }
])

Collaborator.find(1).update(badges: Badge.where({ id: [9, 11, 13, 17] }))
Collaborator.find(2).update(badges: Badge.where({ id: [7, 9, 10, 11, 14] }))
Collaborator.find(3).update(badges: Badge.where({ id: [1, 7, 8, 11, 14, 17] }))
Collaborator.find(4).update(badges: Badge.where({ id: [7, 11, 14, 17] }))
Collaborator.find(5).update(badges: Badge.where({ id: [7, 11, 14] }))
Collaborator.find(6).update(badges: Badge.where({ id: [7, 11, 14, 17] }))
Collaborator.find(7).update(badges: Badge.where({ id: [1, 2, 3, 11] }))



# ****************************************************************************
# CREATING ADVANTA ACCOUNT DATA FOR QA
# ****************************************************************************
advanta = Account.create(
  { account_uuid: Faker::IDNumber.unique.invalid, manager: managers.sample, name: "ADVANTA", contact_name: Faker::Name.unique.name, contact_email: Faker::Internet.unique.email, contact_phone: Faker::PhoneNumber.unique.phone_number, account_status_id: AccountStatus.first.id, salesforce_id: random_salesforce_id(15), city: locations.sample, client_satisfaction: rand(0..100), moral: rand(0..100), bugs_detected: rand(0..100), permanence: rand(0..100), productivity: rand(0..100), speed: rand(0..100) }.merge(account_amounts)
)
project_advanta = Project.create(
  { name: advanta.name, start_date: Faker::Date.between(from: 10.months.ago, to: 5.months.ago), description: "ADVANTA PROJECT", account_id: advanta.id, tech_stacks: TechStack.all.sample(3), tools: Tool.all.sample(2) }
)
advanta_collaborators = Collaborator.create([
  { id: 10, role:, position: "PRODUCT OWNER", first_name: "DIEGO", last_name: "MEDRANO", email: "dmorales@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Diego+Medrano.jfif", seniority: "SENIOR", uuid: "93de193e-2270-11ed-861d-0242ac120002" },
  { id: 11, role:, position: "SCRUM MASTER", first_name: "RAUL", last_name: "GALVAN", email: "rrodrigo@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Raul+Galvan.jfif", seniority: "SENIOR", uuid: "93de339c-2270-11ed-861d-0242ac120002" },
  { id: 12, role:, position: "SOFTWARE ENGINEER", first_name: "EDGAR", last_name: "ALCANTARA", email: "ealcantara@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Edgar+Alcantara.jfif", seniority: "MIDDLE", uuid: "93de1b0a-2270-11ed-861d-0242ac120002" },
  { id: 13, role:, position: "SOFTWARE ENGINEER", first_name: "ROBERTO", last_name: "GALVAN", email: "rgalvan@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Roberto+Galvan.jfif", seniority: "SENIOR", uuid: "93de32c0-2270-11ed-861d-0242ac120002" },
  { id: 14, role:, position: "SOFTWARE ENGINEER", first_name: "LILO", last_name: "FLORES", email: "lflores@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Lilo+Flores.jfif", seniority: "SENIOR", uuid: "93de2816-2270-11ed-861d-0242ac120002" },
  { id: 15, role:, position: "QA ENGINEER", first_name: "OMAR", last_name: "GONZALEZ", email: "ogonzalez@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Omar+Gonazalez.jfif", seniority: "MIDDLE", uuid: "ogonzalez@arkusnexus.com" },
  { id: 16, role:, position: "SOFTWARE ENGINEER", first_name: "FERNANDO", last_name: "FUENTES", email: "lfuentes@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Fernando+Fuentes.jfif", seniority: "MIDDLE", uuid: "93de2a46-2270-11ed-861d-0242ac120002" },
  { id: 17, role:, position: "SOFTWARE ENGINEER", first_name: "JORGE", last_name: "JIMENEZ", email: "aljimenez@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Jorge+Alejandro.jfif", seniority: "MIDDLE", uuid: "93de13c6-2270-11ed-861d-0242ac120002" }
])
team_advanta = Team.create(
  {
    added_date: project_advanta.start_date,
    team_type_id: TeamType.find_by({ name: "POD" }).id,
    collaborators: advanta_collaborators,
    project: project_advanta,
    board_id: 8
  }
)
Metric.create([
  # PERFORMANCE
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 89 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 66 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 96 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "performance", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 85 }.to_json },
  # VELOCITY
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 207 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 77 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 92 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "velocity", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 85 }.to_json },
  # MORALE
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "morale", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 62 }.to_json },
  # BALANCE
  { date: "15-01-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-01-2022", "value" => 0 }.to_json },
  { date: "15-02-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-02-2022", "value" => 0 }.to_json },
  { date: "15-03-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-03-2022", "value" => 0 }.to_json },
  { date: "15-04-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-04-2022", "value" => 0 }.to_json },
  { date: "15-05-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-05-2022", "value" => 0 }.to_json },
  { date: "15-06-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-06-2022", "value" => 0 }.to_json },
  { date: "15-07-2022".to_date, related: team_advanta, indicator_type: "balance", metrics: { "team_id" => team_advanta.id, "date" => "15-07-2022", "value" => 0 }.to_json }
])
team_advanta.investments.create([
  { value: 55000.00, date: "15-01-2022".to_date },
  { value: 55000.00, date: "15-02-2022".to_date },
  { value: 60000.00, date: "15-03-2022".to_date },
  { value: 70000.00, date: "15-04-2022".to_date },
  { value: 70000.00, date: "15-05-2022".to_date },
  { value: 60000.00, date: "15-06-2022".to_date },
  { value: 60000.00, date: "15-07-2022".to_date }
])


# **************************************
# CREATING CUSTOMER CONTACT DATA
# **************************************

Contact.create ([
          {
            first_name: "ANGEL",
            last_name: "SANCHEZ",
            email: "asanchez@arkus-solutions.com",
            account_id: advanta.id
          },
          {
            first_name: "ARMANDO",
            last_name: "TEJEDA",
            email: "atejeda@arkus-solutions.com",
            account_id:	advanta.id
          },
          {
            first_name: "JONATHAN",
            last_name: "HERNANDEZ",
            email: "jrhernandez@arkusnexus.com",
            account_id: advanta.id
          }
        ])


# ****************************************************************************
# CREATING BREAKTHROGHT BROKER ACCOUNT DATA FOR QA
# ****************************************************************************
broker = Account.create(
  { manager: managers.sample, name: "Breakthrough Broker", contact_name: Faker::Name.unique.name, contact_email: Faker::Internet.unique.email, contact_phone: Faker::PhoneNumber.unique.phone_number, account_status_id: AccountStatus.first.id, account_uuid: Faker::IDNumber.unique.invalid, salesforce_id: random_salesforce_id(15), city: locations.sample, client_satisfaction: rand(0..100), moral: rand(0..100), bugs_detected: rand(0..100), permanence: rand(0..100), productivity: rand(0..100), speed: rand(0..100) }.merge(account_amounts)
)
project_broker = Project.create(
  { name: broker.name, start_date: Faker::Date.between(from: 10.months.ago, to: 5.months.ago), description: "breakthrough_broker project", account_id: broker.id, tech_stacks: TechStack.all.sample(3), tools: Tool.all.sample(2) }
)

AccountContactCollaborator.create!([
  { account_id: advanta.id, collaborator_id: 101 },
  { account_id: broker.id, collaborator_id: 102 }
])

broker_collaborators = Collaborator.create!([
  { id: 20, role:, position: "SCRUM MASTER", first_name: "DELIA", last_name: "ESCOBAR", email: "docampo@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Escobar+Ocampo+Delia.jfif", seniority: "MIDDLE", uuid: "93de1a24-2270-11ed-861d-0242ac120002" },
  { id: 21, role:, position: "SOFTWARE ENGINEER", first_name: "MARIO", last_name: "DE JESUS", email: "mdejesus@arkusnexus.com", seniority: "SENIOR", uuid: "93de2ce4-2270-11ed-861d-0242ac120002" },
  { id: 22, role:, position: "SOFTWARE ENGINEER", first_name: "OCTAVIO", last_name: "CORNEJO", email: "ocornejo@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Octavio+Cornejo+Trujillo.png", seniority: "MIDDLE", uuid: "93de302c-2270-11ed-861d-0242ac120002" },
  { id: 23, role:, position: "QA ENGINEER", first_name: "FRANCISCO", last_name: "PEREZ", email: "fdelarosa@arkusnexus.com", seniority: "MIDDLE", uuid: "93de2032-2270-11ed-861d-0242ac120002" },
  { id: 24, role:, position: "SOFTWARE ENGINEER", first_name: "MARIO", last_name: "CORTES", email: "acortes@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Cortes+Munos+Mario+Alberto.jfif", seniority: "MIDDLE", uuid: "93de0f0c-2270-11ed-861d-0242ac120002" },
  { id: 25, role:, position: "SOFTWARE ENGINEER", first_name: "EDGAR", last_name: "REYES", email: "ereyes@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Reyes+Flores+Edgar+Noe.jfif", seniority: "MIDDLE", uuid: "93de1f4c-2270-11ed-861d-0242ac120002" },
  { id: 26, role:, position: "SOFTWARE ENGINEER", first_name: "JUAN", last_name: "CHAVEZ", email: "jgamez@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/Juan+Chavez+Gamez.PNG", seniority: "JUNIOR", uuid: "93de2564-2270-11ed-861d-0242ac120002" },
  { id: 27, role:, position: "SOFTWARE ENGINEER", first_name: "CARLOS", last_name: "LOPEZ", email: "cvillanueva@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/LOPEZ+VILLANUEVA+CARLOS+ENRIQUE.jfif", seniority: "JUNIOR", uuid: "93de1592-2270-11ed-861d-0242ac120002" },
  { id: 28, role:, position: "SOFTWARE ENGINEER", first_name: "GABRIEL", last_name: "SALAS", email: "gsalas@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/SALAS+ROMO+GABRIEL+EMMANUEL.jfif", seniority: "JUNIOR", uuid: "93de210e-2270-11ed-861d-0242ac120002" },
  { id: 29, role:, position: "SOFTWARE ENGINEER", first_name: "DANTE", last_name: "BARBOZA", email: "dbarboza@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/BARBOZA+LOPEZ+DANTE+GAMALIEL.jfif", seniority: "JUNIOR", uuid: "93de1772-2270-11ed-861d-0242ac120002" },
  { id: 30, role:, position: "UX/UI", first_name: "ELBA", last_name: "ECHEVARRIA", email: "eechevarria@arkusnexus.com", profile: "https://nrdn-s3-qastack-s3qa61dc0f4a5c5b192856ecb6eabucke-1hdholr13v0ni.s3.us-west-1.amazonaws.com/collaborators/ECHEVARRIA+ORNELAS+ELBA.jfif", seniority: "JUNIOR", uuid: "93de1e52-2270-11ed-861d-0242ac120002" }
])
team_broker = Team.create(
  { added_date: project_broker.start_date, team_type_id: TeamType.find_by({ name: "POD" }).id, collaborators: broker_collaborators, project: project_broker, board_id: 18 }
)
Metric.create([
  # PERFORMANCE
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 105 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 103 }.to_json },
  { date: "15-07-2022".to_date, related: team_broker, indicator_type: "performance", metrics: { "team_id" => team_broker.id, "date" => "15-07-2022", "value" => 91 }.to_json },
  # VELOCITY
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 192 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 130 }.to_json },
  { date: "15-07-2022".to_date, related: team_broker, indicator_type: "velocity", metrics: { "team_id" => team_broker.id, "date" => "15-07-2022", "value" => 142 }.to_json },
  # MORALE
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "morale", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 82 }.to_json },
  # BALANCE
  { date: "15-01-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-01-2022", "value" => 69 }.to_json },
  { date: "15-02-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-02-2022", "value" => 69 }.to_json },
  { date: "15-03-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-03-2022", "value" => 69 }.to_json },
  { date: "15-04-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-04-2022", "value" => 69 }.to_json },
  { date: "15-05-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-05-2022", "value" => 69 }.to_json },
  { date: "15-06-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-06-2022", "value" => 69 }.to_json },
  { date: "15-07-2022".to_date, related: team_broker, indicator_type: "balance", metrics: { "team_id" => team_broker.id, "date" => "15-07-2022", "value" => 69 }.to_json }
])
team_broker.investments.create([
  { value: 70000.00, date: "15-01-2022".to_date },
  { value: 70000.00, date: "15-02-2022".to_date },
  { value: 70000.00, date: "15-03-2022".to_date },
  { value: 70000.00, date: "15-04-2022".to_date },
  { value: 60000.00, date: "15-05-2022".to_date },
  { value: 60000.00, date: "15-06-2022".to_date }
])

# **************************************
# CREATING CUSTOMER CONTACT DATA
# **************************************

Contact.create ([
          { first_name: "ANGEL", last_name: "SANCHEZ", email: "asanchez@arkus-solutions.com", account_id: broker.id },
          { first_name: "ARMANDO", last_name: "TEJEDA", email: "atejeda@arkus-solutions.com", account_id:	broker.id					},
          { first_name: "JONATHAN", last_name: "HERNANDEZ", email: "jrhernandez@arkusnexus.com", account_id: broker.id },
          { first_name: "EDUARDO", last_name: "DE LA TORRE", email: "etorre@arkusnexus.com", account_id: broker.id }
        ])


posts_for_collaborators = []
CollaboratorRepository.by_role_name("DEVELOPER").all.each do |collaborator|
  posts_for_collaborators << {
    title: Faker::Name.unique.name,
    description: Faker::Lorem.sentence,
    collaborator_id: collaborator.id,
    project_id: collaborator.teams&.first&.project&.id
  }
end
Post.create(posts_for_collaborators)




p "Seed... #{AccountStatus.count} AccountStatus created"
p "Seed... #{TeamType.count} TeamType created"
p "Seed... #{Tool.count} Tool created"
p "Seed... #{TechStack.count} TechStack created"
p "Seed... #{Account.count} Account created"
p "Seed... #{Payment.count} Payment created"
p "Seed... #{Project.count} Project created"
p "Seed... #{Collaborator.count} Collaborator created"
p "Seed... #{CollaboratorRepository.by_role_name("ACCOUNT MANAGER").count} Managers created"
p "Seed... #{Team.count} Teams created"
p "Seed... #{TeamRequirement.count} Teams Requirements created"
p "Seed... #{Investment.count} Investment created"
p "Seed... #{Post.count} Posts created"
p "Seed... #{Metric.count} Metrics created"
p "Seed... #{Badge.count} Badges created"
