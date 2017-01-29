defmodule Office.CaseTest do
  use Office.ModelCase

  alias Office.Case

  @valid_attrs %{signature: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Case.changeset(%Case{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Case.changeset(%Case{}, @invalid_attrs)
    refute changeset.valid?
  end
end
