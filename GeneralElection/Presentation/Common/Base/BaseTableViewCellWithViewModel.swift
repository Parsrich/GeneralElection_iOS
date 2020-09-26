//
//  BaseTableViewCellWithViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/17.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTableViewCellWithViewModel<T: BaseCellViewModel>: BaseTableViewCell {
    
    var viewModel: T?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = T()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel = T()
    }
    
    
}
