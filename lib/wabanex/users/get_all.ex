defmodule Wabanex.Users.GetAll do
  alias Wabanex.Repo
  alias Wabanex.User

  def call, do: Repo.all(User)
end
