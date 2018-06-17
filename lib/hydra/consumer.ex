defmodule Hydra.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Hydra.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    Parallel.pmap(events, &Hydra.TechnicalAnalysis.Trend.estimate/1)

    {:noreply, [], state}
  end
end
