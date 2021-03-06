defmodule SchoolWeb.DatesController do
  use SchoolWeb, :controller
  alias School.Services.Dates

  def create(conn, params) do
    case Dates.create(params) do
      {:ok} -> json(conn, %{ok: "done"})
      {:error, error} -> json(conn, %{error: error})
    end
  end

  def get(conn, _params) do
    data = Dates.get()
    json(conn, %{ok: data})
  end
end
