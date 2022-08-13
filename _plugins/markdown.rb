module Jekyll
    module Converters
        class Markdown
            class MarzkaMarkdown < KramdownParser
                def initialize(config)
                    super
                    begin
                        require 'unicode/emoji'
                    rescue LoadError
                        STDERR.puts 'Missing unicode-emoji gem for markdown. Try running:'
                        STDERR.puts '  $ [sudo] gem install unicode-emoji'
                        raise FatalException.new('Missing dependency: unicode-emoji')
                    end
                end

                def convert(content)
                    super.gsub(Unicode::Emoji::REGEX, '<i class="emoji" aria-hidden="true">\0</i>')
                end
            end
        end
    end
end