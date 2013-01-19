namespace :benchmark do
  desc 'Load benchmark data'
  task setup: :environment do
    WordRelationship.delete_all
    Quote.delete_all
    Definition.delete_all
    Word.delete_all

    srand(0)

    parts_of_speech = %w[noun verb adjective adverb preposition conjunction]
    dictionary_words = Rails.root.join('benchmark/words.txt').readlines.map &:chomp

    build_definition = lambda do |word, position|
      Definition.create! word: word,
        position: position,
        part_of_speech: parts_of_speech.sample,
        body: dictionary_words.sample(rand(2..20)).join(' ')
    end

    build_quote = lambda do |word|
      Quote.create! word: word,
        body: dictionary_words.sample(rand(5..30)).join(' '),
        source: dictionary_words.sample(3).join(' ')
    end

    Word.transaction do
      dictionary_words.each do |word_string|
        word = Word.create! text: word_string,
          pronunciation: word_string

        rand(1..15).times { |n| build_definition.call word, n }
        rand(0..5).times { |n| build_quote.call word }
      end
    end

    word_ids = Word.pluck :id
    relationships = %w[synonym antonym]

    Word.connection.execute 'drop index if exists word_relationships_source_id_destination_id_idx;'
    word_ids.in_groups_of(1000, false).each do |word_id_group|
      Word.transaction do
        word_id_group.each do |word_id|
          word_ids.sample(rand(1..10)).each do |other_word_id|
            relationship = relationships.sample
            WordRelationship.create! relationship: relationship,
              source_id: word_id,
              destination_id: other_word_id

            WordRelationship.create! relationship: relationship,
              source_id: other_word_id,
              destination_id: word_id
          end
        end
      end
    end

    Word.connection.execute <<-SQL
      with t as (
        select source_id, destination_id
        from word_relationships
        group by source_id, destination_id
        having count(*) > 1
      )
      delete from word_relationships
      using t
      where word_relationships.source_id = t.source_id
        and word_relationships.destination_id = t.destination_id
    SQL

    Word.connection.execute 'create unique index on word_relationships (source_id, destination_id);'
  end
end