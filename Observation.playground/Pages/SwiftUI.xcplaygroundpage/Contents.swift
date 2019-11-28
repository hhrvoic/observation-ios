/*:
 [⬅️](@previous) [➡️](@next)

*/

import SwiftUI
import PlaygroundSupport

extension Song: Identifiable {}

struct SongListRow: View {
    let item: Song

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.name)
                .font(.headline)
            Text(item.author)
                .font(.subheadline)
        }
    }
}

struct SongList: View {
    @EnvironmentObject private var songStore: SongStore // Whenever this object changes (when song array changes) view will re-render it's body

    var body: some View {
         List {
            ForEach(songStore.songs) { song in
                SongListRow(item: song)
            }
        }
    }
}

// Make a UIHostingController
let songList = SongList().environmentObject(SongStore.shared) // Brutally easy dependency injection
let viewController = UIHostingController(rootView: songList)
PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
    let store = SongStore.shared
    var songs = HardcodedSongs.ironMaiden
    songs[1].name = "Run to the hills"
    store.didUpdate(songs: songs)
}
