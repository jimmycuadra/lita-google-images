# lita-google-images

[![Build Status](https://travis-ci.org/jimmycuadra/lita-google-images.png?branch=master)](https://travis-ci.org/jimmycuadra/lita-google-images)
[![Code Climate](https://codeclimate.com/github/jimmycuadra/lita-google-images.png)](https://codeclimate.com/github/jimmycuadra/lita-google-images)
[![Coverage Status](https://coveralls.io/repos/jimmycuadra/lita-google-images/badge.png)](https://coveralls.io/r/jimmycuadra/lita-google-images)

**lita-google-images** is a handler for [Lita](https://github.com/jimmycuadra/lita) that searches Google Images for images matching users' queries, and replies with links to them.

## Installation

Add lita-google-images to your Lita instance's Gemfile:

``` ruby
gem "lita-google-images"
```

## Configuration

### Required attributes

```
* `google_cse_id` (String) - ID of the Google Custom Search Engine to use.
* `google_cse_key` (String) - API key for the Google Custom Search account.
```

### Optional attributes

* `safe_search` (String, Symbol) - The safe search setting to use when querying for images. Possible values are `:high`, `:medium`, and `:off`. Default: `:high`.

### Example

```
Lita.configure do |config|
  config.handlers.google_images.safe_search = :off
end
```

## Usage

The following are all equivalent ways of asking Lita to search for an image of "carl the pug":

```
Lita: image carl the pug
Lita: image me carl the pug
Lita: img carl the pug
Lita: img me carl the pug
```

The following are all equivalent ways of askign Lita to search for an animated GIF of "carl the pug":

```
Lita: animate carl the pug
Lita: animate me carl the pug
Lita: gif carl the pug
Lita: gif me carl the pug
```

The second form ("verb me") is to ease the transition for people coming from [Hubot](http://hubot.github.com/).

## Getting a CSE ID and API key
For the `google_cse_id` and `google_cse_key` you will need to get a Custom Search Engine ID and a Google API key.

### Getting a Custom Search Engine ID
The custom search engine is used to fetch images. Here is how to create one:

1. [Head to the CSE creation page](https://cse.google.com/cse/create/new)
2. Enter any url in the "sites to search" field. We will open the CSE to the whole web later on.
3. Give your CSE a name and hit create
4. Go to the control panel for your new CSE
5. Change the "Image search" switch to ON
6. Change the "Search the entire web" switch to ON
7. `google_cse_id` is the value of "Search engine ID"

### Getting a Google API key
The final attribute you need to set is the Google API key.

1. [Head to the Google Developers Console](https://console.developers.google.com)
2. Create a new project for your lita bot
3. Add the Custom Search API to your project
4. Click on Credentials in the menu on the left
5. Click on Create Credentials
6. Select "API key"
7. `google_cse_key` is the value of your new API key

## License

[MIT](http://opensource.org/licenses/MIT)
