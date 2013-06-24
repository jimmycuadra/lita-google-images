require "spec_helper"

describe Lita::Handlers::GoogleImages, lita: true do
  it { routes("#{robot.name}: image me foo").to(:fetch) }
  it { routes("#{robot.name}: image foo").to(:fetch) }
  it { routes("#{robot.name}: img foo").to(:fetch) }
  it { routes("#{robot.name}: img me foo").to(:fetch) }

  describe ".help" do
    it "returns a hash of command help" do
      expect(described_class.help).to be_a(Hash)
    end
  end

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
      expect_reply("http://www.example.com/path/to/an/image.jpg#.png")
      send_test_message("Lita: image carl")
    end

    it "logs a warning on failure" do
      allow(response).to receive(:body).and_return(<<-JSON.chomp
{
  "responseStatus": 500,
  "responseDetails": "google fail"
}
JSON
      )
      expect_no_reply
      expect(Lita.logger).to receive(:warn).with(/google fail/)
      send_test_message("Lita: image carl")
    end
  end
end
