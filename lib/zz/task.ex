defmodule Zz.Task do
  alias Zz.TaskGrain, as: Zg

  def run() do
    {:ok, _} = Application.ensure_all_started(:zz)
    u1(b())
  end

  def phone do
    u = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/activity/SAct007"
    body = "{\"channelCode\": \"04\",\"pageNo\": \"1\",\"pageSize\": \"10\"}"
    # options = [params: [channelCode: "04", currentDate: "2019-07-15"]]
    headers = ["content-type": "application/json;charset=UTF-8"]
    {:ok, url} = HTTPoison.post(u, body, headers)
    code = url.body |> Jason.decode!()
    total = code["result"]["total"]
    page_no = ceil(total / 10)

    tasks =
      for p <- 1..page_no do
        # Enum.map(1..page_no, fn p ->
        Task.async(fn ->
          body = "{\"channelCode\": \"04\",\"pageNo\": \"#{p}\",\"pageSize\": \"10\"}"
          {:ok, url} = HTTPoison.post(u, body, headers)
          code = url.body |> Jason.decode!()

          code = code["result"]["activityList"]

          code =
            for x <- code do
              # Enum.map(code, fn x ->
              uuu = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/activity/SAct009"

              options = [params: [activityNum: x["activityNum"], channelCode: "04"]]
              body = "{\"channelCode\": \"04\",\"activityNum\": \"#{x["activityNum"]}\"}"
              {:ok, url} = HTTPoison.post(uuu, body, headers, options)
              code = url.body |> Jason.decode!()
              code["result"]["cusId"]
            end

          for code <- code do
            # Enum.map(code, fn x ->
            # code = x["result"]["cusId"]
            uuuu = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/commonality/SCus001"
            # headers = ["content-type": "application/json;charset=UTF-8"]
            options = [params: [channelCode: "04", custId: code]]
            body = "{\"channelCode\": \"04\",\"custId\": \"#{code}\"}"
            {:ok, url} = HTTPoison.post(uuuu, body, headers, options)
            code = url.body |> Jason.decode!()
            code["result"]
          end
        end)
      end

    Task.yield_many(tasks, 15000)
  end

  # 1
  # u="https://trade.gdgrain.com/sgtcTrade-front/sgtc/activity/SAct006"
  # body="{\"channelCode\": \"04\",\"currentDate\": \"2019-07-15\"}"
  # headers = ["content-type": "application/json;charset=UTF-8"]
  # 参数固定为04
  # options=[params: [channelCode: "04",currentDate: "2019-07-15"]]
  # {o, url} = HTTPoison.post(u, body, headers, options)
  # 2
  # uu = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/targets/STar001"
  # headers = ["content-type": "application/json;charset=UTF-8"]
  # body="{\"channelCode\": \"04\",\"activityNum\": \"8C1CAECE87EF4EAF8986D11BA21E980F\"}"
  # options=[params: ["activityNum": "0635D66BAC634FD382476F54C9959AC6","channelCode": "04"]]
  # {o, url} = HTTPoison.post(uu, body, headers, options)
  # 3
  # uuu = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/activity/SAct009"
  # headers = ["content-type": "application/json;charset=UTF-8"]
  # options=[params: ["activityNum": "0635D66BAC634FD382476F54C9959AC6","channelCode": "04"]]
  # body="{\"channelCode\": \"04\",\"activityNum\": \"8C1CAECE87EF4EAF8986D11BA21E980F\"}"
  # {o, url} = HTTPoison.post(uuu, body, headers, options)
  # 4
  # uuuu="https://trade.gdgrain.com/sgtcTrade-front/sgtc/commonality/SCus001"
  # headers = ["content-type": "application/json;charset=UTF-8"]
  # options=[params: [channelCode: "04",custId: "4402118018"]]
  # body="{\"channelCode\": \"04\",\"custId\": \"4401117026\"}"
  # {o, url} = HTTPoison.post(uuuu, body, headers, options)
  def b do
    # u = "http://59.55.120.113:8311/web/bidPriceSpecialWatch?specialNo=1018&specialName=num"
    # uu = "http://59.55.120.113:8311/trade/open/watchSpecial"
    u = "http://59.55.120.113:8311/trade/open/findSpecialMessageByCondition"
    # u = "http://59.55.120.113:8311/trade/biddingAbout/tradeRequestListWatch"
    # uuuu = "http://59.55.120.113:8311/web/bidPrice"
    # headers = [referer: u]
    options = [params: [ckType: "plan", specialType: "7801"]]
    {o, url} = HTTPoison.post(u, "", [], options)

    if o == :ok do
      url.body |> Jason.decode!()
    else
      b()
    end
  end

  def u1(c) do
    tasks =
      for x <- c["row"] do
        # Enum.each(c["row"], fn x ->
        y = x["specialNo"]
        yy = x["selfBS"]
        Task.async(Zg, :grain, [y, yy])
      end

    Task.yield_many(tasks)
  end
end
