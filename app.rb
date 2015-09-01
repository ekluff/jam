require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

before do
  cache_control :public, :no_cache
	cache_control :views, :no_cache
end
