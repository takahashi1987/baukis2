module ApplicationHelper
  include HtmlBuilder

  def document_titel
    if @title.present?
      "#{@title} - Baukis2"
    else
      "Baukis2"
    end
  end
end
