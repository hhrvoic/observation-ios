/*:
 [⬅️](@previous) [➡️](@next)

*/

import UIKit
import Foundation
import NotificationCenter
import PlaygroundSupport

let notificationName = Notification.Name("songDidChange")

// No need to manually remove observer on deinit here, since we are using selector based addObserver, subscription is removed automatically since iOS 9
public class SongListViewControllerNCSelector: SongListViewController {

    private let _notificationCenter = NotificationCenter.default

    override public func viewDidLoad() {
        _notificationCenter.addObserver(self,
                                        selector: #selector(receiveSongDidUpdate(notification:)),
                                        name: notificationName,
                                        object: nil)
    }

    @objc func receiveSongDidUpdate(notification: Notification) {
        guard
            let _updatedSong = notification.userInfo?["song"] as? Song,
            let _action = notification.userInfo?["action"] as? Action
        else { return }
        didUpdate(song: _updatedSong, action: _action)
    }
}

let viewController = SongListViewControllerNCSelector()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    var song = HardcodedSongs.ironMaiden[1]
    song.name = "Run to the hills"
    var notification = Notification(name: notificationName)
    notification.userInfo = ["song": song, "action": Action.update]
    NotificationCenter.default.post(notification)
}

