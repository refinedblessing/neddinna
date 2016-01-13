class String
  def to_snake_case
    gsub(/::/, "/").
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr("-", "_").downcase
  end

  def to_camel_case
    return self if self !~ /_/ && self =~ /[A-Z].*/
    split("_").map(&:capitalize).join
  end
end

class DoubleRenderError < StandardError
  DEFAULT_MESSAGE =
  "Render and/or redirect were called multiple times in this action.\
  Please note that you may only call render at most once per action."
end

class Object
  def self.const_missing(name)
    require name.to_s.to_snake_case + ".rb"
    Object.const_get(name)
  end
end
