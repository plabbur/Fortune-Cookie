//
//  OptionsView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/5/24.
//

import SwiftUI

struct OptionsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dataModel: FortuneCookieModel

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        ZStack {
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Image("Back Arrow Icon")
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                            .padding(.leading, 80)
                            
                            Text("Options")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Color.offWhite)
                                .frame(width: geometry.size.width, alignment: .center)
                        }
                        .padding(.vertical)
                        .padding(.bottom)
                        
                        MenuOptionView(text: "Premium", icon: "Star Icon", premium: true, width: geometry.size.width - 30)
                            .onTapGesture {
                                dataModel.currentOverlay = .PREMIUM
                            }
                        
                        Rectangle()
                            .fill(.grayButtonBG)
                            .frame(width: geometry.size.width - 40, height: 0.5)
                            .padding(.vertical)
                        
                        NavigationLink(destination: GeneralSettingsView().navigationBarBackButtonHidden(true)) {
                            MenuOptionView(text: "General settings", icon: "Options Icon Filled", premium: false, width: geometry.size.width - 30)
                                .padding(.bottom)
                        }
                        MenuOptionView(text: "Retore purchases", icon: "Money Icon", premium: false, width: geometry.size.width - 30)
                            .padding(.bottom)
                        
                        MenuOptionView(text: "Add to home", icon: "Plus Box Icon", premium: false, width: geometry.size.width - 30)
                            .onTapGesture {
                                dataModel.currentOverlay = .ADD_TO_HOME
                            }
                        
                        
                    }
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .background(.mainBackground)
                .overlay {
                    
                    if (dataModel.currentOverlay == .PREMIUM) {
                        AnyView(PremiumView())
                    } else if (dataModel.currentOverlay == .ADD_TO_HOME) {
                        AnyView(AddToHomeView())
                    }
                }
            }
            
        }
        
    }
}

struct MenuOptionView: View {
    
    var text: String
    var icon: String
    var premium: Bool
    var width: CGFloat
    var height: CGFloat = 74
    var showArrow: Bool = true
    
    var gradientBorder: LinearGradient = Constants.premiumGradient
    var regularBorder:  LinearGradient = Constants.menuOptionBorder
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(premium ? gradientBorder : regularBorder)
            .frame(width: width, height: height)
            .overlay {
                RoundedRectangle(cornerRadius: 19)
                    .fill(.menuOptionFill)
                    .frame(width: width - 4, height: height - 4)
                    .overlay {
                        HStack {
                            Image(icon)
                                .padding(.leading, 14)
                            Text(text)
                                .foregroundColor(.offWhite)
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            if showArrow {
                                Image("Right Arrow Icon")
                                    .padding(.trailing, 24)
                            }
                        }
                    }
            }
    }
}

#Preview {
    OptionsView()
        .environmentObject(FortuneCookieModel())
}
