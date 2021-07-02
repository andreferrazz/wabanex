defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :end_date, non_null(:string)
    field :start_date, non_null(:string)
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4), description: "User"
    field :end_date, non_null(:string), description: "Trainings final date"
    field :start_date, non_null(:string), description: "Trainings start date"
    field :exercises, list_of(:create_exercise_input), description: "Exercises of the training"
  end
end
