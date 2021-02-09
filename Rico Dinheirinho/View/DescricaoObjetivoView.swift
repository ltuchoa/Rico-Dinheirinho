//
//  DescricaoObjetivoView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 06/02/21.
//

import SwiftUI

struct DescricaoObjetivoView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var objetivoViewModel: ObjetivoViewModel = ObjetivoViewModel()

    var objetivo = Objetivo()

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
                            // What to perform
                            objetivo.valorDepositado -= 50
                            objetivoViewModel.update(viewContext: viewContext, objetivo: objetivo)
                            print(objetivo.valorDepositado)
                        }) {
                            // How the button looks like
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

                        Button(action: {
                            // What to perform
                            objetivo.valorDepositado += 50
                            objetivoViewModel.update(viewContext: viewContext, objetivo: objetivo)
                            print(objetivo.valorDepositado)
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
                Text(objetivo.data.description.dropLast(15))
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
                Image("Plantin2")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, -5)
                    .frame(minWidth: 60, idealWidth: 90, maxWidth: 130, minHeight: 80, idealHeight: 160, maxHeight: 200, alignment: .bottom)
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
        .edgesIgnoringSafeArea(.top)
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
                    .animation(.linear)
                    .cornerRadius(40)
                    .padding(.leading, 1)
            }.cornerRadius(45.0)
        }
    }
}

struct DescricaoObjetivoView_Previews: PreviewProvider {
    static var previews: some View {
        DescricaoObjetivoView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
