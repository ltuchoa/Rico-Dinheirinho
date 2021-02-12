//
//  ObjetivoViewModel.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 08/02/21.
//

import SwiftUI
import CoreData

class ObjetivoViewModel: ObservableObject {

    var objetivos: FetchedResults<Objetivo>

    func save(viewContext: NSManagedObjectContext, nome: String, valor: Double, data: Date, icone: String) -> Bool {
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
            return false
        }
        return true
    }

    func update(viewContext: NSManagedObjectContext, objetivo: Objetivo) -> Bool {

        let progress = Float(objetivo.valorDepositado/objetivo.valorTotal)
        objetivo.progress = progress
        
        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
            return false
        }
        return true

    }

    func delete(viewContext: NSManagedObjectContext, objetivo: Objetivo) -> Bool {
        viewContext.delete(objetivo)

        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
            return false
        }
        return true
    }


}
