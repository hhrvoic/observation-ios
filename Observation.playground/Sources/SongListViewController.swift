import UIKit
import Foundation
import NotificationCenter
import PlaygroundSupport

public let songCellReuseId = "SongCell"

extension UITableViewCell {

    public func configure(with item: Song) {
        textLabel?.text = item.name
        detailTextLabel?.text = item.author
    }
}

open class SongListViewController: UITableViewController {

    private var datasource = HardcodedSongs.ironMaiden

    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: songCellReuseId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: songCellReuseId)
        let item = datasource[indexPath.row]

        cell.configure(with: item)

        return cell
    }

    open func didUpdate(song: Song, action: Action) {
        switch action {
        case .update:
            guard let index = datasource.firstIndex(where: { $0.id == song.id }) else { return }
            datasource[index] = song
        case .delete:
            guard let index = datasource.firstIndex(where: { $0.id == song.id }) else { return }
            datasource.remove(at: index)
        case .create:
            datasource.append(song)
        }
        tableView.reloadData()
    }

}
