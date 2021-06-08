require 'mysql2'
require 'hanami/controller'
require 'json'

module AddEmp
    class AddEmp
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            signupDetails = JSON.parse(response)
            name = signupDetails['signupDetails']['name']
            email = signupDetails['signupDetails']['email']
            password = signupDetails['signupDetails']['password']
            empcode = signupDetails['signupDetails']['empcode']
            address = signupDetails['signupDetails']['address']
            joiningdate = signupDetails['signupDetails']['joiningdate']
            begin
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                
                existingUser = client.query("select exists (select * from emp where email='#{email}') as numbers")
             
                # existingUser.each do |row|
                #     puts row
                #   end
                puts existingUser.first["numbers"]
                if existingUser.first["numbers"]==0 
                    exist = client.query("INSERT INTO emp values ('#{name}', '#{email}', '#{password}', '#{empcode}', '#{address}', '#{joiningdate}')")
                    puts "Emp Added"
                    result = "Account Created"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else 
                    result = "Existing User"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end  
            
            rescue Exception => e
            
                puts e.message 

                puts "Emp Not Added"
                
            ensure
            
                client.close if client
                
            end
        end
    end
end 
