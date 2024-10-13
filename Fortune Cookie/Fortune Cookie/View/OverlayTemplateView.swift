//
//  OverlayTemplateView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/7/24.
//

import SwiftUI

struct OverlayTemplateView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    @State var yOffset: Double = 900
    @State private var isDragging = false
    @State var opacityOffset: Double = 0
    @State private var dragVelocity: CGFloat = 0.0

    
    var content: any View
    var overlayMode: FortuneCookieModel.Overlay
    var height: CGFloat
    var title: String
    
    var customHeader: Bool?
    
    init(content: any View, overlay: FortuneCookieModel.Overlay, height: CGFloat, title: String, customHeader: Bool?) {
        self.content = content
        self.overlayMode = overlay
        self.height = height
        self.title = title
        self.customHeader = customHeader
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 40)
                .fill(.overlayBG)
                .frame(height: self.height)
                .overlay {
                    VStack {
                        
                        if (!(customHeader ?? true)) {

                            HStack {
                                
                                Spacer()
                                
                                if (overlayMode == .PREMIUM) {
                                    Text(self.title)
                                        .gradientForeground(gradient: Constants.premiumGradient)
                                        .font(.system(size: 28))
                                        .fontWeight(.semibold)
                                        .padding(.leading, 50)
                                } else {
                                    Text(self.title)
                                        .foregroundColor(.offWhite)
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .padding(.leading, 50)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            yOffset = 1000
                                            
                                        }
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            opacityOffset = 0.4
                                        }
                                        
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        dataModel.currentOverlay = .NONE

                                    }
                                    
                                }) {
                                    
                                    Image("Exit Icon")
                                }
                                .padding(.trailing, 30)

                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                            .padding(.bottom, 30)

                        
                            
                            
                        }
                        
                        AnyView(self.content)
                            
                    }
                    .frame(width: geometry.size.width, height: height, alignment: .top)
                    .padding(.top, 80)
                }
                .frame(height: geometry.size.height + 10, alignment: .bottom)
                .frame(height: geometry.size.height * 2)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .black.opacity(0.0),
                            .black.opacity(0.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            yOffset = 900
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            dataModel.currentOverlay = .NONE
                        }
                    }
                )
                .ignoresSafeArea()
                .position(x: geometry.size.width / 2, y: CGFloat(yOffset))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        withAnimation(.easeInOut(duration: overlayMode == .EDIT_WIDGET ? 0.0 : 0.1)) {
                            yOffset = 451
                        }
                        withAnimation(.easeIn(duration: overlayMode == .EDIT_WIDGET ? 0.0 : 0.25)) {
                            opacityOffset = 0.4
                        }
                    }
                }
                .gesture(
                    
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 0 && dataModel.currentOverlay != .EDIT_WIDGET {
                                isDragging = true
                                yOffset = 451 + value.translation.height
                            }
                        }
                        .onEnded { value in
                            print(value.velocity)
                            if value.velocity.height < 30 {
                                isDragging = false
                                withAnimation(.spring()) {
                                    yOffset = 451
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    yOffset = 1000
                                    dataModel.currentOverlay = .NONE
                                }
                            }
                        }
                )
                .animation(.spring(), value: isDragging)
        }
    }
}

#Preview {
    OverlayTemplateView(content: PremiumViewContent(), overlay: FortuneCookieModel.Overlay.PREMIUM, height: 875, title: "Premium", customHeader: false)
        .environmentObject(FortuneCookieModel())
}
