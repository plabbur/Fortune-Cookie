//
//  GeneralSettingsView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 9/2/24.
//

import SwiftUI

struct GeneralSettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var dataModel: FortuneCookieModel
    
    @State private var shakeToReveal = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ZStack {
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                            Image("Back Arrow Icon")
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                        .padding(.leading, 80)
                        
                        Text("General Settings")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color.offWhite)
                            .frame(width: geometry.size.width, alignment: .center)
                    }
                    .padding(.vertical)
                    .padding(.bottom)
                    
                    Toggle(isOn: $dataModel.shakeToReveal) {
                        Text("Shake to reveal")
                            .foregroundColor(.offWhite)
                    }
                    .padding(.horizontal, 40)
                    
                    
                }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .background(.mainBackground)
        }
    }
}

#Preview {
    GeneralSettingsView()
}
