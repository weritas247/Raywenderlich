/// Copyright (c) 2019 Razeware LLC
///


import UIKit
import RxSwift
import RxCocoa

class ChocolatesOfTheWorldViewController: UIViewController {
  @IBOutlet private var cartButton: UIBarButtonItem!
  @IBOutlet private var tableView: UITableView!
  let europeanChocolates = Observable.just(Chocolate.ofEurope)
  private let disposeBag = DisposeBag()
}

//MARK: View Lifecycle
extension ChocolatesOfTheWorldViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Chocolate!!!"
    
//    tableView.dataSource = self
//    tableView.delegate = self
    
    setupCartObserver()
    setupCellConfiguration()
    setupCellTapHandling()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    updateCartButton()
  }
}

//MARK: - Rx Setup
private extension ChocolatesOfTheWorldViewController {
  func setupCellTapHandling() {
    tableView
      .rx
      .modelSelected(Chocolate.self)
      .subscribe(onNext: { [unowned self] chocolate in
        let newValue = ShoppingCart.sharedCart.chocolates.value + [chocolate]
        ShoppingCart.sharedCart.chocolates.accept(newValue)
        
        if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
          self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
        }
    })
      .disposed(by: disposeBag)
  }
  func setupCellConfiguration() {
    europeanChocolates.bind(to: tableView
      .rx
      .items(cellIdentifier: ChocolateCell.Identifier, cellType: ChocolateCell.self)) {
        row, chocolate, cell in
        cell.configureWithChocolate(chocolate: chocolate)
      }
      .disposed(by: disposeBag)
  }
  
  func setupCartObserver() {
    ShoppingCart.sharedCart.chocolates.asObservable()
      .subscribe(onNext: {
        [unowned self] chocolate in
        self.cartButton.title = "\(chocolate.count) 🍫"
    })
    .disposed(by: disposeBag)
  }
}

//MARK: - Imperative methods
//private extension ChocolatesOfTheWorldViewController {
//  func updateCartButton() {
//    cartButton.title = "\(ShoppingCart.sharedCart.chocolates.value.count) 🍫"
//  }
//}

// MARK: - Table view data source
//extension ChocolatesOfTheWorldViewController: UITableViewDataSource {
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return europeanChocolates.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChocolateCell.Identifier, for: indexPath) as? ChocolateCell else {
//      //Something went wrong with the identifier.
//      return UITableViewCell()
//    }
//
//    let chocolate = europeanChocolates[indexPath.row]
//    cell.configureWithChocolate(chocolate: chocolate)
//
//    return cell
//  }
//}

// MARK: - Table view delegate
//extension ChocolatesOfTheWorldViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath, animated: true)
//
//    let chocolate = europeanChocolates[indexPath.row]
//    let newValue = ShoppingCart.sharedCart.chocolates.value + [chocolate]
//    ShoppingCart.sharedCart.chocolates.accept(newValue)
////    updateCartButton()
//  }
//}

// MARK: - SegueHandler
extension ChocolatesOfTheWorldViewController: SegueHandler {
  enum SegueIdentifier: String {
    case goToCart
  }
}
