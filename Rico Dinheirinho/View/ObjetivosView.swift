//
//  ObjetivosView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

struct ObjetivosView: View {

    init() {
        let greenA: UIColor = UIColor(red: 58/255, green: 171/255, blue: 71/255, alpha: 1.0)


        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: greenA]
        appearance.titleTextAttributes = [.foregroundColor: greenA]
        appearance.backgroundColor = .systemBackground

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                    ObjetivoCell()
                }.padding(.bottom, 20)
            }
            .contentShape(Rectangle())
            .clipped()

            .navigationBarTitle("Objetivos", displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    print("Novo Objetivo")
                }) {
                    Image(systemName: "plus.circle.fill").imageScale(.large)
                }
                .foregroundColor(.primaryGreen)
            )
            .navigationBarTitleDisplayMode(.large)

        }
    }
}

struct ObjetivosView_Previews: PreviewProvider {
    static var previews: some View {
        ObjetivosView()
            .preferredColorScheme(.light)
    }
}
