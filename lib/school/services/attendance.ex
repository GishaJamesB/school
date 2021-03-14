defmodule School.Services.Attendance do
  alias School.Attendance
  alias School.Services.Children
  alias School.Services.Dates
  alias School.Repo
  alias School.Utils.Attendance, as: AttendanceUtils

  import Ecto.Query

  def create(data) do
    Attendance.changeset(%Attendance{}, data) |> Repo.insert
  end

  def delete(data) do
    query = from a in Attendance,
      where: a.date_id == ^Map.get(data, "date_id") and a.children_id == ^Map.get(data, "children_id")

    query |> Repo.one!() |> Repo.delete
  end

  def get_ids_present(dateId) do
    query = from a in Attendance,
      select: a.children_id,
      where: a.date_id == ^dateId

    query |> Repo.all()
  end

  def get_attendance_by_date(dateId) do
    # School.Utils.Attendance.merge_attendance_with_child_data(all_children, get_ids_present(dateId))
    query = "select c.id, c.name,
            case
              when a.id IS NULL then false
              else true
            end as attendance
            from children c
            left join attendance a on a.children_id = c.id
            and a.date_id=#{dateId}"
    result = Ecto.Adapters.SQL.query!(Repo, query, [])
    columns = Enum.map result.columns, &(String.to_atom(&1))
    Enum.map result.rows, fn(row) ->
      Enum.zip(columns, row) |> Enum.into(%{})
    end
  end

  def get_full_attendance() do
    all_children = Children.get_all()
    all_dates = Dates.get()
    attendance = all_dates
                  |> Enum.reduce(%{}, fn date, acc->
                        list = %{date[:date] => AttendanceUtils.merge_attendance_with_child_data(all_children, get_ids_present(date.id))}
                        list |> Map.merge(acc)
                      end)

    all_children |> Enum.map(fn x->
      %{
        :id => x.id,
        :name => x.name,
        :attendance => AttendanceUtils.get_attendance_for_the_child_for_all_dates(x.id, all_dates, attendance)
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
