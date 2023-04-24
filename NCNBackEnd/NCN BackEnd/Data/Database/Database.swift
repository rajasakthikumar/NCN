////
////  Database.swift
////  NCN BackEnd
////
////  Created by raja-16327 on 14/03/23.
////
//
//import Foundation
//import SQLite3
//
//import VTComponents
////enum SQLiteError: Error {
////    case Preparestmt(response: String)
////    case Step(response: String)
////}
//
//public class Database {
//    var db: OpaquePointer?
//    static let shared = Database()
//
//    public init() {
//        createDatabase()
//        enableForeignKeys(db!)
//        // executequery(db: db, Statement: "PRAGMA FOREIGN_KEYS = ON")
//      // createUserTable()
////        createEmployeeTypeTable()
////        createEmployeeTable()
////        createAdminTable()
////        createEnterpriseTable()
////        createAvailableServiceTable()
////        createEmployeeTypeTable()
////        createQueryTypeTable()
////        createQueryTable()
////        createAvailavleSubscriptionTable()
////        createServicesLinkTable()
//
//        insertDefaultAdminValues()
//    }
//
//    func createDatabase() {
//        var filePath = ""
//
//        do {
//            var path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            path.append(path: "NCNapp.sqlite3")
//
//            filePath = path.absoluteString
//
//        } catch {
//            print("Error creating database!")
//        }
//        var tempDbPointer: OpaquePointer?
//
//        if sqlite3_open(filePath, &tempDbPointer) == SQLITE_OK {
//            if let dbPointer = tempDbPointer {
//                db = dbPointer
//            }
//        } else {
//            print("Error in Database Creation")
//        }
//    }
//
//    func enableForeignKeys(_ db: OpaquePointer) {
//        var statement: OpaquePointer?
//
//        let query = "PRAGMA foreign_keys = ON;"
//        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
//            print("Error preparing foreign key enforcement")
//            return
//        }
//
//        if sqlite3_step(statement) != SQLITE_DONE {
//            print("Error enabling foreign key enforcement")
//        } else {
//            print("Foreign Keys Enabled")
//        }
//
//        sqlite3_finalize(statement)
//    }
//
//    
//
//
//    func createTable(createTableString: String, tableName: String) {
//        // 1
//        var createTableStatement: OpaquePointer?
//        // 2
//        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
//            SQLITE_OK
//        {
//            // 3
//            if sqlite3_step(createTableStatement) == SQLITE_DONE {
//                print("\n \(tableName) table created.")
//            } else {
//                print("\n \(tableName) table is not created.")
//            }
//        } else {
//            print("\nCREATE TABLE statement is not prepared.")
//        }
//        // 4
//        sqlite3_finalize(createTableStatement)
//    }
//
//    func createAvailableServiceTable() {
//        let tableString = """
//        CREATE TABLE IF NOT EXISTS "availableService" (
//            "serviceId"    INTEGER NOT NULL UNIQUE,
//            "serviceTitle"    TEXT,
//            "serviceDescription"    TEXT,
//            "enterpriseId"    INTEGER NOT NULL,
//            FOREIGN KEY("enterpriseId") REFERENCES "enterprise"("enterpriseId"),
//            PRIMARY KEY("serviceId" AUTOINCREMENT)
//         );
//        """
//        let tableNamme = "availableService"
//        createTable(createTableString: tableString, tableName: tableNamme)
//    }
//
//    func createQueryTable() {
//        let tableString = """
//        CREATE TABLE IF NOT EXISTS "query" (
//            "queryId"    INTEGER NOT NULL UNIQUE,
//            "queryTypeId"    INTEGER NOT NULL,
//            "queryMessage"    TEXT NOT NULL,
//            "queryStatus"    TEXT,
//            "createdOn"    DATE NOT NULL,
//            "userId"    INTEGER NOT NULL,
//            "employeeId"    INTEGER,
//            "enterpriseId"    INTEGER,
//            PRIMARY KEY("queryId" AUTOINCREMENT),
//            FOREIGN KEY("employeeId") REFERENCES "employee"("employeeId"),
//            FOREIGN KEY("enterpriseId") REFERENCES "enterprise"("enterpriseId"),
//            FOREIGN KEY("userId") REFERENCES "users"("userId"),
//            FOREIGN KEY("queryTypeId") REFERENCES "queryType"("queryTypeId")
//        );
//        """
//        let tableName = "query"
//        createTable(createTableString: tableString, tableName: tableName)
//    }
//
//    func createServicesLinkTable() {
//        let tableString = """
//        CREATE TABLE "serviceLinkTable" (
//            "id"    INTEGER NOT NULL UNIQUE,
//            "userId"    INTEGER NOT NULL,
//            "employeeId"    INTEGER NOT NULL,
//            "serviceId"    INTEGER NOT NULL,
//            "subscriptionId"    INTEGER NOT NULL,
//            "enterpriseId"    INTEGER,
//            "createdOn"    DATE,
//            "validTill"    DATE,
//            "subscriptionUsage"    NUMERIC,
//            "subscriptionUsageLimit"    NUMERIC,
//            FOREIGN KEY("enterpriseId") REFERENCES "enterprise"("enterpriseId"),
//            FOREIGN KEY("serviceId") REFERENCES "availableService"("serviceId"),
//            FOREIGN KEY("employeeId") REFERENCES "employee"("employeeId"),
//            FOREIGN KEY("subscriptionId") REFERENCES "availableSubscription"("subscriptionId"),
//            FOREIGN KEY("userId") REFERENCES "users"("userId"),
//            PRIMARY KEY("id" AUTOINCREMENT)
//        );
//        );
//        """
//        let tableName = "serviceLinkTable"
//        createTable(createTableString: tableString, tableName: tableName)
//    }
//
//    func createQueryTypeTable() {
//        let tableString = """
//        CREATE TABLE IF NOT EXISTS "queryType" (
//            "queryTypeId"    INTEGER NOT NULL UNIQUE,
//            "qeryType"    TEXT NOT NULL,
//            PRIMARY KEY("queryTypeId" AUTOINCREMENT)
//        );
//        """
//        let tableName = "queryType"
//        createTable(createTableString: tableString, tableName: tableName)
//    }
//
//    func insertDefaultAdminValues() {
//        // insert into employee type table
//        insertIntoEmployeeType()
//        insertUserDetails()
//        insertEmployeeDetails()
//    }
//
//    func insertIntoEmployeeType() {
//        print("inseertionemployee type called")
//        let insertStatementString = "INSERT INTO employeeType (employeeTypeId, employeeType) VALUES(?,?)"
//        var insertStatement: OpaquePointer?
//        let employeeTypes = ["\'admin\'", "\'permanent\'", "\'contract\'"]
//        let sql = "INSERT INTO employeeType (employeeTypeId, employeeType) VALUES (?, ?)"
////        if sqlite3_prepare_v2(db, sql, -1, &insertStatement, nil) != SQLITE_OK {
////            print("Error preparing INSERT statement")
////            return
////        }
//
//        // iterate over the array and bind the values to the statement
//        for (index, name) in employeeTypes.enumerated() {
//            let sql = "INSERT INTO employeeType (employeeTypeId, employeeType) VALUES (\(index + 1), \(name))"
//            if sqlite3_prepare_v2(db, sql, -1, &insertStatement, nil) != SQLITE_OK {
//                print("Error preparing in eType INSERT statement")
//                return
//            }
//
////            // bind the index (starting at 1, not 0) to the first parameter
////            if sqlite3_bind_int(insertStatement, 1, Int32(index+1)) != SQLITE_OK {
////                print("Error binding index to statement")
////                return
////            }
//
//            // bind the name to the second parameter
////            if sqlite3_bind_text(insertStatement, 2, name, -1, nil) != SQLITE_OK {
////                print("Error binding name to statement")
////                return
////            }
//
//            // execute the statement
//            if sqlite3_step(insertStatement) != SQLITE_DONE {
//                print("Error executing INSERT statement: Called in Database not in DataBase")
//                return
//            }
//
//            // reset the statement for the next iteration
//            if sqlite3_reset(insertStatement) != SQLITE_OK {
//                print("Error resetting INSERT statement")
//                return
//            }
//        }
//
//        // finalize the statement
//        if sqlite3_finalize(insertStatement) != SQLITE_OK {
//            print("Error finalizing INSERT statement")
//            return
//        }
//    }
//
//    func insertUserDetails() {
//        print("adding user details")
//        let insertStatementString = "INSERT INTO users (userId, userName, eMail, password, mobileNumber, enterpriseId) VALUES(1, \"raja\", \"rajasakthikumar.r@zohocorp.com\", \"raja\",1234567890,1);"
//        var insertStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        }
//    }
//
//    func insertEmployeeDetails() {
//        print("adding employee details")
//        let insertStatementString = "INSERT INTO employee (employeeId, employeeTypeId, userId) VALUES(1, 1, 1);"
//        var insertStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        }
//    }
//}
//
//extension Database {
//    func selectQuery(columnString: String, tableName: String, joinClause: String = "", whereClause: String = "") -> [[String: Any]]? {
//        print("select query for \(tableName) called")
//
//        var stmt: OpaquePointer?
//        var result: [[String: Any]] = []
//        var query = "SELECT \(columnString) FROM \(tableName) \(joinClause)"
//
//        if whereClause != "" {
//            query += " WHERE \(whereClause)"
//        }
//
//        print(query)
//
//        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
//            // print("select statement preparation = sucess")
//            while sqlite3_step(stmt) == SQLITE_ROW {
//                var row: [String: Any] = [:]
//                let columnCount = sqlite3_column_count(stmt)
//
//                for i in 0 ..< columnCount {
//                    let columnName = String(cString: sqlite3_column_name(stmt, i))
//                    let columnType = sqlite3_column_type(stmt, i)
//
//                    switch columnType {
//                    case SQLITE_INTEGER:
//                        let value = sqlite3_column_int(stmt, i)
//                        row[columnName] = Int(value)
//                    case SQLITE_FLOAT:
//                        let value = sqlite3_column_double(stmt, i)
//                        row[columnName] = Double(value)
//                    case SQLITE_TEXT:
//                        let value = String(cString: sqlite3_column_text(stmt, i))
//                        row[columnName] = value
//                    case SQLITE_BLOB:
//                        let value = Data(bytes: sqlite3_column_blob(stmt, i), count: Int(sqlite3_column_bytes(stmt, i)))
//                        row[columnName] = value
//                    default:
//                        row[columnName] = nil
//                    }
//                }
//
//                result.append(row)
//            }
//        } else {
//            print("selsct statement preparation failure")
//        }
//
//        sqlite3_finalize(stmt)
//
//        if result.isEmpty {
//            return nil
//        } else {
//            return result
//        }
//    }
//
//    func prepareStatement(db: OpaquePointer?, sql: String) throws -> OpaquePointer? {
//        var statement: OpaquePointer?
//        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
//            throw SQLiteError.Preparestmt(response: errorMessage(db: db))
//        }
//        return statement
//    }
//
//    func stepStatement(db: OpaquePointer?, statement: OpaquePointer?) throws {
//        guard sqlite3_step(statement) == SQLITE_DONE else {
//            throw SQLiteError.Step(response: errorMessage(db: db))
//        }
//    }
//
//    func errorMessage(db _: OpaquePointer?) -> String {
//        return "Error"
//    }
//
//    func executequery(db: OpaquePointer?, Statement: String) {
//        do {
//            let queryStatement = try prepareStatement(db: db, sql: Statement)
//            defer {
//                sqlite3_finalize(queryStatement)
//            }
//            try stepStatement(db: db, statement: queryStatement)
//        } catch {
//            print(error)
//        }
//    }
//
//    public func prepareStatement(statement: String) -> OpaquePointer? {
//        var preparePointer: OpaquePointer?
//        if sqlite3_prepare(db, statement, -1, &preparePointer, nil) == SQLITE_OK {
//            return preparePointer
//        } else {
//            print("Error In Prepare Statement:\(String(describing: sqlite3_errmsg(db))) ")
//        }
//        return nil
//    }
//
//    func insertStatement(tableName: String, columnName: [String], insertData: [Any], success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
//        var columnNameString = ""
//        if columnName.count > 1 {
//            columnNameString = columnName.joined(separator: ", ")
//
//        } else {
//            columnNameString = columnName[0]
//        }
//        var insertString = ""
//        for val in insertData {
//            if val is String {
//                insertString = insertString + "\'" + String(describing: val) + "\'"
//                insertString = insertString + ", "
//            } else {
//                insertString = insertString + String(describing: val)
//                insertString = insertString + ", "
//            }
//        }
//
//        var finalInsertString = insertString.dropLast(2)
//        var insertValueString = insertData.map { String(describing: $0) }.joined(separator: ", ")
//
//        var querry = "INSERT INTO \(tableName) (\(columnNameString)) VALUES (\(finalInsertString))"
//        print(querry)
//        let prepareStatement: OpaquePointer? = Database.shared.prepareStatement(statement: querry)
//
//        if sqlite3_step(prepareStatement) == SQLITE_DONE {
//            success("\(tableName): Sucessfully Executed")
//        } else {
//            failure("Error : \(String(cString: sqlite3_errmsg(db)))")
//        }
//    }
//
//    func updateValue(tableName: String, columnValue: [Any], columnName: [String], whereClause: String? = nil, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
//        let query = prepareUpdateStatement(tableName: tableName, columnName: columnName, columnValue: columnValue, whereClause: whereClause)
//        print(query)
//        let prepareStatement: OpaquePointer? = Database.shared.prepareStatement(statement: query)
//
//        if sqlite3_step(prepareStatement) == SQLITE_DONE {
//            success("\(tableName): Sucessfully Executed")
//        } else {
//            failure("Error : \(String(cString: sqlite3_errmsg(db)))")
//        }
//    }
//
//    func prepareUpdateStatement(tableName: String, columnName: [String], columnValue: [Any], whereClause: String? = nil) -> String {
//        var columnsString = ""
//        for i in 0 ... columnName.count - 1 {
//            if columnValue[i] is String {
//                columnsString = columnsString + "\(columnName[i])" + " = " + "\'" + "\(String(describing: columnValue[i]))" + "\'" + "," + " "
//            } else {
//                columnsString = columnsString + "\(columnName[i])" + " = " + "\(String(describing: columnValue[i]))" + "," + " "
//            }
//        }
//        columnsString = String(columnsString.dropLast(2))
//
//        var updateStatement = "UPDATE \(tableName) SET \(columnsString)"
//        if let whereClause = whereClause {
//            updateStatement += " WHERE \(whereClause);"
//        } else {
//            updateStatement += ";"
//        }
//
//        return updateStatement
//    }
//
//    func deleteValue(tableName: String, columnName: String = "", columnValue: String = "", whereClause: String = "", success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
//        var deleteQuery = ""
//        if whereClause == "" {
//            deleteQuery = "DELETE FROM \(tableName) WHERE " + columnName + " = " + columnValue
//        } else {
//            deleteQuery = "DELETE FROM \(tableName) WHERE " + whereClause
//        }
//
//        print(deleteQuery)
//        var deleteStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                sqlite3_finalize(deleteStatement)
//                success("Deletion Statement Executed")
//            } else {
//                sqlite3_finalize(deleteStatement)
//                failure("Deletion is not done.")
//            }
//        }
//    }
//}
