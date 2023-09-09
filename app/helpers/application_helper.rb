module ApplicationHelper
  def default_meta_tags
    {
      site: Settings.site.name,
      reverse: true,
      title: Settings.site.title,
      description: Settings.site.description,
      keywords: Settings.site.keywords,
      canonical: request.original_url
    }
  end
end
