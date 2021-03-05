defmodule School.Services.Attendance do
  alias School.Attendance
  alias School.Repo
  alias School.Services.Children

  import Ecto.Query

  def create(data) do
    Attendance.changeset(%Attendance{}, data) |> Repo.insert
  end

  def get_attendance_by_date(dateId) do
    query = from a in Attendance,
      select: a.children_id,
      where: a.date_id == ^dateId

    present = query |> Repo.all()

    all_children = Children.get_all()

    Enum.map(all_children, fn(x) ->
      if(Enum.member?(present, x[:id])) do
        x |> Map.put(:attendance, true)
      else
        x |> Map.put(:attendance, false)
      end
    end)
  end

end
