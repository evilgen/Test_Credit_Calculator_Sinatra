#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'pry'

get '/' do
		slim :'dashboard'
end
