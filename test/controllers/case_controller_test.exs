defmodule Office.CaseControllerTest do
  use Office.ConnCase

  alias Office.Case
  @valid_attrs %{signature: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, case_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cases"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, case_path(conn, :new)
    assert html_response(conn, 200) =~ "New case"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, case_path(conn, :create), case: @valid_attrs
    assert redirected_to(conn) == case_path(conn, :index)
    assert Repo.get_by(Case, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, case_path(conn, :create), case: @invalid_attrs
    assert html_response(conn, 200) =~ "New case"
  end

  test "shows chosen resource", %{conn: conn} do
    case = Repo.insert! %Case{}
    conn = get conn, case_path(conn, :show, case)
    assert html_response(conn, 200) =~ "Show case"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, case_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    case = Repo.insert! %Case{}
    conn = get conn, case_path(conn, :edit, case)
    assert html_response(conn, 200) =~ "Edit case"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    case = Repo.insert! %Case{}
    conn = put conn, case_path(conn, :update, case), case: @valid_attrs
    assert redirected_to(conn) == case_path(conn, :show, case)
    assert Repo.get_by(Case, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    case = Repo.insert! %Case{}
    conn = put conn, case_path(conn, :update, case), case: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit case"
  end

  test "deletes chosen resource", %{conn: conn} do
    case = Repo.insert! %Case{}
    conn = delete conn, case_path(conn, :delete, case)
    assert redirected_to(conn) == case_path(conn, :index)
    refute Repo.get(Case, case.id)
  end
end
