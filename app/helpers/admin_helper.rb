module AdminHelper
  def slice_name(name, size)
    name.length > size ? name.slice(0..(size-1)) + "..." : name
  end
end
