require "pdf-reader"

def get_all_files_from_directory dir
  return Dir[ File.join(dir, '**', '*') ].reject { |file| File.directory? file }
end

dir = "#{Dir.pwd}/pdf"
files = get_all_files_from_directory dir

unless files.empty?
  files.each do |file|
    reader = PDF::Reader.new file

    name = file.scan(/.+\/(.+?)\.pdf/).first.first
    puts name

    file_store = []

    reader.pages.each do |page|
      file_store << page.text
    end

    File.open("#{name}.txt", 'w') do |file|
      file.puts file_store
    end
  end
end
