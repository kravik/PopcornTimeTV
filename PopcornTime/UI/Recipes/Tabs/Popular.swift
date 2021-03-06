

import TVMLKitchen
import PopcornKit

struct Popular: TabItem {
    
    let title = "Popular"
    let fetchType: Trakt.MediaType
    
    init(_ type: Trakt.MediaType) {
        fetchType = type
    }
    
    func handler() {
        var recipe: CatalogRecipe!
        switch fetchType {
        case .movies:
            recipe = CatalogRecipe(title: title, fetchBlock: { (page, completion) in
                PopcornKit.loadMovies(page, filterBy: .popularity, completion: { (movies, error) in
                    if let movies = movies { completion(movies.map({$0.lockUp}).joined(separator: "")) }
                    ActionHandler.shared.serveCatalogRecipe(recipe)
                })
            })
        case .shows:
            recipe = CatalogRecipe(title: title, fetchBlock: { (page, completion) in
                PopcornKit.loadShows(page, filterBy: .popularity, completion: { (shows, error) in
                    if let shows = shows { completion(shows.map({$0.lockUp}).joined(separator: "")) }
                    ActionHandler.shared.serveCatalogRecipe(recipe)
                })
            })
        default: return
        }
    }
}
