defmodule API.Utils.HTTP do
  alias Kaur.Result
  
  def get(url) do
    HTTPoison.get(url)
    |> Result.and_then(&fetch_body/1)
    |> Result.map_error(&handle_api_error/1)
  end

  defp fetch_body(http_response = %HTTPoison.Response{status_code: code})
       when code >= 200 and code < 300 do
    http_response
    |> Map.fetch(:body)
    |> Result.and_then(&Poison.decode/1)
  end

  defp fetch_body(http_response = %HTTPoison.Response{status_code: code}) when code >= 400 do
    http_response
    |> Map.fetch(:body)
    |> Result.and_then(&Poison.decode/1)
    |> Result.and_then(&Result.error({:api_error, &1}))
  end

  defp handle_api_error(error), do: error
end
