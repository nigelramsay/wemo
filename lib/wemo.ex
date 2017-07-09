defmodule Wemo do
  @moduledoc """
  Documentation for Wemo.
  """

  def switches do
    Wemo.Switch.all
  end
end
