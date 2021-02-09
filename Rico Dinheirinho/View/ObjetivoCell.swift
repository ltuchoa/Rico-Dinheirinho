//
//  ObjetivoCell.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 04/02/21.
//

import SwiftUI

struct ObjetivoCell: View {

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var objetivoViewModel: ObjetivoViewModel = ObjetivoViewModel()

    var objetivo = Objetivo()

    var body: some View {
        ZStack {
            HStack {
                Text(Image(systemName: objetivo.icone))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 34))

                VStack(alignment: .leading) {
                    Text(objetivo.nome)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .font(.system(size: 20))

                    HStack {
                        ProgressBar(value: objetivo.progress).frame(height: 18)

                        Text("\(Int(objetivo.progress*100))%")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }.padding(.top, -2)
                }.padding([.top, .bottom], 15)
                .padding(.leading, 20)
            }.padding([.leading, .trailing], 20)


        }
        .background(LinearGradient(gradient: Gradient(colors: [.primaryGreen, .secondaryGreen]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.9))
        .cornerRadius(20)
        .padding([.leading, .trailing], 30)
        .padding([.top, .bottom], 7.5)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct ProgressBar: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(1)
                    .foregroundColor(Color.white)

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height-2)
                    .foregroundColor(Color.primaryGreen)
                    .animation(.linear)
                    .cornerRadius(40)
                    .padding(.leading, 1)
            }.cornerRadius(45.0)
        }
    }
}

struct ObjetivoCell_Previews: PreviewProvider {
    static var previews: some View {
        ObjetivoCell(objetivo: Objetivo())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
