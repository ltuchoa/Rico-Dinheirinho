//
//  CustomPickerView.swift
//  Rico Dinheirinho
//
//  Created by Larissa Uchoa on 05/02/21.
//

import SwiftUI

struct CustomPickerView: View {
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 60))]
    var items: [String]
    @Binding var pickerField: String
    @Binding var presentPicker: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
            VStack(alignment: .leading) {
                HStack {
                    Text("Selecione um ícone ")
                        .padding()
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(Color(UIColor.label))
                    Spacer()
                    Button(action: {
                        withAnimation {
                            presentPicker = false
                        }
                    }) {
                        Text(Image(systemName: "xmark.circle.fill"))
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .foregroundColor(.primaryGreen)
                            .padding()
                    }
                }
                .overlay(Rectangle().frame(width: nil, height: 2, alignment: .top).foregroundColor(Color.primaryGreen).opacity(0.2), alignment: .bottom)

                .foregroundColor(.white)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            pickerField = item
                            withAnimation {
                                presentPicker = false
                            }
                        }) {
                            Text(Image(systemName: item))
                                .font(.system(size: 24, weight: .semibold, design: .default))
                                .foregroundColor(.primaryGreen)
                        }
                    }
                }.padding(.top, 10)
            }
            .padding(.bottom, 20)
            .background(Color(UIColor.secondarySystemBackground)).cornerRadius(20)
            .padding(.horizontal, 30)
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.primaryGreen, lineWidth: 2)
//                    .padding(.horizontal, 30)
//            )
            .shadow(color: Color(UIColor.label).opacity(0.1), radius: 2, x: 0, y: 2)
        }
        .edgesIgnoringSafeArea(.all)
    }
}



struct CustomPickerView_Previews: PreviewProvider {
    static let sampleImage = ["airplane", "car.fill", "map.fill", "gamecontroller.fill", "gift.fill", "tv.fill", "guitars.fill"]
    static var previews: some View {
        CustomPickerView(items: sampleImage, pickerField: .constant(""), presentPicker: .constant(true))
    }
}
