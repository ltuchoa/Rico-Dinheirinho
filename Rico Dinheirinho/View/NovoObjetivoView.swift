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
    @State private var icone: String = "square.and.pencil"
    @State private var data = Date()
    var items = ["airplane", "car.fill", "map.fill", "gamecontroller.fill", "gift.fill", "tv.fill", "guitars.fill"]
    @State private var presentPicker = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var body: some View {
        ZStack {
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
                    .keyboardType(.numbersAndPunctuation)
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

                Button(action: {
                    // What to perform
                    presentPicker = true
                }) {
                    // How the button looks like
                    HStack(alignment: .center) {
                        Text(Image(systemName: icone))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.primaryGreen)
                        Text(nome)
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.primaryGreen)
                    }
                }.padding(.leading, 10)
                .padding(.top, 1)

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
            .modifier(BlurModifierSimple(showOverlay: $presentPicker))

            if presentPicker {
                CustomPickerView(items: items, pickerField: $icone, presentPicker: $presentPicker)
            }

        }.animation(.easeInOut(duration: 0.22))
    }
}

struct BlurModifierSimple: ViewModifier {
    @Binding var showOverlay: Bool
    @State var blurRadius: CGFloat = 10

    func body(content: Content) -> some View {
        Group {
            content
                .blur(radius: showOverlay ? blurRadius : 0)
                .animation(.easeInOut)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
