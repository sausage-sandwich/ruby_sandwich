# Sandwich

[![Maintainability](https://api.codeclimate.com/v1/badges/0b931040ab1af9b304d7/maintainability)](https://codeclimate.com/github/sausage-sandwich/ruby_sandwich/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0b931040ab1af9b304d7/test_coverage)](https://codeclimate.com/github/sausage-sandwich/ruby_sandwich/test_coverage)

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```
