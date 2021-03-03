defmodule SchoolWeb.DatesController do
  use SchoolWeb, :controller
  alias School.Services.Dates

  def create(conn, params) do
    Dates.create(params)
    json(conn, %{ok: "done"})
  end
end
