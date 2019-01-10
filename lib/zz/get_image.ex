defmodule Zz.GetImage do
  import ZzWeb.LayoutView

  def n do
    [_, i] = Regex.split(~r{\(}, get_img())
    [i, _] = Regex.split(~r{\)}, i)
    image = HTTPoison.get!(i, recv_timeout: 10000).body
    File.write("./priv/static/images/background_image.jpg", image)
    html = HTTPoison.get!("www.youmile.vip", recv_timeout: 10000).body
    File.write("./priv/static/index.html", html)
  end
end
