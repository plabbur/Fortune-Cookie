//
//  ViewWidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/5/24.
//

import SwiftUI
struct ViewWidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    var widget: WidgetModel
    
    var body: some View {
        OverlayTemplateView(content: ViewWidgetContentView(widget: widget), overlay: FortuneCookieModel.Overlay.VIEW_WIDGET, height: 690, title: "View widget", customHeader: false)
            .overlay {
                if (dataModel.currentOverlay == .ADD_TO_HOME) {
                    AnyView(AddToHomeView())
                } else if (dataModel.currentOverlay == .EDIT_WIDGET) {
                    AnyView(EditWidgetView(widget: widget))
                }
            }
    }
}

struct ViewWidgetContentView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    var widget: WidgetModel;
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                dataModel.widgetToView.displayWidget(shareable: true, expandable: false, staged: true, overlayOpacity: 0.0)
                
                HStack {
                    
                    Button(action: {
                        dataModel.currentOverlay = .ADD_TO_HOME
                    }) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.grayButtonBG)
                            .frame(width: 175, height: 45)
                            .overlay {
                                HStack {
                                    Image("Home Icon")
                                        .padding(.leading, 15)
                                    Spacer()
                                    Text("Add to home")
                                        .font(.system(size: 17))
                                        .foregroundColor(.offWhite)
                                        .padding(.trailing, 22)
                                }
                            }
                    }
                    
                    Button(action: {
//                        withAnimation(.easeIn(duration: 0.2)) {
                            dataModel.currentOverlay = .EDIT_WIDGET
//                        }
                    }) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.grayButtonBG)
                            .frame(width: 175, height: 45)
                            .overlay {
                                HStack {
                                    Image("Edit Icon")
                                        .padding(.leading, 15)
                                    Spacer()
                                    Text("Edit widget")
                                        .font(.system(size: 17))
                                        .foregroundColor(.offWhite)
                                        .padding(.trailing, 32)

                                }
                            }
                    }
                    
                }
                .padding(.top, 15)
            }
            .frame(width: geometry.size.width, alignment: .center)
            
        }
    }
}


#Preview {
    ViewWidgetView(widget: WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[2], font: "Times New Roman"))
        .environmentObject(FortuneCookieModel())
}
