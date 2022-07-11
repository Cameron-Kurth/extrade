defmodule ExTrade.Accounts.OpenCall do
  @moduledoc """
  A struct representing an E*TRADE [OpenCalls](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/OpenCalls) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :min_equity_call,
    :fed_call,
    :cash_call,
    :house_call
  ]
end
