import Foundation
import RxSwift
import RxCocoa

public class Subject {

    public static let shared = Subject()

    private init() { }

    public var songDidUpdate = PublishRelay<(Song, Action)>()
}
