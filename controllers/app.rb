require "sinatra/base"

class App < Sinatra::Base
  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../", __FILE__)
  set :server, :puma
  connections = []

  before do
    request.path_info.sub! %r{/$}, ""
  end

  get "/" do
    erb :home
  end

  post "/update" do
    json = request.body.read

    connections.each do |out|
      out << "id: #{Time.now}\n" +
             "event: ping\n" +
             "data: #{json}\n\n" unless out.closed?
    end
  end

  get "/healthcheck", provides: "text/event-stream" do
    stream :keep_open do |out|
      connections << out

      out.callback {
        connections.delete(out)
      }
    end
  end
end
