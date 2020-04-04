//
//  PartyPromiseCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/04.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class PartyPromiseCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    func setData(promise: Promise?) {
        guard let promise = promise else { return }
        
        numberLabel.text = promise.ord
        subjectLabel.text = "[\(promise.realmName ?? "")]\n\(promise.title ?? "")"
        
    }
}
