import Combine

public extension Publisher {
    func flatMap<A: AnyObject, P: Publisher>(weak obj: A, transform: @escaping (A, Output) -> P) -> AnyPublisher<P.Output, Failure> where P.Failure == Failure {
        return self
            .compactMap { [weak obj] output in
                guard let obj = obj else { return nil }
                return (obj, output)
            }
            .flatMap { obj, output in transform(obj, output) }
            .eraseToAnyPublisher()
    }

    @available(iOS 14.0, *)
    func flatMap<A: AnyObject, P: Publisher>(weak obj: A, transform: @escaping (A, Output) -> P) -> AnyPublisher<P.Output, P.Failure> where Failure == Never {
        return self
            .compactMap { [weak obj] output in
                guard let obj = obj else { return nil }
                return (obj, output)
            }
            .flatMap { obj, output in transform(obj, output) }
            .eraseToAnyPublisher()
    }

    func map<A: AnyObject, T>(weak obj: A, transform: @escaping (A, Output) -> T) -> AnyPublisher<T, Failure> {
        return self
            .compactMap { [weak obj] output in
                guard let obj = obj else { return nil }
                return (obj, output)
            }
            .map { obj, output in transform(obj, output) }
            .eraseToAnyPublisher()
    }

    func map<A: AnyObject, T>(weak obj: A, transform: @escaping (A, Output) -> T) -> Publishers.CompactMap<Self, T> where Failure == Never {
        return self
            .compactMap { [weak obj] output in
                guard let obj = obj else { return nil }
                return transform(obj, output)
            }
    }

    func handleEvents<A: AnyObject>(
        weak obj: A,
        receiveOutput: @escaping (A, Output) -> Void
    ) -> AnyPublisher<Output, Failure> {
        return self
            .handleEvents(receiveOutput: { [weak obj] output in
                guard let obj = obj else { return }
                receiveOutput(obj, output)
            })
            .eraseToAnyPublisher()
    }

    func tryMap<A: AnyObject, T>(weak obj: A, transform: @escaping (A, Output) throws -> T) -> AnyPublisher<T, Error> where Failure == Error {
        return self
            .compactMap { [weak obj] output -> (A, Output)? in
                guard let obj = obj else { return nil }
                return (obj, output)
            }
            .tryMap { obj, output in
                try transform(obj, output)
            }
            .eraseToAnyPublisher()
    }
}

public extension Future where Failure == Error {
    convenience init<A: AnyObject>(weak obj: A, attemptToFulfill: @escaping (A, @escaping (Result<Output, Failure>) -> Void) -> Void) {
        self.init { promise in
            attemptToFulfill(obj, promise)
        }
    }
}
