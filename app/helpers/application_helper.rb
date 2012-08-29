module ApplicationHelper
  def title(page_title, show_title = true)
    page_title = "Undefined" if page_title == nil
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  private
  # make a html button for action
  # icon is the icon of Glyphicons we want
  # see Twitter bootstrap for a list of icons
  def name_for_button(icon)
    "<i class='icon-#{icon}'></i>"
  end
end
