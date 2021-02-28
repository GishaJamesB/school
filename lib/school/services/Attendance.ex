defmodule School.Services.Attendance do
  alias School.Attendance
  alias School.Repo

  def insert(data) do
    Attendance.changeset(%Attendance{}, data) |> Repo.insert
  end
end
