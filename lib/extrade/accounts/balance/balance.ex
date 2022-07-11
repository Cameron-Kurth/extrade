defmodule ExTrade.Accounts.Balance do
  @moduledoc """
  A struct representing an E*TRADE [BalanceResponse](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/BalanceResponse) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :account_id,
    :institution_type,
    :as_of_date,
    :option_level,
    :quote_mode,
    :day_trader_status,
    :open_calls,
    :cash,
    :margin,
    :lending,
    :computed
  ]
end
