# encoding: utf-8
require 'spec_helper'

RSpec.describe RocketChat::Notifier do

  before :each do
    @http_client = double("RocketChat::Notifier::DefaultHTTPClient")
  end

  {
    ['hello', {}] =>
      { payload: { text:"hello" }.to_json },

    ['[hello](http://example.com/world)', {}] =>
      { payload: { text: '[hello](http://example.com/world)' }.to_json },

    ['hello/こんにちは from notifier test', {}] =>
      { payload: { text: 'hello/こんにちは from notifier test' }.to_json },

    ['Hello World, enjoy [this](http://example.com)[this2](http://example2.com)', {}] =>
      { payload: { text: 'Hello World, enjoy [this](http://example.com)[this2](http://example2.com)'}.to_json },

    ['[John](mailto:john@example.com)', {}] =>
      { payload: { text: "[John](mailto:john@example.com)"}.to_json },

    ['hello', { channel: 'hodor' }] =>
      { payload: { channel: 'hodor', text: 'hello' }.to_json },

    ['the message', { channel: 'foo',
                      attachments: [{ color: '#000',
                                      text: 'attachment message',
                                      fallback: 'fallback message' }] }] =>
      { payload: { channel: 'foo',
                   attachments: [ { color: '#000',
                                    text: 'attachment message',
                                    fallback: 'fallback message' } ],
                   text: 'the message' }.to_json },

   [{ attachments: [{ color: '#000',
                      text: 'attachment message',
                      fallback: 'fallback message' }] }] =>
    { payload: { attachments: [{ color: '#000',
                                 text: 'attachment message',
                                 fallback: 'fallback message' }] }.to_json },

   [{ attachments: { color: '#000',
                     text: 'attachment message [hodor](http://winterfell.com)',
                     fallback: 'fallback message' } }] =>
    { payload: { attachments: { color: '#000',
                                text: 'attachment message [hodor](http://winterfell.com)',
                                fallback: 'fallback message' } }.to_json },

   ['hello', { http_options: { timeout: 5 } }] =>
    { http_options: { timeout: 5 }, payload: { text: 'hello' }.to_json }


  }.each do |args, payload|

    it "sends correct payload for #{args}" do
      notifier = RocketChat::Notifier.new 'http://example.com', http_client: @http_client

      expect( @http_client ).to receive(:post)
                            .with( URI.parse('http://example.com'),
                                    payload )

      notifier.ping *args
    end
  end


end
