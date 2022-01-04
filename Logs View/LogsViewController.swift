//
//  ViewController.swift
//  Logger
//
//  Created by Mahmoud Aziz on 03/01/2022.
//

import UIKit

class LogsViewController: Logger {
    
    @IBOutlet private weak var logsTableView: UITableView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        print(logLevel: .error, "error")
        print(logLevel: .warning, "warning")
        print(logLevel: .info, "info")
    }
    
    private func getLogs() -> [Context] {
        return UserDefaults.standard.getDecodablesFromArrayOfDictionaries(for: "logs") ?? []  
    }
}

extension LogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! logsTableViewCell
        cell.log = getLogs()[indexPath.row]
        return cell
    }
}

extension LogsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

