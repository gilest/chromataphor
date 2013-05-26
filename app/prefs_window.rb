class AppDelegate

  def buildPrefsWindow

    # create the window and set it up
    @prefsWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
       styleMask: NSTitledWindowMask|NSClosableWindowMask,
       backing: NSBackingStoreBuffered,
       defer: true)
    @prefsWindow.setReleasedWhenClosed(false)
    @prefsWindow.delegate = self
    @prefsWindow.title = "#{@appName} Preferences"

    buildParitionList

    # create a save button and attach it to the bottom of the window
    save_button = NSButton.alloc.initWithFrame(NSMakeRect(240, 20, 60, 25))
    save_button.setBezelStyle NSRoundedBezelStyle
    save_button.setTitle 'Save'
    save_button.setAction 'savePreferences:'
    @prefsWindow.contentView.addSubview(save_button)

  end

  def buildParitionList
    # yValue seems to be the location in pixels from the bottom of the window, so we decrement as we add lines
    yValue = 318
    # iterate over all the paritions within the preferences
    @preferences.bootPartitions.each do |partition|

      # create a field for the name
      parition_name = NSTextField.alloc.initWithFrame(NSMakeRect(20, yValue, 120, 22))
      parition_name.stringValue = partition[:name]
      parition_name.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
      @prefsWindow.contentView.addSubview(parition_name)

      # and the reference
      partition_reference = NSTextField.alloc.initWithFrame(NSMakeRect(160, yValue, 60, 22))
      partition_reference.stringValue = partition[:reference]
      partition_reference.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
      @prefsWindow.contentView.addSubview(partition_reference)

      # and a checkbox for enabling/disabling
      partition_enabled = NSButton.alloc.initWithFrame(NSMakeRect(240, yValue, 60, 22))
      partition_enabled.setButtonType(NSSwitchButton)
      partition_enabled.setTitle 'Enabled'
      state = case partition[:enabled]
      when true
        NSOnState
      when false
        NSOffState
      end
      partition_enabled.setState state
      @prefsWindow.contentView.addSubview(partition_enabled)

      # decrement the yValue for the next row
      yValue = yValue - 26
    end
  end

  def savePreferences(sender)
    puts "This would save the prefs"
  end

end