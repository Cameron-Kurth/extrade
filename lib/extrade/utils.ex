defmodule ExTrade.Utils do
  @moduledoc false

  @spec format_date(integer()) :: nil | DateTime.t()
  def format_date(0), do: nil
  def format_date(unix), do: unix |> format_datetime() |> DateTime.to_date()

  @spec format_datetime(integer()) :: nil | DateTime.t()
  def format_datetime(0), do: nil
  def format_datetime(unix), do: DateTime.from_unix!(unix)

  @spec format_key(String.t()) :: atom()
  def format_key("adjLastTrade"), do: :adjusted_last_trade
  def format_key("adjPrevClose"), do: :adjusted_previous_close
  def format_key("adjPrice"), do: :adjusted_price
  def format_key("availExcessEquity"), do: :available_excess_equity
  def format_key("callPut"), do: :option_type
  def format_key("commPerShare"), do: :commissions_per_share
  def format_key("dateTimeUTC"), do: :date_time_utc
  def format_key("deliverablesStr"), do: :deliverables
  def format_key("delta52WkHigh"), do: :delta_52_week_high
  def format_key("delta52WkLow"), do: :delta_52_week_low
  def format_key("divPayDate"), do: :dividend_payable_date
  def format_key("divYield"), do: :dividend_yield
  def format_key("dtCashOpenOrderReserve"), do: :cash_open_order_reserve
  def format_key("dtMarginOpenOrderReserve"), do: :margin_open_order_reserve
  def format_key("estEarnings"), do: :estimated_earnings
  def format_key("fundsForOpenOrdersCash"), do: :funds_for_open_orders
  def format_key("instType"), do: :institution_type
  def format_key("ivPct"), do: :implied_volatility_percent
  def format_key("marginable"), do: :is_marginable
  def format_key("moneyMktBalance"), do: :money_market_balance
  def format_key("msgText"), do: :message
  def format_key("netMv"), do: :net_market_value
  def format_key("netMvLong"), do: :net_market_value_long
  def format_key("netMvShort"), do: :net_market_value_short
  def format_key("pctOfPortfolio"), do: :percent_of_portfolio
  def format_key("perform1Month"), do: :performance_1_month
  def format_key("perform3Month"), do: :performance_3_month
  def format_key("perform6Month"), do: :performance_6_month
  def format_key("perform12Month"), do: :performance_12_month
  def format_key("premiumAdj"), do: :adjusted_premium
  def format_key("prev"), do: :previous
  def format_key("prevClose"), do: :previous_close
  def format_key("prevDayVolume"), do: :previous_day_volume
  def format_key("regtEquity"), do: :reg_t_equity
  def format_key("regtEquityPercent"), do: :reg_t_equity_percent
  def format_key("shareWorksAccount"), do: :is_shareworks_account
  def format_key("shortAdjustBalance"), do: :short_adjusted_balance
  def format_key("sv10DaysAvg"), do: :stochastic_volatility_10_day_avg
  def format_key("sv20DaysAvg"), do: :stochastic_volatility_20_day_avg
  def format_key("sv1MonAvg"), do: :stochastic_volatility_1_month_avg
  def format_key("sv2MonAvg"), do: :stochastic_volatility_2_month_avg
  def format_key("sv3MonAvg"), do: :stochastic_volatility_3_month_avg
  def format_key("sv4MonAvg"), do: :stochastic_volatility_4_month_avg
  def format_key("sv6MonAvg"), do: :stochastic_volatility_6_month_avg
  def format_key("tenDayVolume"), do: :volume_10_day
  def format_key("totalMarginRqmts"), do: :total_margin_requirements
  def format_key("unSettledCashForInvestment"), do: :unsettled_cash_for_investment

  def format_key(key) do
    cond do
      String.contains?(key, "GainLoss") ->
        key |> String.replace("GainLoss", "GainOrLoss") |> format_key()

      String.slice(key, -4..-1) == "Desc" ->
        key |> String.replace("Desc", "Description") |> format_key()

      String.slice(key, -3..-1) == "Pct" ->
        key |> String.replace("Pct", "Percent") |> format_key()

      String.slice(key, -2..-1) == "No" ->
        key |> String.replace("No", "Number") |> format_key()

      true ->
        key |> Macro.underscore() |> String.to_existing_atom()
    end
  end

  @spec format_value(String.t(), any()) :: any()
  def format_value(key, value) when is_integer(value) do
    cond do
      key |> String.downcase() |> String.slice(-4..-1) == "date" ->
        format_date(value)

      key |> String.downcase() |> String.slice(-4..-1) == "time" ->
        format_datetime(value)

      key |> String.downcase() |> String.slice(-3..-1) == "utc" ->
        format_datetime(value)

      true ->
        value
    end
  end

  def format_value(key, value) do
    module = object_name_to_module(key)

    if module do
      module.cast(value)
    else
      value
    end
  end

  # Object names are not always cased in the response payload, so this performs a
  # case-insensitive check on the object name key
  @spec object_name_to_module(String.t()) :: module() | nil
  def object_name_to_module(name), do: name |> String.downcase() |> ci_object_name_to_module()

  # Accounts
  defp ci_object_name_to_module("account"), do: ExTrade.Accounts.Account
  defp ci_object_name_to_module("accountportfolio"), do: ExTrade.Accounts.Portfolio
  defp ci_object_name_to_module("balanceresponse"), do: ExTrade.Accounts.Balance
  defp ci_object_name_to_module("brokerage"), do: ExTrade.Accounts.Brokerage
  defp ci_object_name_to_module("cash"), do: ExTrade.Accounts.Cash
  defp ci_object_name_to_module("category"), do: ExTrade.Accounts.Category
  defp ci_object_name_to_module("complete"), do: ExTrade.Accounts.CompleteView
  defp ci_object_name_to_module("computed"), do: ExTrade.Accounts.Computed
  defp ci_object_name_to_module("fundamental"), do: ExTrade.Accounts.FundamentalView
  defp ci_object_name_to_module("lending"), do: ExTrade.Accounts.Lending
  defp ci_object_name_to_module("margin"), do: ExTrade.Accounts.Margin
  defp ci_object_name_to_module("opencalls"), do: ExTrade.Accounts.OpenCall
  defp ci_object_name_to_module("optionswatch"), do: ExTrade.Accounts.OptionsWatchView
  defp ci_object_name_to_module("performance"), do: ExTrade.Accounts.PerformanceView
  defp ci_object_name_to_module("portfoliomargin"), do: ExTrade.Accounts.PortfolioMargin
  defp ci_object_name_to_module("portfolioresponse"), do: ExTrade.Accounts.PortfolioResponse
  defp ci_object_name_to_module("position"), do: ExTrade.Accounts.Position
  defp ci_object_name_to_module("positionlot"), do: ExTrade.Accounts.PositionLot
  defp ci_object_name_to_module("product"), do: ExTrade.Accounts.Product
  defp ci_object_name_to_module("productid"), do: ExTrade.Accounts.ProductID
  defp ci_object_name_to_module("quick"), do: ExTrade.Accounts.QuickView
  defp ci_object_name_to_module("realtimevalues"), do: ExTrade.Accounts.RealTimeValues
  defp ci_object_name_to_module("totals"), do: ExTrade.Accounts.Totals
  defp ci_object_name_to_module("transaction"), do: ExTrade.Accounts.Transaction

  defp ci_object_name_to_module("transactiondetailsresponse"),
    do: ExTrade.Accounts.TransactionDetails

  # Alerts
  defp ci_object_name_to_module("alert"), do: ExTrade.Alerts.Alert
  defp ci_object_name_to_module("alertdetailsresponse"), do: ExTrade.Alerts.AlertDetails

  defp ci_object_name_to_module(_), do: nil
end
