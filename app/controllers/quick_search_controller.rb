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

  def surus
    json = Word
      .where('text like ?', "#{params[:word]}%")
      .order('text asc')
      .limit(10)
      .all_json(columns: %i[text])

    render json: json
  end
end
