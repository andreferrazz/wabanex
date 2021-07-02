defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  describe "calculate/1" do
    test "when the given file exists, returns the data" do
      filename = "data.csv"

      result = Wabanex.IMC.calculate(filename)

      expected =
        {:ok,
         %{
           "André" => 18.726007303142847,
           "João" => 20.99605274208449,
           "Naruto" => 24.074074074074073
         }}

      assert result == expected
    end

    test "when the given file doesn't exists, returns an error" do
      filename = "invalid.csv"

      result = Wabanex.IMC.calculate(filename)

      expected = {:error, "Invalid filename"}

      assert result == expected
    end
  end
end
