module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  
  def checked(rating)
    is_checked = true
    if !params[:ratings].nil? 
      is_checked = params[:ratings].include? rating
    end
  return is_checked
  end
  
end
