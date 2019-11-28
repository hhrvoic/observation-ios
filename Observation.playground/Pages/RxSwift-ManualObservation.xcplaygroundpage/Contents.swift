/*:
 [⬅️](@previous) [➡️](@next)

*/

import PlaygroundSupport
import RxSwift
import UIKit

public class SongListViewControllerRxBasic: SongListViewController {
    let subject = Subject.shared
    private let disposeBag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()

        subject
            .songDidUpdate
            .asObservable()
            .subscribe(onNext: { [weak self] (song, action) in
                self?.didUpdate(song: song, action: action)
            })
            .disposed(by: disposeBag)
    }
}

let viewController = SongListViewControllerRxBasic()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    let subject = Subject.shared
    var song = HardcodedSongs.ironMaiden[1]
    song.name = "Run to the hills"
    subject.songDidUpdate.accept((song, .update))
}
