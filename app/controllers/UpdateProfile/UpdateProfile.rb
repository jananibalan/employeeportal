require 'mysql2'
require 'hanami/controller'
require 'json'

module UpdateProfile
    class UpdateProfile
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            updateDetails = JSON.parse(response)
            name = updateDetails['profileDetails']['name']
            email = updateDetails['profileDetails']['email']
            password = updateDetails['profileDetails']['password']
            empcode = updateDetails['profileDetails']['empcode']
            address = updateDetails['profileDetails']['address']
            joiningdate = updateDetails['profileDetails']['joiningdate']
            begin
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                exist = client.query("update emp set name = '#{name}',password = '#{password}',empcode = '#{empcode}',address = '#{address}',joiningdate = '#{joiningdate}' where email = '#{email}'")
                
                    

                    empDetails = client.query("select * from emp where email='#{email}'")

                    updated = "true"
                    name = empDetails.first["name"]
                    email = empDetails.first["email"]
                    password = empDetails.first["password"]
                    empcode = empDetails.first["empcode"]
                    address = empDetails.first["address"]
                    joiningdate = empDetails.first["joiningdate"]
                    
                    response = {'updated' => updated, 'name' => name, 'email' => email, 'password' => password, 'empcode' => empcode, 'address' => address, 'joiningdate' => joiningdate}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                
                
            
            rescue Exception => e
            
                puts e.message 

                    updated = "false"
                                      
                    response = {'updated' => updated}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                
            ensure
            
                client.close if client
                
            end
        end
    end
end 
