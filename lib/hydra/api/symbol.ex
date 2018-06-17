defmodule API.Symbol do
  defstruct [:symbol, :date, :name, :is_enabled]

  def from_json(json) do
    %__MODULE__{
      symbol: json["symbol"],
      date: json["date"],
      name: json["name"],
      is_enabled: json["isEnabled"]
    }
  end
end
