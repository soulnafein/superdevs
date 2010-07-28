module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def current_tab(tab_name)
    content_for(:current_tab) { tab_name }
  end
end