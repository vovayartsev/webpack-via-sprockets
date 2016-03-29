class WebpackProcessor
  Error = Class.new(RuntimeError)

  def call(input)
    puts "Compilation started"
    webpack_binary = Rails.root.join 'node_modules/.bin/webpack'
    config = Rails.root.join 'config/webpack.config.js'
    entry = input[:filename]

    compiled_bundle = Tempfile.open 'webpack-bundle.XXXXXXXX' do |bundle|
      output = `#{webpack_binary} --json --config=#{config} #{entry} #{bundle.path} 2>&1`
      raise Error, output if $? != 0
      bundle.read
    end

    puts "Compilation finished"
    {data: compiled_bundle}
  end
end

Sprockets.register_preprocessor('application/javascript', WebpackProcessor.new)

puts "Initializer worked"
