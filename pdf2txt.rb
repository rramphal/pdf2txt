require "pdf-reader"

def get_all_filenames_from_directory dir
  return Dir[ File.join(dir, '**', '*') ].reject { |file| File.directory? file }
end

dir = "#{Dir.pwd}/pdf"
filenames = get_all_filenames_from_directory dir

unless filenames.empty?
  filenames.each do |filename|
    reader = PDF::Reader.new filename

    name = filename.scan(/.+\/(.+?)\.pdf/).first.first
    puts name

    pages_text = []

    reader.pages.each do |page|
      pages_text << page.text
    end

    File.open("#{name}.txt", 'w') do |file|
      file.puts pages_text
    end
  end
end
