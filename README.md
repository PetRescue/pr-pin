# PR::Pin

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pr-pin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pr-pin

## Usage

### Registering Connections
```ruby
# Require the gem
require 'pr-pin'

# Register a connection using your Pin Payments secret key
PR::Pin.register_connection(
  secret_key: 'your_secret_key',
  # raise on error, defaults to returning PR::Pin::API::Error instance
  error_handler: ->(exception) { raise(exception) },
  sandbox: true # Defaults to true, false for production
)

# You can register another connection by passsing an identifier to
# PR::Pin.register_connection, i.e.
PR::Pin.register_connection(
  :admin, # defaults to :default
  secret_key: 'your_secret_key',
  sandbox: true
)

# Then, you can specify the connection to use when resolving the
# endpoint repository from the PR::Pin container
customers = PR::Pin.customers(:admin).list(page: 1)
# => [#<PR::Pin::Struct::Customer>, ...]
customers.current_page # => 1
customers.per_page # => 25
customers.prev_page # => nil
customers.next_page # => 2
customers.total_count # => 53
customers.total_pages # => 3
```

### One-off charge
```ruby
# Create a charge using a token, you can get a card token
# using Pin Payments hosted fields, or by creating a card
# via the API, this can be used to take a one-off payment
charge = PR::Pin.charges.create(
  email: 'a.user@petrescue.com.au',
  description: 'A $10 donation',
  amount: 1000,
  ip_address: '127.0.0.1',
  card_token: 'card_58b6c52f131956c4394ba7'
)
charge.success? # => true
charge.error? # => false
charge # => #<PR::Pin::Struct::Charge>

# Find a charge by token
PR::Pin.charges.find('ch_1ee2d1')
# => #<PR::Pin::Struct::Charge>
```

### Recurring payments
```ruby
# For a subscription, create a customer using a card token
customer = PR::Pin.customers.create(
  email: 'a.user@petrescue.com.au',
  card_token: 'card_58b6c52f131956c4394ba7'
)
customer.success? # => true
customer.error? # => false
customer # => #<PR::Pin::Struct::Customer>

# And then attach a subscription using the plan token from
# the plans endpoint (you will need to create the plan first)
subscription = PR::Pin.subscriptions.create(
  plan_token: 'plan_2d16b31863015a57820b70',
  customer_token: 'cus_9d18a4516a6ae777-NDecB'
)
subscription.success? # => true
subscription.error? # => false
subscription # => #<PR::Pin::Struct::Subscription>

ledger = PR::Pin.ledger.for_subscription('sub_293857')
subscription.success? # => true
subscription.error? # => false
ledger
# => [
#   #<PR::Pin::Struct::Ledger type="credit" annotation="charge_credit" amount=1026 currency="AUD" created_at=#<DateTime: 2020-07-02T02:19:50+00:00 ((2459033j,8390s,0n),+0s,2299161j)>>,
#   #<PR::Pin::Struct::Ledger type="debit" annotation="interval_fee" amount=1026 currency="AUD" created_at=#<DateTime: 2020-07-02T02:19:47+00:00 ((2459033j,8387s,0n),+0s,2299161j)>>,
#   #<PR::Pin::Struct::Ledger type="debit" annotation="setup_fee" amount=0 currency="AUD" created_at=#<DateTime: 2020-07-02T02:19:47+00:00 ((2459033j,8387s,0n),+0s,2299161j)>>
# ]
```

### Refunds
```ruby
# List refunds (paginated)
refunds = PR::Pin.refunds.list
# => [#<PR::Pin::Struct::Refund>, ...]

# Find a specific refund
refund = PR::Pin.refunds.find('rf_1e5429')
# => #<PR::Pin::Struct::Refund>

# Create a refund for a charge
PR::Pin.refunds.create_for_charge('ch_1ee2d1')
# => #<PR::Pin::Struct::Refund>

# List all refunds by charge
PR::Pin.refunds.for_charge('ch_1ee2d1')
# => [#<PR::Pin::Struct::Refund>, ...]
```

### Errors - See [PR::Pin::API::Error](https://github.com/PetRescue/pr-pin/blob/master/lib/pr/pin/api/error.rb)
```ruby
charge = PR::Pin.charges.create(
  email: 'a.user@petrescue.com.au'
)
charge.success? # => false
charge.error? # => true
charge.code # => "invalid_resource"
charge.description # => "One or more parameters were missing or invalid"
charge # => => #<PR::Pin::API::Error>
```

## API Coverage

Coverage of https://pinpayments.com/developers/api-reference

