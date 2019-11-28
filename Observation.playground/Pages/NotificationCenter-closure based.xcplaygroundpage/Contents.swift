/*:
 [➡️](@next)

*/

import UIKit
import Foundation
import NotificationCenter
import PlaygroundSupport

let notificationName = Notification.Name("songDidChange")

public class SongListViewControllerNCClosure: SongListViewController {

    private var observationToken: Any?
    private let notificationCenter = NotificationCenter.default

    override public func viewDidLoad() {
        super.viewDidLoad()
        observationToken = notificationCenter.addObserver(forName: notificationName, object: nil, queue: nil) { [unowned self] notification in
            guard
                let updatedSong = notification.userInfo?["song"] as? Song,
                let action = notification.userInfo?["action"] as? Action
            else { return }
            self.didUpdate(song: updatedSong, action: action)
        }
    }

    // On deiinit of class that wraps/holds the observation token you should remove subscription
    // Otherwise it will stay alive, this only happens when using closure based addObserver method
    // As discussed here https://oleb.net/blog/2018/01/notificationcenter-removeobserver/

    deinit {
        notificationCenter.removeObserver(observationToken)
    }
}

let viewController = SongListViewControllerNCClosure()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    var song = HardcodedSongs.ironMaiden[1]
    song.name = "Run to the hills"
    var notification = Notification(name: notificationName)
    notification.userInfo = ["song": song, "action": Action.update]
    NotificationCenter.default.post(notification)
}
