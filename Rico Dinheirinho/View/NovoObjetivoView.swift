//
//  NovoObjetivoView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

struct NovoObjetivoView: View {

    @State private var nome: String = ""
    @State private var valor: String = ""
    @State private var data = Date()

    //    init() {
    //        let greenA: UIColor = UIColor(red: 58/255, green: 171/255, blue: 71/255, alpha: 1.0)
    //
    //
    //        let appearance = UINavigationBarAppearance()
    //        appearance.shadowColor = .clear
    //        appearance.largeTitleTextAttributes = [.foregroundColor: greenA]
    //        appearance.titleTextAttributes = [.foregroundColor: greenA]
    //        appearance.backgroundColor = .systemBackground
    //
    //        UINavigationBar.appearance().standardAppearance = appearance
    //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    //        UINavigationBar.appearance().prefersLargeTitles = true
    //    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Nome do Objetivo")
                .padding(.top, 7.5)
                .font(.system(size: 20, weight: .medium, design: .default))
            TextField("Digite o nome do objetivo", text: $nome)
                .textFieldStyle(SuperCustomTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primaryGreen, lineWidth: 1.5)
                        .padding([.leading, .trailing], 10)
                )
                .padding(.top, 4)

            Text("Valor")
                .padding(.top, 15)
                .font(.system(size: 20, weight: .medium, design: .default))
            TextField("Digite o valor do objetivo", text: $valor)
                .textFieldStyle(SuperCustomTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primaryGreen, lineWidth: 1.5)
                        .padding([.leading, .trailing], 10)
                )
                .padding(.top, 4)

            Text("Data")
                .padding(.top, 15)
                .font(.system(size: 20, weight: .medium, design: .default))
            DatePicker("", selection: $data, in: Date()..., displayedComponents: .date).frame(width: 0, height: 30, alignment: .leading)
                .accentColor(.primaryGreen)

            Text("Ícone")
                .padding(.top, 14)
                .font(.system(size: 20, weight: .medium, design: .default))
            Spacer()
        }
        .padding([.leading, .trailing], 20)

        .navigationBarTitle("Novo Objetivo", displayMode: .large)
        .navigationBarItems(trailing:
                                Button(action: {
                                    print("Novo Objetivo")
                                }) {
                                    Text("Salvar")
                                }
            .foregroundColor(.primaryGreen)
        )
    }
}

struct SuperCustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding([.leading, .trailing], 24)
            .padding([.top, .bottom], 8)
            .foregroundColor(.primaryGreen)
            .accentColor(.primaryGreen)
    }
}

struct NovoObjetivoView_Previews: PreviewProvider {
    static var previews: some View {
        NovoObjetivoView()
    }
}
