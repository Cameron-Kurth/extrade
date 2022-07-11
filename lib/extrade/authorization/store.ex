defmodule ExTrade.Authorization.Store do
  @moduledoc false
  use Agent

  defstruct [:consumer_key, :consumer_secret, :access_token, :access_token_secret, :verifier]

  def start_link(_) do
    initial_state =
      struct(ExTrade.Authorization.Store, %{
        consumer_key: get_api_key(),
        consumer_secret: get_api_secret(),
        access_token: nil,
        access_token_secret: nil,
        verifier: nil
      })

    Agent.start_link(
      fn ->
        Process.flag(:sensitive, true)
        initial_state
      end,
      name: __MODULE__
    )
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def update(new_state) do
    Agent.update(__MODULE__, fn _state -> new_state end)
  end

  defp get_api_key, do: Application.get_env(:extrade, :api_key, "")
  defp get_api_secret, do: Application.get_env(:extrade, :api_secret, "")
end

defimpl Inspect, for: ExTrade.Authorization.Store do
  # Implements redaction on all present Store values to obfuscate stacktraces, etc.
  # Nils are left as-is. This allows for minimal necessary feedback to determine which stage in the OAuth flow the process is in.
  @spec inspect(%ExTrade.Authorization.Store{}, any) :: <<_::352>>
  def inspect(store, _opts) do
    ~s(%ExTrade.Authorization.Store{consumer_key: #{redact(store.consumer_key)}, consumer_secret: #{redact(store.consumer_secret)}, access_token: #{redact(store.access_token)}, access_token_secret: #{redact(store.access_token_secret)}, verifier: #{redact(store.verifier)}})
  end

  defp redact(nil), do: nil
  defp redact(_), do: :redacted
end
