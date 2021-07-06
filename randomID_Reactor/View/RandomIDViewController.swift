import UIKit
import ReactorKit
import RxCocoa

class RandomIDViewController: UIViewController, StoryboardView {
  var disposeBag = DisposeBag()
  let reactor = RandomIDReactor()
  
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    FetchRandomInfo.shared.fetch()
    reactor.action.onNext(.fetchData)
  }
  
  func bind(reactor: RandomIDReactor) {
    reactor.state.map(\.displayIDText)
      .distinctUntilChanged()
      .bind(to: self.idLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    reactor.state.map(\.displayTitleText)
      .distinctUntilChanged()
      .bind(to: self.titleLabel.rx.text)
      .disposed(by: self.disposeBag)
  }
}

