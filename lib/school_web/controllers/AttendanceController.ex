defmodule SchoolWeb.AttendanceController do
  use SchoolWeb, :controller

  alias School.Services.Attendance
  alias School.Services.Children
  alias School.Services.Dates

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

  def check_if_present(child_id, date, attendance_data) do
    attendance_for_the_day =
      attendance_data[date]
        |> Enum.filter(fn x ->
          x.id == child_id
        end)
      |> Enum.at(0)
      |> Map.get(:attendance)
    %{
      :date => date,
      :present => attendance_for_the_day
    }
  end

  def get_attendance(conn, _params) do
    all_children = Children.get_all()
    all_dates = Dates.get()
    attendance = all_dates
                  |> Enum.reduce(%{}, fn date, acc->
                        list = %{date[:date] => Attendance.get_attendance_by_date(date.id, all_children)}
                        list |> Map.merge(acc)
                      end)

    result = all_children |> Enum.map(fn x->
      attendance_for_the_child = all_dates |> Enum.map(fn d -> check_if_present(x.id, d.date, attendance) end)
      %{
        :id => x.id,
        :name => x.name,
        :attendance => attendance_for_the_child
      }
    end)

    json(conn, %{children: result})
  end
end
