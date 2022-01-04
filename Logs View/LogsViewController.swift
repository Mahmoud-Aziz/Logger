//
//  ViewController.swift
//  Logger
//
//  Created by Mahmoud Aziz on 03/01/2022.
//

import UIKit

class LogsViewController: Logger {
    
    @IBOutlet private weak var logsTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private var logsCollection: [Context]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLogs()
        searchBar.showsCancelButton = true
        print(logLevel: .error, "error")
        print(logLevel: .warning, "warning")
        print(logLevel: .info, "info")
    }
    
    private func getLogs() {
        let logs: [Context] = UserDefaults.standard.getDecodablesFromArrayOfDictionaries(for: "logs") ?? []
        self.logsCollection = logs
        print(logLevel: .info, "test")
    }
}

//MARK: - TableView Datasource
extension LogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logsCollection?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! logsTableViewCell
        guard let logs = logsCollection?[indexPath.row] else { return UITableViewCell() }
        cell.log = logs
        return cell
    }
}
//MARK: - TableView Delegate
extension LogsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - Search Bar delegate
extension LogsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        searchBar.resignFirstResponder()
        searchLogs(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getLogs()
        searchBar.text = ""
        logsTableView.reloadData()
    }
}

//MARK: - Search Helpers
extension LogsViewController {
    func searchLogs(text: String) {
        let result = logsCollection?.filter({
            isIncluded(context: $0, text: text)
        }) ?? []
        
        self.logsCollection = result
        logsTableView.reloadData()
    }
    
    private func isIncluded(context: Context, text: String) -> Bool {
        guard let level = context.level?.prefix, let date = context.date, let line = context.line, let function = context.function, let file = context.file, let input = context.input else {
            return false
        }
        return level.description.contains(text) || date.description.contains(text) || line.description.contains(text) ||
        function.description.contains(text) || file.description.contains(text) || input.description.contains(text)
    }
}
