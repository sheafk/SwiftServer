import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "Shea"]
    ])
}

drop.get("/hello") { request in
    return "Hello World!"
}

drop.get("/people") { request in
    let people = [Person(name: "Sean", favoriteCity: "New York",identification : 1234),
                Person(name: "Tom", favoriteCity: "Philadelphia", identification : 1235),
                Person(name: "Sara", favoriteCity: "Pittburgh", identification : 1236)]
    let friendsNode = try people.makeNode()
    let nodeDictionary = ["people": friendsNode]
    return try JSON(node: nodeDictionary)
}
drop.resource("posts", PostController())

drop.run()
