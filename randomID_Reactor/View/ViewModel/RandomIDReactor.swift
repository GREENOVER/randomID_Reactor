import Foundation
import ReactorKit
import Alamofire

final class RandomIDReactor: Reactor {
  enum Action {
    case clickButton
    case viewDidAppear
  }
  
  enum Mutation {
    case fetchResult(Result<RandomInfo, NSError>)
  }
  
  struct State {
    var fetchResult: Result<RandomInfo, NSError>?
    
    var displayIDText: String? {
      return fetchResult.flatMap({ fetchResult in
        switch fetchResult {
        case let .success(randomInfo):
          return "\(randomInfo.id)"
        default:
          return nil
        }
      })
    }
    
    var displayTitleText: String? {
      return fetchResult.flatMap({ fetchResult in
        switch fetchResult {
        case let .success(randomInfo):
          return "\(randomInfo.title)"
        default:
          return nil
        }
      })
    }
  }
  
  let initialState: State = .init()
}

extension RandomIDReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .clickButton:
      return FetchRandomInfo.shared.rx.fetch()
        .asObservable()
        .materialize()
        .map({ event -> Event<Result<RandomInfo, NSError>> in
          switch event {
          case .completed:
            return .completed
          case let .error(error):
            return .next(Result.failure(error as NSError))
          case let .next(randomInfo):
            return .next(Result.success(randomInfo))
          }
        })
        .dematerialize()
        .map(Mutation.fetchResult)
      
    case .viewDidAppear:
      return Observable<Int>
        .interval(RxTimeInterval.seconds(3), scheduler: MainScheduler.asyncInstance)
        .flatMapLatest { _ in
          FetchRandomInfo.shared.rx.fetch().asObservable()
        }
        .materialize()
        .map({ event -> Event<Result<RandomInfo, NSError>> in
          switch event {
          case .completed:
            return .completed
          case let .error(error):
            return .next(Result.failure(error as NSError))
          case let .next(randomInfo):
            return .next(Result.success(randomInfo))
          }
        })
        .dematerialize()
        .map(Mutation.fetchResult)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .fetchResult(let result):
      state.fetchResult = result
    }
    return state
  }
}
