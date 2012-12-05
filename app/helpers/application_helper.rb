module ApplicationHelper
  def title(_title)
    content_for(:title) { _title }
  end

  def nav(_nav)
    content_for(:nav) { _nav }
  end
end
