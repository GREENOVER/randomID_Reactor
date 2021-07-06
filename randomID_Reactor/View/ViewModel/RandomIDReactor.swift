import Foundation
import ReactorKit

final class RandomIDReactor: Reactor {
  var fetchData: RandomInfo?
  
  enum Action {
    case fetchData
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
    case .fetchData:
//      Single<Any>.create(subscribe: { single in
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
//          FetchRandomInfo().init()
//        })
//        return Disposables.create()
//      }).asObservable()
//      self.fetchData = FetchRandomInfo.init().sortData[0]
//      return Observable.just(Mutation.refreshView(fetchData!))
      
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
      FetchRandomInfo.shared.fetch()
      let index = randomDataIndex()
      observer.onNext(.refreshView(FetchRandomInfo.shared.sortData[index]))
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func randomDataIndex() -> Int {
    return Int.random(in: 0..<100)
  }
  
}
