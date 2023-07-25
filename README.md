
# 🇬🇧 English:

## 🌌 Combine Extensions & RxSwift to Combine Conversion

This repository provides useful extensions for Apple's Combine framework and tools to assist transitioning from RxSwift to Combine.

### 🛠 Extensions for Weak References

Keeping memory safe is crucial when dealing with asynchronous and reactive programming. Our custom extensions for `Publisher` allow you to fluently and readably use weak references, helping to prevent memory leaks.

Key extensions:

- **`map(weak:transform:)`**: Transforms the publisher's output using a weakly referenced object.
  
- **`flatMap(weak:transform:)`**: Transforms the publisher's output into a new publisher, using a weakly referenced object.
  
- **`handleEvents(weak:transform:)`**: Tracks lifecycle events of the publisher, using a weakly referenced object.
  
- **`tryMap(weak:transform:)`**: Transforms the publisher's output or throws an error, using a weakly referenced object.
  
- **`Future(weak:)`**: Allows initializing a `Future` using a weak reference.

Check out the detailed examples above for deeper understanding.

### 🔄 RxSwift to Combine Conversion

Migrating from RxSwift to Combine can be a challenging task. Our tools simplify this process, enabling smoother conversion from `Observable` and `Single` to `AnyPublisher`.

Key methods:

- **`asPublisher()` for `Observable`**: Converts an RxSwift `Observable` into a Combine `AnyPublisher`.
  
- **`asPublisher()` for `Single`**: Converts an RxSwift `Single` into a Combine `AnyPublisher`.

Take a look at the examples provided below to see how these tools can be integrated into your UIKit and SwiftUI projects.

---

# 🇧🇷 Português:

## 🌌 Extensões Combine & Conversão de RxSwift para Combine

Este repositório fornece extensões úteis para o framework Combine da Apple e ferramentas para ajudar na transição do RxSwift para o Combine.

### 🛠 Extensões para Referências Fracas

Manter a memória segura é fundamental ao lidar com programação assíncrona e reativa. Nossas extensões personalizadas para `Publisher` permitem que você use referências fracas (`weak`) de maneira mais fluente e legível, ajudando a prevenir vazamentos de memória.

Principais extensões:

- **`map(weak:transform:)`**: Transforma a saída do publisher usando um objeto referenciado de forma fraca.
  
- **`flatMap(weak:transform:)`**: Transforma a saída do publisher em um novo publisher, usando um objeto referenciado de forma fraca.
  
- **`handleEvents(weak:transform:)`**: Acompanha eventos de ciclo de vida do publisher, usando um objeto referenciado de forma fraca.
  
- **`tryMap(weak:transform:)`**: Transforma a saída do publisher ou lança um erro, usando um objeto referenciado de forma fraca.
  
- **`Future(weak:)`**: Permite inicializar um `Future` usando uma referência fraca.

Veja os exemplos detalhados acima para uma compreensão mais profunda.

### 🔄 Conversão de RxSwift para Combine

A migração do RxSwift para o Combine pode ser uma tarefa desafiadora. Nossas ferramentas simplificam este processo, permitindo uma conversão mais suave de `Observable` e `Single` para `AnyPublisher`.

Principais métodos:

- **`asPublisher()` para `Observable`**: Converte um `Observable` do RxSwift em `AnyPublisher` do Combine.
  
- **`asPublisher()` para `Single`**: Converte um `Single` do RxSwift em `AnyPublisher` do Combine.

Dê uma olhada nos exemplos a seguir para ver como essas ferramentas podem ser integradas em seus projetos UIKit e SwiftUI.

---

<br>

# 🔄 `map(weak:transform:)`

## 🇬🇧 English:
The `map(weak:transform:)` extension for `Publisher` streamlines transformations on the publisher's output using a weakly referenced object. It's designed to not only prevent memory leaks due to strong reference cycles but also to provide a more fluent and readable syntax.

**Parameters**:
- `obj`: The object to be weakly referenced.
- `transform`: The function to apply to the output.

## 🇧🇷 Português:
A extensão `map(weak:transform:)` para `Publisher` permite transformações na saída do publisher usando uma referência fraca. Ela foi projetada não só para prevenir vazamentos de memória devido a ciclos de referência forte, mas também para fornecer uma sintaxe mais fluente e legível.

**Parâmetros**:
- `obj`: O objeto a ser referenciado de forma fraca.
- `transform`: A função a ser aplicada na saída.

## 📖 Example (Exemplo):

```swift
class SampleClass {
    var description: String = "Sample Description"

    func transformData(data: AnyPublisher<String, Never>) {
        data.map(weak: self) { weakSelf, value in
            "\(value) processed by \(weakSelf.description)"
        }
        .sink(receiveValue: { print($0) })
    }
}
```
---

# 🔄 `flatMap(weak:transform:)`

