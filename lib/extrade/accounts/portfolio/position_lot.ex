defmodule ExTrade.Accounts.PositionLot do
  @moduledoc """
  A struct representing an E*TRADE [PositionLot](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/PositionLot) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :position_id,
    :position_lot_id,
    :price,
    :term_code,
    :days_gain,
    :days_gain_percent,
    :market_value,
    :total_cost,
    :total_gain,
    :total_cost_for_percent,
    :lot_source_code,
    :original_qty,
    :remaining_qty,
    :available_qty,
    :order_number,
    :leg_number,
    :acquired_date,
    :location_code,
    :exchange_rate,
    :settlement_currency,
    :payment_currency,
    :adjusted_price,
    :commissions_per_share,
    :fees_per_share,
    :adjusted_premium,
    :short_type
  ]
end
