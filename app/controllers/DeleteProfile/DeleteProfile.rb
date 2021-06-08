require 'mysql2'
require 'hanami/controller'
require 'json'

module DeleteProfile
    class DeleteProfile
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            puts response
            deleteProfileDetails = JSON.parse(response)
            email = deleteProfileDetails['profileDetails']['email']
            puts email
            
            begin
                
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                exist = client.query("DELETE FROM emp where email = '#{email}'")
                
                    puts "Profile Is Deleted"

                    deleted = "true"
                                        
                    response = {'deleted' => deleted}
                    
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
