protocol HomeInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class HomeInteractor: HomeInteractorProtocol {
    func fetchGreeting() -> String {
        return "Hello, World!"
    }
}
