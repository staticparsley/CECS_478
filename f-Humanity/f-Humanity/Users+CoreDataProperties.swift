//
//  Users+CoreDataProperties.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/3/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users");
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?

}
