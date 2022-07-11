defmodule ExTrade.Accounts.Lending do
  @moduledoc """
  A struct representing an E*TRADE [Lending](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/Lending) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :current_balance,
    :credit_line,
    :outstanding_balance,
    :min_payment_due,
    :amount_past_due,
    :available_credit,
    :ytd_interest_paid,
    :last_ytd_interest_paid,
    :payment_due_date,
    :last_payment_received_date,
    :payment_received_mtd
  ]
end
