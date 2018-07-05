require "pdf-reader"

def validate_argv
    if ARGV.empty?
        puts "MISSING ARG"
        exit(1)
    end
end

def get_all_filenames_from_directory (dir)
  return Dir[ File.join(dir, '**', '*') ]
    .reject { |file| File.directory? file }
    .select { |file| file.include? '.pdf' }
    .sort
end

def convert_pdf_to_txt (filename)
    puts filename

    reader = PDF::Reader.new filename

    pages_text = []

    reader.pages.each do |page|
      pages_text << page.text
    end

    File.open(filename.sub(/\.pdf$/, '.txt'), 'w') do |file|
      file.puts pages_text
    end
end

def convert
    target = ARGV.first

    if File.directory? target
        filenames = get_all_filenames_from_directory target

        unless filenames.empty?
            filenames.each do |filename|
                convert_pdf_to_txt filename
            end
        end
    else
        convert_pdf_to_txt target
    end
end

validate_argv
convert
