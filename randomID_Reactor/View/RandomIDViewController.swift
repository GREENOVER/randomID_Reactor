import UIKit
import ReactorKit
import RxCocoa

class RandomIDViewController: UIViewController, StoryboardView {
  var disposeBag = DisposeBag()
  let reactor = RandomIDReactor()
  
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var changeButton: UIButton!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    bind(reactor: reactor)
    reactor.action.onNext(.viewDidAppear)
  }
  
  func bind(reactor: RandomIDReactor) {
    self.changeButton.rx.tap
      .map { .clickButton }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
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

