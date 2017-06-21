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

end
