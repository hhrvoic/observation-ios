/*:
 [➡️](@next)

*/

import UIKit
import Foundation
import NotificationCenter
import PlaygroundSupport

let notificationName = Notification.Name("songDidChange")

public class SongListViewControllerNCClosure: SongListViewController {

    var observationToken: Any?
    private let _notificationCenter = NotificationCenter.default

    override public func viewDidLoad() {
        super.viewDidLoad()
        observationToken = _notificationCenter.addObserver(forName: notificationName, object: nil, queue: nil) { [weak self] notification in
            guard let _updatedSong = notification.userInfo?["song"] as? Song,
                let _action = notification.userInfo?["action"] as? Action
                else { return }
            self?.didUpdate(song: _updatedSong, action: _action)
        }
    }

    // On deiinit of class that wraps/holds the observation token you should remove subscription because it will stay alive (this only happens when using closure based addObserver method, as can discussed here) https://oleb.net/blog/2018/01/notificationcenter-removeobserver/
    deinit {
        _notificationCenter.removeObserver(observationToken)
    }
}

let viewController = SongListViewControllerNCClosure()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    var song = HardcodedSongs.ironMaiden[1]
    song.name = "Run to the hills"
    var notification = Notification(name: notificationName)
    notification.userInfo = ["song": song, "action": Action.create]
    NotificationCenter.default.post(notification)
}
