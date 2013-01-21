# JSON API Benchmark

This application is a sample benchmark for various approaches to generating JSON API responses. It exercises the entire application stack instead of just JSON generation so that the timing can be viewed in the context of the entire application. It typically tests three approaches:

* Standard Rails - to_json on model objects
* Optimized Rails - pluck and select_all
* PostgreSQL - row_to_json and array_to_json

The sample domain is a simple dictionary. The entities involved are words, definitions, quotes, and related words.

# Requirements

PostgreSQL, siege

# Scenarios

* Concise auto-complete word search - Returns first 10 words matching search term. This scenario is an example of a very simple, feather weight API call that returns only an array of 10 strings.
* Rich auto-complete word search - Returns first 10 words matching search term with text, pronunciation, part of speech, and first definition. This is a light weight example that involves two entity types.
* Word definition - Shows the definitions, quotes, and related words for the specified word. This is a middle weight example.
* Many word definitions - Shows the definitions, quotes, and related words for many words at a time. This is representative of a heavy weight JSON API.

# Running the Benchmarks

Bundle dependencies:

    bundle install

To setup the test data run the following rake tasks:

    rake db:create db:migrate benchmark:setup

Start the server:

    RAILS_ENV=production unicorn -c config/unicorn.rb

Run the benchmark rake task:

    rake benchmark:run
