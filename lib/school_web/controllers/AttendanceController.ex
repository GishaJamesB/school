defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  def create(conn, params) do
    case School.Services.Attendance.create(params) do
      {:ok, _} -> render conn, "success.json", %{message: "completed"}
      {:error, _} -> render conn, "failure.json", %{message: "could not mark attendance"}
    end

  end
end
