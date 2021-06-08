require 'mysql2'
require 'hanami/controller'

module CreateTable
    class CreateTable
        include ::Hanami::Action
        def call (env)
            begin
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                exist = "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'emp')"
                if exist=='true' 
                    client.query("CREATE TABLE emp(Name VARCHAR(20), Email VARCHAR(30) PRIMARY KEY, Password VARCHAR(20), EmpCode VARCHAR(20), Address VARCHAR(50), JoiningDate  VARCHAR(20))")
                    puts "Table Created"
                else
                    puts "Table Exist"
                end
            
            rescue Exception => e
            
                puts e.message 
                
            ensure
            
                client.close if client
                
            end
        end
    end
end 
