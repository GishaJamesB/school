defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  alias School.Services.Attendance

  def create(conn, params) do
    case School.Services.Attendance.create(params) do
      {:ok, _} -> render conn, "success.json", %{message: "completed"}
      {:error, _} -> render conn, "failure.json", %{message: "could not mark attendance"}
    end
  end

  def get_attendance_by_date(conn, params) do
    data = Attendance.get_attendance_by_date(params["date"])
    json(conn, %{children: data})
  end
end
