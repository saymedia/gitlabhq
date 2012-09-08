require 'spec_helper'

describe Issue do
  let(:issue) { create(:issue) }

  describe "#upvotes" do
    it "with no notes has a 0/0 score" do
      issue.upvotes.should == 0
    end

    it "should recognize non-+1 notes" do
      issue.notes << create(:note, note: "No +1 here")
      issue.should have(1).note
      issue.notes.first.upvote?.should be_false
      issue.upvotes.should == 0
    end

    it "should recognize a single +1 note" do
      issue.notes << create(:note, note: "+1 This is awesome")
      issue.upvotes.should == 1
    end

    it "should recognize multiple +1 notes" do
      issue.notes << create(:note, note: "+1 This is awesome")
      issue.notes << create(:note, note: "+1 I want this")
      issue.upvotes.should == 2
    end
  end

  describe "#downvotes" do
    it "with no notes has a 0/0 score" do
      issue.downvotes.should == 0
    end

    it "should recognize non--1 notes" do
      issue.notes << create(:note, note: "Almost got a -1")
      issue.should have(1).note
      issue.notes.first.downvote?.should be_false
      issue.downvotes.should == 0
    end

    it "should recognize a single -1 note" do
      issue.notes << create(:note, note: "-1 This is bad")
      issue.downvotes.should == 1
    end

    it "should recognize multiple -1 notes" do
      issue.notes << create(:note, note: "-1 This is bad")
      issue.notes << create(:note, note: "-1 Away with this")
      issue.downvotes.should == 2
    end
  end
end
