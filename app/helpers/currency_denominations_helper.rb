module CurrencyDenominationsHelper
  def denomination_image_tag(denomination, side = :obverse, options = {})
    image = side == :obverse ? denomination.obverse_image : denomination.reverse_image
    
    if image.attached?
      image_tag image, options
    else
      content_tag :div, class: "placeholder-image #{options[:class]}", style: "height: #{options[:style] || '200px'}; background: #f8f9fa; display: flex; align-items: center; justify-content: center;" do
        content_tag :div, class: "text-muted" do
          content_tag(:i, "", class: "bi bi-image", style: "font-size: 3rem;") +
          content_tag(:br) +
          content_tag(:small, "No #{side} image")
        end
      end
    end
  end
  
  def has_images?(denomination)
    denomination.obverse_image.attached? || denomination.reverse_image.attached?
  end
end
