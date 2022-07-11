defmodule ExTrade.MixProject do
  use Mix.Project

  def project do
    [
      app: :extrade,
      name: "ExTrade",
      description: "An Elixir client for interacting with the E*TRADE API.",
      version: "0.0.1",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      package: package(),
      source_url: "https://github.com/Cameron-Kurth/extrade"
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ExTrade, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:oauther, "~> 1.3"}
    ]
  end

  defp package do
    [
      maintainers: ["Cameron Kurth"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Cameron-Kurth/extrade"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end

  defp docs do
    [
      extras: [
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      API: [
        ExTrade.Accounts,
        ExTrade.Alerts,
        ExTrade.Authorization
      ],
      Accounts: [
        ExTrade.Accounts.Account,
        ExTrade.Accounts.Balance,
        ExTrade.Accounts.Brokerage,
        ExTrade.Accounts.Cash,
        ExTrade.Accounts.Category,
        ExTrade.Accounts.CompleteView,
        ExTrade.Accounts.Computed,
        ExTrade.Accounts.FundamentalView,
        ExTrade.Accounts.Lending,
        ExTrade.Accounts.Margin,
        ExTrade.Accounts.OpenCall,
        ExTrade.Accounts.OptionsWatchView,
        ExTrade.Accounts.PerformanceView,
        ExTrade.Accounts.Portfolio,
        ExTrade.Accounts.PortfolioMargin,
        ExTrade.Accounts.PortfolioResponse,
        ExTrade.Accounts.Position,
        ExTrade.Accounts.PositionLot,
        ExTrade.Accounts.Product,
        ExTrade.Accounts.ProductID,
        ExTrade.Accounts.QuickView,
        ExTrade.Accounts.RealTimeValues,
        ExTrade.Accounts.Totals,
        ExTrade.Accounts.Transaction,
        ExTrade.Accounts.TransactionDetails
      ],
      Alerts: [
        ExTrade.Alerts.Alert,
        ExTrade.Alerts.AlertDetails
      ],
      Response: [
        ExTrade.Response,
        ExTrade.Response.Error
      ]
    ]
  end
end
