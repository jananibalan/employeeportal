require 'mysql2'
require 'hanami/controller'
require 'json'
require 'sendgrid-ruby'
include SendGrid 

module SendMail
    class SendMail
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            emailDetails = JSON.parse(response)
            puts emailDetails
            email = emailDetails['emailDetails']['email']

            begin
                client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "ruby")
                existingUser = client.query("select exists (select * from emp where email='#{email}') as numbers")
              

                if existingUser.first["exists"]==1
                    from = SendGrid::Email.new(email: '18euit152@skcet.ac.in')
                    to = SendGrid::Email.new(email: email)
                    subject = 'Password Reset Code'
                    content = SendGrid::Content.new(type: 'text/html', value: 'The Password Reset Code is 123')
                    mail = SendGrid::Mail.new(from, subject, to, content)

                    sg = SendGrid::API.new(api_key: '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')
                    response = sg.client.mail._('send').post(request_body: mail.to_json)

                    puts response.status_code
                    puts response.body
                    puts response.headers
                    

                        result = "Mail Sent"
                        response = {'result' => result}
                        
                        puts response
                        res = JSON.generate(response)

                        self.body = res
                else 
                    result = "Not Existing User"
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
