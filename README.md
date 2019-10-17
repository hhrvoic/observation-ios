# observation-ios

Demo that shows different kind of state observation techniques in iOS on a basic example with list of songs: 

* NotificationCenter - selector based
* NotificationCenter - closure based
* Custom observer pattern
* RxSwift - manual triggering with publish relay
* RxSwift - binding of songs in shared SongStore to the tableView.rx.items
* SwiftUI - binding of songs in shared SongStore to the List view - using ObservableObject and @Published + @EnvironmentObject as convenience for dependency injection

# Usage

Open Rx.workspace and shuffle through the Observation.playground to see different kinds of techniques to do pretty much the same result. 
