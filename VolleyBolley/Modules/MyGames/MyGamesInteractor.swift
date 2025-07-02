protocol MyGamesInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class MyGamesInteractor: MyGamesInteractorProtocol {
    func fetchGreeting() -> String {
        return "My Games Module"
    }
}
