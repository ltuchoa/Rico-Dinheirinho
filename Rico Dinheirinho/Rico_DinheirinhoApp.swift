//
//  Rico_DinheirinhoApp.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

@main
struct Rico_DinheirinhoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ObjetivosView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
