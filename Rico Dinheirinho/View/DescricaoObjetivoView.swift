//
//  DescricaoObjetivoView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 06/02/21.
//

import SwiftUI
import ToastUI
import Combine

struct DescricaoObjetivoView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var objetivoViewModel: ObjetivoViewModel = ObjetivoViewModel()

    @State private var presentingToast: Bool = false
    @State private var presentingAnimation: Bool = false
    @State private var valor: String = ""
    @State var modo: String = ""

    @State var objetivo = Objetivo()

    var plantin: String {
        switch objetivo.progress {
        case 0.1...0.24:
            return "Plantin1"
        case 0.25...0.49:
            return "Plantin2"
        case 0.50...0.74:
            return "Plantin3"
        case 0.75...1:
            return "Plantin4"
        default:
            return "Plantin0"
        }
    }

    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .center) {
                    Text(Image(systemName: objetivo.icone))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .font(.system(size: 34))
                        .padding()
                        .background(
                            Circle()
                                .foregroundColor(.white).opacity(0.3).blur(radius: 1.0)
                        )

                    Text(objetivo.nome)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .font(.system(size: 22))

                    HStack(spacing: 20) {
                        Button(action: {
                            presentingToast = true
                            modo = "Retirar"
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.darkGreen).opacity(0.6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.darkGreen, lineWidth: 0.5)
                                    )
                                Text("Retirar")
                                    .foregroundColor(.white)
                            }
                        }.frame(width: 100, height: 34, alignment: .center)
                        .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)

                        .toast(isPresented: $presentingToast) {
                            ToastView {
                                ToastViewContent(isShowing: $presentingAnimation, valor: $valor, presentingToast: $presentingToast, presentingAnimation: $presentingAnimation, objetivo: $objetivo, modo: $modo).environment(\.managedObjectContext, self.viewContext)
                            }
                            .animation(.easeInOut(duration: 0.3))
                        }


                        Button(action: {
                            // What to perform
                            presentingToast = true
                            modo = "Depositar"
                        }) {
                            // How the button looks like
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.darkGreen).opacity(0.9)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.darkGreen, lineWidth: 0.5)
                                    )
                                Text("Depositar")
                                    .foregroundColor(.white)
                            }
                        }.frame(width: 100, height: 34, alignment: .center)
                        .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 10)

                }
                .padding(.top, UIScreen.main.bounds.size.height*0.1)
                .frame(minWidth: UIScreen.main.bounds.size.width)

            }
            .edgesIgnoringSafeArea(.top)
            .background(LinearGradient(gradient: Gradient(colors: [.primaryGreen, .secondaryGreen]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.9))
            .clipShape(RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))
            .padding(.bottom, 10)

            VStack {
                Text("Data Prevista")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(.bottom, 1)
                Text(objetivo.data, style: .date)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .padding(.bottom, 10)

                Text("Dinheiro Guardado")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding(.bottom, 1)
                HStack(spacing: 0) {
                    Text(String(format: "R$ %.2f", objetivo.valorDepositado))
                        .font(.system(size: 18, weight: .regular, design: .default))
                    Text(String(format: "/R$ %.2f", objetivo.valorTotal))
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }

                ZStack {
                    ProgressBar2(value: objetivo.progress).frame(height: 28)
                    Text("\(Int(objetivo.progress*100))%")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }.padding([.trailing, .leading], 60)
                .padding([.top, .bottom], 20)
                Spacer()

                Image(plantin)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, -5)
                    .frame(minWidth: 60, idealWidth: 80, maxWidth: 100, minHeight: 80, idealHeight: 160, maxHeight: 320, alignment: .bottom)
                    .transition(.opacity)
                    .id(plantin)
                    .transition(
                        .asymmetric(
                            insertion: AnyTransition.scale(scale: 1.1, anchor: .bottom),
                            removal: .identity
                        )
                    )
                    .animation(.easeInOut)
            }

        }
        .navigationBarItems(trailing:
                                Button(action: {
                                    objetivoViewModel.delete(viewContext: viewContext, objetivo: objetivo)
                                }) {
                                    Text(Image(systemName: "trash.fill"))
                                }
            .foregroundColor(.white)
        )
        .preference(key: AccentColorPreferenceKey.self, value: Color.white)
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea(.keyboard, edges: .all)
//        .onChange(of: objetivo.progress) { value in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
//                withAnimation(.easeInOut(duration: 2)) {
//                    switch value {
//                    case 0.1...0.24:
//                        self.plantin = "Plantin1"
//                    case 0.25...0.49:
//                        self.plantin = "Plantin2"
//                    case 0.50...0.74:
//                        self.plantin = "Plantin3"
//                    case 0.75...1:
//                        self.plantin = "Plantin4"
//                    default:
//                        self.plantin = "Plantin0"
//                    }
//                }
//            }

