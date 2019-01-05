defmodule ZzWeb.LayoutView do
  use ZzWeb, :view

  def get_img do
    # url = "http://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"
    # url = HTTPoison.get!(url).body |> Jason.decode!()
    # url = url["images"] |> List.first()
    # "http://s.cn.bing.net" <> url["url"]
    b = HTTPoison.get!("https://touduyu.com").body
    [url] = Floki.attribute(b, "body", "style")
    url
  end
end
