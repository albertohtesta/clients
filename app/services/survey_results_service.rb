class SurveyResultsService 
    attr_accessor :surveys, :result

    def initialize(surveys)
        @surveys = surveys
    end

    def convert_to_array(include_id)
        all_surveys = []  # recibe AR relation y pone surveys en arrays estructura [surveys][survey][questions]
        @surveys.each do |survey|   
          survey_data = []
          survey.questions.each do |question|
            questions = []
            questions[0] = question["title"]
            questions[1] = question["category"]
            questions[2] = question["final_score"]
            questions[3] = survey.id if include_id
            survey_data << questions
          end
          all_surveys << survey_data
        end
        all_surveys
    end

    def calc_average(surveys)   # recibe arrays de surveys y regresa array de results
      result = surveys[0]
      surveys.each_with_index do |survey, x|
        if x > 0  # procesa a partir del 2o. survey (el 1ro esta en result)
          survey.each_with_index do |questions,x|
            questions.each_with_index do |question,i|
                if i == 2      # incrementa el score en result
                  result[x][2] = result[x][2] + question
                end
            end
          end
        end
      end
      num_surveys = surveys.length
      # calcula el promedio en result
      result.each do |question|
        question[2] = question[2] / num_surveys
      end
      return result
    end


end