import Foundation
import RxSwift
import RxCocoa

public struct SongStore {
    
    private init() {}
    
    public static let shared = SongStore()
    private var relay: BehaviorRelay<[Song]> = BehaviorRelay(value: HardcodedSongs.ironMaiden)
}

extension SongStore {
    public func didUpdate(songs: [Song]) {
        relay.accept(songs)
    }
    
    public var songs: Observable<[Song]> {
        return relay.asObservable()
    }
}
