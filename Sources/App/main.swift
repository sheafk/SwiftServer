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
    return try JSON(node: ["people": [
                                    ["id" : 1234, "name": "Sean", "favoriteCity": "New York"],
                                    ["id" : 1235, "name": "Tom", "favoriteCity": "Philadelphia"],
                                    ["id" : 1236, "name": "Sara", "favoriteCity": "Pittburgh"]]
        ])
    let friendsNode = try people.makeNode()
    let nodeDictionary = ["people": friendsNode]
    return try JSON(node: nodeDictionary)
}
drop.resource("posts", PostController())

drop.run()
