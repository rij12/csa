module UsersHelper
  # We display either the image associated user or if there
  # isn't one we display a default image
  def image_for(user, size = :medium)
    if user.image
      # I wanted to create a clickable link so that the image
      # could be shown full size. To do this we get a URL to an
      # image of the right size, and also create an image_text
      # variable that is used as the HTML title and as
      # alternative text if the image cannot be displayed.
      # user.image.photo.url is the URL to the full size
      # image. Setting the border to "0" removes the border.
      user_image = user.image.photo.url(size)
      image_text = "Image of #{user.firstname} #{user.surname}"
      link_to image_tag(user_image, class: 'image-tag',
                        alt: image_text,
                        title: image_text, border: '0'),
              user.image.photo.url
    else
      # Creates a non-clickable default image
      image_tag("blank-cover_#{size}.png",
                class: 'image-tag', alt: 'No photo available',
                title: 'No photo available', border: '0')
    end
  end

end
