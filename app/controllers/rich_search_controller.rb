class RichSearchController < ApplicationController
  def domain
    words = Word
      .includes(:first_definition)
      .where('text like ?', "#{params[:word]}%")
      .order('text asc')
      .limit(10)

    for_json = words.map do |word|
      {
        text: word.text,
        pronunciation: word.pronunciation,
        part_of_speech: word.first_definition.part_of_speech,
        definition: word.first_definition.body
      }
    end

    render json: for_json
  end

  def select_all
    sql = Word
      .select('text, pronunciation, part_of_speech, body as definition')
      .joins(:first_definition)
      .where('text like ?', "#{params[:word]}%")
      .order('text asc')
      .limit(10)
      .to_sql

    render json: DB.select_all(sql)
  end

  def postgresql
    sql = <<-SQL
      select array_to_json(array_agg(row_to_json(t)))
      from (
        select text, pronunciation, part_of_speech, body as definition
        from words
          join definitions on words.id=definitions.word_id
        where text like #{DB.quote("#{params[:word]}%")}
          and position=0
        order by text asc
        limit 10
      ) t
    SQL

    render json: DB.select_value(sql)
  end
end
