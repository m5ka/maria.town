require "nokogiri"
require "uri"

class MarzkaExtLinks
  class << self
    def process(doc)
      @site_url = doc.site.config["url"]
      @config = doc.site.config

      return unless processable?(doc)
      doc.output = process_links(doc.output)
    end

    def processable?(doc)
      (doc.is_a?(Jekyll::Page) || doc.write?) &&
        (doc.output_ext == ".html" || doc.permalink&.end_with?("/")) &&
        doc.output.include?("<a")
    end

    def process_links(html)
      soup = Nokogiri::HTML::DocumentFragment.parse(html)
      links = soup.css("a[href]")
      links.each do |link|
        if processable_link?(link)
          process_link(link)
        end
      end
      soup.to_html
    end

    def process_link(link)
      link["target"] = "_blank"
      rels = link["rel"]&.split || []

      rels.push("noopener") unless rels.include?("noopener")
      rels.push("nofollow") unless rels.include?("nofollow")
      link["rel"] = rels.join(" ")
    end

    def processable_link?(link)
      external_link?(link["href"]) && !mailto_link?(link["href"])
    end

    def external_link?(link)
      if link&.match?(URI.regexp(%w(http https)))
        URI.parse(link).host != URI.parse(@site_url).host
      end
    end

    def mailto_link?(link)
      link.to_s.start_with?("mailto:")
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  MarzkaExtLinks::process(doc)
end
