defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  alias School.Services.Attendance, as: AttendanceService

  def create(conn, params) do
    changeset = params |> Map.delete("attendance")
    if(Map.get(params, "attendance") == false) do
      AttendanceService.delete(changeset)
    else
      case AttendanceService.create(changeset) do
        {:ok, _} -> render conn, "success.json", %{message: "completed"}
        {:error, _} -> render conn, "failure.json", %{message: "could not mark attendance"}
      end
    end
  end

  def get_attendance_by_date(conn, %{"date" => date}) do
    data = AttendanceService.get_attendance_by_date(date)
    json(conn, %{children: data})
  end

  def get_attendance(conn, _params) do
    json(conn, %{data: AttendanceService.get_full_attendance})
  end
end
