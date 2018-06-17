defmodule Queries.Chart do
  alias Kaur.Result

  def fetch(symbol) do
    API.Utils.HTTP.get("https://api.iextrading.com/1.0/stock/#{symbol}/chart/1m")
    |> Result.map(&from_json/1)
  end

  defp from_json(json) do
    json
    |> Enum.map(&API.Chart.from_json/1)
  end
end
