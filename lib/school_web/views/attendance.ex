defmodule SchoolWeb.AttendanceView do
  use SchoolWeb, :view

  def render("success.json", %{message: message}) do
    %{
      message: message
    }
  end

  def render("failure.json",%{message: message}) do
    %{
      error: message
    }
  end

  def render("children_attendance.json", %{children: children}) do
    %{
      children: Enum.map(children, &child_attendance_json/1)
    }
  end

  def child_attendance_json(child) do
    %{
      id: child.id,
      name: child.name
    }
  end

end
