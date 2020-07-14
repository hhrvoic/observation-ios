import Foundation

public struct Song {
    public let id: String = UUID().uuidString
    public var name: String
    public var author: String
    public var isFavourite: Bool

    init(name: String, author: String, isFavourite: Bool = false) {
        self.name = name
        self.author = author
        self.isFavourite = isFavourite
    }
}

public struct HardcodedSongs {
    public static let ironMaiden: [Song] = {
        let author = "Iron Maiden"
        let names = ["The number of the beast", "Hallowed be thy name", "Fear of the dark"]
        return names.map { Song(name: $0, author: author) }
    }()
}

public enum Action {
    case update
    case create
    case delete
}
