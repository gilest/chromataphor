# this class contains some working code for gathering disk information and parsing it
# it's currently unused but could be implemeted into a feature later

class DiskList

  def initialize
    # diskutil list -plist

    task = NSTask.new
    task.setLaunchPath('/usr/sbin/diskutil')
    task.setArguments(['list' ,'-plist'])

    pipe = NSPipe.pipe
    task.setStandardOutput(pipe)

    task.launch

    @data = pipe.fileHandleForReading.readDataToEndOfFile
 
    task.waitUntilExit
    task.release

    data = @data.dataUsingEncoding(NSUTF8StringEncoding)

    errorDesc = nil
    format = NSPropertyListFormat 
    @contents = NSPropertyListSerialization.propertyListFromData(@data, mutabilityOption: NSPropertyListImmutable, format: format, errorDescription: errorDesc)

  end

end