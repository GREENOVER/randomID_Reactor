import Foundation
import ReactorKit
import Alamofire

final class RandomIDReactor: Reactor {
  enum Action {
    case clickButton
  }
  
  enum Mutation {
    case refreshView(RandomInfo)
  }
  
  struct State {
    var displayIDText = "1"
    var displayTitleText = "delectus aut autem"
  }
  
  let initialState: State = .init()
}

extension RandomIDReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .clickButton:
      return Observable.concat([
        getData()
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .refreshView(let randomInfo):
      state.displayIDText = String(randomInfo.id)
      state.displayTitleText = String(randomInfo.title)
    }
    return state
  }
}

extension RandomIDReactor {
  func getData() -> Observable<Mutation> {
    return Observable<Mutation>.create{ [self] observer in
      let index = randomDataIndex()
      FetchRandomInfo.shared.fetch(index, completion: { (data) in
        observer.onNext(.refreshView(data))
      })
      return Disposables.create()
    }
  }
  
  func randomDataIndex() -> Int {
    return Int.random(in: 0..<100)
  }
}
