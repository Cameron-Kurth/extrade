defmodule ExTrade.Accounts.Totals do
  @moduledoc """
  A struct representing an E*TRADE [Totals](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/Totals) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :todays_gain_or_loss,
    :todays_gain_or_loss_percent,
    :total_market_value,
    :total_gain_or_loss,
    :total_gain_or_loss_percent,
    :total_price_paid,
    :cash_balance
  ]
end
