cmd = "node compiler.js ./config/webpack.config.js ./app/assets/webpack/index.js /tmp bundle.js"

f = IO.popen(cmd, "r+")

compile = lambda do
  puts "COMPILING..."
  f.puts # start compilation

  errors = []
  while ((line = f.gets.strip) != 'WEBPACK::EOF') do
    puts line
    errors << line
  end

  puts errors
  puts "DONE"
end


compile.call

sleep 5

compile.call