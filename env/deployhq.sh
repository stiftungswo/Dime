curl -XPOST -H "Content-Type: application/json" $DEPLOYHQ --data "{ \"payload\": { \"new_ref\": \"$TRAVIS_COMMIT\", \"branch\": \"master\", \"email\": \"$EMAIL\", \"clone_url\": \"https://github.com/stiftungswo/dime\" } }"

