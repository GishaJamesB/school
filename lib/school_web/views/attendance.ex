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
end
