defmodule Blog.Content.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Blog.Content.Permalink, autogenerate: true}
  schema "categories" do
    field :label, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:label])
    |> validate_required([:label])
    |> slugify_label()
  end

  defp slugify_label(changeset) do
    case fetch_change(changeset, :label) do
      {:ok, new_label} -> put_change(changeset, :slug, slugify(new_label))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  defimpl Phoenix.Param, for: Blog.Content.Category do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
end