## 🇬🇧 English:
The `flatMap(weak:transform:)` extension simplifies the transformation of a publisher's output into another publisher while holding a weak reference to an object. This ensures cleaner code by offering a friendlier syntax while guarding against potential memory leaks due to strong reference cycles.

**Parameters**:
- `obj`: The object to be weakly referenced.
- `transform`: The transformation to apply.

## 🇧🇷 Português:
A extensão `flatMap(weak:transform:)` simplifica a transformação da saída de um publisher em outro publisher, mantendo uma referência fraca a um objeto. Isso garante código mais limpo, oferecendo uma sintaxe mais amigável, enquanto protege contra possíveis vazamentos de memória devido a ciclos de referência forte.

**Parâmetros**:
- `obj`: O objeto a ser referenciado de forma fraca.
- `transform`: A transformação a ser aplicada.

## 📖 Example (Exemplo):

```swift
class ServiceClass {
    func fetchData() -> AnyPublisher<String, Never> {
        Just("Data").eraseToAnyPublisher()
    }
}

class FlatMapSampleClass {
    var description: String = "FlatMapSample"
    let service = ServiceClass()
    
    func transformAndFetch() {
        service.fetchData()
            .flatMap(weak: self) { weakSelf, value in
                Just("\(value) processed by \(weakSelf.description)")
            }
            .sink(receiveValue: { print($0) })
    }
}
```

---

# 🔄 `handleEvents(weak:receiveOutput:)`

## 🇬🇧 English:
The `handleEvents(weak:receiveOutput:)` extension facilitates the handling of output events with a weakly referenced object. This offers a friendlier syntax, allowing for better readability while reducing the risk of memory leaks.

**Parameters**:
- `obj`: The object to be weakly referenced.
- `receiveOutput`: A function to handle the publisher's output events.

## 🇧🇷 Português:
A extensão `handleEvents(weak:receiveOutput:)` facilita o manuseio de eventos de saída com uma referência fraca. Isso oferece uma sintaxe amigável, permitindo uma melhor legibilidade enquanto reduz o risco de vazamentos de memória.

**Parâmetros**:
- `obj`: O objeto a ser referenciado de forma fraca.
- `receiveOutput`: Uma função para lidar com os eventos de saída do publisher.

## 📖 Example (Exemplo):

```swift
class DataProcessor {
    var processedData: [String] = []
    var latestUpdate: String?

    func process(dataStream: AnyPublisher<ServerResponse, Error>) -> AnyPublisher<ProcessingResult, Error> {
        return dataStream
            .handleEvents(weak: self) { weakSelf, response in
                weakSelf.processedData.append(contentsOf: response.data)
                weakSelf.latestUpdate = response.timestamp
            }
            .map(weak: self) { weakSelf, response -> ProcessingResult in
                let summary = "Processed \(weakSelf.processedData.count) items. Last update at \(weakSelf.latestUpdate ?? "unknown time")."
                return ProcessingResult(summary: summary, data: weakSelf.processedData)
            }
            .eraseToAnyPublisher()
    }
}

struct ServerResponse {
    let data: [String]
    let timestamp: String
}

struct ProcessingResult {
    let summary: String
    let data: [String]
}

```
---

# 🔄 `tryMap(weak:transform:)`

## 🇬🇧 English:
With the `tryMap(weak:transform:)` extension, developers can perform transformations that may throw errors, all while keeping a weak reference to an external object. It brings the advantage of error handling into the transformation process and helps to create a cleaner and safer codebase by preventing potential memory leaks.

**Parameters**:
- `obj`: The object to be weakly referenced.
- `transform`: The function to apply to the output that might throw an error.

## 🇧🇷 Português:
Com a extensão `tryMap(weak:transform:)`, desenvolvedores podem realizar transformações que podem lançar erros, mantendo uma referência fraca a um objeto externo. Ela traz a vantagem do tratamento de erros para o processo de transformação e ajuda a criar um código mais limpo e seguro, prevenindo possíveis vazamentos de memória.

**Parâmetros**:
- `obj`: O objeto a ser referenciado de forma fraca.
- `transform`: A função a ser aplicada na saída que pode lançar um erro.

## 📖 Example (Exemplo):

```swift
class UserInfoProcessor {
    var userRole: UserRole
    
    init(role: UserRole) {
        self.userRole = role
    }
    
    func decodeUserPayload(dataStream: AnyPublisher<Data, Error>) -> AnyPublisher<User, Error> {
        return dataStream
            .tryMap(weak: self) { (weakSelf, data) -> User in
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)

                switch weakSelf.userRole {
                case .admin:
                    guard user.isAdmin else {
                        throw ProcessingError.adminPrivilegesMissing
                    }
                case .standard:
                    break
                }
                
                return user
            }
            .eraseToAnyPublisher()
    }
}

enum UserRole {
    case admin
    case standard
}

struct User: Decodable {
    let id: Int
    let name: String
    let isAdmin: Bool
}

enum ProcessingError: Error {
    case adminPrivilegesMissing
}

```

