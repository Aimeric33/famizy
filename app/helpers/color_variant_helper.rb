module ColorVariantHelper
  def color_event(event)
    case event.color
    when 'red'
      'bg-red-400'
    when 'orange'
      'bg-orange-400'
    when 'green'
      'bg-green-400'
    when 'teal'
      'bg-teal-400'
    when 'blue'
      'bg-blue-400'
    when 'yellow'
      'bg-yellow-400'
    when 'purple'
      'bg-purple-400'
    when 'indigo'
      'bg-indigo-400'
    else
      'bg-blue-400'
    end
  end
end
