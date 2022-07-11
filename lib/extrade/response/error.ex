defmodule ExTrade.Response.Error do
  @moduledoc """
  A struct which represents an error that occurred during an E*TRADE API call.

  This struct is designed to provide all the information needed to effectively manage an error response.

  It contains the following fields:
  - `:body` – the raw HTTP response body
  - `:status_code` – the HTTP response status code (e.g., 401)
  - `:status_reason` – the human-readable interpretation of the `status_code` (e.g., "Unauthorized")
  - `:error_code` – the custom error code sent by E*TRADE and parsed from `body`
  - `:user_reason` – the custom error reason/message sent by E*TRADE and parsed from `body`
  """
  defstruct [:body, :status_code, :status_reason, :error_code, :error_reason]

  @type t :: %__MODULE__{
          body: String.t(),
          status_code: integer(),
          status_reason: String.t() | nil,
          error_code: integer() | nil,
          error_reason: String.t() | nil
        }

  @statuses %{
    100 => "Continue",
    101 => "Switching Protocols",
    102 => "Processing",
    103 => "Early Hints",
    200 => "OK",
    201 => "Created",
    202 => "Accepted",
    203 => "Non-Authoritative Information",
    204 => "No Content",
    205 => "Reset Content",
    206 => "Partial Content",
    207 => "Multi-Status",
    208 => "Already Reported",
    226 => "IM Used",
    300 => "Multiple Choices",
    301 => "Moved Permanently",
    302 => "Found",
    303 => "See Other",
    304 => "Not Modified",
    305 => "Use Proxy",
    306 => "Switch Proxy",
    307 => "Temporary Redirect",
    308 => "Permanent Redirect",
    400 => "Bad Request",
    401 => "Unauthorized",
    402 => "Payment Required",
    403 => "Forbidden",
    404 => "Not Found",
    405 => "Method Not Allowed",
    406 => "Not Acceptable",
    407 => "Proxy Authentication Required",
    408 => "Request Timeout",
    409 => "Conflict",
    410 => "Gone",
    411 => "Length Required",
    412 => "Precondition Failed",
    413 => "Request Entity Too Large",
    414 => "Request-URI Too Long",
    415 => "Unsupported Media Type",
    416 => "Requested Range Not Satisfiable",
    417 => "Expectation Failed",
    418 => "I'm a teapot",
    421 => "Misdirected Request",
    422 => "Unprocessable Entity",
    423 => "Locked",
    424 => "Failed Dependency",
    425 => "Too Early",
    426 => "Upgrade Required",
    428 => "Precondition Required",
    429 => "Too Many Requests",
    431 => "Request Header Fields Too Large",
    451 => "Unavailable For Legal Reasons",
    500 => "Internal Server Error",
    501 => "Not Implemented",
    502 => "Bad Gateway",
    503 => "Service Unavailable",
    504 => "Gateway Timeout",
    505 => "HTTP Version Not Supported",
    506 => "Variant Also Negotiates",
    507 => "Insufficient Storage",
    508 => "Loop Detected",
    510 => "Not Extended",
    511 => "Network Authentication Required"
  }

  @doc false
  @spec new(HTTPoison.Response.t()) :: t()
  def new(%HTTPoison.Response{status_code: status_code, body: body}) do
    {error_code, error_reason} =
      with regex <- ~r/<code>(?<code>\d+)<\/code>.*<message>(?<message>.+)<\/message>/,
           cleaned_body <- String.replace(body, "\n", ""),
           capture when not is_nil(capture) <- Regex.named_captures(regex, cleaned_body),
           code when not is_nil(code) <- capture["code"],
           {int, _} <- Integer.parse(code),
           message when not is_nil(message) <- capture["message"] do
        {int, message}
      else
        _ -> {nil, nil}
      end

    struct(ExTrade.Response.Error, %{
      body: body,
      status_code: status_code,
      status_reason: @statuses[status_code],
      error_code: error_code,
      error_reason: error_reason
    })
  end
end
