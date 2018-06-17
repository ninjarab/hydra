defmodule Hydra.TechnicalAnalysis.Trend do
  import Numerix.LinearRegression

  def estimate(company) do
    IO.puts("COMPUTING #{company.symbol}")
    with ord <- Enum.map(company.data, & &1.close),
         abs <-  1..(length(ord)) |> Enum.to_list,
        {_intercept, slope} <- fit(abs, ord)
    do
      result = interpret(slope)

      :ets.insert(:hydra, {String.first(company.symbol), company.symbol, [%{strategy: "LinearRegression", result: result}]})
    end
  end

  defp interpret(slope) when slope > 0, do: "UPTREND"
  defp interpret(_slope), do: "DOWNTREND"
end
