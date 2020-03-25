//
//  CandidateSearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class CandidateSearchViewController: BaseViewControllerWithViewModel<CandidateSearchViewModel> {
    
    @IBOutlet weak var searchFieldBorderView: UIView!
    @IBOutlet weak var candidateSearchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candidateSearchField.delegate = self
        setupUI()
        bindRx()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        searchFieldBorderView.layer.borderWidth = 2
        searchFieldBorderView.layer.borderColor = UIColor(red: 127.toRgb,
                                                          green: 111.toRgb,
                                                          blue: 237.toRgb,
                                                          alpha: 1.0).cgColor
    }
    
    func bindRx() {
//        candidateSearchField.rx.controlEvent(.valueChanged)
//            .subscribe(onNext: { _ in
//                print("input(valueChanged): \(self.candidateSearchField.text!)")
//            }).disposed(by: rx.disposeBag)
//        candidateSearchField.rx.textFieldShouldReturn
//            .subscribe(onNext: { _ in
//                self.candidateSearchField.resignFirstResponder()
//                print("input(textFieldShouldReturn): \(self.candidateSearchField.text!)")
//            }).disposed(by: rx.disposeBag)
    }
}

extension CandidateSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchResultViewController.className) as? CandidateSearchResultViewController {
//            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
        return true
    }
}

//extension UITextField: HasDelegate {
//    public typealias Delegate = UITextFieldDelegate
//}
//
//class RxUITextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
//
//    weak private(set) var textField: UITextField?
//
//    init(textField: UITextField) {
//        self.textField = textField
//        super.init(parentObject: textField, delegateProxy: RxUITextFieldDelegateProxy.self)
//    }
//
//    static func registerKnownImplementations() {
//        self.register {
//            RxUITextFieldDelegateProxy(textField: $0)
//        }
//    }
//}
//
//extension Reactive where Base: UITextField {
//    var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
//        return RxUITextFieldDelegateProxy.proxy(for: base)
//    }
//
//    var textFieldShouldReturn: Observable<Void> {
//        return delegate.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldReturn(_:)))
//            .map { _ in return }
//    }
//}
//
