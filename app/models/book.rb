class Book < ApplicationRecord
  has_one_attached :book_img

  def parse_base64(img)
    if img.present?
      # pngなのかjpegなのか拡張子
      content_type = create_extension(img)
      # BASE64を抜き出す
      contents = img.sub %r/data:((image|application)\/.{3,}),/, ''
      # decode
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
    end
    attach_image(filename)
  end

  private

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end
  
  def attach_image(filename)
    book_img.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end

end
