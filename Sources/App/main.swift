import Vapor
import VaporPostgreSQL

let drop = Droplet()
drop.preparations.append(Person.self)

do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    assertionFailure("Error adding provider: \(error)")
}

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "Shea"]
    ])
}

drop.get("/hello") { request in
    return "Hello World!"
}

drop.get("/people") { request in
    let people = [Person(name: "Sean", favoriteCity: "New York"),
                Person(name: "Tom", favoriteCity: "Philadelphia"),
                Person(name: "Sara", favoriteCity: "Pittburgh")]
    let friendsNode = try people.makeNode()
    let nodeDictionary = ["people": friendsNode]
    return try JSON(node: nodeDictionary)
}

drop.post("person") { req in
    var person = try Person(node: req.json)
    try person.save()
    return try person.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
