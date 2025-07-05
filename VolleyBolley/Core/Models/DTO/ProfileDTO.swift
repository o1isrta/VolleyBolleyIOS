import Foundation

struct ProfileDTO: Decodable {
    let name: String
    let surname: String
    let photo: String
    let id: String
}

// extension ProfileDTO {
//    func toDomainModel() -> Profile? {
//        guard
//            let photo = URL(string: self.avatar)
//        else {
//            return nil
//        }
//
//        return Profile(
//            name: self.name,
//            surname: self.surname,
//            photo: photo,
//            id: self.id
//        )
//    }
// }
