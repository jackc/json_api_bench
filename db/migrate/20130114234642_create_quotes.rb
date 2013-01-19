class CreateQuotes < ActiveRecord::Migration
  def up
    execute <<-DDL
      create table quotes(
        id serial primary key,
        word_id integer not null references words,
        body varchar not null,
        source varchar not null,
        string_padding_1 varchar not null default 'Lorem ipsum dolor sit amet',
        string_padding_2 varchar not null default 'consectetur adipisicing elit',
        integer_padding_1 integer not null default 0,
        integer_padding_2 integer not null default 0,
        date_padding_1 date not null default '2013-01-01',
        date_padding_2 date not null default '2013-01-01',
        created_at timestamptz not null default current_timestamp,
        updated_at timestamptz not null default current_timestamp
      );

      create index on quotes (word_id)
    DDL
  end

  def down
    execute 'drop table quotes;'
  end
end
