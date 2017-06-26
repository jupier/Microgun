defmodule Microgun do

    import Supervisor.Spec

    @version '0.0.1'

    @method :get

    @headers [
        ['test', 'test']
    ]

    @url 'http://google.com'

    @responses []

    defmodule Holes do
        defstruct [:id, :status, :code, :data]
    end

    def test do
        test(10)
    end

    def test(times) do
        IO.puts 'Microgun is going to test #{@url} #{times} times....'

        {:ok, pid} = Task.Supervisor.start_link()
        children = [
            supervisor(Task.Supervisor, [[name: Microgun.TaskSupervisor]])
        ]

        exec(times, RequestUtils.get(@url, []))
            |> Task.yield_many
            |> Enum.map(fn {task, res} -> parseResponse(task, res) end)
    end

    defp parseResponse(task, res) do

        case res do
            {:ok, data} ->
                %Holes{id: task.ref, status: :ok, code: elem(data, 1), data: elem(data, 3)}
            {:ko, data} ->
                %Holes{id: task.ref, status: :ko, code: elem(data, 1), data: elem(data, 3)}
        end

    end

    defp exec(times, func, tasks \\ []) when (times > 0) do
        task = Task.Supervisor.async(Microgun.TaskSupervisor, fn -> func end)
        exec(times - 1, func, [task | tasks])
    end
    defp exec(0, _, tasks) do
       tasks
    end
end