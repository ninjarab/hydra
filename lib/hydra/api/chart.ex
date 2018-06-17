defmodule API.Chart do
  defstruct [
    :change,
    :change_over_time,
    :change_percent,
    :close,
    :date,
    :high,
    :label,
    :low,
    :open,
    :unadjusted_volume,
    :volume,
    :vwap
  ]

  def from_json(json) do
    %__MODULE__{
      change: json["change"],
      change_over_time: json["changeOverTime"],
      change_percent: json["changePercent"],
      close: json["close"],
      date: json["date"],
      high: json["high"],
      label: json["label"],
      low: json["low"],
      open: json["open"],
      unadjusted_volume: json["unadjustedVolume"],
      volume: json["volume"],
      vwap: json["vwap"]
    }
  end
end
