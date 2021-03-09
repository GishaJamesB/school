defmodule School.Utils.Attendance do

  def merge_attendance_with_child_data(children, presentIds) do
    Enum.map(children, fn(x) ->
      if(Enum.member?(presentIds, x[:id])) do
        x |> Map.put(:attendance, true)
      else
        x |> Map.put(:attendance, false)
      end
    end)
  end

  def get_attendance_by_child_id_and_date_from_list(child_id, date, data) do
    data[date]
    |> Enum.filter(fn x ->
      x.id == child_id
    end)
    |> Enum.at(0)
    |> Map.get(:attendance)
  end

  def get_attendance_for_the_child_for_all_dates(child_id, dates, attendance_data) do
    dates |> Enum.reduce(%{}, fn d, acc ->
      %{d.date => get_attendance_by_child_id_and_date_from_list(child_id, d.date, attendance_data)} |> Map.merge(acc)
    end)
  end

end
