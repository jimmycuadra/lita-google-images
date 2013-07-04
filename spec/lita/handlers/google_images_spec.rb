require "spec_helper"

describe Lita::Handlers::GoogleImages, lita_handler: true do
  it { routes_command("image me foo").to(:fetch) }
  it { routes_command("image foo").to(:fetch) }
  it { routes_command("img foo").to(:fetch) }
  it { routes_command("img me foo").to(:fetch) }

  describe "#foo" do
    let(:response) { double("Faraday::Response") }

    before { allow(Faraday).to receive(:get).and_return(response) }

    it "replies with a matching image URL on success" do
      allow(response).to receive(:body).and_return(<<-JSON.chomp
{
  "responseStatus": 200,
  "responseData": {
    "results": [
      {
        "unescapedUrl": "http://www.example.com/path/to/an/image.jpg"
      }
    ]
  }
}
JSON
      )
      send_command("image carl")
      expect(replies.last).to eq(
        "http://www.example.com/path/to/an/image.jpg#.png"
      )
    end

    it "logs a warning on failure" do
      allow(response).to receive(:body).and_return(<<-JSON.chomp
{
  "responseStatus": 500,
  "responseDetails": "google fail"
}
JSON
      )
      expect(Lita.logger).to receive(:warn).with(/google fail/)
      send_command("image carl")
      expect(replies).to be_empty
    end
  end
end
