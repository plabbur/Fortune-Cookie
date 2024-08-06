//
//  ViewWidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/5/24.
//

import SwiftUI

struct ViewWidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    var widget: WidgetModel = WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: .darkBlue, font: "Times New Roman")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.overlayBG)
                    .frame(height: 690)
                    .overlay {
                        VStack {
                            ZStack {
                                Text("View Widget")
                                    .foregroundColor(.offWhite)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                
                                Button(action: { dataModel.viewWidget = false }) {
                                    Image("Exit Icon")
                                }
                                .frame(width: geometry.size.width, alignment: .trailing)
                                .padding(.trailing, 80)
                            }
                            .padding(.bottom, 25)
                            .padding(.top, 55)
                            
                            widget.displayWidget(expandable: false, staged: true)
                            
                            HStack {
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
                                
                                Button(action: { 
                                    dataModel.viewWidget = false
                                    dataModel.editWidget = true
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
                            
                            
                            
                            Spacer()
                        }
                    }
            }
            .frame(height: geometry.size.height + 400)
            .background(.black.opacity(0.25))
            .ignoresSafeArea()
            .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height - 550))
            
        }
    }
}

#Preview {
    ViewWidgetView()
        .environmentObject(FortuneCookieModel())
}
