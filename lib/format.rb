require 'colorize'

class Format
  def string(text = "", color = :default, spacing = "")
    return if text == ""
    spacer if spacing == :pad || spacing == :before
    return text.colorize(color)
    spacer if spacing == :pad || spacing == :after
  end
  
  def currency(price)
    return sprintf("£%.2f", price)
  end
  
  def header(text)
    return string("====== #{text} ======", :red, :before)
  end
  
  def spacer
    puts "\n"
  end
end
