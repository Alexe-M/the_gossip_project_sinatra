require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|         #Retirer le point une fois qu'on appelle depuis le dossier mère
      csv << [@author, @content]
    end
  end

  ## Déclaration de la méthode de classe (self.all) pour appeler directement de la classe Gossip sans avoir besoin de créer un objet. 
  def self.all 
    all_gossips = []     #initialise un tableau vide pour y stocker tous les gossips récupérés du fichier CSV
    CSV.foreach("./db/gossip.csv", "r") do |csv_line| # Parcourt chaque ligne du dossier CSV en mode lecture comme le 'r' l'indique.
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) #on crée un gossip avec les infos de la ligne; i.e on crée une nouvelle instance de la classe Gossip avec l'auteur et le contenu. Chaque nouvelle instance de Gossip est ajoutée au tableau all_gossips.
    end
    return all_gossips   #retourne le tableau qui contient maintenant tous les gossips sous forme de tableau de hashes.
  end
  ## Cette méthode va récupérer chacune des lignes de notre CSV, en fait un objet Gossip avec son author et content puis ressort un array avec tous nos potins.

  def self.find(id)
    all_gossips = self.all    #Cela appelle la méthode de classe all de la classe Gossip qui retourne le tableau contenant tous les gossips, ensuite stocké dans la variable all_gossips.
    return all_gossips[id.to_i-1]    #récupère le gossip correspondant dans le tableau all_gossips.
  end

end


# gossip = Gossip.find(5)
# puts "Gossip 1 - Auteur : #{gossip.author}, Potin : #{gossip.content}"

# gossip = Gossip.find(6)
# puts "Gossip 2 - Auteur : #{gossip.author}, Potin : #{gossip.content}"

# gossip = Gossip.find(7)
# puts "Gossip 3 - Auteur : #{gossip.author}, Potin : #{gossip.content}"



