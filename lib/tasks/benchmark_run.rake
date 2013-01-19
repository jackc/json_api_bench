namespace :benchmark do
  desc 'Run benchmark - server must already be running'
  task :run do
    site = 'http://localhost:8080/'
    benchmarks = [
      'Quick Search Domain',
      'Quick Search Pluck',
      'Quick Search PostgreSQL',
      'Rich Search Domain',
      'Rich Search Select All',
      'Rich Search PostgreSQL',
      'Definition Domain',
      'Definition PostgreSQL'
    ]

    results = benchmarks.map do |b|
      underscore_name = b.downcase.gsub(' ', '_')
      siege_script_file = "benchmark/#{underscore_name}_urls.txt"
      siege_results_file = "tmp/#{underscore_name}_results.txt"
      `siege --concurrent=4 --internet --benchmark --reps 1000 --file=#{siege_script_file} 2> #{siege_results_file}`
      File.read(siege_results_file) =~ /^Transaction rate:\s+([0-9.]+)/
      { name: b, rate: $1 }
    end

    table = Terminal::Table.new :headings => ['Name', 'Reqs/Sec'], :rows => results.map { |r| [r[:name], r[:rate]] }
    puts table
  end
end