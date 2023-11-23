require "nokogiri"

class MariaLinkImages
  class << self
    def process(doc)
      return unless processable?(doc)
      soup = Nokogiri::HTML(doc.output)
      soup.css("main img").each do |image|
        next if image.parent.name == "a"
        src = image["src"]
        image.wrap("<a href=\"#{src}\" target=\"_blank\" rel=\"noreferrer noopener nofollow\"></a>")
      end
      doc.output = soup.to_s
    end

    def processable?(doc)
      (doc.is_a?(Jekyll::Page) || doc.write?) &&
        (doc.output_ext == ".html" || doc.permalink&.end_with?("/")) &&
        doc.output.include?("<img")
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  MariaLinkImages::process(doc)
end
