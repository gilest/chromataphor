class Preferences

  def initialize
    @preferences = NSUserDefaults.standardUserDefaults.retain
    default_values = {
                       bootPartitions: [
                         { name: 'Mac', reference: 'hd(0,2)', enabled: true , current: false },
                         { name: 'Windows', reference: 'hd(1,2)', enabled: false, current: false },
                         { name: 'Linux', reference: 'hd(1,4)', enabled: false, current: false }
                       ],
                       plistPath: '/Extra/org.chameleon.Boot.plist'
                     }
    @preferences.registerDefaults(default_values)
  end

  def bootPartitions
    @preferences[:bootPartitions]
  end

  def bootPartitions= (value)
    @preferences[:bootPartitions] = value
    sync
  end

  def plistPath
    @preferences[:plistPath]
  end

  def plistPath= (value)
    @preferences[:plistPath] = value
    sync
  end

  def sync
    @preferences.synchronize
  end

end