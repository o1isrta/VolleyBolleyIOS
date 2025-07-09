#if DEBUG
final class MockHomeInteractor: HomeInteractorProtocol {
    func fetchGreeting() -> String {
        return "Home Module"
    }
}
#endif
