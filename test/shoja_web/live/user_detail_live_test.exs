defmodule ShojaWeb.UserDetailLiveTest do
  use ShojaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shoja.AccountsFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", bio: "some bio", date_of_birth: "2024-10-06"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", bio: "some updated bio", date_of_birth: "2024-10-07"}
  @invalid_attrs %{first_name: nil, last_name: nil, bio: nil, date_of_birth: nil}

  defp create_user_detail(_) do
    user_detail = user_detail_fixture()
    %{user_detail: user_detail}
  end

  describe "Index" do
    setup [:create_user_detail]

    test "lists all user_details", %{conn: conn, user_detail: user_detail} do
      {:ok, _index_live, html} = live(conn, ~p"/user_details")

      assert html =~ "Listing User details"
      assert html =~ user_detail.first_name
    end

    test "saves new user_detail", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_details")

      assert index_live |> element("a", "New User detail") |> render_click() =~
               "New User detail"

      assert_patch(index_live, ~p"/user_details/new")

      assert index_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_detail-form", user_detail: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_details")

      html = render(index_live)
      assert html =~ "User detail created successfully"
      assert html =~ "some first_name"
    end

    test "updates user_detail in listing", %{conn: conn, user_detail: user_detail} do
      {:ok, index_live, _html} = live(conn, ~p"/user_details")

      assert index_live |> element("#user_details-#{user_detail.id} a", "Edit") |> render_click() =~
               "Edit User detail"

      assert_patch(index_live, ~p"/user_details/#{user_detail}/edit")

      assert index_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_detail-form", user_detail: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_details")

      html = render(index_live)
      assert html =~ "User detail updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes user_detail in listing", %{conn: conn, user_detail: user_detail} do
      {:ok, index_live, _html} = live(conn, ~p"/user_details")

      assert index_live |> element("#user_details-#{user_detail.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_details-#{user_detail.id}")
    end
  end

  describe "Show" do
    setup [:create_user_detail]

    test "displays user_detail", %{conn: conn, user_detail: user_detail} do
      {:ok, _show_live, html} = live(conn, ~p"/user_details/#{user_detail}")

      assert html =~ "Show User detail"
      assert html =~ user_detail.first_name
    end

    test "updates user_detail within modal", %{conn: conn, user_detail: user_detail} do
      {:ok, show_live, _html} = live(conn, ~p"/user_details/#{user_detail}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User detail"

      assert_patch(show_live, ~p"/user_details/#{user_detail}/show/edit")

      assert show_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_detail-form", user_detail: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_details/#{user_detail}")

      html = render(show_live)
      assert html =~ "User detail updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