---

# 🚀 `Future(weak:attemptToFulfill:)`

## 🇬🇧 English:
The `Future(weak:attemptToFulfill:)` extension provides a convenient initializer to create a `Future` instance using a weak reference to an object. This way, you can avoid strong reference cycles when capturing `self` or other objects within asynchronous blocks. It is particularly useful when the lifecycle of the `Future` might exceed the lifecycle of the object you're referencing, preventing potential memory leaks.

**Parameters**:
- `obj`: The object to be weakly referenced.
- `attemptToFulfill`: A closure that, given the weak reference and a promise, tries to fulfill that promise.

## 🇧🇷 Português:
A extensão `Future(weak:attemptToFulfill:)` fornece um inicializador conveniente para criar uma instância `Future` usando uma referência fraca a um objeto. Dessa forma, você pode evitar ciclos de referência forte ao capturar `self` ou outros objetos dentro de blocos assíncronos. É particularmente útil quando o ciclo de vida do `Future` pode exceder o ciclo de vida do objeto que você está referenciando, prevenindo possíveis vazamentos de memória.

**Parâmetros**:
- `obj`: O objeto a ser referenciado de forma fraca.
- `attemptToFulfill`: Uma closure que, dada a referência fraca e uma promessa, tenta cumprir essa promessa.

## 📖 Example (Exemplo):

```swift
class UserManager {
    var userId: Int?

    func fetchUser() -> Future<User, Error> {
        return Future(weak: self) { weakSelf, promise in
            NetworkService.fetchUser(by: weakSelf.userId) { result in
                switch result {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}

struct User {
    let id: Int
    let name: String
}

struct NetworkService {
    static func fetchUser(by userId: Int?, completion: @escaping (Result<User, Error>) -> Void) {
        // Network call to fetch user data...
    }
}

```

-----

# 🚀 Convertendo Observable e Single do RxSwift para Combine

### 🇬🇧 English:

#### `Observable` e `Single` to `AnyPublisher`
Using the `asPublisher()` extension, we can convert RxSwift's `Observable` and `Single` types to Combine's `AnyPublisher`. It's crucial when migrating or co-existing RxSwift with Combine in a project. With the weak referencing mechanism we have set up, this conversion becomes memory-safe, keeping your code free from potential memory leaks.

### 🇧🇷 Português:

#### `Observable` e `Single` para `AnyPublisher`
Utilizando a extensão `asPublisher()`, podemos converter os tipos `Observable` e `Single` do RxSwift para o `AnyPublisher` do Combine. Isso é crucial ao migrar ou fazer com que RxSwift coexista com Combine em um projeto. Com o mecanismo de referência fraca que configuramos, essa conversão se torna segura em relação à memória, mantendo seu código livre de potenciais vazamentos de 


### 📖 Example (Exemplo):

### Service

```swift
class ProductService {
    func fetchProductDetails(_ productID: Int) -> Single<Product> {
        return Single.just(Product(id: productID, name: "Example Product", description: "This is a sample product description."))
    }
}
```

### ViewModel

```swift
class ProductViewModel { // If it is SwiftUI, it must comply with ObservableObject
    var productService: ProductService = ProductService()
    
    func fetchProductPublisher(productID: Int) -> AnyPublisher<Product, Error> {
        return productService.fetchProductDetails(productID)
            .asPublisher()
            .map(weak: self) { _, product -> Product in
                return product
            }
            .eraseToAnyPublisher()
    }
}
```

### Controller (UIKit)

```swift
class ProductViewController: UIViewController {
    var viewModel = ProductViewModel()
    var cancelables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProductDetailsForPublisher(productID: 123)
    }

    private func fetchProductDetailsForPublisher(productID: Int) {
        viewModel.fetchProductPublisher(productID: productID)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { product in
                print("Received product details: \(product.name) - \(product.description)")
            })
            .store(in: &cancelables)
    }
}
```

### View (SwiftUI)

```swift
import SwiftUI
import Combine

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductViewModel
    var productID: Int

    @State private var product: Product?
    @State private var showError: Bool = false
    var cancelables: Set<AnyCancellable> = []

    init(productID: Int) {
        self.productID = productID
        self.viewModel = ProductViewModel()
    }

    var body: some View {
        VStack {
            if let product = product {
                Text(product.name)
                    .font(.headline)
                Text(product.description)
                    .padding()
            } else {
                Text("Loading or error...")
            }
        }
        .onAppear(perform: fetchProductDetailsForPublisher)
        .alert(isPresented: $showError, content: {
            Alert(title: Text("Error"), message: Text("Failed to load product details"), dismissButton: .default(Text("OK")))
        })
    }

    func fetchProductDetailsForPublisher() {
        viewModel.fetchProductPublisher(productID: productID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.showError = true
                }
            }, receiveValue: { product in
                self.product = product
            })
            .store(in: &cancelables)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productID: 123)
    }
}
```

