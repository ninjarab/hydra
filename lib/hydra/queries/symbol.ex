defmodule Queries.Symbol do
  alias Kaur.Result

  def fetch do
    API.Utils.HTTP.get("https://api.iextrading.com/1.0/ref-data/symbols")
    |> Result.map(&from_json/1)
  end

  defp from_json(json) do
    json
    |> Enum.map(&API.Symbol.from_json/1)
  end
end
