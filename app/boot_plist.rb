class BootPlist

  def initialize(preferences)
    @preferences = preferences
    if file_exists?
      puts "boot plist file EXISTS at #{@preferences.plistPath}"
    else
      puts "boot plist file DOES NOT EXIST at #{@preferences.plistPath}"
    end
    @contents = NSMutableDictionary.dictionaryWithContentsOfFile(@preferences.plistPath)
  end

  def file_exists?
    NSFileManager.defaultManager.fileExistsAtPath(@preferences.plistPath)
  end

  def defaultPartition
    @contents['Default Partition']
  end

  def defaultPartition=(value)
    @contents['Default Partition'] = value
  end

  def save
    @contents.writeToFile(@preferences.plistPath, atomically: true)
  end

end