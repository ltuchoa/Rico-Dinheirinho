//
//  ObjetivosViewModelTests.swift
//  Rico DinheirinhoTests
//
//  Created by Larissa Uchoa on 12/02/21.
//

import XCTest
import SwiftUI

@testable import Rico_Dinheirinho

class ObjetivosViewModelTests: XCTestCase {
    @FetchRequest(entity: Objetivo.entity(), sortDescriptors: [NSSortDescriptor(key: "nome", ascending: true)])

    var objetivos: FetchedResults<Objetivo>

    func test_objetivosViewModel_save_true() {
        // Given
        let viewModel = ObjetivoViewModel()
        let viewContext = PersistenceController().container.viewContext
        // When
        let result = viewModel.save(viewContext: viewContext, nome: "Teste", valor: 50, data: Date(timeIntervalSinceNow: 300), icone: "airplane")

        // Then
        XCTAssertTrue(result)
    }

    func test_objetivosViewModel_delete_true() {
        // Given
        let viewModel = ObjetivoViewModel()
        let viewContext = PersistenceController().container.viewContext

        let novoObjetivo = Objetivo(context: viewContext)
        novoObjetivo.id = UUID()
        novoObjetivo.nome = "Teste2"
        novoObjetivo.valorTotal = 500
        novoObjetivo.valorDepositado = 0
        novoObjetivo.progress = 0
        novoObjetivo.data = Date(timeIntervalSinceNow: 300)
        novoObjetivo.icone = "airplane"

        // When
        let result = viewModel.delete(viewContext: viewContext, objetivo: novoObjetivo)

        // Then
        XCTAssertTrue(result)
    }

    func test_objetivosViewModel_update_true() {
        // Given
        let viewModel = ObjetivoViewModel()
        let viewContext = PersistenceController().container.viewContext

        let novoObjetivo = Objetivo(context: viewContext)
        novoObjetivo.id = UUID()
        novoObjetivo.nome = "Teste3"
        novoObjetivo.valorTotal = 500
        novoObjetivo.valorDepositado = 0
        novoObjetivo.progress = 0
        novoObjetivo.data = Date(timeIntervalSinceNow: 300)
        novoObjetivo.icone = "airplane"

        // When
        let result = viewModel.update(viewContext: viewContext, objetivo: novoObjetivo)
        viewModel.delete(viewContext: viewContext, objetivo: novoObjetivo)

        // Then
        XCTAssertTrue(result)
    }

}
