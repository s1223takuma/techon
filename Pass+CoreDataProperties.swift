//
//  Pass+CoreDataProperties.swift
//  db
//
//  Created by 関琢磨 on 2023/01/27.
//
//

import Foundation
import CoreData


extension Pass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pass> {
        return NSFetchRequest<Pass>(entityName: "Pass")
    }

    @NSManaged public var sitename: String?
    @NSManaged public var url: String?
    @NSManaged public var userid: String?
    @NSManaged public var password: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?

}

extension Pass : Identifiable {
    // ここに追加
    // stringUpdatedAtを呼び出すとString型のupdatedAtが返却される
    public var stringUpdatedAt: String { dateFomatter(date: updatedAt ?? Date()) }
    
    func dateFomatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        return dateFormatter.string(from: date)
    }
}
