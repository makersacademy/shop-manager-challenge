require 'colorize'

class Format
  def string(text = "", color = :default, spacing = "")
    return if text == ""
    text = text.colorize(color)
    text = "\n#{text}" if spacing == :pad || spacing == :before
    text = "#{text}\n" if spacing == :pad || spacing == :after
    return text
  end
  
  def currency(price)
    return sprintf("£%.2f", price)
  end
  
  def header(text)
    return string("====== #{text} ======", :red, :before)
  end
end
