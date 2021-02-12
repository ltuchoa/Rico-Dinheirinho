//
//  ObjetivoViewModel.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 08/02/21.
//

import SwiftUI
import CoreData

class ObjetivoViewModel: ObservableObject {

//    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Objetivo.entity(), sortDescriptors: [], predicate: NSPredicate())

    var objetivos: FetchedResults<Objetivo>

    func save(viewContext: NSManagedObjectContext, nome: String, valor: Double, data: Date, icone: String) {
        let novoObjetivo = Objetivo(context: viewContext)
        novoObjetivo.id = UUID()
        novoObjetivo.nome = nome
        novoObjetivo.valorTotal = valor
        novoObjetivo.valorDepositado = 0
        novoObjetivo.progress = 0
        novoObjetivo.data = data
        novoObjetivo.icone = icone

        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
        }
    }

    func update(viewContext: NSManagedObjectContext, objetivo: Objetivo) {
        var objeto = viewContext.object(with: objetivo.objectID)

        let progress = Float(objetivo.valorDepositado/objetivo.valorTotal)
        objetivo.progress = progress
        objeto = objetivo
        
        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
        }

    }

    func delete(viewContext: NSManagedObjectContext, objetivo: Objetivo) {
        viewContext.delete(objetivo)

        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
        }
    }


}
