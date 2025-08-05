module AdminHelper
  def image_status_badge(denomination)
    obverse = denomination.obverse_image.attached?
    reverse = denomination.reverse_image.attached?
    
    if obverse && reverse
      content_tag :span, "Complete", class: "badge bg-success"
    elsif obverse || reverse
      content_tag :span, "Partial", class: "badge bg-warning"
    else
      content_tag :span, "Missing", class: "badge bg-danger"
    end
  end
  
  def image_preview(denomination, side, size: "100x100")
    if denomination.send("#{side}_image").attached?
      image_tag denomination.send("#{side}_image"), 
                 size: size, 
                 class: "img-thumbnail",
                 alt: "#{side.capitalize} of #{denomination.name}"
    else
      content_tag :div, "No #{side} image", 
                  class: "bg-light border d-flex align-items-center justify-content-center",
                  style: "width: #{size.split('x')[0]}px; height: #{size.split('x')[1]}px;"
    end
  end
  
  def denomination_image_stats
    total = CurrencyDenomination.count
    with_obverse = CurrencyDenomination.joins(:obverse_image_attachment).distinct.count
    with_reverse = CurrencyDenomination.joins(:reverse_image_attachment).distinct.count
    complete = CurrencyDenomination.joins(:obverse_image_attachment, :reverse_image_attachment).distinct.count
    
    {
      total: total,
      with_obverse: with_obverse,
      with_reverse: with_reverse,
      complete: complete,
      incomplete: total - complete
    }
  end
end 