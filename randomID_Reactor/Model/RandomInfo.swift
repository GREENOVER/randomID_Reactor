import Foundation

struct RandomInfo: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let completed: Bool
  
  enum CodingKeys: String, CodingKey {
    case userId, id, title, completed
  }
}
