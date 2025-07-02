protocol ProfileInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class ProfileInteractor: ProfileInteractorProtocol {
    func fetchGreeting() -> String {
        return "Profile Module"
    }
}
