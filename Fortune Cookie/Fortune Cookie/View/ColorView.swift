//
//  ColorView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 9/3/24.
//

import SwiftUI

struct ColorView: View {
    
    @State var selectedColor: Int = 0
    
    @State var selectedStart: Color = Constants.originalColors[0].getStart()
    @State var selectedEnd: Color = Constants.originalColors[0].getEnd()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.grayButtonBG)
                    .frame(width: geometry.size.width, height: geometry.size.height / 2.3)
                
                VStack {
                    HStack {
                        Text("Color")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.offWhite)
                            .padding(.leading, 50)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image("Exit Icon")
                        }
                        .padding(.trailing, 50)
                    }
                    
                    HStack {
                        ForEach(Array(Constants.originalColors.enumerated()), id: \.offset) { index, color in
                            if index < 12 {
                                if index < 6 {
                                    HStack {
                                        Circle()
                                            .fill(color.getGradient())
                                            .frame(width: 44)
                                            .padding(.trailing, 5)
                                            .onTapGesture {
                                                selectedColor = index
                                            }
                                            .overlay {
                                                if selectedColor == index {
                                                    Circle()
                                                        .fill(.offWhite)
                                                        .frame(width: 16)
                                                        .frame(width: 22, alignment: .leading)
                                                }
                                            }
                                    }
                                }
                            } else {
                                // create new page
                            }
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        ForEach(Array(Constants.originalColors.enumerated()), id: \.offset) { index, color in
                            if index < 12 {
                                if index >= 6 {
                                    HStack {
                                        Circle()
                                            .fill(color.getGradient())
                                            .frame(width: 44)
                                            .padding(.trailing, 5)
                                            .onTapGesture {
                                                selectedColor = index
                                            }
                                            .overlay {
                                                if selectedColor == index {
                                                    Circle()
                                                        .fill(.offWhite)
                                                        .frame(width: 16)
                                                        .frame(width: 22, alignment: .leading)
                                                }
                                            }
                                    }
                                }
                                
                            } else {
                                // create new page
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Edit gradient")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.subtextGray)
                            .padding(.leading, 50)
                        
                        Spacer()
                    }
                    
                    ZStack {
                        HStack {
                            ColorPicker("", selection: $selectedStart, supportsOpacity: false)
                                .scaleEffect(1.5)
                                .frame(width: 32)
                            
                            RoundedRectangle(cornerRadius: 30)
                                .fill(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: selectedStart, location: 0.00),
                                        Gradient.Stop(color: selectedEnd, location: 1.0)
                                    ], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)
                                ))
                                .frame(width: geometry.size.width - 200, height: 44)
                                .padding(.horizontal, 10)
                            
                            ColorPicker("", selection: $selectedEnd, supportsOpacity: false)
                                .scaleEffect(1.5)
                                .frame(width: 10)
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        .padding(.trailing, 26)
                    }
                    .onChange(of: selectedColor) {
                        selectedStart = Constants.originalColors[selectedColor].getStart()
                        selectedEnd = Constants.originalColors[selectedColor].getEnd()
                    }
                    .onChange(of: selectedStart) {
                        if selectedColor < Constants.originalColors.count {
                            if selectedStart != Constants.originalColors[selectedColor].getStart() {
                                selectedColor = Constants.originalColors.count + 1
                            }
                        }
                    }
                    .onChange(of: selectedEnd) {
                        if selectedColor < Constants.originalColors.count {
                            if selectedEnd != Constants.originalColors[selectedColor].getEnd() {
                                selectedColor = Constants.originalColors.count + 1
                            }
                        }
                    }
                }
            }
            .frame(height: geometry.size.height, alignment: .bottom)
            .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height / 2.3))
        }
    }
}

#Preview {
    ColorView()
}
