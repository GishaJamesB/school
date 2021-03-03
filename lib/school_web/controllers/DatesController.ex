defmodule SchoolWeb.DatesController do
  use SchoolWeb, :controller
  alias School.Services.Dates
  import Ecto.Changeset

  def create(conn, params) do
    case Dates.create(params) do
      {:ok, _ } -> json(conn, %{ok: "done"})
      {:error, changeset} ->
        # IO.inspect changeset
        error = traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        |> Enum.reduce("", fn {k, v}, acc ->
          joined_errors = Enum.join(v, "; ")
          "#{acc} #{k}: #{joined_errors}"
        end)
        # IO.inspect error
        json(conn, %{error: error})
    end
  end

  def get(conn, _params) do
    data = Dates.get()
    json(conn, %{ok: data})
  end
end
