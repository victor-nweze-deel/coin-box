  
| KEY      | BADGE |
| -----------:|:-----------:|
| AUTHOR      | [![Jiggy](https://svgshare.com/i/Bfm.svg)](https://github.com/ProfJigsaw)       |
| BUILD STATUS   | [![Build Status](https://travis-ci.com/ProfJigsaw/coin-box.svg?token=X8ZfjDUfqPhNecNQtVRq&branch=master)](https://travis-ci.com/ProfJigsaw/coin-box)         |

# GRAPHIQL COIN-BOX

This API is A `graphql`-powered interface running on the ruby on rails framework.

## SETUP

* Ruby version
>- 2.6.0

* Bundler version
>- 2.1.4

* System dependencies
>- Once this repository is pulled, run `bundle install` in the working directory to install the necessary dependencies

* Database creation
>- Run `bin/rails db:create`

* How to run the test suite
>- Run `bundle exec rspec spec` 

## USAGE

- Visit this endpoint 👉 https://coinbox.herokuapp.com/graphiql

- On the leftmost pane, enter a graphql request of the following format:
## SAMPLE REQUEST:
```graphql
{
  calculatePrice(
    type: "sell"
    margin: 0.1
    exchangeRate: 363.5
  ) {
    price
  }
}
```

## SAMPLE RESPONSE:
```JSON
{
  "data": {
    "calculatePrice": {
      "price": 3260359.46
    }
  }
}
```

