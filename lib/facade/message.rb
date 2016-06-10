module Facade
  class Message
    attr_accessor :full_message

    def initialize(args = "")
      @full_message = create_message(args)
      set_accessors
    end

    def set_accessors
      full_message.keys.each do |key|
        define_singleton_method(key.underscore.to_sym) do
          full_message[key]
        end
      end
    end

    private

    def message_template
      topic_id = SecureRandom.uuid
      {
        "Type"=> "Notification",
        "MessageId"=> SecureRandom.uuid,
        "TopicArn"=> "arn:aws:sns:us-east-1:#{topic_id}:some-sns-topic",
        "Subject"=> "entityupsert",
        "Message"=> "{\"something\":\"hey\",\"really\":\"there\",\"cool\":\"lonely girl\"}",
        "Timestamp"=> "2016-05-19T19:53:01.936Z",
        "SignatureVersion"=> "1",
        "Signature"=> SecureRandom.base64(16),
        "SigningCertURL"=> "https://sns.us-east-1.amazonaws.com/#{SecureRandom.hex}.pem",
        "UnsubscribeURL"=> "https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:#{topic_id}:some-sns-topic:1234"
      }
    end

    def create_message(args)
      return message_template if args.empty?
      skeleton = message_template
      args.each{|k,v| skeleton[k.to_s.capitalize] = args[k] }
      skeleton["Message"] = skeleton["Message"].to_json
      skeleton
    end
  end
end
