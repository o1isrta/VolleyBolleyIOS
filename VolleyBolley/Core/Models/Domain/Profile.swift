import Foundation

struct Profile: Codable, Hashable {
    let name: String
    let surname: String
    let photo: URL
    let id: String
}

// extension Profile {
//    func toDTO() -> ProfileDTO? {
//
//        return ProfileDTO(
//            name: self.name,
//            avatar: self.avatar.absoluteString,
//            description: self.description,
//            website: self.website.absoluteString,
//            nfts: self.nfts,
//            likes: self.likes,
//            id: self.id
//        )
//    }
// }
