defmodule SchoolWeb.ChildrenView do
  use SchoolWeb, :view

  def render("children.json", %{children: children}) do
    %{
      children: Enum.map(children, &child_json/1)
    }
  end

  def child_json(child) do
    %{
      id: child.id,
      name: child.name,
      gender: child.gender,
      contact_number: child.contact_no,
      medical_condition: child.medical_condition,
      remarks: child.remarks,
      guardians: child.guardians |> Enum.map(fn(x) -> %{name: x.name, relation: x.relation} end)
    }
  end
end
