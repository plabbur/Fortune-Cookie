//
//  AddWidgetUnstagedView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/29/24.
//

import SwiftUI

struct AddWidgetUnstagedView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    var size: WidgetModel.SizeMode
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.mainGray)
                .frame(width: (size == .MEDIUM) ? 273 : 128, height: 128)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .frame(width: (size == .MEDIUM) ? 266 : 121, height: 121)
                }
            
//            Circle()
//                .fill(.mainGray)
//                .frame(width: 60)
//                .overlay {
//                    Circle()
//                        .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
//                        .frame(width: 53)
//                }
            
            Image("Plus Icon Gray")
                .scaleEffect(1.2)
            
        }
        
    }
}

#Preview {
    AddWidgetUnstagedView(size: .MEDIUM)
        .environmentObject(FortuneCookieModel())
}
