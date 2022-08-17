# frozen_string_literal: true

FactoryBot.define do
    factory :survey do
      status { 1 }
      survey_url { "www.survey.com" }
      requested_answers { 10 }
      current_answers { 10 }
      deadline { Date.today + 1.months }
      period { 1 }
      questions_detail {
      {
        questions: [
          {
            title: "Pregunta 1",
            category: "Balance de vida",
            final_score: 100,
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
            final_score: 100,
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
            final_score: 100,
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
            final_score: 100,
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
          }
        ]
    }
    }
      answers_detail { "" }
      team
    end
  end
