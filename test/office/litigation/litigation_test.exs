defmodule Office.LitigationTest do
  use Office.DataCase

  alias Office.Litigation

  describe "phones" do
    alias Office.Litigation.Phone

    @valid_attrs %{phone: "some phone"}
    @update_attrs %{phone: "some updated phone"}
    @invalid_attrs %{phone: nil}

    def phone_fixture(attrs \\ %{}) do
      {:ok, phone} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_phone()

      phone
    end

    test "list_phones/0 returns all phones" do
      phone = phone_fixture()
      assert Litigation.list_phones() == [phone]
    end

    test "get_phone!/1 returns the phone with given id" do
      phone = phone_fixture()
      assert Litigation.get_phone!(phone.id) == phone
    end

    test "create_phone/1 with valid data creates a phone" do
      assert {:ok, %Phone{} = phone} = Litigation.create_phone(@valid_attrs)
      assert phone.phone == "some phone"
    end

    test "create_phone/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_phone(@invalid_attrs)
    end

    test "update_phone/2 with valid data updates the phone" do
      phone = phone_fixture()
      assert {:ok, phone} = Litigation.update_phone(phone, @update_attrs)
      assert %Phone{} = phone
      assert phone.phone == "some updated phone"
    end

    test "update_phone/2 with invalid data returns error changeset" do
      phone = phone_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_phone(phone, @invalid_attrs)
      assert phone == Litigation.get_phone!(phone.id)
    end

    test "delete_phone/1 deletes the phone" do
      phone = phone_fixture()
      assert {:ok, %Phone{}} = Litigation.delete_phone(phone)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_phone!(phone.id) end
    end

    test "change_phone/1 returns a phone changeset" do
      phone = phone_fixture()
      assert %Ecto.Changeset{} = Litigation.change_phone(phone)
    end
  end
end
