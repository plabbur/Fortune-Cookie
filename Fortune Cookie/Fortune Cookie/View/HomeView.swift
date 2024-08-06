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
                                    dataModel.stagedWidget.displayWidget(staged: true)
                                    
                                    //                                WidgetView(staged: true, size: dataModel.stagedWidget.getSize(), color: dataModel.stagedWidget.getColor())
                                }
                                .padding(.top, 30)
                                .padding(.bottom)
                                
                                Button(action: { dataModel.newFortune() }) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 160, height: 40)
                                        .foregroundColor(.grayButtonBG)
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
                                Image("Plus Icon")
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
                                
                                UnstagedWidgetsView(widgetList: dataModel.getWidgets(size: .MEDIUM))
                                
                                Text("Small")
                                    .font(.system(size: 18))
                                    .foregroundColor(.subtextGray)
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.bottom, 5)
                                    .padding(.leading, 35)
                                
                                UnstagedWidgetsView(widgetList: dataModel.getWidgets(size: .SMALL))
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
            .frame(width: 430, height: 931)
            
        }
    }
}

struct UnstagedWidgetsView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    var widgetList: [WidgetModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack(spacing: 20) {
                    ForEach(widgetList, id: \.self) { widget in
                        widget.displayWidget(staged: false)
                            .padding(.leading, widget == widgetList[0] ? 37 : 0)
                            .padding(.trailing, widget == widgetList[widgetList.count - 1] ? 37 : 0)
                            .id(widgetList.firstIndex(of: widget))
                            .onTapGesture {
                                dataModel.stageWidget(widget: widget)
                            }
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
