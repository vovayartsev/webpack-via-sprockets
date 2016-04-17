class WebpackProcessor
  Error = Class.new(RuntimeError)

  def call(input)
    if input[:data] =~ %r{^//= webpack\s+([^\s]+)}
      config = Rails.root.join 'config', $1
      webpack_binary = Rails.root.join 'node_modules/.bin/webpack'
      entry = input[:filename]

      compiled_bundle = Tempfile.open 'webpack-bundle.XXXXXXXX' do |bundle|
        output = `#{webpack_binary} --display-error-details --config=#{config} #{entry} #{bundle.path} 2>&1`
        raise Error, output if $? != 0
        bundle.read
      end

      # {data: input[:data].gsub(%r{^//= webpack\s+.*$}m, compiled_bundle)}
      {data: compiled_bundle}
    end
  end
end

Sprockets.register_preprocessor('application/javascript', WebpackProcessor.new)
