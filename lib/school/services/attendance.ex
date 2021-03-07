defmodule School.Services.Attendance do
  alias School.Attendance
  alias School.Services.Children
  alias School.Services.Dates
  alias School.Repo

  import Ecto.Query

  def create(data) do
    Attendance.changeset(%Attendance{}, data) |> Repo.insert
  end

  def get_attendance_by_date(dateId, all_children) do
    query = from a in Attendance,
      select: a.children_id,
      where: a.date_id == ^dateId

    present = query |> Repo.all()

    Enum.map(all_children, fn(x) ->
      if(Enum.member?(present, x[:id])) do
        x |> Map.put(:attendance, true)
      else
        x |> Map.put(:attendance, false)
      end
    end)
  end

  defp check_if_present(child_id, date, attendance_data) do
    attendance_for_the_day =
      attendance_data[date]
        |> Enum.filter(fn x ->
          x.id == child_id
        end)
      |> Enum.at(0)
      |> Map.get(:attendance)
    %{
      date => attendance_for_the_day
    }
  end

  def get_full_attendance() do
    all_children = Children.get_all()
    all_dates = Dates.get()
    attendance = all_dates
                  |> Enum.reduce(%{}, fn date, acc->
                        list = %{date[:date] => get_attendance_by_date(date.id, all_children)}
                        list |> Map.merge(acc)
                      end)

    all_children |> Enum.map(fn x->
      attendance_for_the_child = all_dates |> Enum.reduce(%{}, fn d, acc ->
        check_if_present(x.id, d.date, attendance) |> Map.merge(acc)
      end)
      %{
        :id => x.id,
        :name => x.name,
        :attendance => attendance_for_the_child
      }
    end)
  end

  # file = File.open!("test.csv", [:write, :utf8])
  # table_data |> CSV.encode |> Enum.each(&IO.write(file, &1))
  def get_flattened_attendance_report do
    all_dates = Dates.get()
    dates = all_dates |> Enum.map(fn x ->
      Date.to_string(x[:date])
    end)
    header = [["name"] ++ dates]
    body = get_full_attendance()
      |> Enum.reduce([], fn record, acc->
        attendance = all_dates |> Enum.reduce([], fn x, ac->
          ac ++ [
            case record.attendance |> Map.get(x.date) do
              true -> "|"
              false -> "X"
            end
          ]
        end)
        acc ++ [[record.name] ++ attendance]
      end)
    header ++ body
  end

end
