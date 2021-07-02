defmodule Wabanex.Users.Create do
  alias Wabanex.Repo
  alias Wabanex.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
