class Files
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end


  def create
    FileUtils.touch(file_path)
  end
end
