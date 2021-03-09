defmodule School.ErrorsTest do
  use ExUnit.Case
  doctest School.Utils.Attendance
  alias School.Utils.Attendance

  test "merge_attendance_with_child_data - merge attendance property to children's data" do
    all_children = [
      %{:id => 1, :name => "Joe"},
      %{:id => 2, :name => "Doe"},
      %{:id => 3, :name => "Harry"},
      %{:id => 4, :name => "Potter"}
    ]

    assert Attendance.merge_attendance_with_child_data(all_children, [1,3]) == [
      %{:id => 1, :name => "Joe", :attendance => true},
      %{:id => 2, :name => "Doe", :attendance => false},
      %{:id => 3, :name => "Harry", :attendance => true},
      %{:id => 4, :name => "Potter", :attendance => false}
    ]
  end

  test "get_attendance_by_child_id_and_date_from_list" do
    data = %{
      ~D[2021-02-21] => [
        %{attendance: true, id: 1, name: "Joe"},
        %{attendance: true, id: 2, name: "Doe"},
        %{attendance: false, id: 26, name: "Harry"},
        %{attendance: false, id: 21, name: "Potter"},
      ],
      ~D[2021-02-28] => [
        %{attendance: false, id: 1, name: "Joe"},
        %{attendance: false, id: 2, name: "Doe"},
        %{attendance: true, id: 26, name: "Harry"},
        %{attendance: true, id: 21, name: "Potter"},
      ]
    }

    assert Attendance.get_attendance_by_child_id_and_date_from_list(2,~D[2021-02-21], data) == true
  end

  test "get_attendance_for_the_child_for_all_dates" do
    data = %{
      ~D[2021-02-21] => [
        %{attendance: true, id: 1, name: "Joe"},
        %{attendance: true, id: 2, name: "Doe"},
        %{attendance: false, id: 26, name: "Harry"},
        %{attendance: false, id: 21, name: "Potter"},
      ],
      ~D[2021-02-28] => [
        %{attendance: false, id: 1, name: "Joe"},
        %{attendance: false, id: 2, name: "Doe"},
        %{attendance: true, id: 26, name: "Harry"},
        %{attendance: true, id: 21, name: "Potter"},
      ]
    }

    dates = [%{date: ~D[2021-02-21], id: 1}, %{date: ~D[2021-02-28], id: 2}]

    assert Attendance.get_attendance_for_the_child_for_all_dates(2,dates, data) == %{
      ~D[2021-02-21] => true,
      ~D[2021-02-28] => false
    }
  end

end
