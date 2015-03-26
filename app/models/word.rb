class Word < ActiveRecord::Base
  has_many :definitions, -> { order('position asc') }
  has_one :first_definition,
    -> { where(position: 0) },
    class_name: 'Definition'
  has_many :quotes
  has_many :synonym_relationships,
    -> { where(relationship: 'synonym') },
    class_name: 'WordRelationship',
    foreign_key: 'source_id'
  has_many :antonym_relationships,
    -> { where(relationship: 'antonym') },
    class_name: 'WordRelationship',
    foreign_key: 'source_id'
  has_many :synonyms, through: :synonym_relationships,
    source: 'destination'
  has_many :antonyms, through: :antonym_relationships,
    source: 'destination'
end
