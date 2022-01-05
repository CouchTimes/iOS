//
//  ShowSeasonsSheet.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.01.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

extension View {
    func halfSheet<SheetView: View>(isPresented: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView, onEnd: @escaping() -> ()) -> some View {
        return self.background(HalfSheetHelper(sheetView: sheetView(), onEnd: onEnd, isPresented: isPresented))
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    var onEnd: () -> ()
    @Binding var isPresented: Bool
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            let sheetController = CustomUIHostingController(rootView: sheetView)
            
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                   self.isPresented.toggle()
               }
            }
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.onEnd()
        }
    }
}

class CustomUIHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }
    }
}
