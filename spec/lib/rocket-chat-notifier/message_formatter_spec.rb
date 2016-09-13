# encoding: utf-8
require 'spec_helper'

describe RocketChat::Notifier::MessageFormatter do

  describe "::format" do

    if "".respond_to? :scrub
      context "when on ruby 2.1+ or have string-scrub installed" do
        it "handles invalid unicode sequences" do
          expect {
            described_class.format("This sequence is invalid: \255")
          }.not_to raise_error
        end

        it "replaces invalid unicode sequences with the unicode replacement character" do
          formatted = described_class.format("\255")
          expect(formatted).to eq "\uFFFD"
        end
      end
    end

    it "doesn't replace valid Japanese" do
      formatted = described_class.format("こんにちは")
      expect(formatted).to eq "こんにちは"
    end

  end

end
