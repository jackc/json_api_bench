class WordRelationship < ActiveRecord::Base
  belongs_to :source, class_name: 'Word'
  belongs_to :destination, class_name: 'Word'
end
