defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  describe "changeset/1" do
    test "when the given parameters are valid, returns a valid changeset" do
      params = %{name: "Test", email: "test@mail.com", password: "123456"}

      result = Wabanex.User.changeset(params)

      _expected = %Ecto.Changeset{
        valid?: true,
        errors: [],
        changes: %{email: "test@mail.com", name: "Test", password: "123456"}
      }

      assert _expected = result
    end

    test "when an invalid name is given, returns a invalid changeset" do
      params = %{name: "T", email: "test@mail.com", password: "123456"}

      result =
        params
        |> Wabanex.User.changeset()
        |> errors_on()

      expected_errors = %{name: ["should be at least 2 character(s)"]}

      assert result == expected_errors
    end

    test "when an invalid email is given, returns a invalid changeset" do
      params = %{name: "Test", email: "testmail.com", password: "123456"}

      result =
        params
        |> Wabanex.User.changeset()
        |> errors_on()

      expected_errors = %{email: ["has invalid format"]}

      assert result == expected_errors
    end

    test "when an invalid password is given, returns a invalid changeset" do
      params = %{name: "Test", email: "test@mail.com", password: "12345"}

      result =
        params
        |> Wabanex.User.changeset()
        |> errors_on()

      expected_errors = %{password: ["should be at least 6 character(s)"]}

      assert result == expected_errors
    end
  end
end
