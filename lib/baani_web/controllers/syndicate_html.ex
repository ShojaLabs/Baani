defmodule BaaniWeb.SyndicateHTML do
  use BaaniWeb, :html

  embed_templates "syndicate_html/*"

  @doc """
  Renders a syndicate form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def syndicate_form(assigns)
end
