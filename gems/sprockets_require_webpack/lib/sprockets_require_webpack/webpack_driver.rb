require 'pathname'
require 'benchmark'

module SprocketsRequireWebpack
  class WebpackDriver
    def initialize(config, entry)
      @tempfile = Tempfile.new("bundle.XXXXXXXXX.js")

      cmd = "node compiler.js #{config} #{entry} #{path.dirname} #{path.basename}"
      @io = IO.popen(cmd, 'r+')
    end

    def compile
      @io.puts # start compilation

      errors = []

      bm = Benchmark.measure do
        while ((line = @io.gets.strip) != 'WEBPACK::EOF') do
          errors << line
        end
      end

      OpenStruct.new(errors: errors, data: path.read, benchmark: bm)
    end

    private

    def path
      @path ||= Pathname.new(@tempfile.path)
    end
  end
end