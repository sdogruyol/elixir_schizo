defmodule Schizo do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Schizo.Worker, [arg1, arg2, arg3])
    ]

    opts = [strategy: :one_for_one, name: Schizo.Supervisor]
    Supervisor.start_link(children, opts)
  end


  @doc """
    Uppercases every other string

    iex> Schizo.uppercase("foo bar")
    "foo BAR"
  """
  def uppercase(string) do
    transform_every_other_word(string, &uppercaser/1)
  end

  @doc """
    Unvowels every other string

    iex > Schizo.unvowel("foo bar")
    "foo br"
  """
  def unvowel(string) do
    transform_every_other_word(string, &unvoweler/1)
  end

  def transform_every_other_word(string, transformation) do
    # Split strings on spaces into a list of words
    words = String.split(string)
    # Transfrom every other word (uppercasing)
    words_with_index = Stream.with_index(words)
    transformed_words = Enum.map(words_with_index, transformation)
    # Join the words back with spaces
    Enum.join(transformed_words, " ")
  end

  def uppercaser({word, index}) do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> String.upcase(word)
    end
  end

  def unvoweler({word, index}) do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> Regex.replace(~r([aeiou]), word, "")
    end
  end
end
