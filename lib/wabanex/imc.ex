defmodule Wabanex.IMC do
  def calculate(filename) do
    filename
    |> File.read()
    |> handle_calculate()
  end

  defp handle_calculate({:ok, content}) do
    result =
      content
      |> String.split("\n")
      |> Enum.map(&parse_row/1)
      |> Enum.map(fn record -> calculate_imc(record) end)
      |> Enum.into(%{})

    {:ok, result}
  end

  defp handle_calculate({:error, _reason}) do
    {:error, "Invalid filename"}
  end

  defp parse_row(row) do
    row
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
  end

  defp calculate_imc([name, height, weight]) do
    {name, weight / (height * height)}
  end
end
