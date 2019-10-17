import Foundation

public enum ObservedType {
    case song
}

public protocol Observer: class {}

public protocol SongObserver: Observer {
    func didUpdate(song: Song, action: Action)
}

// Wrapper class that will hold the weak value of subscribers, else VCs are gonna be retained since they will be stored inside singleton object (that is alive through whole application lifecycle)
public class WeakObserver {
    weak var value: Observer?
    var types: Set<ObservedType>

    init(value: Observer?, subscribedFor types: [ObservedType]) {
        self.value = value
        self.types = Set(types)
    }
}

public protocol SubjectProtocol: class {
    func subscribe(_ observer: Observer, for types: ObservedType...)
    func unsubscribe(_ observer: Observer, from type: ObservedType)
    func unsubscribe(_ observer: Observer)
    func unsubscribeReleasedObservers() // Used for unsubscribing all observers that are nil
}

public class Subject: SubjectProtocol {

    public static let shared = Subject()

    private init() { }

    private var observers: [WeakObserver] = []

    public func subscribe(_ observer: Observer, for types: ObservedType...) {
        let index = observers.firstIndex(where: { $0.value === observer })

        if let _index = index {
            types.forEach({ observers[_index].types.insert($0) })
        } else {
            observers.append(WeakObserver(value: observer, subscribedFor: types))
        }
        print("Number of subscribers: \(observers.count)")
    }

    public func unsubscribe(_ observer: Observer, from type: ObservedType) {
        guard let index = observers.firstIndex(where: { $0.value === observer }) else { return } // Address comparison
        observers[index].types.remove(type)
        print("Number of subscribers: \(observers.count)")
    }

    public func unsubscribe(_ observer: Observer) {
        observers = observers.filter({ $0.value !== observer })
        print("Number of subscribers: \(observers.count)")
    }

    // This method has to be called manually on deinit of some observer object
    public func unsubscribeReleasedObservers() {
        observers = observers.filter({ $0.value != nil })
        print("Number of subscribers: \(observers.count)")
    }
}

extension Subject {
    public func publish(_ action: Action, of song: Song) {
        observers
            .filter{ $0.types.contains(.song) }
            .forEach { (observer) in
                guard let songObserver = observer.value as? SongObserver else { return }
                songObserver.didUpdate(song: song, action: action)
        }
    }
}
