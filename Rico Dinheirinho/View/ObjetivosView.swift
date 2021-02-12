//
//  ObjetivosView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

struct AccentColorPreferenceKey: PreferenceKey {
    typealias Value = Color?

    static func reduce(value: inout Color?, nextValue: () -> Color?) {
        guard let next = nextValue() else { return }
        value = next
    }
}

struct ObjetivosView: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Objetivo.entity(), sortDescriptors: [NSSortDescriptor(key: "nome", ascending: true)])
    
    var objetivos: FetchedResults<Objetivo>

    @State private var navAccentColor: Color? = nil

    @State private var delay: Double = 0.4

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    if !objetivos.isEmpty {
                        ForEach(objetivos) { objetivo in
                            NavigationLink(destination: DescricaoObjetivoView(objetivo: objetivo)) {
                                ObjetivoCell(objetivo: objetivo)
                            }
                        }
                    } else {
                        Text("Você não possui objetivos!")
                            .font(.system(size: 22, weight: .regular, design: .default)).opacity(0.8)
                            .padding(.vertical, UIScreen.main.bounds.height/3)
                    }

                }.padding([.top, .bottom], 10)
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
        .accentColor(navAccentColor)
        .onPreferenceChange(AccentColorPreferenceKey.self) {
            self.navAccentColor = $0
        }
    }
}

struct ObjetivosView_Previews: PreviewProvider {
    static var previews: some View {
        ObjetivosView()
            .preferredColorScheme(.light)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
