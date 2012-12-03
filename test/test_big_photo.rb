#!/usr/bin/env ruby

require 'kiwi_image_tools'

g = KiwiImageTools::Generator.new(
    :background_color => '#b8d2de',
    :logo_image => 'test/images/skipster.png',
    :photo_image => 'test/images/Photo-landscape.jpg',
    :special => {:text => 'Summer',
                 :color => 'blue',
                 :size => 58 },
    :details => {:text => 'The competition',
                 :color => 'blue',
                 :size => 32},
    :expires => {:text => "Expires 10 June 2012",
                  :color => 'black',
                  :size => 18},
    :number => {:text => "Nbr 103452",
                :color => 'black',
                :size => 15},
    :contact => {:text => "23 K-road, Newton, Auckland.  Phone 09-8886767\nor at this address: 24 K-road, Newton, Auckland.  Phone 09-8886767",
                :color => 'black',
                :size => 15},
    :conditions => {:text => "One vote per person.\nVoid where prohibited.\nValid at participating locations only",
                :color => 'red',
                :size => 15}
)

g.display_image
#g.save_image('output.png')

