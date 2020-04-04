class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  # методом map пробегаемся по массиву @letters в котором лежит
  # загаданное слово и если в слове есть ё й преобразуем их в е и
  # остальные буквы возвращаем как есть
  def normalized_letters
    return @letters.map { |letter| normalize_letter(letter) }
  end

  def errors
    return @user_guesses - normalized_letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize_letter(letter))
          letter
        else
          nil
        end
      end
    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    #  Если игра не закончена и если попытки юзера не включают нормализованную букву (текущую)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def won?
    return (normalized_letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end

end
