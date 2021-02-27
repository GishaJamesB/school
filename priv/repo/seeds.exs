# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     School.Repo.insert!(%School.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias School.Children
alias School.Guardian
alias School.ContactInfo
alias School.ChildrenGuardian

csv="/home/gisha/Work/school/priv/repo/children.csv"
csv
|> File.stream!
|> CSV.decode(headers: [:name, :gender, :contact_no, :medical_condition, :remarks,
  :father, :father_contact_no, :father_email, :father_religion,
  :mother, :mother_contact_no, :mother_email, :mother_religion
  ])
|> Enum.map(fn row ->
    School.Repo.transaction(fn ->
      {:ok, data} = row
      {:ok, child_record} = Children.changeset(%Children{}, data)
                              |> School.Repo.insert(returning: [:id])

      father_full_info =  data
                          |> Map.put(:name, data.father)
                          |> Map.put(:religion, data.father_religion)
                          |> Map.put(:relation, "father")

      mother_full_info =  data
                          |> Map.put(:name, data.mother)
                          |> Map.put(:religion, data.mother_religion)
                          |> Map.put(:relation, "mother")

      {:ok, father_record} = Guardian.changeset(%Guardian{}, father_full_info)
                              |> School.Repo.insert(returning: [:id])
      {:ok, mother_record} = Guardian.changeset(%Guardian{}, mother_full_info)
                              |> School.Repo.insert(returning: [:id])

      father_contact_info = data
                            |> Map.put(:email, data.father_email)
                            |> Map.put(:mobile_number, data.father_contact_no)
                            |> Map.put(:guardian_id, father_record.id)

      mother_contact_info = data
                            |> Map.put(:email, data.mother_email)
                            |> Map.put(:mobile_number, data.mother_contact_no)
                            |> Map.put(:guardian_id, mother_record.id)

      ContactInfo.changeset(%ContactInfo{}, father_contact_info)
      |> School.Repo.insert

      ContactInfo.changeset(%ContactInfo{}, mother_contact_info)
      |> School.Repo.insert

      ChildrenGuardian.changeset(%ChildrenGuardian{}, %{:children_id => child_record.id, :guardian_id => father_record.id})
      |> School.Repo.insert

      ChildrenGuardian.changeset(%ChildrenGuardian{}, %{:children_id => child_record.id, :guardian_id => mother_record.id})
      |> School.Repo.insert
    end)
  end
)
