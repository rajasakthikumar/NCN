//
//  ViewUserQuerydatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 18/04/23.
//

import Foundation
public class ViewUserQueryDatabaseService: EnterpriseDatabaseService {
    override public init() {}

    var resultQuery: [Query] = []
}

extension ViewUserQueryDatabaseService: ViewUserQueryDatabaseServiceContract {
    public func viewUserQuery(userId: Int, success: @escaping ([Query]) -> Void, failure: @escaping (String) -> Void) {
        var result = db.selectQuery(columnString: "*", tableName: "query", whereClause: "userId = \(userId)")

        guard let resultantArray = result else {
            failure("No data")
            return
        }

        for dict in resultantArray {
            if let queryId = dict["queryId"] as? Int {
                print(queryId)
                if let queryTypeId = dict["queryTypeId"] as? Int {
                    print(queryTypeId)
                    // changind to queryType
                    var queryType: QueryType = .complaint
                    if queryTypeId == 1 {
                        queryType = .complaint
                    } else {
                        queryType = .feedback
                    }
                    if let queryMessage = dict["queryMessage"] as? String {
                        print(queryMessage)
                        if let querydate = dict["createdOn"] as? String {
                            print(querydate)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            var queryDate = dateFormatter.date(from: querydate)
                            print(queryDate!)

                            if let queryStatus = dict["queryStatus"] as? String {
                                print(queryStatus)
                                var querystatus = (queryStatus == "true") ? true : false
                                var newQuery = Query(queryId: queryId, queryType: queryType, queryMessage: queryMessage, queryDate: queryDate!, querystatus: querystatus)
                                resultQuery.append(newQuery)
                            }
                        }
                    }
                }
            }
        }
        success(resultQuery)
    }
}
