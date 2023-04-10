//
//  DeleteExpiredService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 10/04/23.
//

import Foundation
import VTComponents

public final class DeleteExpiredServiceRequest: Request {
    public var serviceId: Int
   
    public init(serviceId: Int) {
        self.serviceId = serviceId
        
    }
}

public final class DeleteExpiredServiceResponse: ZResponse {
    public var response: String
    public init(response: String) {
        self.response = response
    }
}

public final class DeleteExpiredServiceError: ZError {
    public var error: String
    init(error: String) {
        self.error = error
        super.init(status: .irresponsiveDatabase)
    }
}

public final class DeleteExpiredService: ZUsecase<DeleteExpiredServiceRequest, DeleteExpiredServiceResponse, DeleteExpiredServiceError> {
    var dataManager: DeleteExpiredServiceDataContract

    public init(dataManager: DeleteExpiredServiceDataContract) {
        self.dataManager = dataManager
    }

    override public func run(request: DeleteExpiredServiceRequest, success: @escaping (DeleteExpiredServiceResponse) -> Void, failure: @escaping (DeleteExpiredServiceError) -> Void) {
        dataManager.deleteExpiredService(serviceId: request.serviceId, success: { [weak self] message in
            self?.success(message: message, callback: success)
        }, failure: { [weak self] error in
            self?.failure(error: DeleteExpiredServiceError(error: error), callback: failure)
        })
    }

    private func success(message: String, callback: @escaping (DeleteExpiredServiceResponse) -> Void) {
        let response = DeleteExpiredServiceResponse(response: message)
        invokeSuccess(callback: callback, response: response)
    }

    private func failure(error: DeleteExpiredServiceError, callback: @escaping (DeleteExpiredServiceError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}