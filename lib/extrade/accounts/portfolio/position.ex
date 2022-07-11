defmodule ExTrade.Accounts.Position do
  @moduledoc """
  A struct representing an E*TRADE [Position](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/Position) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :position_id,
    :account_id,
    :product,
    :osi_key,
    :symbol_description,
    :date_acquired,
    :price_paid,
    :price,
    :commissions,
    :other_fees,
    :quantity,
    :position_indicator,
    :position_type,
    :change,
    :change_percent,
    :days_gain,
    :days_gain_percent,
    :market_value,
    :total_cost,
    :total_gain,
    :total_gain_percent,
    :percent_of_portfolio,
    :cost_per_share,
    :today_commissions,
    :today_fees,
    :today_price_paid,
    :today_quantity,
    :quote_status,
    :date_time_utc,
    :adjusted_previous_close,
    :performance,
    :fundamental,
    :options_watch,
    :quick,
    :complete,
    :lots_details,
    :quote_details,
    :position_lot
  ]
end
