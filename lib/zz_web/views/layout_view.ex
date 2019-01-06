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

  def get_text do
    url = "http://m.wufazhuce.com/one/" |> HTTPoison.get!()
    [_, _, _, _, _, _, {_, cookie}, _, _, _] = url.headers
    body = url.body |> Floki.find("div .ui-content script")
    [{_, _, [token]}] = body
    [_, token] = Regex.split(~r{= '}, token)
    [token, _] = ~r{';} |> Regex.split(token)

    res =
      HTTPoison.request!(
        :post,
        "http://m.wufazhuce.com/one/ajaxlist/" <> "0" <> "?_token=" <> token,
        "",
        [{"Cookie", cookie}]
      )

    [h | _] = Jason.decode!(res.body)["data"]
    %{content: h["content"], text_authors: h["text_authors"]}
  end
end
