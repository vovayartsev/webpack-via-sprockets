# require 'benchmark'

# class WebpackProcessor
#   Error = Class.new(RuntimeError)
#
#   def call(input)
#     if input[:data] =~ %r{^//= webpack\s+([^\s]+)}
#       config = Rails.root.join 'config', $1
#       webpack_binary = Rails.root.join 'node_modules/.bin/webpack'
#       entry = input[:filename]
#
#       compiled_bundle = Tempfile.open 'webpack-bundle.XXXXXXXX' do |bundle|
#         output = `#{webpack_binary} --display-error-details --config=#{config} #{entry} #{bundle.path} 2>&1`
#         raise Error, output if $? != 0
#         bundle.read
#       end
#
#       # {data: input[:data].gsub(%r{^//= webpack\s+.*$}m, compiled_bundle)}
#       {data: compiled_bundle}
#     end
#   end
# end
#
#
# Sprockets.register_preprocessor('application/javascript', WebpackProcessor.new)


# To implement a custom directive called `require_glob`, subclass
# `Sprockets::DirectiveProcessor`, then add a method called
# `process_require_glob_directive`.

# class WebpackDriver
#   def initialize(config, entry)
#     @tempfile = Tempfile.new("bundle.XXXXXXXXX.js")
#
#     cmd = "node compiler.js #{config} #{entry} #{path.dirname} #{path.basename}"
#     @io = IO.popen(cmd, "r+")
#   end
#
#   def compile
#     @io.puts # start compilation
#
#     errors = []
#     while ((line = @io.gets.strip) != 'WEBPACK::EOF') do
#       errors << line
#     end
#
#     OpenStruct.new(errors: errors, data: path.read)
#   end
#
#   private
#
#   def path
#     Pathname.new(@tempfile.path)
#   end
# end

# class WebpackDirectiveProcessor < Sprockets::DirectiveProcessor
#   def process_require_webpack_tree_directive(path = ".")
#     path = expand_relative_dirname(:require_tree, path)
#     require_webpack_paths(*@environment.stat_sorted_tree_with_dependencies(path))
#
#     entry = Pathname.new(path).join('index.js')
#     raise "#{entry} doesn't exist" unless entry.exist?
#
#     puts "WEBPACK:", Benchmark.measure {
#            compiled = driver_for(entry).compile
#            raise compiled.errors.join("\n") if compiled.errors.any?
#            @webpack_data = compiled.data
#          }
#   end
#
#   def _call(_)
#     result = super
#     super.merge(data: result[:data] + "\n" + @webpack_data)
#   end
#
#   private
#
#   CONFIG = './config/webpack.config.js'
#
#   def driver_for(entry)
#     entry = String(entry)
#     $webpack_drivers ||= {}
#     $webpack_drivers[entry] ||= WebpackDriver.new(CONFIG, entry)
#   end
#
#   def require_webpack_paths(paths, deps)
#     resolve_paths(paths, deps, accept: @content_type, pipeline: :self) do |uri|
#     end
#   end
# end


# Replace the current processor on the environment with your own:
# Sprockets.unregister_processor('application/javascript', Sprockets::DirectiveProcessor)
# Sprockets.register_processor('application/javascript', WebpackDirectiveProcessor)
