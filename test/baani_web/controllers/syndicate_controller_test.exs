defmodule BaaniWeb.SyndicateControllerTest do
  use BaaniWeb.ConnCase

  import Baani.SyndicatesFixtures

  @create_attrs %{title: "some title", unique_identifier: "some unique_identifier"}
  @update_attrs %{title: "some updated title", unique_identifier: "some updated unique_identifier"}
  @invalid_attrs %{title: nil, unique_identifier: nil}

  describe "index" do
    test "lists all syndicates", %{conn: conn} do
      conn = get(conn, ~p"/syndicates")
      assert html_response(conn, 200) =~ "Listing Syndicates"
    end
  end

  describe "new syndicate" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/syndicates/new")
      assert html_response(conn, 200) =~ "New Syndicate"
    end
  end

  describe "create syndicate" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/syndicates", syndicate: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/syndicates/#{id}"

      conn = get(conn, ~p"/syndicates/#{id}")
      assert html_response(conn, 200) =~ "Syndicate #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/syndicates", syndicate: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Syndicate"
    end
  end

  describe "edit syndicate" do
    setup [:create_syndicate]

    test "renders form for editing chosen syndicate", %{conn: conn, syndicate: syndicate} do
      conn = get(conn, ~p"/syndicates/#{syndicate}/edit")
      assert html_response(conn, 200) =~ "Edit Syndicate"
    end
  end

  describe "update syndicate" do
    setup [:create_syndicate]

    test "redirects when data is valid", %{conn: conn, syndicate: syndicate} do
      conn = put(conn, ~p"/syndicates/#{syndicate}", syndicate: @update_attrs)
      assert redirected_to(conn) == ~p"/syndicates/#{syndicate}"

      conn = get(conn, ~p"/syndicates/#{syndicate}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, syndicate: syndicate} do
      conn = put(conn, ~p"/syndicates/#{syndicate}", syndicate: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Syndicate"
    end
  end

  describe "delete syndicate" do
    setup [:create_syndicate]

    test "deletes chosen syndicate", %{conn: conn, syndicate: syndicate} do
      conn = delete(conn, ~p"/syndicates/#{syndicate}")
      assert redirected_to(conn) == ~p"/syndicates"

      assert_error_sent 404, fn ->
        get(conn, ~p"/syndicates/#{syndicate}")
      end
    end
  end

  defp create_syndicate(_) do
    syndicate = syndicate_fixture()
    %{syndicate: syndicate}
  end
end
