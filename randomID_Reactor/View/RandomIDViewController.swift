import UIKit
import ReactorKit
import RxCocoa

class RandomIDViewController: UIViewController, StoryboardView {
  var disposeBag = DisposeBag()
  
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var changeButton: UIButton!
  
  func bind(reactor: RandomIDReactor) {
    self.changeButton.rx.tap
      .map { .clickButton }
      .bind(to:reactor.action)
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

