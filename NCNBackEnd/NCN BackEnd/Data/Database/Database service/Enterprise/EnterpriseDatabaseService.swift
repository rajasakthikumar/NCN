//
//  EnterpriseDtabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 24/04/23.
//

import Foundation
public class EnterpriseDatabaseService {
    public var db = DataBase.shared
    public init() {
        createTables()
    }
}

extension EnterpriseDatabaseService {
    func createTables() {
        createEnterpriseTable()
        createUserTable()
        createEmployeeTypeTable()
        createEmployeeTable()
        createAdminTable()
        createAvaialablesubscription()
        createAvaialableService()
        createQueryTypeTable()
        createQueryTable()
        createServiceLinkTable()
    }

    // 1
    func createUserTable() {
        let tableName = "users"

        let columnName = ["userId", "userName", "eMail", "password", "mobileNumber"]

        let columnType = ["INTEGER NOT NULL UNIQUE", "TEXT NOT NULL", "TEXT NOT NULL", "TEXT NOT NULL", "INTEGER NOT NULL"]

        let foreignKeyConstraints: [String] = [
            " , PRIMARY KEY(\"userId\"AUTOINCREMENT)", "FOREIGN KEY(\"enterpriseId\") REFERENCES \"enterprise\"(\"enterpriseId\"),",
        ]

        db.createTable(tableName: tableName, columnName: columnName, columnValue: columnType, foreignKeyConstrsint: foreignKeyConstraints)
    }

    func createEnterpriseTable() {
        let tableName = "enterprise"
        let columnName = ["enterpriseId", "enterpriseName"]
        let columnType = ["INTEGER NOT NULL UNIQUE", "TEXT NOT NULL"]
        let foreignKeyConstraints = [", PRIMARY KEY(\"enterpriseId\" AUTOINCREMENT)"]

        db.createTable(tableName: tableName, columnName: columnName, columnValue: columnType, foreignKeyConstrsint: foreignKeyConstraints)
    }

