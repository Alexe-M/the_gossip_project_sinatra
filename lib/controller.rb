require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}   #une commande de Sinatra qui sert à rendre (afficher) une view en utilisant un fichier .erb
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do 
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params[:id])}
  end


end




# Le programme va récupérer les informations du formulaire avec params ;
# Il enregistre ces informations dans un fichier CSV grâce à notre classe Gossip .new et .save;
# Il redirige l'utilisateur vers la page d'accueil grâce au 'redirect'