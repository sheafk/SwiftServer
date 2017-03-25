import Foundation
import Vapor

struct Person: Model {
    var exists: Bool = false
    var id: Node?
    let name: String
    let favoriteCity: String
    let identification: Int
    
    init(name: String, favoriteCity: String, identification: Int) {
        self.name = name
        self.favoriteCity = favoriteCity
        self.identification = identification
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        favoriteCity = try node.extract("favoriteCity")
        identification = try node.extract("identification")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "name": name,
                               "favoriteCity": favoriteCity,
                               "identification": identification])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("people") { people in
            friends.id()
            friends.string("name")
            friends.string("favoriteCity")
            friends.int("identification")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("people")
    }
}
