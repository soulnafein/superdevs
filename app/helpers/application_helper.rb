module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def current_tab(tab_name)
    content_for(:current_tab) { tab_name }
  end

  def print_on(condition, text)
    condition ? text : ''
  end

  def print_unless(condition, text)
    print_on(!condition, text)
  end
end