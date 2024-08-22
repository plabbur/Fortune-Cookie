//
//  HomeView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel

    @State private var actionable: Bool = true
    @State var stagedWidgetScale: CGFloat = 1.0
    @State var stagedWidgetOpacity: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        ZStack {
                            Text("Fortune Cookie")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Color.offWhite)
                                .frame(width: geometry.size.width, alignment: .center)
                            
                            NavigationLink(destination: OptionsView().navigationBarBackButtonHidden(true)) {
                                Image("Options Icon")
                                    .frame(width: geometry.size.width, alignment: .trailing)
                                    .padding(.trailing, 80)
                            }
                            
                        }
                        .padding(.vertical)
                        
                        ScrollView {
                            Group {
                                VStack {
                                    Button(action: { 
                                        dataModel.widgetToView = dataModel.stagedWidget
                                        dataModel.currentOverlay = .VIEW_WIDGET
                                    }) {
                                        dataModel.stagedWidget.displayWidget(expandable: true, staged: true)
                                            .scaleEffect(stagedWidgetScale)
                                            .opacity(stagedWidgetOpacity)
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.bottom)
                                
                                Button(action: { 
                                    
                                    dataModel.newFortune()
                                }) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 160, height: 40)
                                        .foregroundColor(.grayButtonBG)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                        .overlay {
                                            
                                            HStack {
                                                Image("Reload Icon")
                                                Text("New Fortune")
                                                    .foregroundColor(.offWhite)
                                                    .fontWeight(.medium)
                                            }
                                            
                                        }
                                }
                            }
                            
                            Spacer(minLength: 50)
                            
                            
                            HStack {
                                Text("Your widgets")
                                    .foregroundColor(.offWhite)
                                    .font(.system(size: 22))
                                    .fontWeight(.semibold)
                                Spacer()
                                
                                Button(action: { 
                                    dataModel.currentOverlay = .CREATE_WIDGET
                                }) {
                                    Image("Plus Icon")
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom)
                            
                            Group {
                                Text("Medium")
                                    .font(.system(size: 18))
                                    .foregroundColor(.subtextGray)
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.bottom, 5)
                                    .padding(.leading, 35)
                                
                                UnstagedWidgetsView(widgetList: dataModel.getWidgets(size: .MEDIUM), stagedWidgetScale: $stagedWidgetScale, stagedWidgetOpacity: $stagedWidgetOpacity)
                                
                                Text("Small")
                                    .font(.system(size: 18))
                                    .foregroundColor(.subtextGray)
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.bottom, 5)
                                    .padding(.leading, 35)
                                
                                UnstagedWidgetsView(widgetList: dataModel.getWidgets(size: .SMALL), stagedWidgetScale: $stagedWidgetScale, stagedWidgetOpacity: $stagedWidgetOpacity)
                            }
                        }
                    }
                }
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.15, green: 0.13, blue: 0.24), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.07, green: 0.07, blue: 0.07), location: 0.25),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    
                )
            }
            .overlay {
                if (dataModel.currentOverlay == .ADD_TO_HOME) {
                    AnyView(AddToHomeView())
                } else if (dataModel.currentOverlay == .CREATE_WIDGET) {
                    AnyView(CreateWidgetView())
                } else if (dataModel.currentOverlay == .VIEW_WIDGET || dataModel.currentOverlay == .EDIT_WIDGET) {
                    AnyView(ViewWidgetView(widget: dataModel.widgetToView))
                } else if (dataModel.currentOverlay == .PREMIUM) {
                    AnyView(PremiumView())
                }
            }
        }
    }
}

struct UnstagedWidgetsView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    var widgetList: [WidgetModel]
    
    @Binding var stagedWidgetScale: CGFloat
    @Binding var stagedWidgetOpacity: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 20) {
                    ForEach(widgetList, id: \.self) { widget in
                        widget.displayWidget(expandable: false, staged: false)
                            .padding(.leading, widget == widgetList[0] ? 37 : 0)
                            .padding(.trailing, widget == widgetList[widgetList.count - 1] ? 37 : 0)
                            .id(widgetList.firstIndex(of: widget))
                            .onTapGesture {
                                if (widget != dataModel.stagedWidget) {
                                    withAnimation(.easeInOut(duration: 0.15)) {
                                        stagedWidgetScale = 0.75
                                        stagedWidgetOpacity = 0.2
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        dataModel.stageWidget(widget: widget)

                                        withAnimation(.easeInOut(duration: 0.15)) {
                                            stagedWidgetScale = 1.0
                                            stagedWidgetOpacity = 1.0
                                        }
                                    }
                                }
                            }
                            .onLongPressGesture(minimumDuration: 0.1, perform: {
                                dataModel.widgetToView = widget
                                dataModel.currentOverlay = .VIEW_WIDGET
                            })
                            
                    }
                }
                .onChange(of: dataModel.stagedWidget) {
                    withAnimation {
                        scrollView.scrollTo(0, anchor: .center)
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
   HomeView()
        .environmentObject(FortuneCookieModel())
}
