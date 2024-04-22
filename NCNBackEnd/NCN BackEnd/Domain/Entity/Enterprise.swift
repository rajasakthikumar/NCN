//
//  Enterprise.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/03/23.
//

import Foundation
public struct Enterprise: Codable {
    public var enterpriseId: Int
    public var enterpriseName: String
    public var employmentType: [EmploymentType]

    enum CodingKeys: String, CodingKey {
        case enterpriseId
        case enterpriseName
        case employmentType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        enterpriseId = try container.decode(Int.self, forKey: .enterpriseId)
        enterpriseName = try container.decode(String.self, forKey: .enterpriseName)

        if let employmentTypeString = try? container.decode(String.self, forKey: .employmentType) {
            employmentType = employmentTypeString.components(separatedBy: ",").compactMap {
                EmploymentType(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        } else if let employmentTypeArray = try? container.decode([String].self, forKey: .employmentType) {
            employmentType = employmentTypeArray.compactMap {
                EmploymentType(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        } else {
            employmentType = []
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(enterpriseId, forKey: .enterpriseId)
        try container.encode(enterpriseName, forKey: .enterpriseName)

        if !employmentType.isEmpty {
            let employmentTypeString = employmentType.map { $0.rawValue }.joined(separator: ",")
            try container.encode(employmentTypeString, forKey: .employmentType)
        }
    }
}
