//
//  WidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import SwiftUI

struct WidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel

    var expandable: Bool
    var staged: Bool
    var size: WidgetModel.SizeMode
    var color: Color = Color.darkBlue
    let gradientColor: LinearGradient = Constants.darkBlueGradient
    var font: String = "Times New Roman"
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(gradientColor)
            .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 360 : 273) : (staged ? 169 : 128), height: staged ? 169 : 128)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 352 : 265) : (staged ? 161 : 120), height: staged ? 161 : 120)
                
            }
            .overlay {
                VStack {
                    Text(dataModel.getFortune())
                        .font(
                            Font.custom(font, size: (staged ? 22 : 17))
                            .italic()
                        )
                        .foregroundColor(Color.offWhite)
                        .padding(.horizontal, staged ? 0 : -8)
                    
                    Image("Quotation Marks")
                        .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 360 : 273) : (staged ? 169 : 128), alignment: .leading)
                        .padding(.leading, (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 110 : 35) : (staged ? 50 : 15))
                        .padding(.top, 10)
                        .scaleEffect(staged ? 1 : 0.8)
                }
                .padding(.horizontal, 25)
                .foregroundColor(Color.offWhite)
            }
            .overlay {
                if expandable {
                    Image("Expand Icon")
                        .padding(10)
                        .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? 360 : 169, height: 169, alignment: .bottomTrailing)
                }
            }
    }
}

#Preview {
    WidgetView(expandable: true, staged: true, size: WidgetModel.SizeMode.MEDIUM)
        .environmentObject(FortuneCookieModel())
}
