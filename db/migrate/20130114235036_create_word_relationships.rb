class CreateWordRelationships < ActiveRecord::Migration
  def up
    execute <<-DDL
      create table word_relationships(
        id serial primary key,
        relationship varchar not null,
        source_id integer not null references words,
        destination_id integer not null references words
      );

      create unique index on word_relationships (source_id, destination_id);
    DDL
  end

  def down
    execute 'drop table word_relationships'
  end
end
