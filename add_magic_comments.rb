def list(dir)
  Dir.open(dir).each do |subdir|
    if subdir.eql?('.') || subdir.eql?('..')
      next
    end

    subdir_name = dir + '/' + subdir
    if File.directory?(subdir_name)
      list(subdir_name)
    else
      puts subdir_name
      add_encoding_comments(subdir_name)
    end
  end
end

def add_encoding_comments(file_name)
  backup_file_name = file_name + '.bak'
  File.rename(file_name, backup_file_name)

  File.open(file_name, 'w+') do |new_file|
    File.open(backup_file_name, 'r') do |old_file|
      first_line = old_file.gets
      if !first_line.eql?('# encoding: utf-8')
        new_file.puts('# encoding: utf-8')
      end
      new_file.puts(first_line)
      old_file.readlines.each do |line|
        new_file.puts(line)
      end
    end
  end

  File.delete(backup_file_name)
end

list('app')
