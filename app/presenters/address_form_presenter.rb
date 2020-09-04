class AddressFormPresenter < FormPresenter
  def postal_code_block(name, label_text, options)
    markup(:div, class: "input-block") do |m|
      m << decoreated_label(name, label_text, options)
      m << text_field(name, options)
      m.span "(7桁の半角数字で入力してください。)", class: "notes"
      m << error_message_for(name)
    end
  end
end
