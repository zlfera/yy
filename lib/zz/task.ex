defmodule Zz.Task do
  alias Zz.TaskGrain, as: Zg

  def run(pid) do
    {:ok, _} = Application.ensure_all_started(:grain)
    p = Agent.get(pid, & &1)
    IO.inspect(p)

    if p != %{} do
      Map.keys(p) |> Enum.each(&(Process.alive?(p[&1]) |> IO.puts()))
      IO.puts("当前任务正在进行中")
    else
      "启动新任务" |> IO.puts()
      u1(b(), pid)
    end
  end
#1
# u="https://trade.gdgrain.com/sgtcTrade-front/sgtc/activity/SAct006"
#body="{\"channelCode\": \"04\",\"currentDate\": \"2019-07-15\"}"
#headers = ["content-type": "application/json;charset=UTF-8"]
#参数固定为04
#options=[params: [channelCode: "04"]]
#{o, url} = HTTPoison.post(uu, body, headers, options)
#2
#uu = "https://trade.gdgrain.com/sgtcTrade-front/sgtc/targets/STar001"
#headers = ["content-type": "application/json;charset=UTF-8"]
#body="{\"channelCode\": \"04\",\"activityNum\": \"8C1CAECE87EF4EAF8986D11BA21E980F\"}"
#options=[params: ["activityNum": "0635D66BAC634FD382476F54C9959AC6"]]
#{o, url} = HTTPoison.post(uu, "{\"activityNum\":\"0635D66BAC634FD382476F54C9959AC6\"}", headers, options)
#3
#uuu="https://trade.gdgrain.com/sgtcTrade-front/sgtc/commonality/SCus001"
#headers = ["content-type": "application/json;charset=UTF-8"]
#options=[params: [channelCode: "04"]]
#body="{\"channelCode\": \"04\",\"custId\": \"4401117026\"}"
#{o, url} = HTTPoison.post(uuu, body, headers, options)
  def b do
    # u = "http://59.55.120.113:8311/web/bidPriceSpecialWatch?specialNo=1018&specialName=num"
    # uu = "http://59.55.120.113:8311/trade/open/watchSpecial"
    u = "http://59.55.120.113:8311/trade/open/findSpecialMessageByCondition"
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

  def u1(c, pid) do
    if c["success"] == "true" do
      Enum.each(c["row"], fn x ->
        y = x["specialNo"]

        qww = Agent.get(pid, & &1)

        if Map.has_key?(qww, y) do
          Enum.each(Map.keys(qww), fn k ->
            if !Process.alive?(qww[k]) do
              Agent.update(pid, &Map.delete(&1, k))
            end
          end)
        else
          {:ok, pid_list} = Agent.start_link(fn -> [] end)
          i = spawn(Zg, :grain, [y, pid_list])
          Agent.update(pid, &Map.put(&1, y, i))
          p = Agent.get(pid, & &1)
        end
      end)

      Process.sleep(15000)
      u1(b(), pid)
    else
      Process.sleep(10000)
      IO.puts("交易已经结束")
      Agent.update(pid, &Map.drop(&1, Map.keys(&1)))
    end
  end
end
