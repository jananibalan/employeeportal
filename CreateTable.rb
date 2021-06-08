
# require 'pg'

# class App
#     def call (env)
#         begin

#             con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'
#             con.exec "DROP TABLE IF EXISTS Cars"
#             con.exec "CREATE TABLE Cars(Id INTEGER PRIMARY KEY, Name VARCHAR(20), Price INT)"
#             con.exec "INSERT INTO Cars VALUES(1,'Audi',52642)"
#             con.exec "INSERT INTO Cars VALUES(2,'Mercedes',57127)"
#             con.exec "INSERT INTO Cars VALUES(3,'Skoda',9000)"
#             con.exec "INSERT INTO Cars VALUES(4,'Volvo',29000)"
#             con.exec "INSERT INTO Cars VALUES(5,'Bentley',350000)"
#             con.exec "INSERT INTO Cars VALUES(6,'Citroen',21000)"
#             con.exec "INSERT INTO Cars VALUES(7,'Hummer',41400)"
#             con.exec "INSERT INTO Cars VALUES(8,'Volkswagen',21600)"

#             rs = con.exec "SELECT * FROM Cars LIMIT 5"

#             rs.each do |row|
#                 puts "%s %s %s" % [ row['id'], row['name'], row['price'] ]
#             end
        
#         rescue PG::Error => e
        
#             puts e.message 
            
#         ensure
        
#             con.close if con
            
#         end
#     end
#  end
