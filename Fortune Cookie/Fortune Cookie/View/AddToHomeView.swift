//
//  AddToHomeView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/6/24.
//

import SwiftUI

struct AddToHomeView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel

    var body: some View {
        OverlayTemplateView(content: AddToHomeViewContent(), overlay: .ADD_TO_HOME, height: 875, title: "Add to home", customHeader: false)
    }
}

struct AddToHomeViewContent: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    @State var backgroundOffset: CGFloat = -2
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    PageView(image: "Add to home 1", text: "Hold down on any app to edit your Home Screen")
                        .frame(width: geometry.size.width)
                    PageView(image: "Add to home 2", text: "Tap the Plus button in the top left corner")
                        .frame(width: geometry.size.width)
                    PageView(image: "Add to home 3", text: "Search for Fortune Cookie and add the widget")
                        .frame(width: geometry.size.width)
                    PageView(image: "Add to home 4", text: "Hold down on the new widget and click “Edit Widget”")
                        .frame(width: geometry.size.width)
                    PageView(image: "Add to home 5", text: "Click “Choose” and select a widget for your home screen")
                        .frame(width: geometry.size.width)
                }
                .offset(x: -(backgroundOffset * geometry.size.width))
                .padding(.top, 50)
                
                Button(action: {
                    if (backgroundOffset < 2) {
                        backgroundOffset += 1
                    } else {
                        dataModel.currentOverlay = .NONE
                    }
                }) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(backgroundOffset < 2 ? .grayButtonBG : .offWhite)
                        .frame(width: 100, height: 50)
                        .overlay {
                            Text(backgroundOffset < 2 ? "Next" : "Close")
                                .foregroundColor(backgroundOffset < 2 ? .offWhite : .grayButtonBG)
                        }
                }
                .padding(.bottom, 60)
                
                
                ElipsesView(filled: backgroundOffset)
                    .padding(.bottom, 80)
                
            }
            .frame(width: geometry.size.width, alignment: .center)
            .gesture(
            DragGesture()
                .onEnded({ value in
                    if value.translation.width > 5 {
                        if backgroundOffset > -2 {
                            backgroundOffset -= 1
                        }
                    } else if value.translation.width < -5 {
                        if backgroundOffset < 2 {
                            backgroundOffset += 1
                        }
                    }
                })
            )
        }
    }
}

struct ElipsesView: View {
    var filled: CGFloat
    var body: some View {
        HStack {
            Image(filled == -2 ? "Filled Elipse" : "Unfilled Elipse")
            Image(filled == -1 ? "Filled Elipse" : "Unfilled Elipse")
            Image(filled == 0 ? "Filled Elipse" : "Unfilled Elipse")
            Image(filled == 1 ? "Filled Elipse" : "Unfilled Elipse")
            Image(filled == 2 ? "Filled Elipse" : "Unfilled Elipse")
        }
    }
}

struct PageView: View {
    
    var image: String
    var text: String
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Image(image)
                    .padding(.bottom, 50)
                Text(text)
                    .foregroundColor(.offWhite)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .frame(width: geometry.size.width - 125, alignment: .centerLastTextBaseline)
            }
            .frame(width: geometry.size.width, alignment: .center)
            
        }
    }
}

#Preview {
    AddToHomeView()
        .environmentObject(FortuneCookieModel())
}
