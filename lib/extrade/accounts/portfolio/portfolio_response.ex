defmodule ExTrade.Accounts.PortfolioResponse do
  @moduledoc """
  A struct representing an E*TRADE [PortfolioResponse](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/PortfolioResponse) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :totals,
    :account_portfolio
  ]
end
