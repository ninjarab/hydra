defmodule Hydra.Producer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(_state) do
    :ets.new(:hydra, [:bag, :public, :named_table])
    {:ok, s} = Queries.Symbol.fetch()

    symbols = Enum.filter(s, & &1.is_enabled)
    IO.inspect(length(symbols), label: "SYMBOLS LENGTH")

    {:producer, symbols}
  end

  def handle_demand(demand, state) do
    {:noreply, state, length(state) + demand}
  end
end
