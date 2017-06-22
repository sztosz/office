defmodule Office.CourtTest do
  use Office.ModelCase

  alias Office.Court

  @valid_attrs %{city: "some content", name: "some content", phone: 42, street: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Court.changeset(%Court{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Court.changeset(%Court{}, @invalid_attrs)
    refute changeset.valid?
  end
end
