defmodule SchoolWeb.ChildrenView do
  use SchoolWeb, :view

  def render("children.json", %{children: children}) do
    %{
      children: Enum.map(children, &child_json/1)
    }
  end

  def render("single.json", %{child: child}) do
    %{
      id: child.id,
      name: child.name,
      gender: child.gender,
      contact_number: child.contact_no,
      medical_condition: child.medical_condition,
      remarks: child.remarks,
      guardians: Enum.map(child.guardians, &guardian_json/1),
      present: Enum.map(child.attendance, &attendance_json/1)
    }
  end

  def guardian_json(guardian) do
    %{
      name: guardian.name,
      relation: guardian.relation,
      email: guardian.contact_info.email,
      mobile_number: guardian.contact_info.mobile_number
    }
  end

  def child_json(child) do
    %{
      id: child.id,
      name: child.name
    }
  end

  def attendance_json(attendance) do
    attendance.dates.date
  end
end
