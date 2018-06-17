defmodule Hydra.ProducerConsumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(_) do
    {:producer_consumer, %{}, subscribe_to: [Hydra.Producer]}
  end

  def handle_subscribe(:producer, opts, from, producers) do
    pending = opts[:max_demand] || 1
    interval = opts[:interval] || 1000

    producers = Map.put(producers, from, {pending, interval})
    producers = ask_and_schedule(producers, from)

    {:manual, producers}
  end

  def handle_subscribe(:consumer, _, _, state) do
    {:automatic, state}
  end

  def handle_cancel(_, from, producers) do
    {:noreply, [], Map.delete(producers, from)}
  end

  def handle_events(events, from, producers) do
    producers = Map.update!(producers, from, fn {pending, interval} ->
      {pending + length(events), interval}
    end)

    prices = fetch_prices(events)

    {:noreply, prices, producers}
  end

  def handle_info({:ask, from}, producers) do
    {:noreply, [], ask_and_schedule(producers, from)}
  end

  defp ask_and_schedule(producers, from) do
    case producers do
      %{^from => {pending, interval}} ->
        GenStage.ask(from, pending)
        Process.send_after(self(), {:ask, from}, interval)
        Map.put(producers, from, {0, interval})
      %{} ->
        producers
    end
  end

  defp fetch_prices(events) do
    Parallel.pmap(events, fn event ->
      {:ok, data} = Queries.Chart.fetch(event.symbol)

      %{symbol: event.symbol, data: data}
    end)
  end
end
