defmodule OfficeWeb.CourtControllerTest do
  use OfficeWeb.ConnCase

  alias OfficeWeb.Court
  @valid_attrs %{city: "some content", name: "some content", phone: 42, street: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, court_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing courts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, court_path(conn, :new)
    assert html_response(conn, 200) =~ "New court"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, court_path(conn, :create), court: @valid_attrs
    assert redirected_to(conn) == court_path(conn, :index)
    assert Repo.get_by(Court, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, court_path(conn, :create), court: @invalid_attrs
    assert html_response(conn, 200) =~ "New court"
  end

  test "shows chosen resource", %{conn: conn} do
    court = Repo.insert! %Court{}
    conn = get conn, court_path(conn, :show, court)
    assert html_response(conn, 200) =~ "Show court"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, court_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    court = Repo.insert! %Court{}
    conn = get conn, court_path(conn, :edit, court)
    assert html_response(conn, 200) =~ "Edit court"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    court = Repo.insert! %Court{}
    conn = put conn, court_path(conn, :update, court), court: @valid_attrs
    assert redirected_to(conn) == court_path(conn, :show, court)
    assert Repo.get_by(Court, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    court = Repo.insert! %Court{}
    conn = put conn, court_path(conn, :update, court), court: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit court"
  end

  test "deletes chosen resource", %{conn: conn} do
    court = Repo.insert! %Court{}
    conn = delete conn, court_path(conn, :delete, court)
    assert redirected_to(conn) == court_path(conn, :index)
    refute Repo.get(Court, court.id)
  end
end
