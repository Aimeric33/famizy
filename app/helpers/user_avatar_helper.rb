module UserAvatarHelper
  def user_avatar(user)
    if user.avatar.attached?
      cl_image_tag user.avatar.key, class: 'object-cover rounded-full'
    else
      "<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" width=\"100%\" height=\"100%\" viewBox=\"0 0 40 40\">
        <rect width=\"100%\" height=\"100%\" fill=\"#{user.color}\"/>
        <text fill=\"#fff\" font-family=\"Helvetica,Arial,sans-serif\" font-size=\"24\" font-weight=\"500\" x=\"50%\" y=\"55%\" dominant-baseline=\"middle\" text-anchor=\"middle\">
          #{user.name[0].upcase}
        </text>
      </svg>".html_safe
    end
  end
end
