/*:
 [⬅️](@previous) [➡️](@next)

*/

import PlaygroundSupport
import RxSwift
import UIKit
import RxCocoa

public class SongListViewControllerRxBinding: SongListViewController {
    let songStore = SongStore.shared
    private let _disposeBag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil // We will define datasource down below, in reactive way, by binding to tableView.rx.items

        songStore.songs
            .bind(to: tableView.rx.items) {
                (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: songCellReuseId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: songCellReuseId)
                cell.configure(with: item)
                return cell
        }
        .disposed(by: _disposeBag)
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
