defmodule ExTrade do
  @moduledoc """
  ExTrade is an Elixir client library for interacting with the [E*TRADE API](https://developer.etrade.com/home).

  ExTrade manages current authorization state (e.g., request and access tokens) in a supervised process,
  which serves as an in-memory data store for constructing the necessary "Authorization" header for each API request,
  per the [OAuth 1.0](https://oauth.net/core/1.0a) specification that E*TRADE follows.
  """
  use Application
  import ExTrade.Utils

  @doc false
  def start(_start_type, _args) do
    import Supervisor.Spec, warn: false

    children = [ExTrade.Authorization.Store, ExTrade.Authorization.Worker]

    opts = [strategy: :one_for_one, name: Extrade.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defmacro __using__(_) do
    quote do
      @doc false
      @spec cast(map()) :: __MODULE__.t()
      def cast(map) when is_map(map) do
        map
        |> Map.new(fn {k, v} ->
          if is_list(v) do
            {format_key(k), Enum.map(v, &format_value(k, &1))}
          else
            {format_key(k), format_value(k, v)}
          end
        end)
        |> then(&struct(__MODULE__, &1))
      end
    end
  end
end
