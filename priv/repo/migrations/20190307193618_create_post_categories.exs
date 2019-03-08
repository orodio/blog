defmodule Blog.Repo.Migrations.CreatePostCategories do
  use Ecto.Migration

  def change do
    create table(:post_categories) do
      add(:post_id, references(:posts, on_delete: :nothing))
      add(:category_id, references(:categories, on_delete: :nothing))

      timestamps()
    end

    create(index(:post_categories, [:post_id]))
    create(index(:post_categories, [:category_id]))
    create(unique_index(:post_categories, [:post_id, :category_id]))
  end
end
