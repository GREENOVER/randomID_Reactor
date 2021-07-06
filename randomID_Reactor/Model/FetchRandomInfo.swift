import Foundation
import Alamofire

class FetchRandomInfo {
  static var shared = FetchRandomInfo()
  
  private init() {}
  
  let baseURL = "https://jsonplaceholder.typicode.com/todos/"
  
  func fetch(_ index: Int, completion: @escaping (_ data: RandomInfo) -> Void) {
    let convertURL = baseURL+"\(index)"
    AF.request(convertURL, method: .get, encoding: JSONEncoding.default)
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          do {
            let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let list = try JSONDecoder().decode(RandomInfo.self, from: data)
            completion(list)
          } catch DecodingError.dataCorrupted(let context) {
            print("데이터가 손상되었거나 유효하지 않습니다.")
            print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
          } catch DecodingError.keyNotFound(let codingkey, let context) {
            print("주어진 키를 찾을수 없습니다.")
            print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
          } catch DecodingError.typeMismatch(let type, let context) {
            print("주어진 타입과 일치하지 않습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
          } catch DecodingError.valueNotFound(let type, let context) {
            print("예상하지 않은 null 값이 발견되었습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
          } catch {
            print("그외 에러가 발생했습니다.")
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
  }
}