    func createQueryTypeTable() {
        // 2
        // queryTypeTable
        let tableName = "queryType"

        let columnName = ["queryTypeId", "queryType"]

        let columnType = ["INTEGER NOT NULL UNIQUE", "TEXT NOT NULL"]

        let foreignKeyConstraints = [", PRIMARY KEY (\"queryTypeId\" AUTOINCREMENT)"]

        db.createTable(tableName: tableName, columnName: columnName, columnValue: columnType, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////3
    ////queryTable
    /// """
//
    func createQueryTable() {
        let tableName = "query"

        let columnNames = ["queryId", "queryTypeId", "queryMessage", "queryStatus", "createdOn", "userId", "employeeId", "enterpriseId", "PRIMARY KEY"]

        let columnTypes = ["INTEGER NOT NULL UNIQUE", "INTEGER NOT NULL", "TEXT NOT NULL", "TEXT", "DATE NOT NULL", "INTEGER NOT NULL", "INTEGER", "INTEGER NOT NULL", "(\"queryId\" AUTOINCREMENT)"]

        let foreignKeyConstraints = [
            ", FOREIGN KEY(\"employeeId\") REFERENCES \"employee\"(\"employeeId\")",
            " FOREIGN KEY(\"enterpriseId\") REFERENCES \"enterprise\"(\"enterpriseId\") ON DELETE CASCADE",
            ", FOREIGN KEY(\"userId\") REFERENCES \"users\"(\"userId\")  ON DELETE CASCADE",
            ", FOREIGN KEY(\"queryTypeId\") REFERENCES \"queryType\"(\"queryTypeId\") ON DELETE CASCADE",
        ]

        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////4
    ////availableService
    ///

    func createAvaialableService() {
        let tableName = "availableService"

        let columnName = ["serviceId", "serviceTitle", "serviceDescription", "enterpriseId"]

        let columnType = ["INTEGER NOT NULL UNIQUE", "TEXT", "TEXT", "INTEGER NOT NULL"]

        let foreignKeyConstraints = [
            ", PRIMARY KEY(\"serviceId\" AUTOINCREMENT)",
            ", FOREIGN KEY(\"enterpriseId\") REFERENCES \"enterprise\"(\"enterpriseId\") ON DELETE CASCADE",
        ]
        db.createTable(tableName: tableName, columnName: columnName, columnValue: columnType, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////5
    ////availableSubscription
    func createAvaialablesubscription() {
        let tableName = "availableSubscription"

        let columnNames = ["subscriptionId", "subscriptionPackageType", "subscriptionCountLimit", "subscriptionDayLimit", "serviceId", "enterpriseId"]

        let columnTypes = ["INTEGER NOT NULL UNIQUE", "TEXT NOT NULL", "NUMERIC NOT NULL", "NUMERIC NOT NULL", "INTEGER NOT NULL", "INTEGER NOT NULL"]

        let foreignKeyConstraints = [
            ", PRIMARY KEY(\"subscriptionId\" AUTOINCREMENT)",
            ", FOREIGN KEY(\"serviceId\") REFERENCES \"availableService\"(\"serviceId\") ON DELETE CASCADE",
            ", FOREIGN KEY(\"enterpriseId\") REFERENCES \"enterprise\"(\"enterpriseId\") ON DELETE CASCADE",
        ]
        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////6
    ////adminTable
    func createAdminTable() {
        let tableName = "admin"

        let columnNames = ["userId", "employeeId"]

        let columnTypes = ["INTEGER", "INTEGER"]

        let foreignKeyConstraints = [
            ", FOREIGN KEY(\"userId\") REFERENCES \"Users\"(\"userId\") ON DELETE CASCADE",
            ", FOREIGN KEY(\"employeeId\") REFERENCES \"employee\"(\"employeeId\") ON DELETE CASCADE",
        ]
        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////7
    ////employeeTable
    func createEmployeeTable() {
        let tableName = "employee"

        let columnNames = ["employeeId", "employeeTypeId", "userId"]

        let columnTypes = ["INTEGER NOT NULL UNIQUE", "INTEGER", "INTEGER"]

        let foreignKeyConstraints = [
            ", PRIMARY KEY(\"employeeId\" AUTOINCREMENT)",
            ", FOREIGN KEY(\"employeeTypeId\") REFERENCES \"employeeType\"(\"employeeTypeId\") ON DELETE CASCADE",
            ", FOREIGN KEY(\"userId\") REFERENCES \"Users\"(\"userId\") ON DELETE CASCADE",
        ]
        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////8
    ////employeeTypeTable
    func createEmployeeTypeTable() {
        let tableName = "employeeType"

        let columnNames = ["employeeTypeId", "employeeType", "PRIMARY KEY"]

        let columnTypes = ["INTEGER NOT NULL UNIQUE", "TEXT", "(\"employeeTypeId\" AUTOINCREMENT)"]

        let foreignKeyConstraints: [String] = []
        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }

    ////9
    ////serviceLinkTable
    /// CREATE TABLE "serviceLinkTable" (
//    "id"    INTEGER NOT NULL UNIQUE,
//    "userId"    INTEGER NOT NULL,
//    "employeeId"    INTEGER NOT NULL,
//    "serviceId"    INTEGER NOT NULL,
//    "subscriptionId"    INTEGER NOT NULL,
//    "enterpriseId"    INTEGER,
//    "createdOn"    DATE,
//    "validTill"    DATE,
//    "subscriptionUsage"    NUMERIC,
//    "subscriptionUsageLimit"    NUMERIC,
//    FOREIGN KEY("serviceId") REFERENCES "availableService"("serviceId"),
//    FOREIGN KEY("enterpriseId") REFERENCES "enterprise"("enterpriseId"),
//    FOREIGN KEY("userId") REFERENCES "users"("userId"),
//    FOREIGN KEY("employeeId") REFERENCES "employee"("employeeId"),
//    FOREIGN KEY("subscriptionId") REFERENCES "availableSubscription"("subscriptionId"),
//    PRIMARY KEY("id" AUTOINCREMENT)
    // );
    func createServiceLinkTable() {
        let tableName = "serviceLinkTable"

        let columnNames = ["id", "userId", "employeeId", "serviceId", "subscriptionId", "enterpriseId", "createdOn", "validTill", "subscriptionUsage", "subscriptionUsageLimit"]

        let columnTypes = ["INTEGER NOT NULL UNIQUE", "INTEGER NOT NULL", "INTEGER NOT NULL", "INTEGER NOT NULL", "INTEGER NOT NULL", "INTEGER NOT NULL", "DATE", "DATE", "NUMERIC", "NUMERIC"]

        let foreignKeyConstraints = [
            ", FOREIGN KEY(\"employeeId\") REFERENCES \"employee\"(\"employeeId\") ON DELETE CASCADE,",
            "FOREIGN KEY(\"enterpriseId\") REFERENCES \"enterprise\"(\"enterpriseId\") ON DELETE CASCADE,",
            "FOREIGN KEY(\"serviceId\") REFERENCES \"availableService\"(\"serviceId\") ON DELETE CASCADE,",
            "FOREIGN KEY(\"subscriptionId\") REFERENCES \"availableSubscription\"(\"subscriptionId\") ON DELETE CASCADE,",
            "FOREIGN KEY(\"userId\") REFERENCES \"users\"(\"userId\") ON DELETE CASCADE,",
            "PRIMARY KEY(\"id\" AUTOINCREMENT)",
        ]
        db.createTable(tableName: tableName, columnName: columnNames, columnValue: columnTypes, foreignKeyConstrsint: foreignKeyConstraints)
    }
}
