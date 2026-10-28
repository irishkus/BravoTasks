//
//  UIKitFullScreenCover.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 13.10.2026.
//

import SwiftUI
import UIKit
import Combine

struct UIKitFullScreenCover<Content: View>: UIViewControllerRepresentable {

    @Binding var isPresented: Bool

    let publisher: AnyPublisher<Bool, Never>
    var onDismiss: (() -> Void)? = nil
    let content: () -> Content

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIViewController(context: Context) -> Presenter {
        let presenter = Presenter()

        context.coordinator.presenter = presenter
        context.coordinator.binding = $isPresented
        context.coordinator.onDismiss = onDismiss

        presenter.coordinator = context.coordinator
        presenter.makeContent = content
        presenter.setPresented(isPresented)

        context.coordinator.subscribe(to: publisher)

        return presenter
    }

    func updateUIViewController(
        _ presenter: Presenter,
        context: Context
    ) {
        context.coordinator.binding = $isPresented
        context.coordinator.onDismiss = onDismiss

        presenter.updateContent(content)
        presenter.setPresented(isPresented)
    }

    static func dismantleUIViewController(
        _ presenter: Presenter,
        coordinator: Coordinator
    ) {
        coordinator.cancel()
        presenter.tearDown()
    }

    final class Coordinator {

        weak var presenter: Presenter?

        var binding: Binding<Bool>?
        var onDismiss: (() -> Void)?

        private var subscription: AnyCancellable?

        func subscribe(to publisher: AnyPublisher<Bool, Never>) {
            subscription = publisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] value in
                    self?.presenter?.setPresented(value)
                }
        }

        func cancel() {
            subscription?.cancel()
            subscription = nil
        }

        func didDismiss() {
            if binding?.wrappedValue == true {
                binding?.wrappedValue = false
            }

            onDismiss?()
        }
    }

    final class Presenter: UIViewController {

        enum Phase {
            case idle
            case presenting
            case presented
            case dismissing
        }

        weak var coordinator: Coordinator?

        var makeContent: (() -> Content)?

        private(set) var shouldPresent = false
        private var phase: Phase = .idle
        private var hostingController: UIHostingController<Content>?
        private var isActive = true

        override func loadView() {
            let view = UIView()
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            self.view = view
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            reconcile()
        }

        func setPresented(_ value: Bool) {
            guard isActive else { return }

            shouldPresent = value
            reconcile()
        }

        private func reconcile() {
            guard isActive else { return }

            switch phase {
            case .idle:
                if shouldPresent, view.window != nil {
                    presentContent()
                }

            case .presented:
                if !shouldPresent {
                    dismissContent()
                }

            case .presenting, .dismissing:
                break
            }
        }

        private func presentContent() {
            guard let makeContent else { return }
            guard presentedViewController == nil else { return }

            let hosting = UIHostingController(
                rootView: makeContent()
            )

            hosting.modalPresentationStyle = .fullScreen

            hostingController = hosting
            phase = .presenting

            present(hosting, animated: true) { [weak self] in
                guard let self else { return }

                self.phase = .presented
                self.reconcile()
            }
        }

        private func dismissContent() {
            guard hostingController != nil else { return }

            phase = .dismissing

            dismiss(animated: true) { [weak self] in
                guard let self else { return }

                self.hostingController = nil
                self.phase = .idle

                self.coordinator?.didDismiss()
                self.reconcile()
            }
        }

        func tearDown() {
            isActive = false
            shouldPresent = false

            hostingController?.dismiss(animated: false)
            hostingController = nil
            makeContent = nil
            phase = .idle
        }
        
        func updateContent(_ content: @escaping () -> Content) {
            makeContent = content

            if let hostingController {
                hostingController.rootView = content()
            }
        }
    }
}

extension View {

    func uiFullScreenCover<Content: View>(
        isPresented: Binding<Bool>,
        publisher: AnyPublisher<Bool, Never>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        background {
            UIKitFullScreenCover(
                isPresented: isPresented,
                publisher: publisher,
                onDismiss: onDismiss,
                content: content
            )
            .frame(width: 0, height: 0)
        }
    }
}
