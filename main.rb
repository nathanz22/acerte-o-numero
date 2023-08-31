# Jogo
class Jogo
  # Imprime uma linha personalizada
  def self.linha(lenght = 50)
    puts ''.center(lenght, '=-')
  end

  # Para quando o usuário interromper o script
  def self.interrupcao
    puts "\n\e[33mINTERRUPÇÃO | O usuário preferiu interromper\e[0m"
    linha
    exit # Força a parada do script
  end

  # Pede um número ao usuário
  def self.input_num(msg = 'Digite um número inteiro: ')
    loop do
      print msg
      num = Integer(gets.chomp) # Pede um número ao usuário
      return num if num >= 0 && num <= 9 # Retorna o número caso o mesmo esteja entre 0 e 9

      puts "\e[31mERRO | Valor deve estar entre 0 e 9\e[0m"
    rescue ArgumentError # Caso o valor digitado não seja um número inteiro
      puts "\e[31mERRO | Digite um número inteiro\e[0m"
    rescue Interrupt # Caso o usuário interrompa o script
      interrupcao
    end
  end

  # Sorteia um número entre 0 e 9
  def self.drawn_num
    rand(0..9)
  end

  def self.print_victory(count)
    if count == 1 # Caso o usuário acerte na 1ª tentativa
      puts "\e[32m - De primeira! Parabéns!\e[0m"
    elsif count == 2 # Caso o usuário acerte na 2ª tentativa
      puts "\e[32m - De segunda! Parabéns!\e[0m"
    else # Caso  o usuário acerte na 3ª tentativa
      puts "\e[32m - Na última tentativa, mas você CONSEGUIU!\e[0m"
    end
  end

  # Limpa o terminal
  def self.limpar_terminal
    system('clear') || system('cls') || puts("\e[H\e[2J")
  end

  # Pergunta ao usuário se ele deseja continuar ou encerrar
  def self.continuar?
    loop do
      print 'Deseja continuar? [S/N]: '
      choice = String(gets.chomp).strip.upcase
      case choice
      when 'S', 'SIM' # Caso o usuário tenha escolhido continuar
        limpar_terminal
        return true
      when 'N', 'NAO', 'NÃO' # Caso o usuário escolha NÃO continuar
        puts "\e[33mENCERRAMENTO | Até mais!\e[0m"
        return false
      else # Caso o usuário digite uma opção inválida
        puts "\e[31mERRO | Opção inválida! Digite \"S\" para SIM ou \"N\" para NÃO\e[0m"
      end
    rescue Interrupt # Caso o usuário interrompa o script
      interrupcao
    end
  end
end

# Código principal
def main
  continue = true # Condição para o while
  while continue
    Jogo.linha
    puts ' Acerte o Número! Digite um número entre 0 e 9 '.center(50, ' ')
    Jogo.linha
    cont = 0 # Conta as tentativas do usuário
    num = Jogo.drawn_num # Número sorteado
    nums = [] # Lista de números que o usuário tentou
    acertou = false # Para mostrar ou não uma mensagem caso o usuário acerte
    while cont <= 2 # Repetirá 3 vezes
      cont += 1
      num_escolhido = Jogo.input_num " #{cont}ª tentativa: " # Pede um número ao usuário
      nums.push num_escolhido # Adiciona o número escolhido pelo usuário à lista de números
      if num_escolhido == num # Verifica se o usuáriu acertou ou não
        Jogo.linha 30
        Jogo.print_victory cont
        acertou = true # Para não mostrar o número sorteado (já que o usuário já sabe)
        break
      elsif (nums.count num_escolhido) == 2 # Caso o usuário digite um número já digitado anteriormente
        puts "\e[33mREPETIDO | Número já digitado anteriormente, tente outro!\e[0m"
        nums.pop
        cont -= 1
      else # Caso o usuário não acerte
        puts "\e[31m - Errou...\e[0m"
      end
    end
    puts " - Número sorteado: \e[33m#{num}\e[0m" unless acertou # Mostra o número sorteado caso o usuário não acerte
    puts " - Números tentados: \e[35m#{nums.join(', ')}\e[0m" # Mostra as tentativas do usuário
    Jogo.linha 30
    continue = Jogo.continuar? # Pergunta ao usuário se quer continuar ou encerrar
  end
  Jogo.linha
end

main # Chama o código principal
