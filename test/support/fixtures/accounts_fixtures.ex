defmodule Shoja.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shoja.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Shoja.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a user_detail.
  """
  def user_detail_fixture(attrs \\ %{}) do
    {:ok, user_detail} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        date_of_birth: ~D[2024-10-06],
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> Shoja.Accounts.create_user_detail()

    user_detail
  end

  @doc """
  Generate a user_profile.
  """
  def user_profile_fixture(attrs \\ %{}) do
    {:ok, user_profile} =
      attrs
      |> Enum.into(%{
        primary: true,
        purpose: "some purpose",
        username: "some username"
      })
      |> Shoja.Accounts.create_user_profile()

    user_profile
  end
end
