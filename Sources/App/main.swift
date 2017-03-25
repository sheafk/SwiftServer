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
}
drop.resource("posts", PostController())

drop.run()
