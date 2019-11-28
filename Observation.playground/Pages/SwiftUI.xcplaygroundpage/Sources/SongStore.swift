import Foundation
import Combine
import SwiftUI

 // MARK: - Shorter way: store with @Published property wrapper -

public class SongStore: ObservableObject {

    private init() {}
    public static let shared = SongStore()

    @Published public var songs: [Song] = HardcodedSongs.ironMaiden // When value is changed, publisher under the hood will automatically trigger send() and view that observes this will automatically update its body
}

extension SongStore {
    public func didUpdate(songs: [Song]) {
        self.songs = songs
    }
}

// MARK: - Longer way: store without property wrapper (using objectWillChange publisher) -

//public class SongStore: ObservableObject {
//
//    private init() {}
//    public static let shared = SongStore()
//
//    public let objectWillChange = ObjectWillChangePublisher() // SwiftUI provides us with a default objectWillChange property, but it doesn’t work in the current beta so currently new one with the same name as in the protocol def. has to be created
//    public var songs: [Song] = HardcodedSongs.ironMaiden
//}
//
//extension SongStore {
//    public func didUpdate(songs: [Song]) {
//        objectWillChange.send() // Manually triggering the change
//        self.songs = songs
//    }
//}
