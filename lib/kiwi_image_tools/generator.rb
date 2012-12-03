module KiwiImageTools
  DEFAULT_WIDTH = 640
  DEFAULT_HEIGHT = 640
  LOGO_TOP_PAD = 12
  PHOTO_WIDTH = 300
  PHOTO_TOP_PAD = 8
  PHOTO_LEFT_PAD = 12
  SHADOW_COLOR = "gray75"
  SHADOW_SIZE = 5
  UPPER_TEXT_LEFT_PAD = 20
  LOWER_TEXT_LEFT_PAD = 10
  LINE_PADDING = 8

  class Generator

    def initialize(args)
      @color = args[:background_color]
      @logo_image = args[:logo_image]
      @photo_image = args[:photo_image]
      @special = args[:special]
      @details = args[:details]
      @expires = args[:expires]
      @number = args[:number]
      @contact = args[:contact]
      @conditions = args[:conditions]


      #####################
      # Create Base Image #
      #####################
      @image = Image.new(DEFAULT_WIDTH, DEFAULT_HEIGHT){
        #This doesn't work  because @color is being bound
        # to the constructor's instance_eval
        #self.background_color = @color
      }
      #Work around the issue
      @image.color_reset!(@color)

      ################
      # Process Logo #
      ################
      logo = Image.read(@logo_image).first
      logo_x = 0
      logo_y = LOGO_TOP_PAD

      #center logo if it is smaller than our image
      logo_x = ((@image.columns - logo.columns) / 2).to_i
      logo_x = 0 if logo_x < 0

      logo_bottom = logo_y + logo.rows

      #overlay logo
      @image = @image.composite(logo, logo_x, logo_y, OverCompositeOp)


      #################
      # Process Photo #
      #################
      photo = Image.read(@photo_image).first
      photo.resize_to_fit!(PHOTO_WIDTH)


      photo_x = PHOTO_LEFT_PAD
      photo_y = logo_bottom + PHOTO_TOP_PAD

      #construct shadow
      shadow = photo.shadow(2,2,2,1)
      shadow = photo.colorize(1,1,1, SHADOW_COLOR)
      shadow = shadow.blur_image(0, 2)
      shadow_x = photo_x + SHADOW_SIZE
      shadow_y = photo_y + SHADOW_SIZE

      #overlay shadow onto image
      @image = @image.composite(shadow, shadow_x, shadow_y, OverCompositeOp)

      #overlay photo onto image
      @image = @image.composite(photo, photo_x, photo_y, OverCompositeOp)

      #store photo position
      photo_right = shadow_x + shadow.columns
      photo_bottom = shadow_y + shadow.rows

      cursor_position = photo_y

      ########################
      # Process Special Text #
      ########################
      width = @image.columns - photo_right - 10
      height = @special[:size]
      left = photo_right + UPPER_TEXT_LEFT_PAD
      top = cursor_position + height
      cursor_position = top + height + LINE_PADDING

      draw_text(@special[:text], 
               @special[:color],
               @special[:size],
               width,
               height,
               left,
               top)

      cursor_position -= height / 2 #space between these two seems too large so adjusting


      ########################
      # Process Details Text #
      ########################
      width = @image.columns - photo_right - 10
      height = @details[:size]
      left = photo_right + UPPER_TEXT_LEFT_PAD
      top = cursor_position
      cursor_position = top + height + LINE_PADDING

      draw_text(@details[:text], 
               @details[:color],
               @details[:size],
               width,
               height,
               left,
               top)


      #######################
      # Process Expire Text #
      #######################
      width = @image.columns - photo_right - 10
      height = @expires[:size]
      left = photo_right + UPPER_TEXT_LEFT_PAD
      top = cursor_position
      cursor_position = top + height + LINE_PADDING

      draw_text(@expires[:text], 
               @expires[:color],
               @expires[:size],
               width,
               height,
               left,
               top)


      #######################
      # Process Number Text #
      #######################
      width = @image.columns - photo_right - 10
      height = @number[:size]
      left = photo_right + UPPER_TEXT_LEFT_PAD
      top = cursor_position
      cursor_position = top + height + LINE_PADDING

      draw_text(@number[:text], 
               @number[:color],
               @number[:size],
               width,
               height,
               left,
               top)

      #Move cursor below photo
      cursor_position = photo_bottom + 70


      ########################
      # Process Contact Text #
      ########################
      num_lines = @contact[:text].split("\n").length
      width = @image.columns
      height = @contact[:size] * num_lines #  times number of lines
      left = LOWER_TEXT_LEFT_PAD
      top = cursor_position
      cursor_position = top + height + LINE_PADDING

      draw_text(@contact[:text], 
               @contact[:color],
               @contact[:size],
               width,
               height+5,
               left,
               top)


      ##########################
      # Process Conditions Text #
      ##########################
      num_lines = @conditions[:text].split("\n").length
      width = @image.columns
      height = @conditions[:size] * num_lines #  times number of lines
      left = LOWER_TEXT_LEFT_PAD
      top = cursor_position
      cursor_position = top + height + LINE_PADDING

      draw_text(@conditions[:text], 
               @conditions[:color],
               @conditions[:size],
               width,
               height*num_lines,
               left,
               top)
      
    end

    def display_image
      @image.display
    end

    def save_image(filename='output.png')
      @image.write(filename)
    end

    private
    def draw_text(text, color, size, width, height, left, top) 
      Draw.new.annotate(@image, width, height, left, top, text) { 
        self.fill = color
        self.font_family = 'arial'
        self.font_weight = NormalWeight
        self.font_style = NormalStyle
        self.pointsize = size
      }
    end

  end
end
