# observation-ios

Demo that shows different kind of state observation techniques in iOS on a basic example with list of songs: 

* NotificationCenter - selector based
* NotificationCenter - closure based
* Custom observer pattern
* RxSwift - manual triggering with publish relay
* RxSwift - binding of songs in shared SongStore to the tableView.rx.items
* SwiftUI - binding of songs in shared SongStore to the List view - using ObservableObject and @Published + @EnvironmentObject as convenience for dependency injection

# Usage

In order to use the playground files you must first open the Rx.workspace, set the scheme to RxCocoa, and build the project (CMD + B) on some iOS simulator.

Shuffle through the pages of Observation.playground to see how different kinds of observation techniques do pretty much the same result. 
