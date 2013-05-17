class Preferences

  def initialize
    @preferences = NSUserDefaults.standardUserDefaults.retain
    default_values = {
                       bootPartitions: [
                         { name: 'Mac', reference: 'hd(0,2)', enabled: false },
                         { name: 'Windows', reference: 'hd(1,2)', enabled: false }
                       ]
                     }
    @preferences.registerDefaults(default_values)
  end

end