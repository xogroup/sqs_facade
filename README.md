# SQS Facade

[![Build Status](https://semaphoreci.com/api/v1/nrodriguez/sqs_facade/branches/master/badge.svg)](https://semaphoreci.com/nrodriguez/sqs_facade)

This gem is geared towards making your life easier when it comes to testing using AWS SQS messages. Think Factory Girl/Faker for AWS SQS purposes. It works by generating a message skeleton and allows you to override the defaults with anything you want. Internal message are stored as JSON strings.

It works by generating objects with an internal message structure such as:

```ruby
{
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
}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sqs_facade'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sqs_facade

## Usage

Usage is easy. Simply instantiate the class and by default new will return an object with generated dummy values.

```ruby
SqsFacade.new

-> <SqsFacade:0x007fcea2944260 @full_message={"Type"=>"Notification", "MessageId"=>"be3b6b8b-ce76-4e6e-a800-bba8377a37a7", "TopicArn"=>"arn:aws:sns:us-east-1:31cf754f-bbd7-4c14-9c78-e81f7d115958:some-sns-topic", "Subject"=>"entityupsert", "Message"=>"{\"something\":\"hey\",\"really\":\"there\",\"cool\":\"lonely girl\"}", "Timestamp"=>"2016-05-19T19:53:01.936Z", "SignatureVersion"=>"1", "Signature"=>"c+9MIvg7+87QVQzm3xAxog==", "SigningCertURL"=>"https://sns.us-east-1.amazonaws.com/eb74a61a20c15ac1c53db21a4af05993.pem", "UnsubscribeURL"=>"https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:31cf754f-bbd7-4c14-9c78-e81f7d115958:some-sns-topic:1234"}>
```
To access the full message as a hash use the ```full_message``` method

```ruby
SqsFacade.new.full_message

-> {"Type"=>"Notification", "MessageId"=>"e1cbeb58-9b36-4ee4-94ff-d195f2b7fcbf", "TopicArn"=>"arn:aws:sns:us-east-1:e9f8a671-2d08-4fc4-b54b-6109c02da13a:some-sns-topic", "Subject"=>"entityupsert", "Message"=>"{\"something\":\"hey\",\"really\":\"there\",\"cool\":\"lonely girl\"}", "Timestamp"=>"2016-05-19T19:53:01.936Z", "SignatureVersion"=>"1", "Signature"=>"DBHK4iOEfwT99DLhLz2EqQ==", "SigningCertURL"=>"https://sns.us-east-1.amazonaws.com/0fae4284696382f2784a1670d2a56b81.pem", "UnsubscribeURL"=>"https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:e9f8a671-2d08-4fc4-b54b-6109c02da13a:some-sns-topic:1234"}
```

You can override certain values by passing them in during instantiation:

```ruby
SqsFacade.new(message: {awesome_person: "justneph", career: "software engineer/pro wrestler"})

-> <SqsFacade:0x007fcea306c5b0 @full_message={"Type"=>"Notification", "MessageId"=>"20c8433e-16c1-4aec-a0a5-d8f6e3e445e1", "TopicArn"=>"arn:aws:sns:us-east-1:e82988d7-1a3f-45e8-b718-8e7565631c35:some-sns-topic", "Subject"=>"entityupsert", "Message"=>"{\"awesome_person\":\"justneph\",\"career\":\"software engineer/pro wrestler\"}", "Timestamp"=>"2016-05-19T19:53:01.936Z", "SignatureVersion"=>"1", "Signature"=>"/MX5p5Se7ujuIYY2o/vVJQ==", "SigningCertURL"=>"https://sns.us-east-1.amazonaws.com/4c7e432f8f8c3d425fecb50d5c81409c.pem", "UnsubscribeURL"=>"https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:e82988d7-1a3f-45e8-b718-8e7565631c35:some-sns-topic:1234"}>
```

Each parameter is accessible via a method call as well

```ruby
irb(main):012:0> SqsFacade.new(message: {awesome_person: "justneph", career: "software engineer/pro wrestler"}).message
=> "{\"awesome_person\":\"justneph\",\"career\":\"software engineer/pro wrestler\"}"

irb(main):013:0> SqsFacade.new(message: {awesome_person: "justneph", career: "software engineer/pro wrestler"}).timestamp
=> "2016-05-19T19:53:01.936Z"

irb(main):014:0> SqsFacade.new(message: {awesome_person: "justneph", career: "software engineer/pro wrestler"}).topic_arn
=> "arn:aws:sns:us-east-1:61458f06-5922-4fcf-a165-e52531e7f1ee:some-sns-topic"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sqs_facade. This project is intended to be a safe, welcoming space for collaboration. Contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
