# Loads all files in the directory with the same name as this very file

directory = File.basename(__FILE__, '.rb')
files = File.expand_path("#{directory}/*.rb", File.dirname(__FILE__))

Dir.glob(files).sort.each do |file|
  basename = File.basename(file, '.rb')
  require File.join(directory, basename)
end
