module ApplicationHelper
  # Make devise available for all views
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def date_formatter(datetime)
    if ((Time.now - datetime)/(1.minute)).round < 60
     "#{pluralize(((Time.now - datetime)/(1.minute)).round,'minute')} ago"
    elsif datetime.beginning_of_day == Time.now.beginning_of_day
     datetime.strftime("%l:%M %P")
    elsif datetime.beginning_of_day + 1.day == Time.now.beginning_of_day
     "Yesterday at #{datetime.strftime('%l:%M %P')}"
    elsif Time.now.beginning_of_day - datetime.beginning_of_day <= 7.days
     "#{datetime.strftime('%A')} at #{datetime.strftime('%l:%M %P')}"
    else
     "#{datetime.strftime('%B %e')} at #{datetime.strftime('%l:%M %P')}"
    end
  end

  # Generate the empty placeholder
  def empty_placeholder(title: "", subtitle: "", link_visible: false, link_text: "", href: "", remote: false)
    title = title.empty? ?  "Nothing to see here" : title
    content_tag(:div, class: "text-center") do
      concat(content_tag(:div, class: "mg-b-25 mg-xxl-b-50") do
        concat(inline_svg_tag("empty.svg", class: ""))
      end)
      concat(content_tag(:p, title, class: "h6 font-weight-bold mg-b-20 mg-xxl-b-35"))
      concat(content_tag(:p, subtitle, class: "mg-b-25 mg-xxl-b-50"))
      if link_visible
        concat(content_tag(:center) do
          if remote
            button_to(link_text, href, method: :get, remote: remote, class: "btn btn-primary btn-sm font-weight-bold justify-content-center", data: {disable_with: link_text})
          else
            link_to(link_text, href, remote: remote, class: "btn btn-primary btn-sm font-weight-bold justify-content-center")
          end
        end)
      end
    end
  end


  # Integer to Word converter : 100 -> "One hundred"
  def in_words(int)
    numbers_to_name = {
      1000000 => "million",
      1000 => "thousand",
      100 => "hundred",
      90 => "ninety",
      80 => "eighty",
      70 => "seventy",
      60 => "sixty",
      50 => "fifty",
      40 => "forty",
      30 => "thirty",
      20 => "twenty",
      19=>"nineteen",
      18=>"eighteen",
      17=>"seventeen",
      16=>"sixteen",
      15=>"fifteen",
      14=>"fourteen",
      13=>"thirteen",
      12=>"twelve",
      11 => "eleven",
      10 => "ten",
      9 => "nine",
      8 => "eight",
      7 => "seven",
      6 => "six",
      5 => "five",
      4 => "four",
      3 => "three",
      2 => "two",
      1 => "one"
    }
    str = ""
    numbers_to_name.each do |num, name|
      if int == 0
        return str
      elsif int.to_s.length == 1 && int/num > 0
                        return str + "#{name}"
                        elsif int < 100 && int/num > 0
                          return str + "#{name}" if int%num == 0
                          return str + "#{name} " + in_words(int%num)
                        elsif int/num > 0
                          return str + in_words(int/num) + " #{name} " + in_words(int%num)
                        end
                        end
                        end

                        end
