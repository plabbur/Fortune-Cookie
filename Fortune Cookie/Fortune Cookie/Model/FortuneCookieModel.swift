//
//  FortuneCookieModel.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI
import UIKit
import Combine
import WidgetKit

struct OpenAIRequest: Codable {
    let model: String
    let messages: [Message]
}

struct Message: Codable {
    let role: String
    let content: String
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}


class FortuneCookieModel: ObservableObject {

    @Published var widgetToView: WidgetModel = WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[2], font: "New York Times")
    
    @Published var stagedWidget: WidgetModel
    @Published var allWidgets: [WidgetModel]
    @Published var currentOverlay: Overlay
    
    private var fortunesUsed: [String] = [String]()
    private var fortunesUsedString: String = ""
    @Published var currentFortune: String = "Fortune will soon find you, just wait"
    var nextFortune: String = "Your dreams are closer than you think."
    @Published var unstagedFortune: String = "Fortune will soon find you, just wait"

    let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
    
    @AppStorage("ShakeToReveal") var shakeToReveal: Bool = true
    
    enum Overlay {
        case VIEW_WIDGET
        case CREATE_WIDGET
        case EDIT_WIDGET
        case ADD_TO_HOME
        case PREMIUM
        
        case NONE
    }
    
    init() {
        let initialWidgets = [
            WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[1], font: "Times New Roman"),
                WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[2], font: "Helvetica"),
                WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[3], font: "Times New Roman"),
                WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[4], font: "Georgia"),
                WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Constants.originalColors[5], font: "Times New Roman"),
                WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Constants.originalColors[6], font: "Georgia"),
                WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Constants.originalColors[7], font: "Helvetica")
            ]
        
        self.allWidgets = initialWidgets
        self.stagedWidget = initialWidgets[0]
        self.currentOverlay = Overlay.NONE
    }
    
    
    func getWidgets(size: WidgetModel.SizeMode) -> [WidgetModel] {
        var widgets = [WidgetModel]()
        
        allWidgets.forEach { widget in
            if (widget.getSize() == size) {
                widgets.append(widget)
            }
        }
        
        return widgets
    }
    
    func stageWidget(widget: WidgetModel) {
        let fromIndex: Int = allWidgets.firstIndex(of: widget) ?? 0
        allWidgets.remove(at: fromIndex)
        allWidgets.insert(widget, at: 0)
        
        stagedWidget = widget
        updateDefaults()
    }
    
    func addWidget(widget: WidgetModel) {
        allWidgets.append(widget)
        stageWidget(widget: widget)
    }
    
    func widgetExists(widget: WidgetModel) -> Bool {
        return allWidgets.contains(widget)
    }
    
    func getFortune() -> String {
        return self.currentFortune
    }
    
    func setFortune(fortune: String) {
        self.currentFortune = fortune
    }
    
    func addCharToFortune(char: String) {
        self.currentFortune += char
    }
    
    func typeFortune(fortune: String, completion: @escaping () -> Void) {
        let fortuneAsList = Array(fortune)
        setFortune(fortune: "")
        
        for (index, character) in fortuneAsList.enumerated() {
            let delay = 0.05 * Double(index)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.easeIn(duration: 0.5)) {
                    self.addCharToFortune(char: String(character))
                    if index == fortuneAsList.count - 1 {
                        self.updateDefaults()
                        completion()
                    }
                }
            }
        }
    }
    
    func getNextFortune() -> String {
        return self.nextFortune
    }
    
    func setNextFortune(nextFortune: String) {
        self.nextFortune = nextFortune
    }
    
    func setUnstagedFortune() {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.unstagedFortune = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.unstagedFortune = self.getFortune()
                }
            }
        }
    }
    
    func newFortune() {

        if self.shakeToReveal {
            self.setFortune(fortune: self.getFortune())
        } else {
            self.typeFortune(fortune: getNextFortune()) {
                self.fortunesUsed.append(self.currentFortune)
            }
        }
        
        let prompt: String = "Generate a fortune cookie fortune that is less than 10 words and is not similar to these (don't add exclamation marks): " + fortunesUsed.map { "'\($0)'" }.joined(separator: ", ")
        
        makeOpenAIRequest(prompt: prompt) { responseString in
            DispatchQueue.main.async {
                if let response = responseString {
                    self.setNextFortune(nextFortune: response)
                } else {
                    print("failed to get a response")
                }
            }
        }
    }
    
    func makeOpenAIRequest(prompt: String, completion: @escaping (String?) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
            print("API key not found in environment variables")
            completion(nil)
            return
        }
        
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let messages = [
            Message(role: "user", content: prompt)
        ]
        
        let requestBody = OpenAIRequest(model: "gpt-4o-mini", messages: messages)
        
        do {
            let requestBodyData = try JSONEncoder().encode(requestBody)
            request.httpBody = requestBodyData
        } catch {
            print("Failed to encode request body: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            do {
                let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                if let choice = openAIResponse.choices.first {
                    let responseString = choice.message.content
                    completion(responseString) // Return the response as a string
                } else {
                    completion(nil) // No choice found in the response
                }
            } catch {
                print("Failed to decode response: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func updateDefaults() {
        
        var widgetSizes: [String] = [String]()
        var widgetColors: [LinearGradient] = [LinearGradient]()
        var widgetFonts: [String] = [String]()
        
        for widget in allWidgets {
            widgetSizes.append(widget.getSizeAsString())
            widgetColors.append(widget.getColor().getGradient())
            widgetFonts.append(widget.getFont())
        }
        
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: stagedWidget.getColor().getGradient(), requiringSecureCoding: false) {
            sharedDefaults?.set(colorData, forKey: "WidgetColor")
        }
        
        sharedDefaults?.set(self.currentFortune, forKey: "WidgetFortune")
        sharedDefaults?.set(stagedWidget.getFont(), forKey: "WidgetFont")
        sharedDefaults?.set(stagedWidget.getSizeAsString(), forKey: "WidgetSize")

//        sharedDefaults?.set(widgetSizes, forKey: "AllWidgetSizes")
//        sharedDefaults?.set(widgetColors, forKey: "AllWidgetColors")
//        sharedDefaults?.set(widgetFonts, forKey: "AllWidgetFonts")
//        sharedDefaults?.set(self.allWidgets, forKey: "AllWidgets")
        
        WidgetCenter.shared.reloadTimelines(ofKind: "Fortune_Cookie_Widget")
    }
}
