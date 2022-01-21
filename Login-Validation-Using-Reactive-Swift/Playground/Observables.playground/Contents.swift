import UIKit
import RxSwift
import RxCocoa

/******************************** Observables ******************************/
let one = 1
let two = 2
let three = 3

// MARK: just (It accepts only one value)
/* let justObservable = Observable<Int>.just(one)
justObservable.subscribe { element in
    print(element)
} onError: { err in
    print(err.localizedDescription)
} onCompleted: {
    print("Completed!")
} */

// MARK: of (It accepts variadic parameter)
/* let ofObservable = Observable<Int>.of(one, two, three)
ofObservable.subscribe { element in
    print(element)
} onError: { err in
    print(err.localizedDescription)
} onCompleted: {
    print("Completed!")
} */

// MARK: from (It accepts array)
/* let fromObservable = Observable<Int>.from([one, two, three])
fromObservable.subscribe { element in
    print(element)
} onError: { err in
    print(err.localizedDescription)
} onCompleted: {
    print("Completed!")
} */


// MARK: empty (It never emit anything and complete the sequence directly)
/* let emptyObservable = Observable<Any>.empty()
emptyObservable.subscribe(
    onNext: { element in
        print(element)
    },
    onCompleted: {
        print("Completed")
    }
) */

// MARK: never (It never emit anything and never terminate)
/* let neverObservable = Observable<Any>.never()
neverObservable.subscribe(
    onNext: { element in
        print(element)
    },
    onCompleted: {
        print("Completed")
    }
) */
