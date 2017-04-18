#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'pry'
require './credit_class/credit.rb'

get '/' do
  slim :'dashboard'
end

post '/' do
  @credit = Credit.new params[:percent], params[:summa], params[:paymeth], params[:datetime]
  # binding.pry
  if @credit.paymeth == 0
    @credit.standart
  else
    @credit.annuitet
	end

  slim :'rezult', credit: @credit
end

get '/contacts' do
  slim :'contacts'
end



def credit_create_params
  params.require(:credit).permit( :percent, :summa, :paymeth, :datetime )
end