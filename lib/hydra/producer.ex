defmodule Hydra.Producer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state), do: {:producer, state}

  def handle_demand(demand, _state) do
    {:ok, symbols} = Queries.Symbol.fetch()

    {:noreply, symbols, length(symbols) + demand}
  end
end
