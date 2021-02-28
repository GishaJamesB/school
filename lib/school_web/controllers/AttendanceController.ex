defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  def index(conn, _params) do
    data = School.Services.Attendance.insert
    render conn, "children.json", children: data
  end
end
