defmodule Baani.SyndicatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Baani.Syndicates` context.
  """

  @doc """
  Generate a syndicate.
  """
  def syndicate_fixture(attrs \\ %{}) do
    {:ok, syndicate} =
      attrs
      |> Enum.into(%{
        title: "some title",
        unique_identifier: "some unique_identifier"
      })
      |> Baani.Syndicates.create_syndicate()

    syndicate
  end
end
