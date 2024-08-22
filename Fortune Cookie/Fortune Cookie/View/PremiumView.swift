//
//  PremiumView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/6/24.
//

import SwiftUI

struct PremiumView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    var body: some View {
        OverlayTemplateView(content: PremiumViewContent(), overlay: .PREMIUM, height: 875, title: "Premium", customHeader: false)
    }
}

extension View {
    public func gradientForeground(gradient: LinearGradient) -> some View {
        self.overlay(
            gradient
        )
            .mask(self)
    }
}


struct PremiumViewContent: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image("Premium Star Icon")
                    Text("New fortunes, whenever")
                        .font(.system(size: 21))
                        .fontWeight(.medium)
                        .foregroundColor(.offWhite)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading, 40)
                .padding(.bottom, 10)
                
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.grayButtonBG)
                    .overlay {
                        HStack {
                            Image("Reload Icon")
                                .scaleEffect(1.25)
                                .padding(.leading, 25)
                            Spacer()
                            Text("New Fortune")
                                .font(.system(size: 20))
                                .foregroundColor(.offWhite)
                                .fontWeight(.medium)
                                .padding(.trailing, 25)
                        }
                        
                    }
                    .padding(.bottom, 30)
                
                HStack {
                    Image("Premium Star Icon")
                    Text("Choose fonts")
                        .font(.system(size: 21))
                        .fontWeight(.medium)
                        .foregroundColor(.offWhite)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading, 40)
                
                ZStack {
                    Image("Premium Fonts")
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 150, height: 100)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.75, y: 0.44),
                                endPoint: UnitPoint(x: 0.05, y: 0.45)
                            )
                        )
                        .frame(width: geometry.size.width, alignment: .leading)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 150, height: 100)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.75, y: 0.44),
                                endPoint: UnitPoint(x: 0.05, y: 0.45)
                            )
                        )
                        .frame(width: geometry.size.width, alignment: .trailing)
                }
                .padding(.bottom, 30)
                
                HStack {
                    Image("Premium Star Icon")
                    Text("Create multiple widgets")
                        .font(.system(size: 21))
                        .fontWeight(.medium)
                        .foregroundColor(.offWhite)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading, 40)
                
                ZStack {
                    Image("Premium Widgets")
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 150, height: 250)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.75, y: 0.44),
                                endPoint: UnitPoint(x: 0.05, y: 0.45)
                            )
                        )
                        .frame(width: geometry.size.width, alignment: .leading)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 150, height: 260)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.75, y: 0.44),
                                endPoint: UnitPoint(x: 0.05, y: 0.45)
                            )
                        )
                        .frame(width: geometry.size.width, alignment: .trailing)
                }
                .padding(.bottom, 30)
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blueButtonBG)
                    .frame(width: 258, height: 50)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay {
                        Text("Upgrade")
                            .foregroundColor(.offWhite)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                
                Button(action: { 
                    dataModel.currentOverlay = .NONE
                }) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.darkGrayButtonBG)
                        .frame(width: 258, height: 50)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        .overlay {
                            Text("Not now")
                                .foregroundColor(.offWhite)
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                        }
                }
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
    }
}

#Preview {
    PremiumView()
        .environmentObject(FortuneCookieModel())
}
