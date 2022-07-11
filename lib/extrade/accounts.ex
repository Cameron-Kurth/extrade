defmodule ExTrade.Accounts do
  @moduledoc """
  Interface to the E*TRADE [Accounts API](https://apisb.etrade.com/docs/api/account/api-account-v1.html).
  """
  alias ExTrade.{Request, Response, Utils}
  alias ExTrade.Accounts.{Account, Balance, PortfolioResponse, Transaction, TransactionDetails}

  @doc """
  Retrieve a list of `ExTrade.Accounts.Account`s via the [List Accounts](https://apisb.etrade.com/docs/api/account/api-account-v1.html#/definition/getAllAccountList) endpoint.
  """
  @spec list_accounts() :: {:ok, [Account.t()]} | Response.error_t()
  def list_accounts() do
    url = Request.build_url("/v1/accounts/list")
    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("Account")

      response
      |> get_in(["AccountListResponse", "Accounts", "Account"])
      |> Enum.map(&module.cast/1)
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Retrieve a given `ExTrade.Accounts.Account`'s `ExTrade.Accounts.Balance` via the [Get Account Balances](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definition/getBalance) endpoint.

  _Optional Query Parameters_
  - `:acount_type`
  - `:real_time_nav`
  """
  @spec get_account_balance(String.t(), Keyword.t()) :: {:ok, Balance.t()} | Response.error_t()
  def get_account_balance(account_id_key, opts \\ []) do
    url =
      Request.build_url(
        "/v1/accounts/#{account_id_key}/balance",
        Keyword.put(opts, :institution_type, "BROKERAGE")
      )

    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("BalanceResponse")

      response
      |> get_in(["BalanceResponse"])
      |> module.cast()
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Retrieve a given `ExTrade.Accounts.Account`'s list of `ExTrade.Accounts.Transaction`s via the [List Transactions](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definition/getTransactions) endpoint.

  _Optional Query Parameters_
  - `:count`
  - `:end_date`
  - `:marker`
  - `:sort_order`
  - `:start_date`
  """
  @spec list_transactions(String.t(), Keyword.t()) ::
          {:ok, [Transaction.t()]} | Response.error_t()
  def list_transactions(account_id_key, opts \\ []) do
    url = Request.build_url("/v1/accounts/#{account_id_key}/transactions", opts)
    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("Transaction")

      response
      |> get_in(["TransactionListResponse", "Transaction"])
      |> Enum.map(&module.cast/1)
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Retrieve a given `ExTrade.Accounts.Transaction`'s `ExTrade.Accounts.TransactionDetails` via the [List Transaction Details](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definition/getTransactionDetails) endpoint.

  _Optional Query Parameters_
  - `:store_id`
  """
  @spec list_transaction_details(String.t(), integer(), Keyword.t()) ::
          {:ok, TransactionDetails.t()} | Response.error_t()
  def list_transaction_details(account_id_key, transaction_id, opts \\ []) do
    query_params = Keyword.take(opts, [:store_id])

    url =
      Request.build_url(
        "/v1/accounts/#{account_id_key}/transactions/#{transaction_id}",
        query_params
      )

    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("TransactionDetailsResponse")

      response
      |> get_in(["TransactionDetailsResponse"])
      |> module.cast()
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Retrieve a given `ExTrade.Accounts.Account`'s `ExTrade.Accounts.Portfolio` via the [View Portfolio](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definition/getPortfolio) endpoint.

  _Optional Query Parameters_
  - `:count`
  - `:lots_required`
  - `:market_session`
  - `:sort_by`
  - `:sort_order`
  - `:totals_required`
  - `:view`
  """
  @spec view_portfolio(String.t(), Keyword.t()) ::
          {:ok, PortfolioResponse.t()} | Response.error_t()
  def view_portfolio(account_id_key, opts \\ []) do
    url = Request.build_url("/v1/accounts/#{account_id_key}/portfolio", opts)
    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("PortfolioResponse")

      response
      |> get_in(["PortfolioResponse"])
      |> module.cast()
      |> then(&{:ok, &1})
    end
  end
end
