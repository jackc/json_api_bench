class QuickSearchController < ApplicationController
  def domain
    words = Word
      .where('text like ?', "#{params[:word]}%")
      .order('text asc')
      .limit(10)

    render json: words.map(&:text)
  end

  def pluck
    word_texts = Word
      .where('text like ?', "#{params[:word]}%")
      .order('text asc')
      .limit(10)
      .pluck(:text)
    render json: word_texts
  end

  def postgresql
    sql = <<-SQL
      select array_to_json(array_agg(text))
      from (
        select text
        from words
        where text like #{DB.quote("#{params[:word]}%")}
        order by text asc
        limit 10
      ) t
    SQL

    render json: DB.select_value(sql)
  end

  def siege
    query_texts = Word.order('random()').limit(200).pluck('left(text, 3)')
    render text: query_texts.map { |q| url_for controller: 'quick_search', action: params[:type], word: q }.join("\n")
  end
end
