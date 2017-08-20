defmodule OfficeWeb.PhoneControllerTest do
  use OfficeWeb.ConnCase

  alias Office.Litigation

  @create_attrs %{phone: "some phone"}
  @update_attrs %{phone: "some updated phone"}
  @invalid_attrs %{phone: nil}

  def fixture(:phone) do
    {:ok, phone} = Litigation.create_phone(@create_attrs)
    phone
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, phone_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Phones"
  end

  test "renders form for new phones", %{conn: conn} do
    conn = get conn, phone_path(conn, :new)
    assert html_response(conn, 200) =~ "New Phone"
  end

  test "creates phone and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, phone_path(conn, :create), phone: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == phone_path(conn, :show, id)

    conn = get conn, phone_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Phone"
  end

  test "does not create phone and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, phone_path(conn, :create), phone: @invalid_attrs
    assert html_response(conn, 200) =~ "New Phone"
  end

  test "renders form for editing chosen phone", %{conn: conn} do
    phone = fixture(:phone)
    conn = get conn, phone_path(conn, :edit, phone)
    assert html_response(conn, 200) =~ "Edit Phone"
  end

  test "updates chosen phone and redirects when data is valid", %{conn: conn} do
    phone = fixture(:phone)
    conn = put conn, phone_path(conn, :update, phone), phone: @update_attrs
    assert redirected_to(conn) == phone_path(conn, :show, phone)

    conn = get conn, phone_path(conn, :show, phone)
    assert html_response(conn, 200) =~ "some updated phone"
  end

  test "does not update chosen phone and renders errors when data is invalid", %{conn: conn} do
    phone = fixture(:phone)
    conn = put conn, phone_path(conn, :update, phone), phone: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Phone"
  end

  test "deletes chosen phone", %{conn: conn} do
    phone = fixture(:phone)
    conn = delete conn, phone_path(conn, :delete, phone)
    assert redirected_to(conn) == phone_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, phone_path(conn, :show, phone)
    end
  end
end
