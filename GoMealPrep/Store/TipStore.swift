//
//  TipStore.swift
//  GoMealPrep
//
//  Created by user on 14/05/24.
//

import Foundation
import StoreKit

enum TipsError: LocalizedError {
    case failedVerification
    case system(Error)
    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return "User transaction verification failed"
        case .system(let err):
            return err.localizedDescription
        }
    }
}

enum TipsAction: Equatable {
    case successful
    case failed(TipsError)
    static func == (lhs: TipsAction, rhs: TipsAction) -> Bool {
        switch (lhs, rhs) {
        case (.successful, .successful):
            return true
        case (let .failed(lhsErr), let .failed(rhsErr)):
            return lhsErr.localizedDescription == rhsErr.localizedDescription
        default:
            return false
        }
    }
}

typealias PurchaseResult = Product.PurchaseResult
typealias TransactionListener = Task<Void, Error>
@MainActor
final class TipStore: ObservableObject {
    @Published private(set) var items = [Product]()
    @Published private(set) var action: TipsAction? {
        didSet {
            switch action {
            case .failed:
                hasError = true
            default:
                hasError = false
            }
        }
    }
    @Published var hasError = false
    var error: TipsError? {
        switch action {
        case .failed(let err):
            return err
        default:
            return nil
        }
    }
    private var transactionListener: TransactionListener?
    init() {
        transactionListener = configureTransactionListener()
        Task { [weak self] in
            await self?.retrieveProcucts()
        }
    }
    deinit {
        transactionListener?.cancel()
    }
    func purchase(_ item: Product) async {
        do {
            let result = try await item.purchase()
            try await handlePurchase(from: result)
        } catch {
            action = .failed(.system(error))
            print(error)
        }
    }
    func reset() {
        action = nil
    }
}
private extension TipStore {
    func configureTransactionListener() -> TransactionListener {
        Task.detached(priority: .background) { @MainActor [weak self] in
            do {
                for await result in Transaction.updates {
                    let transaction = try self?.checkVerified(result)
                    self?.action = .successful
                    await transaction?.finish()
                }
            } catch {
                self?.action = .failed(.system(error))
                print(error)
            }
        }
    }
    func retrieveProcucts() async {
        do {
            let products = try await Product.products(for: myTipProductIdentifiers).sorted(by: { $0.price < $1.price})
            items = products
        } catch {
            action = .failed(.system(error))
            print(error)
        }
    }
    func handlePurchase(from result: PurchaseResult) async throws {
        switch result {
        case .success(let verification):
            print("Purchase was a sucess, now it's time to verify their purchase")
            let transaction = try checkVerified(verification)
            // Verification was ok Update UI
            action = .successful
            await transaction.finish()
        case .pending:
            print("The user needs to complete some action on their account before they can complete purchase")
        case .userCancelled:
            print("The user hit cancel before their transaction started")
        default:
            break
        }
    }
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            print("The verification of the user failed")
            throw TipsError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}
