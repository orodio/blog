defmodule Blog.Content.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.{Permalink, Post, Category}

  @primary_key {:id, Permalink, autogenerate: true}
  schema "categories" do
    field :label, :string
    field :slug, :string
    many_to_many :posts, Post, join_through: "post_categories"

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

  defimpl Phoenix.Param, for: Category do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
end
