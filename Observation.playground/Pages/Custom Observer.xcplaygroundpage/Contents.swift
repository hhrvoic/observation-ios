/*:
 [⬅️](@previous) [➡️](@next)

*/

import Foundation
import UIKit
import PlaygroundSupport

public class SongListViewControllerCO: SongListViewController {
    let subject = Subject.shared
    var datasource: [Song] = HardcodedSongs.ironMaiden

    deinit {
        print("SongListViewController: released from VC stack")
        subject.unsubscribeReleasedObservers()
    }

    override public func viewDidLoad() {
        print("SongListViewController: subscribing for song changes")
        subject.subscribe(self, for: .song)
    }
}

extension SongListViewControllerCO: SongObserver {}

let viewController = SongListViewControllerCO()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    let subject = Subject.shared
    var song = HardcodedSongs.ironMaiden[1]
    song.name = "Run to the hills"
    subject.publish(.update, of: song)
}
