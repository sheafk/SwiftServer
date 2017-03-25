import Foundation
import Vapor

struct Person: Model {
    var exists: Bool = false
    var id: Node?
    let name: String
    let favoriteCity: String
    
    init(name: String, favoriteCity: String) {
        self.name = name
        self.favoriteCity = favoriteCity
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        favoriteCity = try node.extract("favoriteCity")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "name": name,
                               "favoriteCity": favoriteCity
                               ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("people") { people in
            people.id()
            people.string("name")
            people.string("favoriteCity")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("people")
    }
}
