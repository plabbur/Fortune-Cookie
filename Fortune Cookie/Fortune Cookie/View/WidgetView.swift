//
//  WidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import SwiftUI

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

struct WidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel

    var shareable: Bool
    var expandable: Bool
    var staged: Bool
    var size: WidgetModel.SizeMode
    var color: WidgetColor = Constants.originalColors[2]
    
//    let gradientColor: LinearGradient = Constants.darkBlueGradient
    var font: String = "Times New Roman"
    
    @State var overlayOpacity: CGFloat = 0.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color.getGradient())
            .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 360 : 273) : (staged ? 169 : 128), height: staged ? 169 : 128)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
//            .overlay {
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(color)
//                    .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 352 : 265) : (staged ? 161 : 120), height: staged ? 161 : 120)
//                
//            }
            .overlay {
                ZStack {
                    Text(staged ? dataModel.currentFortune : dataModel.unstagedFortune)
                        .font(
                            Font.custom(font, size: (staged ? 22 : 17))
                            .italic()
                        )
                        .foregroundColor(Color.offWhite)
                        .padding(.horizontal, staged ? 0 : -8)
                        .minimumScaleFactor(0.8)
                        .lineLimit(size == .MEDIUM ? 3 : 6)
                        .frame(width: size == .MEDIUM ? (staged ? 250 : 180) : (staged ? 120 : 80), height: size == .MEDIUM ? (staged ? 120 : 100) : (staged ? 130 : 110), alignment: size == .SMALL ? .topLeading : .topLeading)
                        .padding(.top, size == .MEDIUM ? 30 : 10)
                        .multilineTextAlignment(.leading)

                    if (size == .MEDIUM) {
                        Image("Quotation Marks")
                            .frame(width: size == .MEDIUM ? (staged ? 250 : 250) : (staged ? 120 : 80), height: size == .MEDIUM ? (staged ? 100 : 80) : (staged ? 130 : 80), alignment: .bottomLeading)
//                            .padding(.leading, (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 110 : 35) : (staged ? 50 : 15))
                            .padding(.top, 10)
                            .scaleEffect(staged ? 1 : 0.8)
                    }
                }
                .padding(.horizontal, 25)
                .foregroundColor(Color.offWhite)
            }
            .overlay {
                if expandable {
                    Image("Expand Icon")
                        .padding(10)
                        .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? 360 : 169, height: 169, alignment: .bottomTrailing)
                }
            }
            .overlay {
                if staged {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color.getGradient())
                            .frame(width: (size == WidgetModel.SizeMode.MEDIUM) ? (staged ? 360 : 273) : (staged ? 169 : 128), height: staged ? 169 : 128)
                        
                        Text("Shake to reveal")
                            .foregroundColor(.white)
                    }
                    .opacity(overlayOpacity)
                    .onShake {
                        if overlayOpacity >= 0.9 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    overlayOpacity = 0.0
                                }
                            }
                        }
                        
                        dataModel.setUnstagedFortune()
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            overlayOpacity = 0.0
                            dataModel.setUnstagedFortune()
                        }
                    }
                    .onChange(of: dataModel.currentFortune) {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            overlayOpacity = 0.9
                        }
                    }
                }
            }
    }
}

#Preview {
    WidgetView(shareable: true, expandable: false, staged: true, size: WidgetModel.SizeMode.SMALL)
        .environmentObject(FortuneCookieModel())
}
