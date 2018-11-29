defmodule AuthPlug.AuthenticatePlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, opts) do
    try do
      [bearer] = get_req_header(conn, "authorization")
      [_, jwt] = String.split(bearer, "Bearer ")

      case JsonWebToken.verify(jwt, %{key: opts[:gateway_secret]}) do
        {:ok, user_details} ->
          assign(conn, :user_details, user_details)
        {:error, _} ->
          reject_request(conn)
      end
    rescue
      e -> e
       reject_request(conn)
    end
  end

  defp reject_request(conn) do
    send_resp(conn, 403, "Unauthenticated")
    halt(conn)
  end
end