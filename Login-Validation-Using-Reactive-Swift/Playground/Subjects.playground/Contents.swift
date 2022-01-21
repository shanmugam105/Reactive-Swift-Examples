import UIKit
import RxSwift
import RxCocoa

/******************************** Subjects ******************************/
// MARK: PublishSubject

/* let publishSubject = PublishSubject<String>()

publishSubject.onNext("Is anyone listening?")

let subscriptionOne = publishSubject.subscribe { string in
    print(string)
} onError: { err in
    print(err.localizedDescription)
} onCompleted: {
    print("Completed!")
} onDisposed: {
    print("Disposed!")
}
publishSubject.on(.next("1"))
// publishSubject.onCompleted()
// subscriptionOne.dispose()
publishSubject.onNext("2")
publishSubject.onError(ValidationError.address1MustBeEnter) */

// MARK: BehaviorSubject

/* let bihaviorSubject = BehaviorSubject(value: "Initial value")
bihaviorSubject.onNext("Hello 1")
bihaviorSubject.onNext("Hello 123")
bihaviorSubject.subscribe {
    print($0.element!, "First subscriber")
}

bihaviorSubject.onNext("Hello 2")
bihaviorSubject.onNext("Hello 3")
bihaviorSubject.onNext("Hello 4")

bihaviorSubject.subscribe {
    print($0.element!, "Second subscriber")
} */

// MARK: ReplaySubject

/* let replaySubject =  ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1")
replaySubject.onNext("2")
replaySubject.onNext("3")

replaySubject.subscribe {
    print($0.element!)
}
//replaySubject.onNext("4")
//replaySubject.subscribe {
//    print($0.element!)
//} */

// MARK: PublishRelay

/* let publishRelay = PublishRelay<String>()

publishRelay.accept("Knock knock, anyone home?")

let subscriber = publishRelay.subscribe { element in
    print(element)
} onDisposed: {
    print("Disposed!")
}
// subscriber.dispose()
publishRelay.accept("Anyone home?") */

// MARK: BehaviorRelay

/* let behaviorRelay = BehaviorRelay(value: "Initial value")

behaviorRelay.accept("New initial value")

behaviorRelay.subscribe {
    print($0.element!)
}
behaviorRelay.accept("Final value") */