| Relation | Endpoint | Description | Docs | Implemented |
|--|--|--|--|--|
| Balance | GET /balance | Returns the current balance of your Pin Payments account | [:link:](https://pinpayments.com/developers/api-reference/balance) | :x: |
| Bank Accounts | POST /bank_accounts | Creates a bank account token | [:link:](https://pinpayments.com/developers/api-reference/bank-accounts) | :x: |
| Cards | POST /cards | Securely stores a card's details | [:link:](https://pinpayments.com/developers/api-reference/cards) | :x: |
| Charges | POST /charges | Creates a new charge | [:link:](https://pinpayments.com/developers/api-reference/charges#post-charges) | :heavy_check_mark: |
| Charges | PUT /charges/charge-token/capture | Captures a previously authorised charge | [:link:](https://pinpayments.com/developers/api-reference/charges#put-charges) | :x: |
| Charges | GET /charges | Returns a paginated list of all charges | [:link:](https://pinpayments.com/developers/api-reference/charges#get-charges) | :heavy_check_mark: |
| Charges | GET /charges/search | Returns a paginated list of charges matching the search criteria | [:link:](https://pinpayments.com/developers/api-reference/charges#search-charges) | :heavy_check_mark: |
| Charges | GET /charges/charge-token | Returns the details of a charge | [:link:](https://pinpayments.com/developers/api-reference/charges#get-charge) | :heavy_check_mark: |
| Customers | POST /customers | Creates a new customer | [:link:](https://pinpayments.com/developers/api-reference/customers#post-customers) | :heavy_check_mark: |
| Customers | GET /customers | Returns a paginated list of all customers | [:link:](https://pinpayments.com/developers/api-reference/customers#get-customers) | :heavy_check_mark: |
| Customers | GET /customers/customer-token | Returns the details of a customer | [:link:](https://pinpayments.com/developers/api-reference/customers#get-customer) | :heavy_check_mark: |
| Customers | PUT /customers/customer-token | Updates the details of a customer | [:link:](https://pinpayments.com/developers/api-reference/customers#put-customer) | :heavy_check_mark: |
| Customers | DELETE /customers/customer-token | Deletes a customer and all of its cards | [:link:](https://pinpayments.com/developers/api-reference/customers#delete-customer) | :x: |
| Customers | GET /customers/customer-token/charges | Returns a paginated list of a customer's charges | [:link:](https://pinpayments.com/developers/api-reference/customers#get-customers-charges) | :x: |
| Customers | GET /customers/customer-token/cards | Returns a paginated list of a customer's cards | [:link:](https://pinpayments.com/developers/api-reference/customers#get-customers-cards) | :x: |
| Customers | POST /customers/customer-token/cards | Creates an additional card for the specified customer | [:link:](https://pinpayments.com/developers/api-reference/customers#post-customers-cards) | :x: |
| Customers | DELETE /customers/customer-token/cards/card-token | Deletes a customer's non-primary card | [:link:](https://pinpayments.com/developers/api-reference/customers#delete-customers-card) | :x: |
| Customers | GET /customers/customer-token/subscriptions | Retrieves the specified customer's subscriptions | [:link:](https://pinpayments.com/developers/api-reference/customers#customers-subscriptions) | :x: |
| Events | GET /events | Returns a paginated list of all events | [:link:](https://pinpayments.com/developers/api-reference/events#get-events) | :x: |
| Events | GET /events/event-token | Returns the details of the specified event | [:link:](https://pinpayments.com/developers/api-reference/events#get-event) | :x: |
| Plans | POST /plans | Creates a new plan | [:link:](https://pinpayments.com/developers/api-reference/plans#post-plans) | :heavy_check_mark: |
| Plans | GET /plans | Returns a paginated list of all plans | [:link:](https://pinpayments.com/developers/api-reference/plans#get-plans) | :heavy_check_mark: |
| Plans | GET /plans/plan-token | Returns the details of a specified plan | [:link:](https://pinpayments.com/developers/api-reference/plans#get-plan) | :heavy_check_mark: |
| Plans | PUT /plans/plan-token | Update the specified plan | [:link:](https://pinpayments.com/developers/api-reference/plans#put-plan) | :heavy_check_mark: |
| Plans | DELETE /plans/plan-token | Deletes a plan and all of its subscriptions | [:link:](https://pinpayments.com/developers/api-reference/plans#delete-plan) | :x: |
| Plans | POST /plans/plan-token/subscriptions | Creates a new subscription to the specified plan | [:link:](https://pinpayments.com/developers/api-reference/plans#create-plan-subscription) | :x: |
| Plans | GET /plans/plan-token/subscriptions | Returns a paginated list of subscriptions for a plan | [:link:](https://pinpayments.com/developers/api-reference/plans#get-plan-subscriptions) | :x: |
| Subscriptions | POST /subscriptions | Activate a new subscription and returns its details | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#post-subscriptions) | :heavy_check_mark: |
| Subscriptions | GET /subscriptions | Returns a paginated list of all subscriptions | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#get-subscriptions) | :heavy_check_mark: |
| Subscriptions | GET /subscriptions/sub-token | Returns the details of the subscription identified by subscription token | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#get-subscription) | :heavy_check_mark: |
| Subscriptions | PUT /subscriptions/sub-token | Updates the card associated with a subscription identified by subscription token | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#update-subscription) | :heavy_check_mark: |
| Subscriptions | DELETE /subscriptions/sub-token | Cancels the subscription identified by subscription token | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#delete-subscription) | :x: |
| Subscriptions | PUT /subscriptions/sub-token/reactivate | Reactivates the subscription identified by subscription token | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#reactivate-subscription) | :x: |
| Subscriptions | GET /subscriptions/sub-token/ledger | Fetch the ledger entries relating to a subscription identified by subscription token | [:link:](https://pinpayments.com/developers/api-reference/subscriptions#ledger-subscription) | :heavy_check_mark: |
| Recipients | POST /recipients | Creates a new recipient | [:link:](https://pinpayments.com/developers/api-reference/recipients#post-recipients) | :x: |
| Recipients | GET /recipients | Returns a paginated list of all recipients | [:link:](https://pinpayments.com/developers/api-reference/recipients#get-recipients) | :x: |
| Recipients | GET /recipients/recipient-token | Returns the details of a recipient | [:link:](https://pinpayments.com/developers/api-reference/recipients#get-recipient) | :x: |
| Recipients | PUT /recipients/recipient-token | Updates the details of a recipient | [:link:](https://pinpayments.com/developers/api-reference/recipients#put-recipient) | :x: |
| Recipients | GET /recipients/recipient-token/transfers | Returns a paginated list of a recipient's transfers | [:link:](https://pinpayments.com/developers/api-reference/recipients#get-recipients-transfers) | :x: |
| Refunds | GET /refunds | Returns a paginated list of all refunds | [:link:](https://pinpayments.com/developers/api-reference/refunds#get-refunds) | :heavy_check_mark: |
| Refunds | GET /refunds/refund-token | Returns the details of the specified refund | [:link:](https://pinpayments.com/developers/api-reference/refunds#get-refund) | :heavy_check_mark: |
| Refunds | POST  /charges/charge-token/refunds | Creates a new refund and returns its details | [:link:](https://pinpayments.com/developers/api-reference/refunds#post-refunds) | :heavy_check_mark: |
| Refunds | GET /charges/charge-token/refunds | Returns a list of all refunds for the specified charge | [:link:](https://pinpayments.com/developers/api-reference/refunds#get-token-refunds) | :heavy_check_mark: |
| Transfers | POST /transfers | Creates a new transfer | [:link:](https://pinpayments.com/developers/api-reference/transfers#post-transfers) | :x: |
| Transfers | GET /transfers | Returns a paginated list of all transfers | [:link:](https://pinpayments.com/developers/api-reference/transfers#get-transfers) | :x: |
| Transfers | GET /transfers/search | Returns a paginated list of transfers matching the search criteria | [:link:](https://pinpayments.com/developers/api-reference/transfers#search-transfers) | :x: |
| Transfers | GET /transfers/transfer-token | Returns the details of the specified transfer | [:link:](https://pinpayments.com/developers/api-reference/transfers#get-transfer) | :x: |
| Transfers | GET /transfers/transfer-token/line_items | Returns a paginated list of line items associated with the specified transfer | [:link:](https://pinpayments.com/developers/api-reference/transfers#get-transfer-line-items) | :x: |
| Webhook Endpoints | POST /webhook_endpoints | Creates a new webhook endpoint | [:link:](https://pinpayments.com/developers/api-reference/webhook-endpoints#post-webhook_endpoints) | :x: |
| Webhook Endpoints | GET /webhook_endpoints | Returns a paginated list of all webhook endpoints | [:link:](https://pinpayments.com/developers/api-reference/webhook-endpoints#get-webhook_endpoints) | :x: |
| Webhook Endpoints | GET /webhook_endpoints/webhook-endpoint-token | Returns the details of the specified webhook endpoint | [:link:](https://pinpayments.com/developers/api-reference/webhook-endpoints#get-webhook_endpoints-token) | :x: |
| Webhook Endpoints | DELETE /webhook_endpoints/webhook-endpoint-token | Deletes a webhook endpoint and all of its webhook requests | [:link:](https://pinpayments.com/developers/api-reference/webhook-endpoints#delete-webhook_endpoints) | :x: |
| Webhooks | GET /webhooks | Returns a paginated list of all webhooks | [:link:](https://pinpayments.com/developers/api-reference/webhooks#get-webhooks) | :x: |
| Webhooks | GET /webhooks/webhook-token | Returns the details of a webhook | [:link:](https://pinpayments.com/developers/api-reference/webhooks#get-webhook) | :x: |
| Webhooks | PUT /webhooks/webhook-token/replay | Replays a webhook | [:link:](https://pinpayments.com/developers/api-reference/webhooks#put-webhook-replay) | :x: |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PetRescue/pr-pin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
