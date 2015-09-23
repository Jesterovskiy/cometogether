# cometogether
Simple REST JSON API for creating events with different things

[![Codeship Status for Jesterovskiy/cometogether](https://codeship.com/projects/682ff1a0-388f-0133-fbc2-6e9a9ee8621b/status?branch=master)](https://codeship.com/projects/101347)

## Local setup

### Setup

```
gem install bundler
bundle install
```

### DB creation

```
rake db:create:all
rake db:migrate
rake db:migrate RAILS_ENV=test
```

### Seed data

```
rake db:seed
```

### Run

```
bin/rails s
```

### Testing

```
bundle exec rspec
```

### Documentation

`http://localhost:3000/api/docs`

### Metrics

* `thor metrics:all` – run all metrics
* `thor metrics:lint` – run rubocop linter ([Rubocop](https://github.com/bbatsov/rubocop))
* `thor metrics:smells` – run smell detector ([Reek](https://github.com/troessner/reek/wiki/Code-Smells))
* `thor metrics:coverage` – run coverage report

## Release process

* Run `bundle update` to keep dependencies up-to-date
* Make `thor metrics:all` happy, it should have at least 95% coverage, no failing tests, no rubocop problems and minor reek warnings
* Update README if something changed and make sure that code properly documented
* Clean feature branches
* Tag final commit in git

## Deployment

## System requirements

* Ruby 2.2.x
* PostgreSQL 9.x

## Troubleshooting

### Rails/Rake commands fails with segfault

This may be a trouble with shared gems between old ruby version and new,
to reinstall all gems, run following commands:

```
for i in `gem list --no-versions`; do gem uninstall -aIx $i; done
gem install bundler --no-ri --no-rdoc
bundle install
```
