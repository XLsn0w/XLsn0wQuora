

import UIKit
import FMDB

private let createTableSQL = "CREATE TABLE IF NOT EXISTS AccountModel(ID INTEGER PRIMARY KEY AUTOINCREMENT, ICONNAME TEXT, ICONTITLE TEXT, MONEY TEXT, DATE INTEGER, PHOTO TEXT, REMARK TEXT)"
private let insertSQL = "INSERT INTO AccountModel(ICONNAME, ICONTITLE, MONEY, DATE, PHOTO, REMARK) VALUES(?,?,?,?,?,?)"
private let updateSQL = "UPDATE AccountModel SET ICONNAME=?, ICONTITLE=?, MONEY=?, DATE=?, PHOTO=?, REMARK=? WHERE ID=?"
private let deleteSQL = "DELETE FROM AccountModel WHERE ID=?"
private let selectSQL = "SELECT * FROM AccountModel WHERE ID=?"
private let selectOrderByDateSQL = "SELECT * FROM AccountModel ORDER BY date DESC"

///用户个人信息Model
class AccountItem: NSObject {
    var ID = 0
    var iconName = ""
    var iconTitle = ""
    var money = ""
    var date = 0
    var remark = ""
    var photo = ""
    var dateString = ""
    var dayCost = ""

}

class UserDBManager: NSObject {
    
    class func createDB(DBPath:String) ->Void {
       let db = self.getDB(DBPath)
       print(db.databasePath())
    }
    //取得数据库文件
    class func getDB(_ path:String)->FMDatabase{
        
        //创建文件路径
        let btnPath = String.createFilePathInDocumentWith(path) ?? ""
        //创建filemanager
        let fileManager = FileManager.default
        //不存在要创建的文件则进入创建操作
        if fileManager.fileExists(atPath: btnPath) == false {
            //创建.db文件
            let db = FMDatabase(path: btnPath)
            //判断是否创建成功
            if (db != nil){
                if db?.open() == true{
                    let sql_stmt = createTableSQL
                    if db?.executeStatements(sql_stmt) == false  {
                        //执行语句错误
                        print("Error: \(String(describing: db?.lastErrorMessage()))")
                    }
                    db?.close()
                }
                else{
                    //打不开文件
                    print("Error: \(String(describing: db?.lastErrorMessage()))")
                }
            }
            else{
                //文件创建不成功
                print("Error: \(String(describing: db?.lastErrorMessage()))")
            }
        }
        return FMDatabase(path: btnPath)
    }
    //插入数据
    class func insertData(_ path:String, item:AccountItem){
        let db = self.getDB(path)
        db.open()
        db.executeUpdate(insertSQL, withArgumentsIn: [item.iconName, item.iconTitle, item.money, item.date, item.photo, item.remark])
        db.close()
    }
    //更新数据
    class func updateData(_ path:String, item:AccountItem){
        let db = self.getDB(path)
        db.open()
        db.executeUpdate(updateSQL, withArgumentsIn: [item.iconName, item.iconTitle, item.money, item.date, item.photo, item.remark, item.ID])
        db.close()
    }
    //删除数据
    class func deleteData(_ path:String, item:AccountItem){
        let db = self.getDB(path)
        db.open()
        db.executeUpdate(deleteSQL, withArgumentsIn: [item.ID])
        db.close()
    }
    class func deleteDataWith(_ path:String, ID:Int){
        let db = self.getDB(path)
        db.open()
        db.executeUpdate(deleteSQL, withArgumentsIn: [ID])
        db.close()
    }
    //查询数据
    class func selectDataWithID(_ path:String, id:Int)->AccountItem{
        let db = self.getDB(path)
        db.open()
        let rs = db.executeQuery(selectSQL, withArgumentsIn: [id])
        let item = AccountItem()
        while (rs?.next())!{
            item.ID = Int((rs?.int(forColumn: "ID"))!)
            item.iconName = (rs?.string(forColumn: "ICONNAME"))!
            item.iconTitle = (rs?.string(forColumn: "ICONTITLE"))!
            item.money = (rs?.string(forColumn: "MONEY"))!
            item.date = Int((rs?.int(forColumn: "DATE"))!)
            item.remark = (rs?.string(forColumn: "REMARK"))!
            item.photo = (rs?.string(forColumn: "PHOTO"))!
        }
        db.close()
        return item
    }
    class func selectDataOrderByDate(_ path:String)->[AccountItem] {
        let db = self.getDB(path)
        db.open()
        let rs = db.executeQuery(selectOrderByDateSQL, withArgumentsIn: nil)
        
        var items:[AccountItem] = []
        while rs != nil && (rs?.next())!{
            let item = AccountItem()
            item.ID = Int((rs?.int(forColumn: "ID"))!)
            item.iconName = (rs?.string(forColumn: "ICONNAME"))!
            item.iconTitle = (rs?.string(forColumn: "ICONTITLE"))!
            item.money = (rs?.string(forColumn: "MONEY"))!
            item.date = Int((rs?.int(forColumn: "DATE"))!)
            item.remark = (rs?.string(forColumn: "REMARK"))!
            item.photo = (rs?.string(forColumn: "PHOTO"))!
            items.append(item)
        }
        db.close()
        return items
    }
    
    class func itemCount(_ path:String)->Int{
        let db = self.getDB(path)
        db.open()
        let DBItemCount = db.intForQuery("SELECT COUNT(ID) FROM AccountModel")
        db.close()
        return Int(DBItemCount!)
    }
    
    
}

