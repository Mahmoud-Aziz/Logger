//
//  LogsTableViewCell.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import UIKit

class logsTableViewCell: UITableViewCell {
    @IBOutlet private weak var levelLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var fileNameLabel: UILabel!
    @IBOutlet private weak var lineNumberLabel: UILabel!
    @IBOutlet private weak var functionNameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    var log: Context? {
        didSet {
            levelLabel.text = "\(log?.level.prefix ?? "")"
            dateLabel.text = log?.date
            fileNameLabel.text = "\(((log?.file ?? "") as NSString).lastPathComponent)"
            lineNumberLabel.text = "\(log?.line ?? 0)"
            functionNameLabel.text = log?.function
            messageLabel.text = log?.item
        }
    }
}
