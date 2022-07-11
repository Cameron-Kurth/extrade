defmodule ExTrade.Accounts.TransactionDetails do
  @moduledoc """
  A struct representing an E*TRADE [TransactionDetailsResponse](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definition/getTransactionDetails) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :transaction_id,
    :account_id,
    :transaction_date,
    :post_date,
    :amount,
    :description,
    :category,
    :brokerage
  ]
end
