module UsersHelper
  def gravatar_for user, option = {size: Settings.gravatar.size2}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = option[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def passtive_relationship other_user
    follower = current_user.active_relationships.find_by followed_id: other_user
  end

  def active_relationship
    current_user.active_relationships.build
  end
end
