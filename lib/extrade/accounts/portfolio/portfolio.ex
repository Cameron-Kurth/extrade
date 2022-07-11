defmodule ExTrade.Accounts.Portfolio do
  @moduledoc """
  A struct representing an E*TRADE [AccountPortfolio](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/AccountPortfolio) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :account_id,
    :next,
    :total_pages,
    :next_page_number,
    :position
  ]
end
