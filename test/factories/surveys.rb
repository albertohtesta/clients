FactoryBot.define do
  factory :survey do
    status { 0 }
    survey_monkey_url { "www.surveymonkey.com" }
    requested_answers { 1 }
    current_answers { 1 }
    deadline { "2022-07-29" }
    period { 1 }
    questions_detail { "" }
    team
  end
end
