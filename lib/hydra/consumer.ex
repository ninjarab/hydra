defmodule Hydra.Consumer do
  use GenStage

  import Numerix.LinearRegression

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Hydra.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    Parallel.pmap(events, fn event ->
      ord = Enum.map(event.data, & &1.close)
      abs = 1..(length(ord)) |> Enum.to_list
      {_intercept, slope} = fit(abs, ord)

      interpret(slope, event.symbol)
    end)

    {:noreply, [], state}
  end

  defp interpret(slope, symbol) when slope > 0, do: IO.inspect(slope, label: "UPTREND for #{symbol}")
  defp interpret(slope, symbol), do: IO.inspect(slope, label: "DOWNTREND for #{symbol}")
end
