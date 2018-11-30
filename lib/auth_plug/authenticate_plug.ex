defmodule AuthPlug.AuthenticatePlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, opts) do
    try do
      [bearer] = get_req_header(conn, "authorization")
      [_, jwt] = String.split(bearer, "Bearer ")

      case JOSE.JWE.block_decrypt(opts[:gateway_secret], jwt) do
        {user_details, _} ->
          assign(conn, :user_details, Poison.decode!(user_details))
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
  end
end