//
//  Data_Base.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 03/04/23.
//

import Foundation
import SQLite3

enum SQLiteError: Error {
    case Preparestmt(response: String)
    case Step(response: String)
}

public class DataBase {
    var db: OpaquePointer?

    public init() {
        openDatabase(databaseName: "")
//        createTables()
    }

    static let shared = DataBase()
    func openDatabase(databaseName _: String) {
        var filePath = ""

        do {
            var path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            path.append(path: "NCNapp.sqlite3")

            filePath = path.absoluteString

        } catch {
            print("Error creating database!")
        }
        var tempDbPointer: OpaquePointer?

        if sqlite3_open(filePath, &tempDbPointer) == SQLITE_OK {
            if let dbPointer = tempDbPointer {
                print("database is connected")
                db = dbPointer
            }
        } else {
            print("Error in Database Creation")
        }
    }

    func prepareCreateTableStatement(tableName: String, columnName: [String], columnValue: [String], foreignKeyConstraints: [String]) -> String {
        var columnString = ""
        for i in 0 ..< columnName.count {
            columnString = columnString + columnName[i] + " " + columnValue[i] + "," + " "
        }

        var columnStringModified = columnString.dropLast(2)

        for foreignKeys in foreignKeyConstraints {
            columnStringModified = columnStringModified + foreignKeys
        }

        var createTableStatement = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnStringModified));"

        return createTableStatement
    }

    func createTable(tableName: String, columnName: [String], columnValue: [String], foreignKeyConstrsint: [String]) {
        let createTableStatement = prepareCreateTableStatement(tableName: tableName, columnName: columnName, columnValue: columnValue, foreignKeyConstraints: foreignKeyConstrsint)

        print(createTableStatement)

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableStatement, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully \(tableName)")
            } else {
                print("Failed to create table: \(String(cString: sqlite3_errmsg(db)))")
            }
        } else {
            print("Failed to prepare create table statement \(tableName) : \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(statement)
    }

    func prepareInsertStatement(tableName: String, columns: [String], values: [String]) -> String {
        let columnsString = columns.joined(separator: ", ")
        let valuesString = values.map { _ in "?" }.joined(separator: ", ")
        let insertStatement = "INSERT INTO \(tableName) (\(columnsString)) VALUES (\(valuesString));"
        print(insertStatement)
        return insertStatement
    }

    func insertData(db: OpaquePointer, tableName: String, columns: [String], values: [String]) {
        let insertStatement = prepareInsertStatement(tableName: tableName, columns: columns, values: values)

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatement, -1, &statement, nil) == SQLITE_OK {
            for (index, value) in values.enumerated() {
                sqlite3_bind_text(statement, Int32(index + 1), value.cString(using: .utf8), -1, nil)
                print(value.cString(using: .utf8)!)
            }

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data inserted successfully")
            } else {
                print("Failed to insert data: \(String(cString: sqlite3_errmsg(db)))")
            }
        } else {
            print("Failed to prepare insert statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(statement)
    }

    func enableForeignKeys(_ db: OpaquePointer) {
        var statement: OpaquePointer?

        let query = "PRAGMA foreign_keys = ON;"
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing foreign key enforcement")
            return
        }

        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error enabling foreign key enforcement")
        }

        sqlite3_finalize(statement)
    }

    func updateData() {}

    func deleteData() {}
}

extension DataBase {
    func selectQuery(columnString: String, tableName: String, joinClause: String = "", whereClause: String = "") -> [[String: Any]]? {
        print("select query for \(tableName) called")

        var stmt: OpaquePointer?
        var result: [[String: Any]] = []
        var query = "SELECT \(columnString) FROM \(tableName) \(joinClause)"

        if whereClause != "" {
            query += " WHERE \(whereClause)"
        }

        print(query)

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            print("select statement preparation = sucess")
            while sqlite3_step(stmt) == SQLITE_ROW {
                var row: [String: Any] = [:]
                let columnCount = sqlite3_column_count(stmt)

                for i in 0 ..< columnCount {
                    let columnName = String(cString: sqlite3_column_name(stmt, i))
                    let columnType = sqlite3_column_type(stmt, i)

                    switch columnType {
                    case SQLITE_INTEGER:
                        let value = sqlite3_column_int(stmt, i)
                        row[columnName] = Int(value)
                    case SQLITE_FLOAT:
                        let value = sqlite3_column_double(stmt, i)
                        row[columnName] = Double(value)
                    case SQLITE_TEXT:
                        let value = String(cString: sqlite3_column_text(stmt, i))
                        row[columnName] = value
                    case SQLITE_BLOB:
                        let value = Data(bytes: sqlite3_column_blob(stmt, i), count: Int(sqlite3_column_bytes(stmt, i)))
                        row[columnName] = value
                    default:
                        row[columnName] = nil
                    }
                }

                result.append(row)
            }
        } else {
            print("selsct statement preparation failure")
        }

