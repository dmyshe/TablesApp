//
//  Extension.swift
//  TablesApp
//
//  Created by Дмитро  on 24/04/22.
//

import Cocoa

extension NSTableView {
    func addTableColumn(identifier: NSUserInterfaceItemIdentifier ) {
        let newTableColumn = NSTableColumn(identifier: identifier)
        self.addTableColumn(newTableColumn)
    }
    
    func removeLastTableColumn()  {
        let lastColumn = self.tableColumns.last!
        self.removeTableColumn(lastColumn)
    }
}


