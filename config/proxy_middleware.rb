class ProxyMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    user = User.find_by(email: "owoadeanu@yahoo.com.com")
    puts user
    @app.call(env)
  end

end
