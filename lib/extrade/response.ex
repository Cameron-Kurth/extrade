defmodule ExTrade.Response do
  @moduledoc """
  """
  alias ExTrade.Response.Error

  @type success_t :: {:ok, list() | map() | String.t()}
  @type error_t :: {:error, HTTPoison.Error.t() | Error.t()}
  @type t :: success_t | error_t

  @doc false
  @spec handle_response({:ok | :error, HTTPoison.Response.t()}) :: t()
  def handle_response({:ok, %HTTPoison.Response{status_code: 204}}) do
    {:ok, []}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}}) do
    {_, content_type} = Enum.find(headers, &(String.downcase(elem(&1, 0)) == "content-type"))

    case content_type do
      "application/json" -> Jason.decode(body)
      "application/x-www-form-urlencoded" <> _ -> {:ok, URI.decode_query(body)}
      _ -> {:ok, body}
    end
  end

  def handle_response({:ok, response}) do
    {:error, Error.new(response)}
  end

  def handle_response({:error, %HTTPoison.Error{} = error}) do
    {:error, error}
  end
end
