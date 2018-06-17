defmodule Hydra.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Hydra.Repo, []),
      supervisor(HydraWeb.Endpoint, []),
      worker(Hydra.Refresh, []),
      worker(Hydra.Producer, []),
      worker(Hydra.ProducerConsumer, []),
      worker(Hydra.Consumer, [])
    ]

    opts = [strategy: :one_for_one, name: Hydra.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HydraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
