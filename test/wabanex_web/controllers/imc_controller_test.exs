defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "data.csv"}

      result =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected = %{
        "result" => %{
          "André" => 18.726007303142847,
          "João" => 20.99605274208449,
          "Naruto" => 24.074074074074073
        }
      }

      assert result == expected
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "invalid-filename.csv"}

      result =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected = %{"result" => "Invalid filename"}

      assert result == expected
    end
  end
end
