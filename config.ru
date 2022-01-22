require File.expand_path '../server', __FILE__

run Rack::URLMap.new({
  '/' => App,
  '/login' => Authentication,
  '/api' => Api
})

