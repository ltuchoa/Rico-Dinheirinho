//
//  ObjetivosView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

struct ObjetivosView: View {


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
            .clipped()
            .background(Color(UIColor.systemBackground))

            .onAppear() {
                let greenA: UIColor = UIColor(red: 58/255, green: 171/255, blue: 71/255, alpha: 1.0)

                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: greenA]
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: greenA]

            }
            .navigationBarTitle("Objetivos", displayMode: .large)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: NovoObjetivoView()) {
                                        Image(systemName: "plus.circle.fill").imageScale(.large)
                                    }

                                    .foregroundColor(.primaryGreen)
            )
        }
        .accentColor(.primaryGreen)
    }
}

struct ObjetivosView_Previews: PreviewProvider {
    static var previews: some View {
        ObjetivosView()
            .preferredColorScheme(.light)
    }
}
