import Combine
import RxSwift

extension Observable {
    func asPublisher() -> AnyPublisher<Element, Swift.Error> {
        return Deferred {
            Future<Element, Swift.Error> { promise in
                _ = self.subscribe(
                    onNext: { value in
                        promise(.success(value))
                    },
                    onError: { error in
                        promise(.failure(error))
                    },
                    onCompleted: {
                        // Nothing to do here for Observable
                    }
                )
            }
        }
        .eraseToAnyPublisher()
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    func asPublisher() -> AnyPublisher<Element, Swift.Error> {
        return Deferred {
            Future<Element, Swift.Error> { promise in
                _ = self.subscribe(
                    onSuccess: { value in
                        promise(.success(value))
                    },
                    onFailure: { error in
                        promise(.failure(error))
                    }
                )
            }
        }
        .eraseToAnyPublisher()
    }
}
