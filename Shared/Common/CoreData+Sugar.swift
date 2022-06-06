//
//  CoreData+Uicorn.swift
//  macOS
//
//  Created by Henk van der Spek on 27/05/2022.
//

import Foundation
import CoreData

extension NSAttributeDescription {
    enum `Type` {
        case string
        case date
        case int16
        case int32
        case bool
        case float
        case binary
    }
    convenience init(_ name: String, type: `Type`) {
        self.init()
        self.name = name
        self.attributeType = .init(from: type)
    }
}

extension NSPropertyDescription {
    static func attribute(_ name: String, type: NSAttributeDescription.`Type`) -> NSAttributeDescription {
        return .init(name, type: type)
    }
    static func string(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .string)
    }
    static func date(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .date)
    }
    static func int16(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .int16)
    }
    static func int32(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .int32)
    }
    static func bool(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .bool)
    }
    static func float(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .float)
    }
    static func binary(_ name: String) -> NSAttributeDescription {
        return .init(name, type: .binary)
    }
}

extension NSAttributeType {
    init(from other: NSAttributeDescription.`Type`) {
        switch other {
        case .string: self = .stringAttributeType
        case .date: self = .dateAttributeType
        case .int16: self = .integer16AttributeType
        case .int32: self = .integer32AttributeType
        case .bool: self = .booleanAttributeType
        case .float: self = .floatAttributeType
        case .binary: self = .binaryDataAttributeType
        }
    }
}

extension NSEntityDescription {
    convenience init(name: String, managedObjectClassName: String? = nil, properties: [NSPropertyDescription], uniquenessConstraints: [[Any]]) {
        self.init()
        self.name = name
        self.properties = properties
        self.managedObjectClassName = managedObjectClassName ?? name
        self.uniquenessConstraints = uniquenessConstraints
    }
}

extension NSManagedObjectModel {
    convenience init(entities: [NSEntityDescription]) {
        self.init()
        self.entities = entities
    }
}

extension NSRelationshipDescription {
    convenience init(name: String, destinationEntity: NSEntityDescription?, inverseRelationship: NSRelationshipDescription?, minCount: Int, maxCount: Int) {
        self.init()
        self.name = name
        self.destinationEntity = destinationEntity
        self.inverseRelationship = inverseRelationship
        self.minCount = minCount
        self.maxCount = maxCount
    }
}
