JsonApiBench::Application.routes.draw do
  get 'quick_search/domain' => 'quick_search#domain'
  get 'quick_search/pluck' => 'quick_search#pluck'
  get 'quick_search/postgresql' => 'quick_search#postgresql'

  get 'rich_search/domain' => 'rich_search#domain'
  get 'rich_search/select_all' => 'rich_search#select_all'
  get 'rich_search/postgresql' => 'rich_search#postgresql'

  get 'definition/domain' => 'definition#domain'
  get 'definition/postgresql' => 'definition#postgresql'
end
