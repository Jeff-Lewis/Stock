module ErdatesHelper
  def watch? user, erdate
    if !user.nil?
      user.watchEr?(erdate)
    else
      false
    end
  end
end
