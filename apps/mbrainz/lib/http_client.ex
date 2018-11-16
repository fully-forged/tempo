defmodule HTTPClient do
  @moduledoc """
  Simple http client based on httpc.
  """

  defmodule Response do
    @moduledoc false
    defstruct status_code: 100,
              headers: [],
              body: <<>>
  end

  defmodule ErrorResponse do
    @moduledoc false
    defstruct message: nil
  end

  def json_get(url, headers \\ [], qs_params \\ []) do
    case get(url, headers, qs_params) do
      %Response{} = response ->
        %{response | body: Jason.decode!(response.body)}

      error_response ->
        error_response
    end
  end

  def json_post(url, data, headers \\ []) do
    case post(url, Jason.encode!(data), headers, 'application/json') do
      %Response{body: []} = response ->
        response

      %Response{} = response ->
        %{response | body: Jason.decode!(response.body)}

      error_response ->
        error_response
    end
  end

  def json_put(url, data, headers \\ []) do
    case put(url, Jason.encode!(data), headers, 'application/json') do
      %Response{body: []} = response ->
        response

      %Response{} = response ->
        %{response | body: Jason.decode!(response.body)}

      error_response ->
        error_response
    end
  end

  def get(url, headers \\ [], qs_params \\ %{}) do
    headers =
      Enum.map(headers, fn {k, v} ->
        {String.to_charlist(k), String.to_charlist(v)}
      end)

    url_with_qs = url <> "?" <> URI.encode_query(qs_params)

    :httpc.request(:get, {String.to_charlist(url_with_qs), headers}, [], [])
    |> process_response
  end

  def post(url, body, headers \\ [], content_type \\ 'application/json') do
    headers =
      Enum.map(headers, fn {k, v} ->
        {String.to_charlist(k), String.to_charlist(v)}
      end)

    :httpc.request(:post, {String.to_charlist(url), headers, content_type, body}, [], [])
    |> process_response
  end

  def put(url, body, headers \\ [], content_type \\ 'application/json') do
    headers =
      Enum.map(headers, fn {k, v} ->
        {String.to_charlist(k), String.to_charlist(v)}
      end)

    :httpc.request(:put, {String.to_charlist(url), headers, content_type, body}, [], [])
    |> process_response
  end

  def delete(url, headers \\ []) do
    headers =
      Enum.map(headers, fn {k, v} ->
        {String.to_charlist(k), String.to_charlist(v)}
      end)

    :httpc.request(:delete, {String.to_charlist(url), headers, [], []}, [], [])
    |> process_response
  end

  defp process_response({:ok, result}) do
    {{_, status, _}, headers, body} = result

    headers =
      Enum.map(headers, fn {k, v} ->
        {List.to_string(k), List.to_string(v)}
      end)

    %Response{status_code: status, headers: headers, body: body}
  end

  defp process_response({:error, reason}) do
    %ErrorResponse{message: reason}
  end
end
