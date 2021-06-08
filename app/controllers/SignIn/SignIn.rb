require 'mysql2'
require 'hanami/controller'
require 'json'

module SignIn
    class SignIn
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            signinDetails = JSON.parse(response)
            email = signinDetails['signinDetails']['email']
            password = signinDetails['signinDetails']['password']
            
            begin
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                exist = client.query("select exists (select * from emp where email='#{email}' and password='#{password}') as numbers")

                if exist.first["numbers"]==1 
                    puts "Existing User"
                    empDetails = client.query("select * from emp where email='#{email}' and password='#{password}'")

                    validation = "true"
                    name = empDetails.first["name"]
                    email = empDetails.first["email"]
                    password = empDetails.first["password"]
                    empcode = empDetails.first["empcode"]
                    address = empDetails.first["address"]
                    joiningdate = empDetails.first["joiningdate"]
                    
                    response = {'validation' => validation, 'name' => name, 'email' => email, 'password' => password, 'empcode' => empcode, 'address' => address, 'joiningdate' => joiningdate}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else
                    puts "Wrong User Details"
                    validation = "false"
                                      
                    response = {'validation' => validation}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end
                
            
            rescue Exception => e
            
                puts e.message 
                
            ensure
            
                client.close if client
                
            end
        end
    end
end 