        sqlite3_finalize(stmt)

        if result.isEmpty {
            return nil
        } else {
            return result
        }
    }

    func prepareStatement(db: OpaquePointer?, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Preparestmt(response: errorMessage(db: db))
        }
        return statement
    }

    func stepStatement(db: OpaquePointer?, statement: OpaquePointer?) throws {
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SQLiteError.Step(response: errorMessage(db: db))
        }
    }

    func errorMessage(db _: OpaquePointer?) -> String {
        return "Error"
    }

    func executequery(db: OpaquePointer?, Statement: String) {
        do {
            let queryStatement = try prepareStatement(db: db, sql: Statement)
            defer {
                sqlite3_finalize(queryStatement)
            }
            try stepStatement(db: db, statement: queryStatement)
        } catch {
            print(error)
        }
    }

    public func prepareStatement(statement: String) -> OpaquePointer? {
        var preparePointer: OpaquePointer?
        if sqlite3_prepare(db, statement, -1, &preparePointer, nil) == SQLITE_OK {
            return preparePointer
        } else {
            print("Error In Prepare Statement:\(String(describing: sqlite3_errmsg(db))) ")
        }
        return nil
    }

    func insertStatement(tableName: String, columnName: [String], insertData: [Any], success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var columnNameString = ""
        if columnName.count > 1 {
            columnNameString = columnName.joined(separator: ", ")

        } else {
            columnNameString = columnName[0]
        }
        var insertString = ""
        for val in insertData {
            if val is String {
                insertString = insertString + "\'" + String(describing: val) + "\'"
                insertString = insertString + ", "
            } else {
                insertString = insertString + String(describing: val)
                insertString = insertString + ", "
            }
        }

        var finalInsertString = insertString.dropLast(2)
        var insertValueString = insertData.map { String(describing: $0) }.joined(separator: ", ")

        var querry = "INSERT INTO \(tableName) (\(columnNameString)) VALUES (\(finalInsertString))"
        print(querry)
        let prepareStatement: OpaquePointer? = DataBase.shared.prepareStatement(statement: querry)

        if sqlite3_step(prepareStatement) == SQLITE_DONE {
            success("\(tableName): Sucessfully Executed")
        } else {
            failure("Error : \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    func updateValue(tableName: String, columnValue: [Any], columnName: [String], whereClause: String? = nil, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let query = prepareUpdateStatement(tableName: tableName, columnName: columnName, columnValue: columnValue, whereClause: whereClause)
        print(query)
        let prepareStatement: OpaquePointer? = DataBase.shared.prepareStatement(statement: query)

        if sqlite3_step(prepareStatement) == SQLITE_DONE {
            success("\(tableName): Sucessfully Executed")
        } else {
            failure("Error : \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    func prepareUpdateStatement(tableName: String, columnName: [String], columnValue: [Any], whereClause: String? = nil) -> String {
        var columnsString = ""
        for i in 0 ... columnName.count - 1 {
            if columnValue[i] is String {
                columnsString = columnsString + "\(columnName[i])" + " = " + "\'" + "\(String(describing: columnValue[i]))" + "\'" + "," + " "
            } else {
                columnsString = columnsString + "\(columnName[i])" + " = " + "\(String(describing: columnValue[i]))" + "," + " "
            }
        }
        columnsString = String(columnsString.dropLast(2))

        var updateStatement = "UPDATE \(tableName) SET \(columnsString)"
        if let whereClause = whereClause {
            updateStatement += " WHERE \(whereClause);"
        } else {
            updateStatement += ";"
        }

        return updateStatement
    }

    func deleteValue(tableName: String, columnName: String = "", columnValue: String = "", whereClause: String = "", success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var deleteQuery = ""
        if whereClause == "" {
            deleteQuery = "DELETE FROM \(tableName) WHERE " + columnName + " = " + columnValue
        } else {
            deleteQuery = "DELETE FROM \(tableName) WHERE " + whereClause
        }

        print(deleteQuery)
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                success("Deletion Statement Executed")
            } else {
                sqlite3_finalize(deleteStatement)
                failure("Deletion is not done.")
            }
        }
    }
}
