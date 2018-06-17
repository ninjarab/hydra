defmodule Hydra.Refresh do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    schedule_work()

    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :tick, 2 * 60 * 1000)
  end
end
