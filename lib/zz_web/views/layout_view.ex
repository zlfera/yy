defmodule ZzWeb.LayoutView do
  use ZzWeb, :view

  def get_text do
    url = "https://www.youmile.vip/index.html" |> HTTPoison.get!()
    Jason.encode!(url.body)
  end
end
