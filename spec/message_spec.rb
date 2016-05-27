require 'spec_helper'

describe AwsSqsFaker::Message do
  describe "When a new message is created" do
    let(:default_message){{
        "Type"=> "Notification",
        "MessageId"=> "b2632fcd-b735-57ae-84aa-6075ace8a47c",
        "TopicArn"=> "arn:aws:sns:us-east-1:123456789:sample_sns",
        "Subject"=> "entityupsert",
        "Message"=> "{\"something\":\"hey\",\"really\":\"there\",\"cool\":\"lonely girl\"}",
        "Timestamp"=> "2016-05-19T19:53:01.936Z",
        "SignatureVersion"=> "1",
        "Signature"=> "cf23df2207d99a74fbe169e3eba035e633b65d94==",
        "SigningCertURL"=> "https://sns.us-east-1.amazonaws.com/SampleSNS.pem",
        "UnsubscribeURL"=> "https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:123456789:sample_sns"
    }}
    context "with all the default values" do
      it "has the keys in the default skeleton of an sqs message" do
        expect(described_class.new.full_message.keys).to eq ["Type", "MessageId", "TopicArn", "Subject", "Message", "Timestamp", "SignatureVersion", "Signature", "SigningCertURL", "UnsubscribeURL"]
      end
    end

    it "sets the body message when passed in" do
      expect(described_class.new(message: "JustNeph").message).to eq "JustNeph".to_json
    end

    it "creates the message attributes as methods" do
      expect(described_class.new.methods).to include(:type, :message_id, :topic_arn, :subject, :message, :timestamp, :signature_version, :signature, :signing_cert_url, :unsubscribe_url)
    end
  end
end
