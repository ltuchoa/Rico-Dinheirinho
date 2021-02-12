//
//  Objetivo+CoreDataProperties.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 08/02/21.
//
//

import Foundation
import CoreData


extension Objetivo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Objetivo> {
        return NSFetchRequest<Objetivo>(entityName: "Objetivo")
    }

    @NSManaged public var data: Date
    @NSManaged public var icone: String
    @NSManaged public var id: UUID
    @NSManaged public var nome: String
    @NSManaged public var progress: Float
    @NSManaged public var valorDepositado: Double
    @NSManaged public var valorTotal: Double

}

extension Objetivo : Identifiable {

}
