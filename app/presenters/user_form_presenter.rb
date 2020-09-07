class UserFormPresenter < FormPresenter

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name1, label_text, options)
      m << text_field(name1, options)
      m << text_field(name2, options)
      m << error_message_for(name1)
      m << error_message_for(name2)
    end
  end

  def password_field_block(name, label_text, options = {})
    if object.new_record?
      super(name, label_text, options)
    end
  end
end
