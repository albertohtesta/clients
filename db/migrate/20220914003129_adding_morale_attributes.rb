class AddingMoraleAttributes < ActiveRecord::Migration[7.0]
  def change
    attributes =
    {
      "IMPARCIALIDAD" => ["question01", "question02" ],
      "COMPAÑERISMO" => ["question03"],
      "RELACION CON LIDER" => ["question04"],
      "RELACION CON CLIENTE" => ["question05"],
      "BALANCE DE VIDA" => ["question06"],
      "HERRAMIENTAS DE TRABAJO" => ["question07"],
      "ORGULLO" => ["question08"],
      "RETOS PROFESIONALES" => ["question09"],
      "PLAN DE CARRERA" => ["question10"]
    }

    attributes.each do |attribute, questions|
      attribute_in_table = MoraleAttribute.where(name: attribute).first_or_initialize
      attribute_in_table.update(name: attribute)
      questions.each do |question|
        question_in_table = SurveyQuestion.where(question:).first_or_initialize
        question_in_table.update(question:, morale_attribute: attribute_in_table)
      end
    end
    puts "Morale Attributes created!!"
  end
end
