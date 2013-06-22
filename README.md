# lita-google-images

[![Build Status](https://travis-ci.org/jimmycuadra/lita-google-images.png)](https://travis-ci.org/jimmycuadra/lita-google-images)
[![Code Climate](https://codeclimate.com/github/jimmycuadra/lita-google-images.png)](https://codeclimate.com/github/jimmycuadra/lita-google-images)
[![Coverage Status](https://coveralls.io/repos/jimmycuadra/lita-google-images/badge.png)](https://coveralls.io/r/jimmycuadra/lita-google-images)

**lita-google-images** is a handler for [Lita](https://github.com/jimmycuadra/lita) that searches Google Images for images matching users' queries, and replies with links to them.

## Installation

Add lita-google-images to your Lita instance's Gemfile:

``` ruby
gem "lita-google-images"
```

## Configuration

Set `safe_search` to `false` if you want to allow explicit images. (Default is `true`.)

```
Lita.configure do |config|
  config.handlers.google_images.safe_search = false
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

The second form is for those coming from [Hubot](http://hubot.github.com/).

## License

[MIT](http://opensource.org/licenses/MIT)