//        }


    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ProgressBar2: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(1)
                    .foregroundColor(Color.secondaryGreen).opacity(0.55)

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height-2)
//                    .foregroundColor(Color.primaryGreen)
                    .background(LinearGradient(gradient: Gradient(colors: [.primaryGreen, .secondaryGreen]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.clear)
                    .animation(Animation.easeInOut(duration: 0.9).delay(2.8))
                    .cornerRadius(40)
                    .padding(.leading, 1)
            }.cornerRadius(45.0)
        }
    }
}

struct ToastViewContent: View {
    @Binding var isShowing: Bool
    @Binding var valor: String
    @Binding var presentingToast: Bool
    @Binding var presentingAnimation: Bool
    @Binding var objetivo: Objetivo
    @Binding var modo: String

    @State var deuRuim: Bool = false

    var valorDeposit: Double {
        return objetivo.valorDepositado + valorFormatted
    }

    var valorRetir: Double {
        return objetivo.valorDepositado - valorFormatted
    }

    var valorFormatted: Double {
        return (Double(valor) ?? 0) / 100
    }

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var objetivoViewModel: ObjetivoViewModel = ObjetivoViewModel()

    var body: some View {
        if !isShowing {
            VStack(alignment: .center) {
                Text("Quanto gostaria de \(modo)?")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .padding(.horizontal, 10)

                ZStack(alignment: .leading) {
                    Text("R$ \(valorFormatted, specifier: "%.2f")").foregroundColor(.primaryGreen)
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .padding(.top, 15)
                    TextField("", text: $valor)
                        .keyboardType(.numberPad)
                        .textFieldStyle(BottomLineTextFieldStyle())
                        .onReceive(Just(valor)) { _ in if valor.count > 11 {
                                                    valor = String(valor.prefix(11))
                                                }}
                        .frame(minWidth: 80, idealWidth: 100, maxWidth: 200)
                        .padding(.top, 15)
                }


                HStack(spacing: 20) {
                    Button(action: {
                        presentingToast = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(UIColor.systemRed)).opacity(0.9)
                                .frame(width: 90, height: 34)
                            Text("Cancelar")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular, design: .default))
                        }
                    }

                    .toast(isPresented: $deuRuim) {
                        ToastView {
                            VStack {
                                Text("Os valores estão conflitantes.")
                                    .padding(.bottom)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200, height: 100)

                                Button {
                                    deuRuim = false
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

                    Button(action: {
                        if modo == "Retirar" {
                            if valorRetir < 0 {
                                deuRuim = true
                            } else {
                                objetivo.valorDepositado -= valorFormatted
                            }
                        } else {
                            if valorDeposit > objetivo.valorTotal {
                                deuRuim = true
                            } else {
                                objetivo.valorDepositado += valorFormatted
                            }
                        }
                        if !deuRuim {
                            objetivoViewModel.update(viewContext: viewContext, objetivo: objetivo)
                            valor = ""
                            presentingAnimation = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                presentingToast = false
                                presentingAnimation = false
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.darkGreen)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.darkGreen, lineWidth: 0.5)
                                )
                                .frame(width: 90, height: 34)
                            Text(modo)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular, design: .default))
                        }
                    }
                }.padding(.top, 20)
            }
            .padding(.vertical, 15)
            
        } else {
            LottieView(name: "animation", play: $isShowing)
                .frame(width: 200, height: 200)
        }

    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
            Rectangle()
                .frame(height: 0.5, alignment: .bottom)
                .foregroundColor(.primaryGreen)
                .accentColor(.primaryGreen)
        }
        .foregroundColor(.clear)
        .accentColor(.clear)
    }
}

struct DescricaoObjetivoView_Previews: PreviewProvider {
    static var previews: some View {
        DescricaoObjetivoView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
