class BootPlist

  def initialize
    @path = "/Extra/org.chameleon.Boot.plist"
    @contents = NSMutableDictionary.dictionaryWithContentsOfFile(@path)
  end

  def defaultPartition
    @contents['Default Partition']
  end

  def defaultPartition=(value)
    @contents['Default Partition'] = value
  end

  def save
    @contents.writeToFile(@path, atomically: true)
  end

end