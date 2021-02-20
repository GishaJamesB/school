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

# defmodule Seeds.Children do

#   defp process_csv_row(row) do
#     IO.puts "reached here"
#     IO.puts row
#   end

#   def read_and_populate do
#     csv="/home/gisha/Work/school/priv/repo/children.csv"
#     csv
#     |> File.stream!
#     |> CSV.decode(headers: [:name, :gender])
#     |> Enum.map(fn row ->
#         IO.puts "reached here"
#       end
#     )
#   end
# end

alias School.Children

csv="/home/gisha/Work/school/priv/repo/children.csv"
csv
|> File.stream!
|> CSV.decode(headers: [:name, :gender])
|> Enum.map(fn row ->
  {:ok, data} = row
    IO.inspect data
    # %School.Children{data} |> School.Repo.insert!
    Children.changeset(%Children{}, data)
    |> School.Repo.insert!

  end
)
