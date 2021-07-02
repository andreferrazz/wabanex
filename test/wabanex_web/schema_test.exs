defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "test@mail.com", name: "Test", password: "123456"}

      {:ok, %User{id: id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{id}"){
            id
            name
            email
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "getUser" => %{
                   "email" => "test@mail.com",
                   "id" => _id,
                   "name" => "Test"
                 }
               }
             } = result
    end

    test "when an invalid id is given, returns an error", %{conn: conn} do
      query = """
        {
          getUser(id: "invalid-id"){
            id
            name
            email
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 13, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"invalid-id\"."
          }
        ]
      }

      assert result == expected
    end

    test "when the user is not found, returns an error", %{conn: conn} do
      query = """
        {
          getUser(id: "00028430-b334-442a-bd56-67c666ae89c8"){
            id
            name
            email
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "errors" => [
          %{
            "locations" => [
              %{"column" => 5, "line" => 2}
            ],
            "message" => "User not found ",
            "path" => ["getUser"]
          }
        ],
        "data" => %{"getUser" => nil}
      }

      assert result == expected
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Test"
            email: "test@wabanex.com"
            password: "123456"
          }) {
            id
            name
            email
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "email" => "test@wabanex.com",
                   "id" => _id,
                   "name" => "Test"
                 }
               }
             } = result
    end
  end
end
