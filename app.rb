# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'pathname'
require 'lib/public_file'

set :root, File.dirname(__FILE__)

module Sinatra
  class Base
    def not_found(body = nil)
      code = 301
      body ||= "http://alphasights.com#{request.fullpath}"
      response.body = <<-HTML.gsub(/^ {8}/, '')
        <!DOCTYPE html>
        <html>
          <head>
            <meta http-equiv="Content-type" content="text/html; charset=utf-8">
            <title>Sinatra</title>
            <style type="text/css" media="screen">
              body {
                margin: 40px 0;
              }
              h1 {
                font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", sans-serif;
                font-weight: 300;
                font-size: 24px;
                color: #0080FF;
                text-align: center;
              }
            </style>
          </head>
          <body id="alphasights-sinatra">
            <h1>
              #{body}
            </h1>
          </body>
        </html>
      HTML
      halt code
    end
  end
end

get '/' do
  PublicFile.push(self, '/index.html')
end

get '/:path' do
  PublicFile.push(self, params[:path])
end
