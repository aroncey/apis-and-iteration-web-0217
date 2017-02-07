require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  film_link_hash_array = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].map do |item|
        item.map do |k,v|
          if v == character
          item["films"].map do |film|
                  film_link = RestClient.get(film)
                  film_link_hash = JSON.parse(film_link)
                  film_link_hash_array << film_link_hash
              end
            end
          end
      end
    film_link_hash_array
end

def parse_character_movies(film_link_hash)
  # some iteration magic and puts out the movies in a nice list
new_arr = []
  film_link_hash.collect do | film|
  film.collect do | k,v |
      if k == "title"
        new_arr.push(v)
      end
    end
  end
  new_arr
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
