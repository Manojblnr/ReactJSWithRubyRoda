
# This is for routes and it will execute the models funtions

begin
	require_relative '../../.env.rb'
rescue LoadError => e
	puts e.message
end

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

%w(
    defaults
    models
).each { |lib| require_relative lib }

class App < Roda
    plugin :render
    plugin :json

    route do |r|
        body = request.body.read
		request.body.rewind
		data = JSON.parse(body) rescue {} 
        data = indifferent_data(data)

        r.root do
            puts 'ReactJS home is loaded'
        end

        r.post "register" do
            ret = User.register data
            {
                values: ret,
                success: true
            }
        end

        r.post "login" do
            ret = User.login data
            {
                values: ret,
                success: true
            }
        end

        r.on "user" do

            token = params[:an_token] || data[:an_token] || nil
            raise "No token." if token.nil?

            @user = User.find(token: token)
            raise "only registered users are allowed" if !@user

            r.on "users" do
                r.get do
                    ret = @user.get_all_users
                    {
                        values: ret,
                        success: true
                    } 
                end
            end
    
            # r.on "posts" do
            #     r.get do
            #         ret = @user.get_all
            #         {
            #             values: ret,
            #             success: true
            #         }
            #     end
    
            #     r.post "create" do
            #         ret = @user.create_post params
            #         {
            #             values: ret,
            #             success: true
            #         }
            #     end
    
            #     r.on Integer do |post_id|
            #         post = Post[post_id.to_i]
            #         raise 'Invalid Post' if !post
                    
            #         r.get do
            #             ret = post.get_all
            #             {
            #                 values: ret,
            #                 success: true
            #             }
            #         end
                    
            #         r.post do
            #             ret = post.update_post data
    
            #             {
            #                 values: ret,
            #                 success: true
            #             }
            #         end
            #     end
            # end
        end
    
        # r.on "posts" do
        #     r.on "comments" do
        #         id = params[:post_id] || data[:post_id] || nil
        #         raise "No id." if id.nil?
        
        #         @post = Post.find(id: id)
        #         raise "Create Post First" if !@post
        
        #         r.get do
        #             ret = @post.get_all_comments
        #             {
        #                 values: ret,
        #                 success: true
        #             }
        #         end
        
        #         r.post "create" do
        #             ret = @post.create_comment data
        
        #             {
        #                 values: ret,
        #                 success: true
        #             }
        #         end
        #     end
        # end
    end
end