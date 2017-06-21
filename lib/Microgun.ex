defmodule Microgun do
  @moduledoc """
  Documentation for Microgun.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Microgun.hello
      :world

  """
  def hello do
    :world
  end


  def get(url) do

    :ibrowse.send_req(url, [], :get)

  end


   def getNTimes() do

     Call.exec(5, get 'http://google.com')

   end


end


defmodule Call do

    def exec(times, func) when (times > 0)do

     func
     exec(times - 1, func)

    end

    def exec(0) do

      false

    end

end
