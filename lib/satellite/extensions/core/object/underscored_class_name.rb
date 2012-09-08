class Object

  def underscored_class_name
    self.class.name.split('::').last.underscore.to_sym
  end

end