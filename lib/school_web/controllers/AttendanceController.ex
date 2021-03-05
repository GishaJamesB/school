defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  alias School.Services.Attendance
  alias School.Services.Children

  def create(conn, params) do
    case School.Services.Attendance.create(params) do
      {:ok, _} -> render conn, "success.json", %{message: "completed"}
      {:error, _} -> render conn, "failure.json", %{message: "could not mark attendance"}
    end
  end

  def get_attendance_by_date(conn, params) do
    all_children = Children.get_all()
    data = Attendance.get_attendance_by_date(params["date"], all_children)
    json(conn, %{children: data})
  end
end
