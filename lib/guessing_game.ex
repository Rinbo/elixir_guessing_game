defmodule GuessingGame do
  
  def begin do
    IO.puts "Welcome to this game!"
    game_loop(:initial, Enum.random(0..10))
  end

  defp game_loop(type, magic_number) do
    guess = ask_for_input(type)
    case check_guess(guess, magic_number) do
      :argument_error -> game_loop(:invalid_input, magic_number)
      :guess_lower -> game_loop(:guess_lower, magic_number)
      :guess_higher -> game_loop(:guess_higher, magic_number)
      :win -> IO.puts("You guessed correctly! Well done! Goodbye!")      
    end
  end

  defp ask_for_input(:initial), do: IO.gets("Guess a number between 0 and 10: ") |> String.trim

  defp ask_for_input(:guess_higher), do: IO.gets("To low! Guess higher: ") |> String.trim

  defp ask_for_input(:guess_lower), do: IO.gets("To high! Guess lower: ") |> String.trim
  
  defp ask_for_input(:invalid_input), do: IO.gets("Invalid input. Try again: ") |> String.trim

  defp check_guess(guess, magic_number) do
    guess = validate(guess)
    cond do
      guess == :error -> :argument_error
      guess > magic_number -> :guess_lower
      guess < magic_number -> :guess_higher
      guess == magic_number -> :win      
    end
  end

  defp validate(guess) do
    case Regex.match?(~r/[\d]/, guess) && String.to_integer(guess) >= 0 && String.to_integer(guess) <= 10 do
      true -> String.to_integer(guess)
      false -> :error
    end    
  end
end
