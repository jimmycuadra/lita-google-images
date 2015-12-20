require "lita"

module Lita
  module Handlers
    class GoogleImages < Handler
      URL = "https://www.googleapis.com/customsearch/v1"
      VALID_SAFE_VALUES = %w(high medium off)

      config :safe_search, types: [String, Symbol], default: :high do
        validate do |value|
          unless VALID_SAFE_VALUES.include?(value.to_s.strip)
            "valid values are :high, :medium, or :off"
          end
        end
      end

      config :google_cse_id, default: "" do
        validate do |value|
          if value.empty?
            "Set your google cse id at configuration file"
          end
        end
      end

      config :google_cse_key, default: "" do
        validate do |value|
          if value.empty?
            "Set your google cse key at configuration file"
          end
        end
      end

      route(/(?:image|img)(?:\s+me)? (.+)/i, :fetch, command: true, help: {
        "image QUERY" => "Displays a random image from Google Images matching the query."
      })

      def fetch(response)
        query = response.matches[0][0]

        http_response = http.get(
          URL,
          v: "1.0",
          searchType: 'image',
          q: query,
          safe: config.safe_search,
          fields: 'items(link)',
          rsz: 8,
          cx: config.google_cse_id,
          key: config.google_cse_key
        )

        data = MultiJson.load(http_response.body)

        if http_response.status == 200
          choice = data["items"].sample if data["items"]
          if choice
            response.reply ensure_extension(choice["link"])
          else
            response.reply %{No images found for "#{query}".}
          end
        else
          reason = data["error"]["message"] || "unknown error"
          Lita.logger.warn(
            "Couldn't get image from Google: #{reason}"
          )
        end
      end

      private

      def ensure_extension(url)
        if [".gif", ".jpg", ".jpeg", ".png"].any? { |ext| url.end_with?(ext) }
          url
        else
          "#{url}#.png"
        end
      end
    end

    Lita.register_handler(GoogleImages)
  end
end
