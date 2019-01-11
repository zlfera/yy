defmodule ZzWeb.LayoutView do
  use ZzWeb, :view

  def get_text do
    url = "./priv/static/index.html" |> File.read!()
    Jason.decode!(url)
  end
end
