defmodule AuthPlug.RolePlug do
  import Plug.Conn

  @admin_role "admin"

  def init(options), do: options

  def call(conn, opts) do
    case can?(conn, user(conn), opts[:role]) do
      true ->
        conn
      false ->
        reject_request(conn)
    end
  end

  def can?(conn, user_details = %{"roles" => [%{"name" => @admin_role}]}, role), do: true

  def can?(conn, user_details, role) do
    Enum.member?(user_roles(conn), role)
  end

  def user_roles(conn) do
    roles = user(conn)["roles"] || []

    Enum.map(roles, fn x -> x["name"] end)
  end

  def user(conn) do
    conn.assigns[:user_details]
  end

  defp reject_request(conn) do
    conn
    |> send_resp(405, "Method not allowed, role level too low")
    |> halt()
  end
end