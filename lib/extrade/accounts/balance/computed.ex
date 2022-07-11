defmodule ExTrade.Accounts.Computed do
  @moduledoc """
  A struct representing an E*TRADE [ComputedBalance](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/ComputedBalance) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :cash_available_for_investment,
    :cash_available_for_withdrawal,
    :total_available_for_withdrawal,
    :net_cash,
    :cash_balance,
    :settled_cash_for_investment,
    :unsettled_cash_for_investment,
    :funds_withheld_from_purchase_power,
    :funds_withheld_from_withdrawal,
    :margin_buying_power,
    :cash_buying_power,
    :margin_balance,
    :short_adjusted_balance,
    :reg_t_equity,
    :reg_t_equity_percent,
    :account_balance,
    :open_calls,
    :real_time_values,
    :portfolio_margin
  ]
end
