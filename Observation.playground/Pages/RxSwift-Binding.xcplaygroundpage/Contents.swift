/*:
 [⬅️](@previous) [➡️](@next)

*/

import PlaygroundSupport
import RxSwift
import UIKit
import RxCocoa

public class SongListViewControllerRxBinding: SongListViewController {
    private let songStore = SongStore.shared
    private let disposeBag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil // Datasource is defined in code below by binding to tableView.rx.items (reactive way)

        songStore
            .songs
            .bind(to: tableView.rx.items) { [unowned self] (_, _, item) in // Closure for returning cell that is updated with song item
                let cell = self.instantiateCell()
                cell.configure(with: item)
                return cell
        }
        .disposed(by: disposeBag)
    }
}

let viewController = SongListViewControllerRxBinding()
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    let store = SongStore.shared
    var songs = HardcodedSongs.ironMaiden
    songs[1].name = "Run to the hills"
    store.didUpdate(songs: songs)
}
