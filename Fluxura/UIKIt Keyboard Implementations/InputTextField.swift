//
//  InputTextField.swift
//  Integra
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI
import UIKit

struct InputTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    @EnvironmentObject var data: AppData

    func makeUIView(context: UIViewRepresentableContext<InputTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<InputTextField>) {
//        uiView.inputAccessoryView = AccessoryView(target: uiView)
        uiView.inputView = Keyboard(target: uiView)
        
    }

    func makeCoordinator() -> InputTextField.Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        private let textField: InputTextField

        init(_ textField: InputTextField) {
            self.textField = textField
        }

//        func textField(_ textField: UITextField) {
//            self.textField
//        }
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField()
        .environmentObject(AppData())
    }
}
