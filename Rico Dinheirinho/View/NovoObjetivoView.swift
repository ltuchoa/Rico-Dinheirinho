//
//  NovoObjetivoView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI
import Combine
import ToastUI

struct NovoObjetivoView: View {

    @Environment(\.presentationMode) var presentationMode

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var objetivoViewModel: ObjetivoViewModel = ObjetivoViewModel()

    @State private var presentingToast: Bool = false
    @State private var nome: String = ""
    @State private var valor: String = ""
    @State private var icone: String = "square.and.pencil"
    @State private var data = Date()

    var valorFormatted: Double {
        return (Double(valor) ?? 0) / 100
    }

    var items = ["airplane", "car.fill", "map.fill", "gamecontroller.fill", "gift.fill", "tv.fill", "guitars.fill", "books.vertical.fill", "graduationcap.fill", "case.fill", "house.fill", "cart.fill", "camera.fill", "iphone.homebutton", "headphones"]
    @State private var presentPicker = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Nome do Objetivo")
                    .padding(.top, 7.5)
                    .font(.system(size: 20, weight: .medium, design: .default))
                TextField("Digite o nome do objetivo", text: $nome)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .disableAutocorrection(true)
                    .onReceive(Just(nome)) { _ in if nome.count > 20 {
                                                nome = String(nome.prefix(20))
                                            }}
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.primaryGreen, lineWidth: 1.5)
                            .padding([.leading, .trailing], 10)
                    )
                    .padding(.top, 4)

                Text("Valor")
                    .padding(.top, 15)
                    .font(.system(size: 20, weight: .medium, design: .default))
                ZStack(alignment: .leading) {
                    Text("R$ \(valorFormatted, specifier: "%.2f")").foregroundColor(.primaryGreen)
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .padding([.leading, .trailing], 24)
                        .padding([.top], 5)
                    TextField("", text: $valor)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .padding([.leading, .trailing], 24)
                        .padding([.top, .bottom], 8)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primaryGreen, lineWidth: 1.5)
                                .padding([.leading, .trailing], 10)
                        )
                        .onReceive(Just(valor)) { _ in if valor.count > 11 {
                                                    valor = String(valor.prefix(11))
                                                }}
                        .padding(.top, 4)
                }

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

                .toast(isPresented: $presentingToast) {
                    ToastView {
                        VStack {
                            Text("Parece que alguns dados não foram preenchidos.")
                                .padding(.bottom)
                                .multilineTextAlignment(.center)
                                .frame(width: 200, height: 100)

                            Button {
                                presentingToast = false
                            } label: {
                                Text("OK")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 12.0)
                                    .background(Color(UIColor.systemRed).opacity(0.9))
                                    .cornerRadius(10)
                            }.padding(.bottom, 10)
                        }
                    }
                }

                Spacer()
            }
            .padding([.leading, .trailing], 20)

            .navigationBarTitle("Novo Objetivo", displayMode: .large)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        if nome.count != 0 && valorFormatted != 0 && icone != "square.and.pencil" {
                                            objetivoViewModel.save(viewContext: viewContext, nome: nome, valor: valorFormatted, data: data, icone: icone)
                                            self.presentationMode.wrappedValue.dismiss()
                                        } else {
                                            presentingToast = true
                                        }

                                    }) {
                                        Text("Salvar")
                                    }
                .foregroundColor(.primaryGreen)
            )

            .toast(isPresented: $presentPicker) {
                ToastView {
                    CustomPickerView(items: items, pickerField: $icone, presentPicker: $presentPicker)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
            }


        }
        .preference(key: AccentColorPreferenceKey.self, value: Color.primaryGreen)
        .animation(.easeInOut(duration: 0.22))
        .onAppear(perform: {
            UIApplication.shared.addTapGestureRecognizer()
        })
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
