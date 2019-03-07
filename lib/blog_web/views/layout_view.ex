defmodule BlogWeb.LayoutView do
  use BlogWeb, :view

  def title(%{page_title: page_title}), do: "qv.vg - #{page_title}"
  def title(_), do: "qv.vg"
end
