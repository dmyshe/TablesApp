//
//  ViewController.swift
//  TablesApp
//
//  Created by Дмитро  on 21/04/22.
//

import Cocoa

class SpreadSheetViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    
    var dataManager = TableDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataManager.delegate = self
    }
    
    @IBAction func showTotalSum(_ sender: NSButton) {
        dataManager.calculateTotalNumber()
    }
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            dataManager.addPenultimateRows()
        } else {
            guard tableView.numberOfRows > 2 else { return }
            dataManager.removePenultimateRows()
        }
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            dataManager.addNewColumn()
            tableView.addTableColumn(identifier: .textFieldColumn)
        } else {
            guard  tableView.numberOfColumns > 1 else { return }
            dataManager.removeLastColumn()
            tableView.removeLastTableColumn()
        }
    }
}

// MARK: - SpreadSheetViewModelDelegate
extension SpreadSheetViewController:  SpreadSheetViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - NSTableViewDelegate
extension SpreadSheetViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumn = tableColumn,
                let index = tableView.tableColumns.firstIndex(of: tableColumn) else { return nil }

        if tableColumn.identifier == .textFieldColumn,
           let cell = tableView.makeView(withIdentifier: .textFieldIdentifier, owner: self) as? TextFieldCell {
            
            let numberOfElements = dataManager.numberOfElementsInSubArray(at: index)
            
            let intValue = dataManager.checkIfNumberOfElementsGreater(than: row, at: index)
            
            cell.configure(with: "\(intValue)")
            
            cell.textField?.textColor = row < numberOfElements ? .black : .gray
            cell.textField?.isEditable = row < numberOfElements ? true : false
            cell.textField?.delegate = self
            return cell
        }
        return nil
    }
}

// MARK: - NSTableViewDataSource
extension SpreadSheetViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        dataManager.numbersOfRows
    }
}

// MARK: - NSTextFieldDelegate
extension SpreadSheetViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        let textField = obj.object as! NSTextField
        
        guard textField.stringValue != "" , let newNumber = Int(textField.stringValue) else {
            print("Enter number")
            return }
        
        let column = tableView.column(for: textField)
        let row = tableView.row(for: textField)
        dataManager.intArray[column][row] = newNumber
        reloadData()
    }
}

extension NSUserInterfaceItemIdentifier {
    static let textFieldColumn = NSUserInterfaceItemIdentifier("TextFieldIColumn")
    static let textFieldIdentifier = NSUserInterfaceItemIdentifier("TextFieldIdentifier")
}
