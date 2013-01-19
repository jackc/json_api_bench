class Word < ActiveRecord::Base
  has_many :definitions, order: 'position asc'
  has_one :first_definition,
    class_name: 'Definition',
    conditions: { position: 0 }
  has_many :quotes
  has_many :synonym_relationships,
    class_name: 'WordRelationship',
    foreign_key: 'source_id',
    conditions: { relationship: 'synonym' }
  has_many :antonym_relationships,
    class_name: 'WordRelationship',
    foreign_key: 'source_id',
    conditions: { relationship: 'antonym' }
  has_many :synonyms, through: :synonym_relationships,
    source: 'destination'
  has_many :antonyms, through: :antonym_relationships,
    source: 'destination'
end
