defmodule WabanexWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias WabanexWeb.Resolvers.Training, as: TrainingResolver
  alias WabanexWeb.Resolvers.User, as: UserResolver
  alias WabanexWeb.Schema.Types

  import_types Types.Custom.UUID4
  import_types Types.Training
  import_types Types.User

  object :root_query do
    field :get_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve &UserResolver.get/2
    end

    # field :get_all_user, type: list_of(:user) do
    #   resolve &UserResolver.get_all/2
    # end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :create_training, type: :training do
      arg :input, non_null(:create_training_input)

      resolve &TrainingResolver.create/2
      middleware TranslateErrors
    end
  end
end
