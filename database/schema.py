#create all the necessary tables here for stats gathering

#import necessary modules
import sqlite3

#establish a connection here with a local file
con = sqlite3.connect("Final_Project.db")

#open the cursor from the connection
cur = con.cursor()

def dropExistingSchema(tables):
    for table in tables :
        try:
             cur.execute("drop table "+table + ";");
             con.commit()
             print table + " was successful!"
        except Exception as e:
             print e
             pass

def createSchema(statements) :
    for statement in statements:
        print statement
        try:
             cur.execute(statement)
             con.commit()
             print tableName + " creation was successful!"
        except Exception as e:
             print e
             pass

def createDbSchema(dbFileName, drop):
        #First, let's drop the existing ones
        print "file : " + dbFileName
        schemaFile = open( dbFileName, "r" )
        createStatements = []
        tableNames = []
        for line in schemaFile:
            if str(line).startswith('CREATE') :
               createStatements.append(line)
               tableNames.append(line[13:str(line).index('(')])
        schemaFile.close()
        if drop :
            dropExistingSchema(tableNames)
        print tableNames;
        #Create tables now
        createSchema(createStatements)

def insertRows(insertStatementsList) :
     if insertStatementsList is not None and len(insertStatementsList) > 0 : 
                    for insertStatement in insertStatementsList :
                        try :
                             print insertStatement
                             cur.execute(insertStatement)
                             pass
                        except Exception as e:
                              #print e
                              pass           
                        
                    con.commit()

def selectRows(selectionQuery, param) :
     return cur.execute(selectionQuery)

