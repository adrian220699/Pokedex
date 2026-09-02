//
//  PokemonMapper.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

extension PokemonDTO {
    
    //MARK: - List Mapper
    
    
    func toListDomain() -> Pokemon {

        
        let typeNames = types.map { pokemonTypeDTO in
            return pokemonTypeDTO.type.name
        }

        let spritesEntity = Sprites(
            normal: sprites.frontDefault ?? "",
            shiny: sprites.frontShiny ?? ""
        )

        return Pokemon(
            id: id,
            name: name,
            types: typeNames,
            image: spritesEntity,
            move: [],
            description: "",
            location: [],
            characteristics: ""
        )
    }
    
    
    //MARK: - Detail Mapper
    
    func toDetailDomain(species: PokemonSpeciesDTO, encounters: [PokemonEncounterDTO]) -> Pokemon {
        
        // Types
        
        let typeNames = types.map { pokemonTypeDTO in
            return pokemonTypeDTO.type.name
        }
        
        // Sprites
        
        let spritesEntity = Sprites(
            normal: sprites.frontDefault ?? "",
            shiny: sprites.frontShiny ?? ""
        )
        
        // Moves
        
        let movePokemon = moves.map { moveDTO in
            return moveDTO.move.name
        }
        
        // Description
        
        let description = species.flavor_text_entries.first { entry in
            
            return entry.language.name == "es"
            
        }?.flavor_text ?? ""
        
        
        // Locations
        
        let pokemonLocations = encounters.map { PokemonEncounterDTO in
            return PokemonEncounterDTO.location_area.name
            
        }
        
        

      
        
        // Entity
        
        return Pokemon(
            
            id: id,
            name: name,
            types: typeNames,
            image: spritesEntity,
            move: movePokemon,
            description: description,
            location: pokemonLocations,
            characteristics: ""
            
            
        )
    }
}
