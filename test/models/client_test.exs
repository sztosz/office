defmodule Office.ClientTest do
  use Office.ModelCase

  alias Office.Client

  @valid_attrs %{address: "some content", email: "some content", krs: 42, name: "some content", nip: 42, phone: 42, regon: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Client.changeset(%Client{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Client.changeset(%Client{}, @invalid_attrs)
    refute changeset.valid?
  end
end
