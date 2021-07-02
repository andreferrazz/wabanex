defmodule WabanexWeb.Resolvers.User do
  alias Wabanex.Users.Create
  alias Wabanex.Users.Get
  alias Wabanex.Users.GetAll

  def create(%{input: params}, _context), do: Create.call(params)

  def get(%{id: user_id}, _context), do: Get.call(user_id)

  def get_all(_params, _context), do: GetAll.call()
end
