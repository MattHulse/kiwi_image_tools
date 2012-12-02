# Kiwi Image Tools

Custom Image Generator
Provide the images, text, and text properties and an image is generated with ImageMagick

## Installation

Add this line to your application's Gemfile:

    gem 'kiwi_image_tools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kiwi_image_tools

## Usage

```ruby
require 'kiwi_image_tools'
img = KiwiImageTools.new(:background_color => '#b8d2de', 
                         :logo_image => 'logo.png', 
                         :photo_image => 'photo.jpg', 
                         :special => {:text => 'Title', :color => 'blue', :size => 58 }, 
                         :details => {:text => 'Subtitle', :color => 'blue', :size => 32}, 
                         :expires => {:text => "Expires January 29th, 2013", :color => 'black', :size => 18}, 
                         :number => {:text => "Number 1123", :color => 'black', :size => 15}, 
                         :contact => {:text => "123 Mayberry Road, Anytown  Phone 867-5309\nor email joe@home.com", 
                                      :color => 'black', 
                                      :size => 15}, 
                         :conditions => {:text => "One vote per person.\nVoid where prohibited.\nValid at participating locations only", 
                                         :color => 'red', 
                                         :size => 15}
                         )
img.save_image('output.png')
```

