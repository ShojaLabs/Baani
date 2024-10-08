defmodule Shoja.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shoja.Organizations` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        description: "some description",
        domain: "some domain",
        is_private: true,
        logo: "some logo",
        name: "some name",
        unique_name: "some unique_name"
      })
      |> Shoja.Organizations.create_organization()

    organization
  end
end
